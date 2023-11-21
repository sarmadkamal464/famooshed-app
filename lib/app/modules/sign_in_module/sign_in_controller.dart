import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/common/util/loading_dialog.dart';
import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/signin_response.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/utils/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/util/exports.dart';
import '../../common/util/firebase_messeging_helper/firebase_helper.dart';
import '../../common/util/validators.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/size_config.dart';
import '../../utils/dprint.dart';
import '../widgets/custom_default_button.dart';
import '../widgets/custom_text_field_widget.dart';
// GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//       'https://www.googleapis.com/auth/contacts.readonly',
//     ],
//   );

class SignInController extends GetxController {
  @override
  void onReady() {
    getDebugData();
    super.onReady();
  }

  final ApiHelper _apiHelper = ApiHelper.to;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final forgotPasstextCont = TextEditingController();
  final passController = TextEditingController();
  RxBool passwordVisible = false.obs;
  RxBool isRemeber = false.obs;
  int currentView = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  getDebugData() {
    if (kDebugMode) {
      // emailController.text = "nightcoder13@gmail.com";
      // emailController.text = "whole_milk@gmail.com";
      emailController.text = "ankit@spyvebsolutions.com";
      // passController.text = "123456";
      passController.text = "123465";
    }
  }

  signIn() {
    Get.toNamed(Routes.OTP);
  }

  signInWithGoogle() async {
    // await Authentication.signOut(context: Get.context!);

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
      auth.User? user =
          await Authentication.signInWithGoogle(context: Get.context!);
      dprint(user);
      checkUser(user!, 'google');
    } on auth.FirebaseAuthException catch (error) {
      Utils.showSnackbar("${error.message ?? "Something went wrong!!!"}");
    } catch (e) {
      print(e);
    }
  }

  signInWithFacebook() async {
    // LoginResult result = await FacebookAuth.instance.login();
    //
    // if (result.status == LoginStatus.success) {
    //   final OAuthCredential facebookAuthCredential =
    //       FacebookAuthProvider.credential(result.accessToken!.token);
    //
    //   print(facebookAuthCredential);

    try {
      final result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        print(userData);
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        if (userCredential.user != null) {
          auth.User firebaseUser = userCredential.user!;
          checkUser(firebaseUser, 'facebook');
        }
      }
    } on auth.FirebaseAuthException catch (error) {
      Utils.showSnackbar("${error.message ?? "Something went wrong!!!"}");
    } catch (e) {
      print(e);
    }
  }

  signInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ], nonce: nonce);
      dprint(credential);

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      if (userCredential.user != null) {
        auth.User firebaseUser = userCredential.user!;
        checkUser(firebaseUser, 'apple');
      }
    } on auth.FirebaseAuthException catch (error) {
      Utils.showSnackbar("${error.message ?? "Something went wrong!!!"}");
    } catch (e) {
      print(e);
    }
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  void loginNormal() {
    var body = {
      'email': emailController.text,
      'password': passController.text,
    };

    if (formKey.currentState!.validate()) {
      _apiHelper.signIn(AppUrl.loginEmail, body).futureValue(
        (value) async {
          try {
            var response = SignInResponse.fromJson(value);
            if (response.error == 0) {
              String fcmToken = FirebaseMessages().fcmToken;
              print("FCM_TOKEN=======>" + fcmToken);
              await Storage.saveValue(Constants.isLoggedIn, true);
              Storage.saveValue(Constants.userId, response.user!.id);
              await Storage.saveValue(
                  Constants.rememberMe, isRemeber.value == true ? "Yes" : "No");
              await Storage.saveValue(
                      Constants.token, "Bearer ${response.accessToken}")
                  .whenComplete(() async {
                Response fcmResponse = await _apiHelper
                    .postApiCall(AppUrl.fcbToken, {"fcbToken": fcmToken});
                print("FCM_RESPONSE======>" + fcmResponse.body.toString());
                Get.offAllNamed(Routes.DASHBOARD);
              });
            } else {
              Utils.showSnackbar(response.message);
            }
          } catch (e, trace) {
            print(
              e.toString(),
            );
          }
        },
        retryFunction: loginNormal,
      );
    }
  }

  redirctToSignUp() {
    Get.toNamed(Routes.SIGN_UP);
  }

  checkUser(auth.User user, String type) {
    _apiHelper.getApiCall(AppUrl.checkUser + user.email!).futureValue(
      (value) {
        if (value["error"] == null) {
          dprint(value);
          register(user, type);
        } else {
          loginSocial(user);
        }
      },
      retryFunction: () {},
    );
  }

  void register(auth.User user, String type) {
    var body = {
      'email': user.email,
      'password': user.uid,
      'name': user.displayName ?? user.email!.split('@').first,
      'typeReg': type,
      'photoUrl': user.photoURL ?? ''
    };
    // if (formKey.currentState!.validate()) {
    _apiHelper.postApiCall(AppUrl.register, body).futureValue(
      (value) {
        loginSocial(user);
      },
      retryFunction: () {},
    );
    // }
  }

  void loginSocial(auth.User user) {
    var body = {
      'email': user.email,
      'password': user.uid,
    };

    _apiHelper.signIn(AppUrl.loginEmail, body).futureValue(
      (value) async {
        try {
          var response = SignInResponse.fromJson(value);
          if (response.error == 0) {
            String fcmToken = FirebaseMessages().fcmToken;
            print("FCM_TOKEN=======>" + fcmToken);
            await Storage.saveValue(Constants.isLoggedIn, true);
            await Storage.saveValue(Constants.userId, response.user!.id);
            Storage.saveValue(Constants.token, "Bearer ${response.accessToken}")
                .whenComplete(() async {
              LoadingDialog.showLoadingDialog();
              Response fcmResponse = await _apiHelper
                  .postApiCall(AppUrl.fcbToken, {"fcbToken": fcmToken});
              print("FCM_RESPONSE======>" + fcmResponse.body.toString());
              LoadingDialog.closeLoadingDialog();
              Get.offAllNamed(Routes.DASHBOARD);
            });
          } else {
            Utils.showSnackbar(response.message);
          }
        } catch (e, trace) {
          print(
            e.toString(),
          );
        }
      },
      retryFunction: () {},
    );
  }

  Future<void> forgotPassword() async {
    LoadingDialog.showLoadingDialog();

    try {
      var body = {"email": forgotPasstextCont.text};
      Response response = await _apiHelper.postApiCall(
        AppUrl.forgotPassword,
        body,
      );

      print(body);
      if (response.statusCode == 200) {
        LoadingDialog.closeLoadingDialog();
        if (response.body['error'] == '0') {
          Get.back();
          checkEmailBottomSheet();
        } else {
          Utils.showSnackbar(
              response.body['message'] ?? "Something went wrong!!!");
        }
      }
    } catch (e) {
      LoadingDialog.closeLoadingDialog();
      print(e.toString());
    }
  }

  checkEmailBottomSheet() {
    return Get.bottomSheet(
      barrierColor: Colors.black.withOpacity(.6),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24.0),
              topLeft: Radius.circular(24.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height * .02,
              ),
              child: Column(children: [
                SvgPicture.asset(AppImages.bottomHeader),
                SizedBox(height: Get.height * .05),
                SvgPicture.asset(AppImages.checkMail),
                SizedBox(height: Get.height * .03),
                Text(
                  Strings.checkEmail,
                  style: beVietnamProaBold.copyWith(
                      color: AppColors.appTheme, fontSize: 24),
                ),
                SizedBox(height: Get.height * .03),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "We have sent a password recovery instructions\nemail to ",
                        style: urbanistMedium.copyWith(
                          color: '#9EA4A0'.fromHex,
                          fontSize: getProportionalFontSize(16),
                        ),
                        children: [
                          TextSpan(
                            text: forgotPasstextCont.text,
                            style: urbanistMedium.copyWith(
                                color: AppColors.appTheme, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * .03),
                DefaultButton(
                  buttonColor: AppColors.darkGreenColor,
                  color: AppColors.white,
                  text: Strings.goToEmail,
                  height: 60,
                  textStyle:
                      urbanistBold.copyWith(color: Colors.white, fontSize: 18),
                  width: Get.width * .8,
                  onTap: () {
                    Get.back();
                    launch("https://mail.google.com/mail/u/0/#inbox");
                  },
                ),
                SizedBox(height: Get.height * .03),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    forgotPasswordBottomSheet();
                  },
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Didn’t receive the email?  ",
                            style: urbanistMedium.copyWith(
                                color: '#9EA4A0'.fromHex, fontSize: 16),
                            children: [
                              TextSpan(
                                text: "try again",
                                style: urbanistMedium.copyWith(
                                    color: AppColors.appTheme, fontSize: 16),
                              )
                            ])
                      ])),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  GlobalKey<FormState> formKeyFor = GlobalKey<FormState>();
  forgotPasswordBottomSheet() {
    return Get.bottomSheet(
        barrierColor: Colors.black.withOpacity(.6),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            // height: Get.height,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24.0),
                topLeft: Radius.circular(24.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Get.height * .02, horizontal: Get.width * .08),
                child: Form(
                  key: formKeyFor,
                  child: Column(children: [
                    SvgPicture.asset(AppImages.bottomHeader),
                    SizedBox(height: Get.height * .05),
                    SvgPicture.asset(AppImages.forgotPassword),
                    SizedBox(height: Get.height * .03),
                    Text(Strings.forgotPassword,
                        style: beVietnamProaBold.copyWith(
                            color: AppColors.appTheme, fontSize: 22)),
                    SizedBox(height: Get.height * .01),
                    Text(
                      Strings.forgotPassInstrs,
                      style: urbanistMedium.copyWith(
                          color: "#9EA4A0".fromHex, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Get.height * .03),
                    CustomTextFieldWidget(
                      lableStyle: urbanistMedium.copyWith(
                          fontSize: 14, color: "#88D707".fromHex),
                      controller: forgotPasstextCont,
                      validator: Validators.validateEmail,
                      addHint: false,
                      hintText: Strings.emailAddress,
                      obscureText: false,
                    ),
                    SizedBox(height: Get.height * .03),
                    DefaultButton(
                      buttonColor: AppColors.darkGreenColor,
                      textStyle: urbanistBold.copyWith(
                          color: AppColors.white, fontSize: 18),
                      color: AppColors.white,
                      text: Strings.sendEmail,
                      width: Get.width * .8,
                      onTap: () async {
                        // checkEmailBottomSheet();

                        if (formKeyFor.currentState!.validate()) {
                          forgotPassword();
                        }

                        // final backButton = await Navigator.of(Get.context!).push<bool?>(
                        //   PageRouteBuilder(
                        //     opaque: false,
                        //     barrierDismissible: true,
                        //     pageBuilder: (_, __, ___) => checkEmailBottomSheet(),
                        //   ),
                        // );
                        // if (backButton == null || backButton == false) {
                        //   if (backButton == true) Navigator.of(Get.context!).pop();
                        // }
                      },
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}
