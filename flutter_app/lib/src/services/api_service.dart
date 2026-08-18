import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  late final Dio dio;

  ApiService() {
    final base = dotenv.env['API_BASE_URL'] ?? 'https://api.example.com';
    dio = Dio(BaseOptions(baseUrl: base, connectTimeout: 5000, receiveTimeout: 5000));
  }
}
