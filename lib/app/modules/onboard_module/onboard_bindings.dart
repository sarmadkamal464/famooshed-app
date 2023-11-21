import 'package:famooshed/app/modules/onboard_module/onboard_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class OnboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardController());
  }
}
