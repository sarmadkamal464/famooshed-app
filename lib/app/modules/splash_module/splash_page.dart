import 'dart:async';

import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../common/constants.dart';
import '../../common/util/firebase_messeging_helper/firebase_helper.dart';
import '../../common/values/app_urls.dart';
import '../../data/api_helper.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SpalshPageState();
}

class _SpalshPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 5), () => Get.offNamed(Routes.ONBOARD));
    Future.delayed(Duration(seconds: 5)).then((value) async {
      String? rememberMe = Storage.getValue(Constants.rememberMe);
      String? token = Storage.getValue(Constants.token);
      String fcmToken = FirebaseMessages().fcmToken;
      print("FCM_TOKEN=======>" + fcmToken);
      print(token);
      print(rememberMe);
      if (rememberMe != null &&
          rememberMe == "Yes" &&
          token != null &&
          token.isNotEmpty) {
        print(Storage.getValue(Constants.token).toString());

        ApiHelper apiHelper = ApiHelper.to;
        // LoadingDialog.showLoadingDialog();
        Response fcmResponse = await apiHelper
            .postApiCall(AppUrl.fcbToken, {"fcbToken": fcmToken});
        print("FCM_RESPONSE======>" + fcmResponse.body.toString());
        // LoadingDialog.closeLoadingDialog();
        Get.offNamed(Routes.DASHBOARD);
      } else {
        Get.offNamed(Routes.ONBOARD);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appTheme,
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColors.appTheme,
          systemNavigationBarColor: AppColors.appTheme,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Image.asset(
            AppImages.splash_screen,
          )),
    );
  }
}
