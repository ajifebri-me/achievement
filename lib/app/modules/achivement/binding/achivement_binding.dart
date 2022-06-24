import 'package:achievement/app/modules/achivement/controller/achivement_controller.dart';
import 'package:get/get.dart';

class AchivementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AchivementController());
  }
}
