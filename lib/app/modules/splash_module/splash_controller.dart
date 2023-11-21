import 'package:famooshed/app/routes/app_pages.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class SplashController extends GetxController {
  moveToNext() {
    return Get.offNamed(Routes.ONBOARD);
  }
}
