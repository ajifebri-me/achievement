import 'dart:convert';

import 'package:achievement/app/data/models/achivement_model.dart';
import 'package:achievement/app/repo/achivement_repo.dart';
import 'package:achievement/app/routes/app_routes.dart';
import 'package:achievement/app/utils/tools.dart';
import 'package:achievement/config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  RxBool loading = RxBool(false);
  RxList<DataAchivement> data = RxList<DataAchivement>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    get();
    super.onInit();
  }

  Future get({String search = ""}) async {
    try {
      loading.value = true;
      http.Response res = await http.get(
        Uri.parse(AchivementRepo.get),
        headers: {
          "token": token,
          "device": device,
        },
      );

      if (res.statusCode != 200) {
        throw new Exception("Error");
      } else {
        AchivementModel result = AchivementModel.fromJson(jsonDecode(res.body));
        data.value = result.data!;

        if (search != "") {
          data.value = data
              .where(
                (e) =>
                    e.level!.toLowerCase().contains(search.toLowerCase()) ||
                    e.organizer!.toLowerCase().contains(search.toLowerCase()) ||
                    e.year!.toLowerCase().contains(search.toLowerCase()) ||
                    e.achievementName!.toLowerCase().contains(
                          search.toLowerCase(),
                        ),
              )
              .toList();
        }
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      alertError(content: [e.toString()]);
    }
  }

  Future delete({required int id}) async {
    try {
      loading.value = true;
      http.Response res = await http.post(
        Uri.parse(AchivementRepo.delete),
        headers: {
          "token": token,
          "device": device,
          'content-type': 'application/json'
        },
        body: jsonEncode(
          {"id": id},
        ),
      );

      if (res.statusCode != 200) {
        if (res.statusCode == 400) {
          AchivementModel result =
              AchivementModel.fromJson(jsonDecode(res.body));
          Get.back();
          alertWarning(content: result);
        } else {
          throw new Exception("Error");
        }
      } else {
        data.value = data.where((element) => element.id != id).toList();
      }
      loading.value = false;
    } catch (e) {
      alertError(content: [e.toString()]);
    }
  }

  void logout() {
    if (GetStorage().read("token") != null) {
      GetStorage().remove("token");
    }

    Get.offAndToNamed(Routes.LOGIN);
  }
}
