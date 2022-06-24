import 'dart:convert';
import 'package:achievement/app/routes/app_routes.dart';
import 'package:achievement/app/utils/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login() async {
    dialogCircular();

    if (email.text == "akun@test.id" && password.text == "password") {
      GetStorage().write("token", "token123");

      Get.offAndToNamed(Routes.HOME);
    } else {
      alertError(content: ["Credential not valid"]);
    }
  }
}
