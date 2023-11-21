import 'package:famooshed/app/modules/orders_module/orders_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class OrdersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersController(), fenix: true);
  }
}
