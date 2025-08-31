import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../services/api_services.dart';

class LocationController extends GetxController {
  final ApiService api = Get.find<ApiService>();
  var currentLat = 0.0.obs;
  var currentLng = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _startTracking();
  }

  void _startTracking() {
    Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 10)).listen((Position pos) {
      currentLat.value = pos.latitude;
      currentLng.value = pos.longitude;
      api.sendLocation(lat: pos.latitude, lng: pos.longitude);
    });
  }
}
