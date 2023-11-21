import 'package:famooshed/app/modules/merchants_module/merchants_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class MerchantsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MerchantsController());
  }
}
