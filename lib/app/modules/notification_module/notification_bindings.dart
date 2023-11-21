import 'package:famooshed/app/modules/notification_module/notification_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}
