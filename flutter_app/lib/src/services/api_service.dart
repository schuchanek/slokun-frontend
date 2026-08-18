import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'local_storage.dart';

class ApiService {
  late final Dio dio;
  final LocalStorage _storage = LocalStorage();

  ApiService() {
    final base = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';
    dio = Dio(BaseOptions(baseUrl: base, connectTimeout: 5000, receiveTimeout: 5000));

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      final token = await _storage.readAccessToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    }, onError: (e, handler) async {
      // Attempt refresh on 401
      if (e.response?.statusCode == 401) {
        final refresh = await _storage.readRefreshToken();
        if (refresh != null) {
          try {
            final res = await dio.post('/auth/refresh', data: {'refreshToken': refresh});
            if (res.data != null && res.data['success'] == true) {
              final access = res.data['data']['accessToken'];
              final newRefresh = res.data['data']['refreshToken'];
              await _storage.saveTokens(access, newRefresh ?? refresh);
              // retry original request
              final opts = e.requestOptions;
              opts.headers['Authorization'] = 'Bearer $access';
              final clone = await dio.request(opts.path,
                  options: Options(method: opts.method, headers: opts.headers),
                  data: opts.data,
                  queryParameters: opts.queryParameters);
              return handler.resolve(clone);
            }
          } catch (_) {}
        }
      }
      return handler.next(e);
    }));
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final resp = await dio.post('/auth/register', data: {'email': email, 'password': password});
    return Map<String, dynamic>.from(resp.data);
  }

  Future<bool> login(String email, String password) async {
    final resp = await dio.post('/auth/login', data: {'email': email, 'password': password});
    final body = resp.data;
    if (body['success'] == true) {
      final data = body['data'];
      await _storage.saveTokens(data['accessToken'], data['refreshToken']);
      return true;
    }
    return false;
  }

  Future<bool> loginWithGoogleIdToken(String idToken) async {
    final resp = await dio.post('/auth/google', data: {'idToken': idToken});
    final body = resp.data;
    if (body['success'] == true) {
      final data = body['data'];
      await _storage.saveTokens(data['accessToken'], data['refreshToken']);
      return true;
    }
    return false;
  }

  Future<Map<String, dynamic>?> getMe() async {
    final resp = await dio.get('/users/me');
    final body = resp.data;
    if (body['success'] == true) return Map<String, dynamic>.from(body['data']);
    return null;
  }

  Future<List<dynamic>> getNearbyVenues(double lat, double lng, {int radius = 5}) async {
    final resp = await dio.get('/venues/nearby', queryParameters: {'lat': lat, 'lng': lng, 'radius': radius});
    final body = resp.data;
    if (body['success'] == true) return List<dynamic>.from(body['data']);
    return [];
  }

  Future<Map<String, dynamic>?> getVenue(String id) async {
    final resp = await dio.get('/venues/$id');
    final body = resp.data;
    if (body['success'] == true) return Map<String, dynamic>.from(body['data']);
    return null;
  }

  Future<bool> postAttendance(String id) async {
    final resp = await dio.post('/venues/$id/attendance');
    final body = resp.data;
    return body['success'] == true;
  }
}
