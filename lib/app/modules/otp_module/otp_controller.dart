import 'package:famooshed/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class OtpController extends GetxController {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  redirectToAddressShare() {
    Get.toNamed(Routes.SHARE_ADDRESS);
  }
}
