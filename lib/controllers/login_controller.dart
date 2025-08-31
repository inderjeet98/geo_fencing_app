import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geofencing_api/geofencing_api.dart';
import '../screens/home.dart';

class LoginController extends GetxController {
  RxString token = ''.obs;
  RxInt userId = 0.obs;

  Future<bool> login(String email, String password, double lat, double lng, int browserId) async {
    final url = Uri.parse('https://api.helixtahr.com/api/v1/login');
    final payload = {"email": email, "password": password, "lng": lng, "lat": lat, "browser_id": browserId};
    final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(payload));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      token.value = data['data']['token'];
      userId.value = data['data']['id'];
      return true;
    }
    return false;
  }

  Future<void> handleLoginAndGeofencing({required String email, required String password, required double lat, required double lng, required int browserId}) async {
    bool success = await login(email, password, lat, lng, browserId);
    if (success) {
      final permission = await Geofencing.instance.requestLocationPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        Get.snackbar('Error', 'Location permission denied');
        return;
      }
      try {
        await Geofencing.instance.stop();
      } catch (_) {}
      Geofencing.instance.setup(interval: 5000, accuracy: 100, statusChangeDelay: 10000, allowsMockLocation: true, printsDebugLog: true);
      final region = GeofenceRegion.circular(id: 'office', data: {'name': 'Office'}, center: const LatLng(1.3565952, 103.809024), radius: 100.0, loiteringDelay: 0);
      await Geofencing.instance.start(regions: {region});
      Get.off(() => const HomePage());
    } else {
      Get.snackbar('Login Failed', 'Invalid credentials');
    }
  }
}
