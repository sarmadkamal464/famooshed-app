import 'package:famooshed/app/modules/add_new_location_module/add_new_location_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class AddNewLocationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNewLocationController(), fenix: true);
  }
}
