import 'package:famooshed/app/modules/location_module/location_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class LocationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationController());
  }
}
