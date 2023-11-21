import 'package:famooshed/app/modules/widgets/custom_default_button.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:famooshed/app/modules/share_address_module/share_address_controller.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../common/util/exports.dart';

class ShareAddressPage extends GetView<ShareAddressController> {
  const ShareAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back, color: AppColors.darkGreenColor))),
      backgroundColor: AppColors.loginBackgroud,
      body: GetBuilder(
        builder: (ShareAddressController shareAddressController) {
          return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * .12, vertical: Get.height * .01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Strings.shareAddress.capitalize!,
                    textAlign: TextAlign.center,
                    style: beVietnamProaBold.copyWith(
                        fontSize: 32, color: HexColor('215034')),
                  ),
                  SizedBox(height: Get.height * .02),
                  Text(
                    Strings.allowLocationAcess,
                    textAlign: TextAlign.center,
                    style: urbanistMedium.copyWith(color: HexColor("697A70")),
                  ),
                  SizedBox(height: Get.height * .04),
                  Image.asset(AppImages.shareAddress),
                  SizedBox(height: Get.height * .04),
                  DefaultButton(
                    buttonColor: AppColors.darkGreenColor,
                    color: AppColors.white,
                    text: Strings.allowLocations,
                    width: Get.width,
                    onTap: () {
                      controller.redirectToDashboard();
                    },
                  ),
                  SizedBox(height: Get.height * .04),
                  GestureDetector(
                    onTap: () {
                      controller.redirectToDashboard();
                    },
                    child: Text(
                      Strings.skipForNow.capitalize!,
                      textAlign: TextAlign.center,
                      style: urbanistBold.copyWith(
                          fontSize: 18, color: HexColor('215034')),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
