import 'package:famooshed/app/modules/home_location_module/home_location_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class HomeLocationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeLocationController());
  }
}
