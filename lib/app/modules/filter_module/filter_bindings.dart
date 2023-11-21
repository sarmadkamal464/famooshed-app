import 'package:famooshed/app/modules/filter_module/filter_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class FilterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FilterController(),
      fenix: true,
    );
  }
}
