import 'package:famooshed/app/modules/otp_module/otp_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class OtpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }
}
