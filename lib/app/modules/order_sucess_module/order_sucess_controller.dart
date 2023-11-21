import 'package:famooshed/app/routes/app_pages.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class OrderSucessController extends GetxController {
  @override
  void onReady() {
    orderAccept();
    super.onReady();
  }

  RxBool orderAccepted = false.obs;

  orderAccept() {
    Future.delayed(const Duration(seconds: 3), () {
      orderAccepted.value = true;
      update();
      Future.delayed(const Duration(milliseconds: 1200), () {
        Get.toNamed(Routes.DASHBOARD);
      });
      update();
    });
  }
}
