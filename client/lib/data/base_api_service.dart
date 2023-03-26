abstract class BaseApiService {
  final baseUrl = "http://127.0.0.1:5000";
  final headers = {
    'Content-Type': 'application/json',
  };

  Future<dynamic> postResponse(String url, Map<String, dynamic> body);
}
