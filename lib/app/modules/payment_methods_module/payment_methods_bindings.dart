import 'package:famooshed/app/modules/payment_methods_module/payment_methods_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class PaymentMethodsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentMethodsController());
  }
}
