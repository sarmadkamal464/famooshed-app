import 'package:get/get.dart';

import 'cart_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController(), fenix: true);
  }
}
