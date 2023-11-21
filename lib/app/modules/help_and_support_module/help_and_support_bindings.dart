import 'package:get/get.dart';

import 'help_and_support_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class HelpAndSupportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HelpAndSupportController());
  }
}
