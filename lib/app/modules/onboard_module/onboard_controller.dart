import 'package:famooshed/app/routes/app_pages.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class OnboardController extends GetxController {
  redirectToLoginPage() {
    Get.toNamed(Routes.SIGN_IN);
  }
}
