import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/logic/controller.dart';
import 'package:login/ui/component/body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController(Get.find()));
    return const Scaffold(
      body: Body(),
    );
  }
}
