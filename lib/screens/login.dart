import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final emailCtrl = TextEditingController(text: "NAV1003");
  final passCtrl = TextEditingController(text: "Pp@1234567");
  final loginCtrl = Get.put(LoginController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passCtrl,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                await loginCtrl.handleLoginAndGeofencing(email: emailCtrl.text, password: passCtrl.text, lat: 1.3565952, lng: 103.809024, browserId: 3417089516);
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
