import 'package:famooshed/app/modules/order_sucess_module/order_sucess_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class OrderSucessBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderSucessController());
  }
}
