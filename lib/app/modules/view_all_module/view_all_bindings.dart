import 'package:famooshed/app/modules/view_all_module/view_all_controller.dart';
import 'package:get/get.dart';

class ViewAllBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewAllController());
  }
}
