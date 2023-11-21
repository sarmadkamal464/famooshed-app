import 'package:famooshed/app/modules/checkout_module/checkout_controller.dart';
import 'package:get/get.dart';

import '../cart_module/cart_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class CheckoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckoutController(), fenix: true);
    Get.lazyPut(() => CartController(), fenix: true);
  }
}
