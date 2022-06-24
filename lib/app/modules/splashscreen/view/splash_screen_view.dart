import 'package:achievement/app/modules/splashscreen/controller/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenView extends StatelessWidget {
  final splashC = Get.put(SplashScreenController());

  SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                margin: EdgeInsets.only(top: Get.height * 0.45),
                child: const Text(
                  "Achievement APPS",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Expanded(
                // ignore: unnecessary_const
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
