import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/utils/dprint.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/constants.dart';
import '../../common/storage/storage.dart';
import '../../common/util/firebase_messeging_helper/firebase_helper.dart';
import '../../data/api_helper.dart';
import '../../data/models/sign_up_response.dart';
import '../../routes/app_pages.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class SignUpController extends GetxController {
  @override
  void onInit() {
    // getDebugData();
    super.onInit();
  }

  final ApiHelper _apiHelper = ApiHelper.to;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxBool passwordVisible = false.obs;
  int currentView = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  getDebugData() {
    if (kDebugMode) {
      emailController.text = "Test User";
      passController.text = "123456";
      nameController.text = "Dev Name";
      emailController.text = "Test User";
      locationController.text = "Mohali";
    }
  }

  void register() {
    var body = {
      'email': emailController.text,
      'password': passController.text,
      'name': nameController.text,
      'phone': phoneController.text,
      'typeReg': 'email',
      'photoUrl': ""
    };
    if (formKey.currentState!.validate()) {
      _apiHelper.postApiCall(AppUrl.register, body).futureValue(
        (value) async {
          dprint(value);
          var response = GetSignUpResponse.fromJson(value);
          if (response.error != null && response.error == '0') {
            await Storage.saveValue(Constants.isLoggedIn, true);
            Storage.saveValue(Constants.userId, response.user!.id);
            await Storage.saveValue(Constants.rememberMe, "Yes");
            Storage.saveValue(Constants.token, "Bearer ${response.accessToken}")
                .whenComplete(() async {
              await _apiHelper.postApiCall(
                  AppUrl.fcbToken, {"fcbToken": FirebaseMessages().fcmToken});
              Get.offAllNamed(Routes.DASHBOARD);
            });
          } else {
            if (response.error != null && response.error == '3') {
              Utils.showSnackbar("Email already exists.");
            } else {
              Utils.showSnackbar("Registration Failed.");
            }
          }
          // Get.offAllNamed(Routes.DASHBOARD);
        },
        retryFunction: register,
      );
    }
  }
}
