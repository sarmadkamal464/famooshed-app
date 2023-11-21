// ignore_for_file: must_be_immutable

import 'package:famooshed/app/modules/checkout_module/checkout_controller.dart';
import 'package:famooshed/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/util/exports.dart';
import '../../theme/app_text_theme.dart';
import '../widgets/custom_appbar_widget.dart';

class SelectAddressPage extends GetView<CheckoutController> {
  SelectAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        centerTitle: true,
        backgroundColor: AppColors.white,
        statusBarColor: AppColors.white,
        title: "Delivery Address",
      ),
      backgroundColor: AppColors.white,
      body: GetBuilder<CheckoutController>(
        builder: (CheckoutController checkoutController) {
          return SingleChildScrollView(
            clipBehavior: Clip.none,
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16),
                vertical: getProportionateScreenHeight(16)),
            child: Column(
              children: [
                checkoutController.addressList.isEmpty
                    ? SizedBox(
                        height: 50,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "No Address Found",
                              style: beVietnamProSemiBold,
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          for (var i = 0;
                              i < checkoutController.addressList.length;
                              i++)
                            SizedBox(
                              width: Get.width,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                        AppImages.locationPlaceholder,
                                      ),
                                    ),
                                    titleAlignment: ListTileTitleAlignment.top,
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(
                                      checkoutController.addressList[i].type ??
                                          '-'.capitalize.toString(),
                                      style: beVietnamProSemiBold.copyWith(
                                        color: const Color(0xFF204F33),
                                        fontSize: getProportionalFontSize(16),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        checkoutController.addressList[i]
                                                        .addressResponseDefault !=
                                                    null &&
                                                checkoutController
                                                        .addressList[i]
                                                        .addressResponseDefault ==
                                                    "true"
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                    color: AppColors.appTheme,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Text(
                                                  "Default",
                                                  style: urbanistRegular.copyWith(
                                                      color: AppColors.white,
                                                      fontSize:
                                                          getProportionalFontSize(
                                                              13)),
                                                ),
                                              )
                                            : const SizedBox(),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(8),
                                        ),
                                        Text(
                                          checkoutController
                                                  .addressList[i].flatHouseNo ??
                                              '-'.capitalize.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: urbanistRegular.copyWith(
                                            color: const Color(0xFF9D9D9D),
                                            fontSize:
                                                getProportionalFontSize(13),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          checkoutController
                                                  .addressList[i].text ??
                                              '-'.capitalize.toString(),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: urbanistRegular.copyWith(
                                            color: const Color(0xFF9D9D9D),
                                            fontSize:
                                                getProportionalFontSize(13),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: SizedBox(
                                      width: SizeConfig.deviceWidth! * .25,
                                      child: Radio(
                                          activeColor: AppColors.appTheme,
                                          value: checkoutController
                                              .addressList[i].text,
                                          groupValue: controller.addValue.value,
                                          onChanged: (val) {
                                            checkoutController.addValue.value =
                                                val as String;
                                            checkoutController.selectedAddress =
                                                checkoutController
                                                    .addressList[i];
                                            checkoutController.update();
                                          }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(5),
                                  ),
                                  Visibility(
                                      visible: i <
                                          checkoutController
                                                  .addressList.length -
                                              1,
                                      child: Divider(
                                        thickness: 1,
                                        endIndent: 20,
                                      ))
                                ],
                              ),
                            ),
                        ],
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
