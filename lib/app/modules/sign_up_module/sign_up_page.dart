import 'package:famooshed/app/common/util/validators.dart';
import 'package:famooshed/app/modules/sign_up_module/sign_up_controller.dart';
import 'package:famooshed/app/modules/widgets/custom_default_button.dart';
import 'package:famooshed/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../common/util/exports.dart';
import '../../theme/size_config.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.appThemeLight,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back, color: AppColors.darkGreenColor))),
      backgroundColor: AppColors.loginBackgroud,
      body: GetBuilder(
        builder: (SignUpController signUpController) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * .05, vertical: Get.height * .01),
                child: Form(
                  key: signUpController.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.createAccount,
                              style: beVietnamProaBold.copyWith(
                                  fontSize: getProportionalFontSize(32),
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.appTheme)),
                        ],
                      ),
                      SizedBox(height: Get.height * .03),
                      CustomTextFieldWidget(
                        controller: signUpController.nameController,
                        validator: Validators.validateEmpty,
                        addHint: true,
                        hintText: Strings.name,
                        hintStyle: urbanistRegular.copyWith(
                          color: const Color(0xFF204F33).withOpacity(.68),
                          fontSize: getProportionalFontSize(15),
                        ),
                        obscureText: false,
                      ),
                      SizedBox(height: Get.height * .03),
                      CustomTextFieldWidget(
                        controller: signUpController.emailController,
                        validator: Validators.validateEmail,
                        addHint: true,
                        hintStyle: urbanistRegular.copyWith(
                          color: const Color(0xFF204F33).withOpacity(.68),
                          fontSize: getProportionalFontSize(15),
                        ),
                        hintText: Strings.emailAddress,
                        obscureText: false,
                      ),
                      SizedBox(height: Get.height * .03),
                      CustomTextFieldWidget(
                        controller: signUpController.phoneController,
                        validator: Validators.validatePhone,
                        addHint: true,
                        hintStyle: urbanistRegular.copyWith(
                          color: const Color(0xFF204F33).withOpacity(.68),
                          fontSize: getProportionalFontSize(15),
                        ),
                        hintText: Strings.mobileNumber,
                        obscureText: false,
                      ),
                      SizedBox(height: Get.height * .03),
                      CustomTextFieldWidget(
                        controller: signUpController.locationController,
                        validator: Validators.validateEmpty,
                        addHint: true,
                        hintStyle: urbanistRegular.copyWith(
                          color: const Color(0xFF204F33).withOpacity(.68),
                          fontSize: getProportionalFontSize(15),
                        ),
                        hintText: Strings.location,
                        obscureText: false,
                      ),
                      SizedBox(height: Get.height * .03),
                      CustomTextFieldWidget(
                        obscureText: !signUpController.passwordVisible.value,
                        controller: signUpController.passController,
                        validator: Validators.validatePassword,
                        hintStyle: urbanistRegular.copyWith(
                          color: const Color(0xFF204F33).withOpacity(.68),
                          fontSize: getProportionalFontSize(15),
                        ),
                        addHint: true,
                        hintText: Strings.password,
                        suffixIcon: IconButton(
                          icon: Icon(
                            signUpController.passwordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.lightGreenColor,
                          ),
                          onPressed: () {
                            signUpController.passwordVisible.value =
                                !signUpController.passwordVisible.value;
                            signUpController.update();
                          },
                        ),
                      ),
                      SizedBox(height: Get.height * .03),
                      CustomTextFieldWidget(
                        obscureText: !signUpController.passwordVisible.value,
                        controller: signUpController.confirmController,
                        validator: (value) =>
                            Validators.validateConfirmPassword(
                                value, signUpController.passController.text),
                        hintStyle: urbanistRegular.copyWith(
                          color: const Color(0xFF204F33).withOpacity(.68),
                          fontSize: getProportionalFontSize(15),
                        ),
                        addHint: true,
                        hintText: Strings.confirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            signUpController.passwordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.lightGreenColor,
                          ),
                          onPressed: () {
                            signUpController.passwordVisible.value =
                                !signUpController.passwordVisible.value;
                            signUpController.update();
                          },
                        ),
                      ),
                      SizedBox(height: Get.height * .02),
                      DefaultButton(
                        buttonColor: AppColors.darkGreenColor,
                        color: AppColors.white,
                        text: Strings.signUp,
                        width: Get.width,
                        textStyle: urbanistBold.copyWith(
                          color: Colors.white,
                          fontSize: getProportionalFontSize(15),
                        ),
                        height: getProportionateScreenHeight(50),
                        onTap: () {
                          signUpController.register();
                        },
                      ),
                      SizedBox(height: Get.height * .03),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                style: urbanistMedium.copyWith(
                                    fontSize: getProportionalFontSize(14),
                                    color: "#697A70".fromHex),
                                text:
                                    "By Clicking “Sign Up” You certify that you agree to our ",
                                children: [
                                  TextSpan(
                                      text: "Privacy Policy ",
                                      style: urbanistBold.copyWith(
                                          fontSize: getProportionalFontSize(14),
                                          color: "#215034".fromHex),
                                      children: [
                                        TextSpan(
                                            text: "and",
                                            style: urbanistMedium.copyWith(
                                                fontSize:
                                                    getProportionalFontSize(14),
                                                color: "#697A70".fromHex),
                                            children: [
                                              TextSpan(
                                                text: " Terms & Conditions",
                                                style: urbanistBold.copyWith(
                                                    fontSize:
                                                        getProportionalFontSize(
                                                            14),
                                                    color: "#215034".fromHex),
                                              )
                                            ])
                                      ])
                                ])
                          ])),
                      SizedBox(height: Get.height * .1),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  style: urbanistMedium.copyWith(
                                      fontSize: getProportionalFontSize(14),
                                      color: "#697A70".fromHex),
                                  text: Strings.alreadyHave,
                                  children: [
                                    TextSpan(
                                      text: Strings.signIn,
                                      style: urbanistBold.copyWith(
                                          fontSize: getProportionalFontSize(14),
                                          color: "#215034".fromHex),
                                    )
                                  ])
                            ])),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
