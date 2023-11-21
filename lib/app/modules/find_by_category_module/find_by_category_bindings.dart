import 'package:famooshed/app/modules/find_by_category_module/find_by_category_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class FindByCategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FindByCategoryController());
  }
}
