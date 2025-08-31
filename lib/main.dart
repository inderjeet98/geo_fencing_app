import 'package:flutter/material.dart';
import 'package:geo_fencing_app/screens/login.dart';
import 'package:get/get.dart';
import 'package:geofencing_api/geofencing_api.dart';

import '../utils/utils.dart';
import 'services/api_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ApiService());
  final permission = await Geofencing.instance.requestLocationPermission();
  if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
    Utils.printLog('Location permission denied');
    return;
  }
  Geofencing.instance.setup(interval: 5000, accuracy: 100, statusChangeDelay: 10000, allowsMockLocation: true, printsDebugLog: true);
  final region = GeofenceRegion.circular(id: 'office', data: {'name': 'Office'}, center: const LatLng(1.3565952, 103.809024), radius: 100.0, loiteringDelay: 0);
  await Geofencing.instance.start(regions: {region});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: LoginPage());
  }
}
