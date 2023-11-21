import 'package:get/get.dart';

import 'about_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class AboutUsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AboutUsController(),
    );
  }
}
