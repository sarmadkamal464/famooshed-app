import 'package:famooshed/app/modules/signle_item_module/signle_item_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class SignleItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignleItemController());
  }
}
