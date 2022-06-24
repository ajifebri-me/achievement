import 'dart:convert';
import 'dart:io';

import 'package:achievement/app/data/models/achivement_model.dart';
import 'package:achievement/app/repo/achivement_repo.dart';
import 'package:achievement/app/routes/app_routes.dart';
import 'package:achievement/app/utils/tools.dart';
import 'package:achievement/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:math';

class AchivementController extends GetxController {
  TextEditingController achivementName = TextEditingController();
  TextEditingController level = TextEditingController();
  TextEditingController organizer = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController file = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? files;

  Future create() async {
    try {
      dialogCircular();
      var headers = {
        "Content-Type": "multipart/form-data",
        "Accept": 'application/json',
        "token": token,
        "device": device
      };

      var request =
          http.MultipartRequest('POST', Uri.parse(AchivementRepo.create))
            ..headers.addAll(headers)
            ..fields["achievement_name"] = achivementName.text
            ..fields["level"] = level.text
            ..fields["organizer"] = organizer.text
            ..fields["year"] = year.text
            ..files.add(
              await http.MultipartFile(
                'file',
                files!.readAsBytes().asStream(),
                files!.lengthSync(),
                filename: file.text.split("/").last,
              ),
            );
      var res = await request.send();

      http.Response response = await http.Response.fromStream(res);

      if (res.statusCode != 200) {
        AchivementModel result = AchivementModel.fromJson(
          jsonDecode(response.body),
        );
        if (res.statusCode == 400) {
          Get.back();
          alertWarning(content: result);
        } else {
          throw new Exception("Error");
        }
      } else {
        AchivementModel result = AchivementModel.fromJson(
          jsonDecode(response.body),
        );
        Get.back();
        Get.offAndToNamed(Routes.HOME);
        alertSuccess(content: result.message);
      }
    } catch (e) {
      print(e);
      Get.back();
      alertError(content: [e.toString()]);
    }
  }

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      files = File(image.path);
      final length = files!.lengthSync();
      file.text = files.toString();
      update();
    }
  }
}
