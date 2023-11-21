import 'package:famooshed/app/modules/verify_module/verify_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class VerifyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyController());
  }
}
