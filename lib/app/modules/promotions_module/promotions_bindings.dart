import 'package:famooshed/app/modules/promotions_module/promotions_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class PromotionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PromotionsController());
  }
}
