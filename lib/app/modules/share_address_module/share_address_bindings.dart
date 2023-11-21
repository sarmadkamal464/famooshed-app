import 'package:famooshed/app/modules/share_address_module/share_address_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class ShareAddressBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShareAddressController());
  }
}
