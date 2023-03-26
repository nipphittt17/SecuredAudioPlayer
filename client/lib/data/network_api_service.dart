import 'dart:convert';
import 'dart:developer';

import 'package:client/data/base_api_service.dart';
import "package:http/http.dart" as http;

class NetWorkApiService extends BaseApiService {
  Map<String, dynamic> returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw Exception("Error Response");
    }
  }

  @override
  Future<Map<String, dynamic>> postResponse(
    String url,
    Map<String, dynamic> body,
  ) async {
    dynamic responseJson;
    try {
      log(baseUrl + url);
      final response = await http.post(
        Uri.parse(baseUrl + url),
        body: jsonEncode(body),
        headers: headers,
      );
      responseJson = returnResponse(response);
    } catch (e) {
      log(e.toString());
      throw Exception("Error on Post");
    }
    return responseJson;
  }
}
