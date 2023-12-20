// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:famooshed/app/data/models/get_cart_model.dart';
import 'package:famooshed/app/modules/checkout_module/checkout_controller.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/util/exports.dart';
import '../../theme/app_text_theme.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/custom_default_button.dart';
import 'checkout_page.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class OrderSummaryPage extends GetView<CheckoutController> {
  OrderSummaryPage({super.key});
  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        centerTitle: true,
        backgroundColor: AppColors.white,
        statusBarColor: AppColors.white,
        title: "Order Summary",
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(16),
            vertical: getProportionateScreenHeight(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            billTotal(),
            DefaultButton(
              text: "Place Order",
              width: Get.width * .9,
              // onTap: () {
              //   Get.toNamed(Routes.PAYMENT_PAGE);
              // },
              onTap: () async {
                await controller.makePayment(
                  controller.cartResponse.data!.payable ?? '',
                  controller.getProfileResponse!.user.email,
                  controller.getProfileResponse!.user.name,
                );
              },
              buttonColor: AppColors.appTheme,
              textColor: AppColors.white,
              textStyle: urbanistRegular.copyWith(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: AppColors.white,
      body: GetBuilder<CheckoutController>(
        builder: (CheckoutController checkoutController) {
          return SafeArea(
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16),
                  vertical: getProportionateScreenHeight(5)),
              child: Column(
                children: [
                  cartCard(checkoutController.cartResponse),
                  checkoutController.takeOrderMySelf.value
                      ? curbSideType(checkoutController)
                      : addressType(checkoutController),
                  // paymentType(),
                  // billTotal(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget cartCard(CartResponse basketResponse) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 12,
              color: Color.fromRGBO(0, 0, 0, 0.16),
            )
          ]),
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      basketResponse.data!.cart!.restaurantProfile!),
                ),
                title: Text(
                  basketResponse.data!.cart!.restaurantName ?? '-',
                  style: beVietnamProaBold.copyWith(
                      fontSize: 20, color: AppColors.appTheme),
                ),
                trailing: Text(
                  "${basketResponse.data!.cart!.products!.length} Items",
                  style: urbanistMedium.copyWith(
                      fontSize: 16, color: AppColors.appTheme),
                ),
              ),
              const Divider(thickness: 2),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: basketResponse.data!.cart!.products!.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = basketResponse.data!.cart!.products![index];
                  return cartItem(data);
                },
              ),
            ],
          )),
    );
  }

  Widget cartItem(Product product) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(product.image!),
      ),
      title: Text(
        product.productName ?? '-'.capitalize.toString(),
        style: beVietnamProSemiBold.copyWith(
            fontSize: 18, color: AppColors.appTheme),
      ),
      subtitle: Text(
        "Price : £${product.unitPrice}",
        style:
            urbanistSemiBold.copyWith(fontSize: 14, color: AppColors.greyText),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // InkWell(
          //   onTap: () {
          //     controller.decrement(detail);
          //   },
          //   child: const Icon(
          //     Icons.remove_circle_outline,
          //     color: AppColors.appTheme,
          //     size: 18,
          //   ),
          // ),
          // const SizedBox(width: 10),
          Text('${product.quantity}',
              style: beVietnamProaBold24.copyWith(
                  fontSize: 16, color: AppColors.appTheme)),
          const SizedBox(width: 10),
          // InkWell(
          //     onTap: () {
          //       controller.increment(detail);
          //     },
          //     child: const Icon(
          //       Icons.add_circle_outline,
          //       color: AppColors.appTheme,
          //       size: 18,
          //     )),
        ],
      ),
    );
  }

  addressType(checkoutController) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Delivery Address",
                  style: beVietnamProaBold.copyWith(
                    color: Color(0xFF204F33),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ))),
          Container(
            width: Get.width,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19204F33),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                getAddress(checkoutController),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getAddress(CheckoutController checkoutController) {
    return checkoutController.selectedAddress == null
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
        : SizedBox(
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.only(
                  left: Get.width * .05,
                  top: getProportionateScreenHeight(12),
                  bottom: getProportionateScreenHeight(12)),
              child: Column(
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage(AppImages.locationPlaceholder),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              checkoutController.selectedAddress!.type ??
                                  '-'.capitalize.toString(),
                              style: beVietnamProSemiBold.copyWith(
                                color: Color(0xFF204F33),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 5),
                            checkoutController.selectedAddress!
                                        .addressResponseDefault ==
                                    "true"
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: AppColors.appTheme,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      "Default",
                                      style: urbanistRegular.copyWith(
                                          color: AppColors.white, fontSize: 14),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                        const SizedBox(height: 3),
                        SizedBox(
                          width: Get.width * .5,
                          child: Text(
                            checkoutController.selectedAddress!.text ??
                                '-'.capitalize.toString(),
                            style: urbanistMedium.copyWith(
                              color: Color(0xFF9D9D9D),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                  ]),
                ],
              ),
            ),
          );
  }

  curbSideType(checkoutController) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Curb Side Pickup",
                  style: beVietnamProaBold.copyWith(
                    color: Color(0xFF204F33),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ))),
          Container(
            width: Get.width,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19204F33),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                getCurbSide(checkoutController),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getCurbSide(CheckoutController checkoutController) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Name:",
                          style: beVietnamProSemiBold.copyWith(
                            fontSize: getProportionalFontSize(15),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                            "${checkoutController.cartResponse.data!.cart!.restaurantName}",
                            style: TextStyle()),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text("Address:",
                            style: beVietnamProSemiBold.copyWith(
                                fontSize: getProportionalFontSize(15))),
                      ),
                      Expanded(
                        child: Text(
                            "${checkoutController.cartResponse.data!.cart!.restaurantName}",
                            style: TextStyle()),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Arriving Date:",
                          style: beVietnamProSemiBold.copyWith(
                            fontSize: getProportionalFontSize(15),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Text(
                              "${checkoutController.cartResponse.data!.cart!.arrivalDate ?? controller.selectedDate}"))
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Arriving Time:",
                          style: beVietnamProSemiBold.copyWith(
                            fontSize: getProportionalFontSize(15),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Text(
                              "${checkoutController.cartResponse.data!.cart!.arrivalTime ?? controller.startTimeController}"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  paymentType() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Payment Method",
              style: beVietnamProaBold.copyWith(
                  color: AppColors.appTheme, fontSize: 20),
            ),
          ),
          Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19204F33),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  RadioListTile<PaymentEnum>(
                    activeColor: AppColors.appTheme,
                    contentPadding: EdgeInsets.zero,
                    title: Row(children: [
                      // SizedBox(
                      //     width: 40,
                      //     child: SvgPicture.asset("assets/svg/Chip.svg")),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Master / Visa Card",
                            style: beVietnamProSemiBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("********4545"),
                        ],
                      )
                    ]),
                    value: PaymentEnum.card,
                    groupValue: controller.payment,
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (PaymentEnum? value) {
                      controller.payment = value;
                      controller.update();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  billTotal() {
    // double total =
    //     double.parse(controller.getBasketResponse.basketTotalWithTax);
    // total = total + controller.deliveryFee.value;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping Amount",
                style: beVietnamProaBold.copyWith(
                    color: AppColors.appTheme, fontSize: 15.5),
              ),
              Text(
                "£${controller.cartResponse.data!.cart!.deliveryPrice}",
                style: beVietnamProaBold.copyWith(
                    color: AppColors.appTheme, fontSize: 15.5),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discount Amount",
                style: beVietnamProaBold.copyWith(
                    color: AppColors.appTheme, fontSize: 15.5),
              ),
              Text(
                "£${controller.cartResponse.data!.cart!.discountAmount}",
                style: beVietnamProaBold.copyWith(
                    color: AppColors.appTheme, fontSize: 15.5),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Items",
                style: beVietnamProaBold.copyWith(
                    color: AppColors.appTheme.withOpacity(.5), fontSize: 20),
              ),
              Text(
                "${controller.cartResponse.data!.cart!.products!.length} Items",
                style: beVietnamProaBold.copyWith(
                    color: AppColors.appTheme.withOpacity(.5), fontSize: 20),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: beVietnamProaBold.copyWith(
                    color: AppColors.appTheme, fontSize: 20),
              ),
              Text(
                "£${controller.cartResponse.data!.payable}",
                style: beVietnamProaBold.copyWith(
                    color: AppColors.appTheme, fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Future<void> makePayment(String payable) async {
  //   try {
  //     int amountInCents = (double.parse(payable) * 100).round();
  //     paymentIntent =
  //         await createPaymentIntent(amountInCents.toString(), 'GBP');

  //     var gpay = PaymentSheetGooglePay(
  //         merchantCountryCode: "GB",
  //         currencyCode: "GBP",
  //         testEnv: true,
  //         label: 'famooshed Pay',
  //         amount: '100');
  //     //STEP 2: Initialize Payment Sheet
  //     await Stripe.instance
  //         .initPaymentSheet(
  //             paymentSheetParameters: SetupPaymentSheetParameters(
  //                 paymentIntentClientSecret: paymentIntent![
  //                     'client_secret'], //Gotten from payment intent
  //                 style: ThemeMode.light,
  //                 merchantDisplayName: 'Famooshed',
  //                 googlePay: gpay,
  //                 applePay: const PaymentSheetApplePay(
  //                   buttonType: PlatformButtonType.buy,
  //                   merchantCountryCode: 'GB',
  //                 )))
  //         .then((value) {});

  //     //STEP 3: Display Payment sheet
  //     displayPaymentSheet();
  //   } catch (err) {
  //     print(err);
  //   }
  // }

  // displayPaymentSheet() async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet().then((value) {
  //       print("Payment Successfully");
  //     });
  //   } catch (e) {
  //     print('$e');
  //   }
  // }

  // createPaymentIntent(String amount, String currency) async {
  //   try {
  //     Map<String, dynamic> body = {
  //       'amount': amount,
  //       'currency': currency,
  //     };

  //     var response = await http.post(
  //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //       headers: {
  //         'Authorization':
  //             'Bearer sk_test_51OMVstJ2x5Ph6J2TdbqqCEANmQwmQYgjy1VQtB4HHYNexkGAGZBBk1hEX9HtzTmLr8VJ6zFq7r629PTi1RZdMMsc00IvUld2Bc',
  //         'Content-Type': 'application/x-www-form-urlencoded'
  //       },
  //       body: body,
  //     );
  //     return json.decode(response.body);
  //   } catch (err) {
  //     throw Exception(err.toString());
  //   }
  // }
}
