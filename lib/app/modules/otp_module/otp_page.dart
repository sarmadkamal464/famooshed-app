import 'package:famooshed/app/modules/widgets/custom_default_button.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:famooshed/app/modules/otp_module/otp_controller.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pinput/pinput.dart';

import '../../common/util/exports.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class OtpPage extends GetView<OtpController> {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    const fillColor = AppColors.appTheme;

    final defaultPinTheme = PinTheme(
      width: 80,
      height: 80,
      textStyle: const TextStyle(
        fontSize: 32,
        color: AppColors.white,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: fillColor, width: 3),
      ),
    );
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back, color: AppColors.darkGreenColor))),
      backgroundColor: AppColors.loginBackgroud,
      body: GetBuilder(
        builder: (OtpController otpController) {
          return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * .12, vertical: Get.height * .01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Strings.verifyAccount,
                    style: beVietnamProaBold.copyWith(
                        fontSize: 32, color: HexColor('215034')),
                  ),
                  SizedBox(height: Get.height * .02),
                  Text(
                    "We send a code on your phone number",
                    style: urbanistMedium.copyWith(color: HexColor("697A70")),
                  ),
                  Text(
                    "+44********808",
                    style: urbanistBold.copyWith(color: HexColor("215034")),
                  ),
                  SizedBox(height: Get.height * .04),
                  Directionality(
                    // Specify direction if desired
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      controller: otpController.pinController,
                      focusNode: otpController.focusNode,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      listenForMultipleSmsOnAndroid: true,
                      defaultPinTheme: defaultPinTheme,
                      // hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) {
                        debugPrint('onCompleted: $pin');
                      },
                      onChanged: (value) {
                        debugPrint('onChanged: $value');
                      },

                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: fillColor, width: 3),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: fillColor),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Resend in: ",
                        style:
                            urbanistMedium.copyWith(color: HexColor("697A70")),
                      ),
                      Text(
                        "00:30",
                        style: urbanistBold.copyWith(color: HexColor("215034")),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * .04),
                  DefaultButton(
                    buttonColor: AppColors.darkGreenColor,
                    color: AppColors.white,
                    text: Strings.continueText,
                    width: Get.width,
                    onTap: () {
                      controller.redirectToAddressShare();
                    },
                  ),
                ],
              ));
        },
      ),
    );
  }
}
