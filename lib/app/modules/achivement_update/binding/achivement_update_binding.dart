import 'package:achievement/app/modules/achivement_update/controller/achivement_update_controller.dart';
import 'package:get/get.dart';

class AchivementUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AchivementUpdateController());
  }
}
