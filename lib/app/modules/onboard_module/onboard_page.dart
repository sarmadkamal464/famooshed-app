import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/modules/onboard_module/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../theme/app_text_theme.dart';
import '../../theme/size_config.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class OnboardPage extends GetView<OnboardController> {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColors.appTheme,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      backgroundColor: AppColors.appTheme,
      body: Container(
        color: AppColors.appTheme,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(height: Get.height * .004),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(50),
              ),
              child: Image.asset(
                AppImages.onboard1,
                height: getProportionateScreenHeight(241),
                fit: BoxFit.fitWidth,
              ),
            ),
            Text(
              'we deliver directly\nto your door'.capitalize!,
              style: beVietnamProExtraBold.copyWith(
                  color: AppColors.white,
                  fontSize: getProportionalFontSize(32),
                  fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            // DefaultButton(
            //   textColor: AppColors.appTheme,
            //   textStyle: urbanistBold.copyWith(fontSize: 18),
            //   buttonColor: AppColors.white,
            //   color: AppColors.white,
            //   text: Strings.getStarted,
            //   width: Get.width * 0.5,
            // onTap: () {
            //   controller.redirectToLoginPage();
            // },
            // ),
            GestureDetector(
              onTap: () {
                controller.redirectToLoginPage();
              },
              child: Padding(
                padding: EdgeInsets.only(right: Get.width * .08),
                child: SvgPicture.asset("assets/icons/getstarted.svg"),
              ),
            ),
            Image.asset(
              AppImages.onboardBottom,
              width: Get.width,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
