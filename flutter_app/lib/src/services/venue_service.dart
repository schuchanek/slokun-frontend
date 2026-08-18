import 'api_service.dart';

class VenueService {
  final ApiService _api = ApiService();

  Future<List<dynamic>> getNearby(double lat, double lng, {int radius = 5}) async {
    return await _api.getNearbyVenues(lat, lng, radius: radius);
  }

  Future<Map<String, dynamic>?> getDetails(String id) async {
    return await _api.getVenue(id);
  }

  Future<bool> attend(String id) async {
    return await _api.postAttendance(id);
  }
}
