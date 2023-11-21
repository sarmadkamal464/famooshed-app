import 'package:famooshed/app/modules/feedbacks_module/feedbacks_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class FeedbacksBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeedbacksController());
  }
}
