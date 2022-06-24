import 'package:achievement/app/modules/achivement/binding/achivement_binding.dart';
import 'package:achievement/app/modules/achivement/view/achivement_view.dart';
import 'package:achievement/app/modules/achivement_update/binding/achivement_update_binding.dart';
import 'package:achievement/app/modules/achivement_update/view/achivement_update_view.dart';
import 'package:achievement/app/modules/auth/bindings/auth_binding.dart';
import 'package:achievement/app/modules/auth/views/login_view.dart';
import 'package:achievement/app/modules/home/binding/home_controller.dart';
import 'package:achievement/app/modules/home/view/home_view.dart';
import 'package:achievement/app/modules/home/view/search_view.dart';
import 'package:achievement/app/modules/splashscreen/view/splash_screen_view.dart';
import 'package:achievement/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HoneView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.ACHIVEMENT_ADD,
      page: () => AchimenetView(),
      binding: AchivementBinding(),
    ),
    GetPage(
      name: Routes.ACHIVEMENT_EDIT,
      page: () => AchimenetUpdateView(),
      binding: AchivementUpdateBinding(),
    ),
  ];
}
