import 'api_service.dart';

class VenueService {
  final ApiService _api = ApiService();

  Future<List<dynamic>> getNearby(double lat, double lng, {int radius = 5}) async {
    return await _api.getNearbyVenues(lat, lng, radius: radius);
  }

  Future<Map<String, dynamic>?> getDetails(String id) async {
    return await _api.getVenue(id);
  }

  Future<List<dynamic>> getReviews(String id) async {
    final resp = await _api.dio.get('/venues/$id/reviews');
    final body = resp.data;
    if (body['success'] == true) return List<dynamic>.from(body['data']);
    return [];
  }

  Future<bool> postReview(String id, int rating, {String? comment}) async {
    final resp = await _api.dio.post('/venues/$id/reviews', data: {'rating': rating, 'comment': comment});
    return resp.data['success'] == true;
  }

  Future<bool> attend(String id) async {
    return await _api.postAttendance(id);
  }
}
