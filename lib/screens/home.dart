import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/location_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Geo Tracking App")),
      body: Center(
        child: GetX<LocationController>(
          init: LocationController(),
          builder: (ctrl) => Text("Lat: ${ctrl.currentLat.value}, Lng: ${ctrl.currentLng.value}", style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
