import 'dart:convert';
import 'package:geo_fencing_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService extends GetxService {
  final String baseUrl = "https://api.helixtahr.com/api/v1/";
  String? token;
  int? userId;

  Future<bool> login(String email, String password, double lat, double lng) async {
    final url = Uri.parse("${baseUrl}login");

    final body = {"email": email, "password": password, "lng": lng, "lat": lat, "browser_id": 3417089516};

    try {
      final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(body));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        token = data['token'];
        userId = data['user']['id'];
        return true;
      } else {
        Get.snackbar("Login Failed", response.body);
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Login failed: $e");
      return false;
    }
  }

  Future<void> sendLocation({int? userId, double? lat, double? lng, String? token}) async {
    final url = Uri.parse('https://api.helixtahr.com/api/v1/location');
    final payload = {"user_id": userId, "lat": lat, "lng": lng};
    Utils.printLog('Sending location: $payload');
    await http.post(url, headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'}, body: jsonEncode(payload));
  }
}
