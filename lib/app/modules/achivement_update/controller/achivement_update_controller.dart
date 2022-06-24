import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:achievement/app/data/models/achivement_model.dart';
import 'package:achievement/app/repo/achivement_repo.dart';
import 'package:achievement/app/routes/app_routes.dart';
import 'package:achievement/app/utils/tools.dart';
import 'package:achievement/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AchivementUpdateController extends GetxController {
  TextEditingController achivementName = TextEditingController();
  TextEditingController level = TextEditingController();
  TextEditingController organizer = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController file = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  RxBool loading = RxBool(false);
  List<DataAchivement>? data;
  DataAchivement? item;
  File? files;
  int? id;
  ReceivePort _port = ReceivePort();

  void onInit() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print("download success");
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
    id = Get.arguments["id"];
    load();
    super.onInit();
  }

  Future load() async {
    loading.value = true;
    update();
    await Future.wait({
      get(),
    });
    loading.value = false;
    update();
  }

  Future get() async {
    try {
      // loading.value = true;
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
        data = result.data!;
        getById();
      }
      // loading.value = false;
    } catch (e) {
      // loading.value = false;
      alertError(content: [e.toString()]);
    }
  }

  void getById() {
    try {
      item = data!.firstWhere((element) => element.id == id);

      if (item == null) {
        Get.back();
        return;
      }

      // await download("https://picsum.photos/200");
      achivementName.text = item!.achievementName!;
      level.text = item!.level!;
      organizer.text = item!.organizer!;
      year.text = item!.year!;
      file.text = item!.file!;
      update();
    } catch (e) {
      alertError(content: [e.toString()]);
    }
  }

  Future updateData() async {
    try {
      dialogCircular();

      if (file.text == item!.file) {
        Get.back();
        alertError(content: ["pictures can't be the same"]);
      } else {
        var headers = {
          "Content-Type": "multipart/form-data",
          "Accept": 'application/json',
          "token": token,
          "device": device
        };

        var request =
            http.MultipartRequest('POST', Uri.parse(AchivementRepo.update))
              ..headers.addAll(headers)
              ..fields["id"] = id.toString()
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
      }
    } catch (e) {
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

  Future download(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      await FlutterDownloader.enqueue(
        url: url,
        savedDir: baseStorage!.path,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    }
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }
}
