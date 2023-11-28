import 'dart:io';

import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/common/util/validators.dart';
import 'package:famooshed/app/modules/sign_in_module/sign_in_controller.dart';
import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed/app/modules/widgets/custom_default_button.dart';
import 'package:famooshed/app/modules/widgets/custom_icon_button.dart';
import 'package:famooshed/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/size_config.dart';

class SignInPage extends GetView<SignInController> {
  SignInPage({super.key});
  final formKeyFor = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppbarWidget(),
      backgroundColor: AppColors.loginBackgroud,
      body: GetBuilder(
        builder: (SignInController signInController) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * .05,
                          vertical: Get.height * .02),
                      child: Form(
                        key: signInController.formKey,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Strings.signIn,
                                    style: TextStyle(
                                        fontSize: Dimens.fontSize26,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.darkGreenColor)),
                              ],
                            ),
                            SizedBox(height: Get.height * .02),
                            CustomTextFieldWidget(
                              controller: signInController.emailController,
                              validator: Validators.validateEmail,
                              addHint: true,
                              keyboardType: TextInputType.emailAddress,
                              hintText: Strings.emailAddress,
                              obscureText: false,
                            ),
                            SizedBox(height: Get.height * .03),
                            CustomTextFieldWidget(
                              obscureText:
                                  !signInController.passwordVisible.value,
                              controller: signInController.passController,
                              validator: Validators.validatePassword,
                              hintStyle:
                                  TextStyle(color: AppColors.lightGreenColor),
                              addHint: true,
                              keyboardType: TextInputType.visiblePassword,
                              hintText: Strings.password,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  signInController.passwordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.lightGreenColor,
                                ),
                                onPressed: () {
                                  signInController.passwordVisible.value =
                                      !signInController.passwordVisible.value;
                                  signInController.update();
                                },
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 18.0,
                                  child: Transform.scale(
                                    scale: 0.9,
                                    child: Checkbox(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        activeColor: AppColors.appTheme,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        side: const BorderSide(
                                          color: AppColors.appTheme,
                                          width: 1.5,
                                        ),
                                        checkColor: AppColors.white,
                                        value: signInController.isRemeber.value,
                                        onChanged: (e) {
                                          signInController.isRemeber.value =
                                              !signInController.isRemeber.value;
                                          signInController.update();
                                        }),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  Strings.rememberMe,
                                  style: urbanistMedium.copyWith(
                                      color: AppColors.appTheme, fontSize: 16),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    controller.forgotPasswordBottomSheet();
                                  },
                                  child: Text(
                                    Strings.forgotPassword,
                                    style: urbanistBold.copyWith(
                                        color: AppColors.appTheme,
                                        fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: Get.height * .02),
                            DefaultButton(
                              buttonColor: AppColors.darkGreenColor,
                              textStyle: urbanistBold.copyWith(
                                  fontSize: 18, color: AppColors.white),
                              text: Strings.signIn,
                              width: Get.width,
                              onTap: () {
                                signInController.loginNormal();
                              },
                            ),
                            SizedBox(height: Get.height * .03),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                      style: urbanistMedium.copyWith(
                                          color: "#697A70".fromHex,
                                          fontSize: 14),
                                      text:
                                          "By Clicking “Sign In” You certify that you agree to our ",
                                      children: [
                                        TextSpan(
                                            text: "Privacy Policy ",
                                            style: urbanistBold.copyWith(
                                                color: AppColors.appTheme,
                                                fontSize: 14),
                                            children: [
                                              TextSpan(
                                                  text: "and",
                                                  style:
                                                      urbanistMedium.copyWith(
                                                          color:
                                                              "#697A70".fromHex,
                                                          fontSize: 14),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          " Terms & Conditions",
                                                      style:
                                                          urbanistBold.copyWith(
                                                              color: AppColors
                                                                  .appTheme,
                                                              fontSize: 14),
                                                    )
                                                  ])
                                            ])
                                      ])
                                ])),
                            SizedBox(height: Get.height * .03),
                            Center(
                              child: Text(
                                Strings.signInWith,
                                style: urbanistMedium.copyWith(
                                    color: AppColors.appTheme, fontSize: 16),
                              ),
                            ),
                            SizedBox(height: Get.height * .03),
                            CustomIconButtonWidget(
                                onTap: controller.signInWithGoogle,
                                text: Strings.signInWithGoogle,
                                buttonColor: AppColors.redColor,
                                color: AppColors.lightRed,
                                textColor: AppColors.white,
                                width: Get.width * .75,
                                logo: AppImages.googleLogo),
                            Visibility(
                              visible: Platform.isIOS,
                              child: Column(
                                children: [
                                  SizedBox(height: Get.height * .02),
                                  CustomIconButtonWidget(
                                      onTap: () {
                                        controller.signInWithApple();
                                      },
                                      text: Strings.signInWithApple,
                                      buttonColor: AppColors.black,
                                      color: AppColors.lightBlack,
                                      textColor: AppColors.white,
                                      width: Get.width * .75,
                                      logo: AppImages.appleLogo),
                                ],
                              ),
                            ),
                            // Platform.isIOS
                            //     ? SizedBox(height: Get.height * .02)
                            //     : SizedBox(),
                            // Platform.isIOS
                            //     ? CustomIconButtonWidget(
                            //         onTap: () {
                            //           controller.signInWithApple();
                            //         },
                            //         text: Strings.signInWithApple,
                            //         buttonColor: AppColors.black,
                            //         color: AppColors.lightBlack,
                            //         textColor: AppColors.white,
                            //         width: Get.width * .75,
                            //         logo: AppImages.appleLogo)
                            //     : SizedBox(),
                            SizedBox(height: Get.height * .02),
                            CustomIconButtonWidget(
                                onTap: () {
                                  controller.signInWithFacebook();
                                },
                                text: Strings.signInWithFacebook,
                                textColor: AppColors.white,
                                buttonColor: AppColors.blueColor,
                                color: AppColors.lightBlue,
                                width: Get.width * .75,
                                logo: AppImages.facebooklogo),
                            SizedBox(height: Get.height * .04),
                            // GestureDetector(
                            //   onTap: () {
                            //     controller.redirctToSignUp();
                            //   },
                            //   child: RichText(
                            //       textAlign: TextAlign.center,
                            //       text: TextSpan(children: [
                            //         TextSpan(
                            //             style: urbanistMedium.copyWith(
                            //                 color: "#697A70".fromHex, fontSize: 16),
                            //             text: Strings.donotHaveAcc,
                            //             children: [
                            //               TextSpan(
                            //                 text: " ${Strings.createAcc}",
                            //                 style: urbanistBold.copyWith(
                            //                     color: AppColors.appTheme,
                            //                     fontSize: 14),
                            //               )
                            //             ])
                            //       ])),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      bottom:
                          50.0), // Adjust the value for the desired bottom space
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        controller.redirctToSignUp();
                      },
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                style: urbanistMedium.copyWith(
                                    color: "#697A70".fromHex, fontSize: 16),
                                text: Strings.donotHaveAcc,
                                children: [
                                  TextSpan(
                                    text: " ${Strings.createAcc}",
                                    style: urbanistBold.copyWith(
                                        color: AppColors.appTheme,
                                        fontSize: 14),
                                  )
                                ])
                          ])),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // forgotPasswordBottomSheet(SignInController signInController) {
  //   return Get.bottomSheet(
  //       barrierColor: Colors.black.withOpacity(.6),
  //       BackdropFilter(
  //         filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
  //         child: Container(
  //           // height: Get.height,
  //           width: double.maxFinite,
  //           decoration: const BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.only(
  //               topRight: Radius.circular(24.0),
  //               topLeft: Radius.circular(24.0),
  //             ),
  //           ),
  //           child: SingleChildScrollView(
  //             child: Padding(
  //               padding: EdgeInsets.symmetric(
  //                   vertical: Get.height * .02, horizontal: Get.width * .08),
  //               child: Form(
  //                 key: formKeyFor,
  //                 child: Column(children: [
  //                   SvgPicture.asset(AppImages.bottomHeader),
  //                   SizedBox(height: Get.height * .05),
  //                   SvgPicture.asset(AppImages.forgotPassword),
  //                   SizedBox(height: Get.height * .03),
  //                   Text(Strings.forgotPassword,
  //                       style: beVietnamProaBold.copyWith(
  //                           color: AppColors.appTheme, fontSize: 22)),
  //                   SizedBox(height: Get.height * .01),
  //                   Text(
  //                     Strings.forgotPassInstrs,
  //                     style: urbanistMedium.copyWith(
  //                         color: "#9EA4A0".fromHex, fontSize: 14),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   SizedBox(height: Get.height * .03),
  //                   CustomTextFieldWidget(
  //                     lableStyle: urbanistMedium.copyWith(
  //                         fontSize: 14, color: "#88D707".fromHex),
  //                     controller: signInController.forgotPasstextCont,
  //                     validator: Validators.validateEmail,
  //                     addHint: false,
  //                     hintText: Strings.emailAddress,
  //                     obscureText: false,
  //                   ),
  //                   SizedBox(height: Get.height * .03),
  //                   DefaultButton(
  //                     buttonColor: AppColors.darkGreenColor,
  //                     textStyle: urbanistBold.copyWith(
  //                         color: AppColors.white, fontSize: 18),
  //                     color: AppColors.white,
  //                     text: Strings.sendEmail,
  //                     width: Get.width * .8,
  //                     onTap: () async {
  //                       // checkEmailBottomSheet();
  //
  //                       if (formKeyFor.currentState!.validate()) {
  //                         await signInController.forgotPassword();
  //                         Get.back();
  //                         checkEmailBottomSheet(signInController);
  //                       }
  //
  //                       // final backButton = await Navigator.of(Get.context!).push<bool?>(
  //                       //   PageRouteBuilder(
  //                       //     opaque: false,
  //                       //     barrierDismissible: true,
  //                       //     pageBuilder: (_, __, ___) => checkEmailBottomSheet(),
  //                       //   ),
  //                       // );
  //                       // if (backButton == null || backButton == false) {
  //                       //   if (backButton == true) Navigator.of(Get.context!).pop();
  //                       // }
  //                     },
  //                   ),
  //                 ]),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ));
  // }
  //
  // checkEmailBottomSheet(SignInController signInController) {
  //   return Get.bottomSheet(
  //     barrierColor: Colors.black.withOpacity(.6),
  //     BackdropFilter(
  //       filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
  //       child: Container(
  //         width: double.maxFinite,
  //         decoration: const BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.only(
  //             topRight: Radius.circular(24.0),
  //             topLeft: Radius.circular(24.0),
  //           ),
  //         ),
  //         child: SingleChildScrollView(
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(
  //               vertical: Get.height * .02,
  //             ),
  //             child: Column(children: [
  //               SvgPicture.asset(AppImages.bottomHeader),
  //               SizedBox(height: Get.height * .05),
  //               SvgPicture.asset(AppImages.checkMail),
  //               SizedBox(height: Get.height * .03),
  //               Text(
  //                 Strings.checkEmail,
  //                 style: beVietnamProaBold.copyWith(
  //                     color: AppColors.appTheme, fontSize: 24),
  //               ),
  //               SizedBox(height: Get.height * .03),
  //               RichText(
  //                 textAlign: TextAlign.center,
  //                 text: TextSpan(
  //                   children: [
  //                     TextSpan(
  //                       text:
  //                           "We have sent a password recovery instructions\nemail to ",
  //                       style: urbanistMedium.copyWith(
  //                         color: '#9EA4A0'.fromHex,
  //                         fontSize: getProportionalFontSize(16),
  //                       ),
  //                       children: [
  //                         TextSpan(
  //                           text: signInController.forgotPasstextCont.text,
  //                           style: urbanistMedium.copyWith(
  //                               color: AppColors.appTheme, fontSize: 16),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(height: Get.height * .03),
  //               DefaultButton(
  //                 buttonColor: AppColors.darkGreenColor,
  //                 color: AppColors.white,
  //                 text: Strings.goToEmail,
  //                 height: 60,
  //                 textStyle:
  //                     urbanistBold.copyWith(color: Colors.white, fontSize: 18),
  //                 width: Get.width * .8,
  //                 onTap: () {
  //                   Get.back();
  //                 },
  //               ),
  //               SizedBox(height: Get.height * .03),
  //               GestureDetector(
  //                 onTap: () {
  //                   Get.back();
  //                   forgotPasswordBottomSheet(signInController);
  //                 },
  //                 child: RichText(
  //                     textAlign: TextAlign.center,
  //                     text: TextSpan(children: [
  //                       TextSpan(
  //                           text: "Didn’t receive the email?  ",
  //                           style: urbanistMedium.copyWith(
  //                               color: '#9EA4A0'.fromHex, fontSize: 16),
  //                           children: [
  //                             TextSpan(
  //                               text: "try again",
  //                               style: urbanistMedium.copyWith(
  //                                   color: AppColors.appTheme, fontSize: 16),
  //                             )
  //                           ])
  //                     ])),
  //               ),
  //             ]),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
