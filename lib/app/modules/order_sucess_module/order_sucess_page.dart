import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:famooshed/app/modules/order_sucess_module/order_sucess_controller.dart';

import '../../common/util/exports.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class OrderSucessPage extends GetView<OrderSucessController> {
  const OrderSucessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (OrderSucessController orderSucessController) {
        return Scaffold(
          backgroundColor: AppColors.loginBackgroud,
          body: SizedBox(
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppImages.congrats),
                Text(
                  Strings.orderSuccess,
                  style: beVietnamProaBold.copyWith(
                      color: AppColors.appTheme, fontSize: 26),
                ),
                Text(
                  Strings.orderPlaced,
                  style: urbanistRegular.copyWith(
                      color: AppColors.appTheme, fontSize: 16),
                ),
                SizedBox(
                  height: Get.height * .1,
                ),
                orderSucessController.orderAccepted.value
                    ? const Icon(Icons.check)
                    : const CupertinoActivityIndicator(
                        color: AppColors.appTheme,
                        radius: 20,
                      ),
                SizedBox(
                  height: Get.height * .04,
                ),
                // orderSucessController.orderAccepted.value
                //     ? Text(
                //         Strings.acceptByRider,
                //         style: urbanistRegular.copyWith(
                //             color: AppColors.appTheme, fontSize: 16),
                //       )
                //     : Text(
                //         Strings.waitingForAccept,
                //         style: urbanistRegular.copyWith(
                //             color: AppColors.appTheme, fontSize: 16),
                //       ),
                // const SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
