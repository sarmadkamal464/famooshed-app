import 'package:famooshed/app/modules/favorite_module/favorite_controller.dart';
import 'package:famooshed/app/modules/home_module/home_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}
