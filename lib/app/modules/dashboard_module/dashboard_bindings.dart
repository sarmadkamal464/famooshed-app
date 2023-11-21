import 'package:famooshed/app/modules/add_new_location_module/add_new_location_controller.dart';
import 'package:famooshed/app/modules/dashboard_module/dashboard_controller.dart';
import 'package:famooshed/app/modules/favorite_module/favorite_controller.dart';
import 'package:famooshed/app/modules/home_module/home_controller.dart';
import 'package:famooshed/app/modules/my_profile_module/my_profile_controller.dart';
import 'package:famooshed/app/modules/notification_module/notification_controller.dart';
import 'package:famooshed/app/modules/orders_module/orders_controller.dart';
import 'package:famooshed/app/modules/verify_module/verify_controller.dart';
import 'package:get/get.dart';

import '../help_and_support_module/help_and_support_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => DashboardController(),
    );
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => MyProfileController(), fenix: true);
    Get.lazyPut(() => OrdersController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => VerifyController(), fenix: true);
    Get.lazyPut(() => FavoriteController(), fenix: true);
    Get.lazyPut(() => AddNewLocationController(), fenix: true);
    // Get.lazyPut(() => CartController(), fenix: true);

    Get.lazyPut(
      () => HelpAndSupportController(),
      fenix: true,
    );
  }
}
