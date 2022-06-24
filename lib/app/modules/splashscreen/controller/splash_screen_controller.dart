import 'dart:async';

import 'package:achievement/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    // setTime();
    super.onInit();
  }

  // void setTime() {
  //   Timer(Duration(seconds: 2), () {
  //     Get.offAndToNamed(Routes.HOME);
  //   });
  // }
  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(Duration(seconds: 5));

    if (GetStorage().read("token") == null) {
      Get.offAndToNamed(Routes.LOGIN);
    } else {
      Get.offAndToNamed(Routes.HOME);
    }
  }
}
