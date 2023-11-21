import 'package:famooshed/app/modules/review_module/review_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class ReviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewController());
  }
}
