import 'package:geofencing_api/geofencing_api.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../services/api_services.dart';

@pragma('vm:entry-point')
void geofenceCallback(List<String> ids, Location location, GeofenceStatus event) async {
  final loginCtrl = Get.find<LoginController>();
  final api = ApiService();
  await api.sendLocation(userId: loginCtrl.userId.value, lat: location.latitude, lng: location.longitude, token: loginCtrl.token.value);
}
