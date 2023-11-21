import 'package:famooshed/app/modules/order_track_module/order_track_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class OrderTrackBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderTrackController());
  }
}
