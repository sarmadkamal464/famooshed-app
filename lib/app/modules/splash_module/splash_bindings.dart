import 'package:famooshed/app/data/api_helper_impl.dart';
import 'package:famooshed/app/modules/splash_module/splash_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => ApiHelperImpl());
  }
}
