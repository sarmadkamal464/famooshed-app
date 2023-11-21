// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as con;
import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/get_basket_response.dart';
import 'package:famooshed/app/modules/cart_module/cart_controller.dart';
import 'package:famooshed/app/modules/checkout_module/checkout_controller.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/utils/app_keys.dart';
import 'package:famooshed/app/utils/dprint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class PaymentMethodsController extends GetxController {
  String month = '';
  String year = '';
  RxString cardNumber = ''.obs;
  RxString cardHolderName = ''.obs;
  RxString expiryDate = ''.obs;
  RxString cvv = ''.obs;
  RxBool showBack = false.obs;
  String amount = "";
  RxBool isSaved = false.obs;

  var dio = con.Dio();

  late FocusNode focusNode;
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expiryFieldCtrl = TextEditingController();
  GetBasketResponse? getBasketResponse;
  final ApiHelper apiHelper = ApiHelper.to;
  RxBool isLoading = false.obs;
  var routeData = Get.arguments;

  RxString addValue = "".obs;

  RxString lat = "".obs;
  RxString lng = "".obs;
  @override
  void onInit() {
    super.onInit();
    focusNode = FocusNode();
    focusNode.addListener(() {
      focusNode.hasFocus ? showBack.value = true : showBack.value = false;
    });
  }

  @override
  void onReady() {
    dprint(routeData);
    getRouteData();
    super.onReady();
  }

  getRouteData() {
    getBasketResponse = routeData[0]['cart'];
    addValue.value = routeData[1]['address'];
    lat.value = routeData[2]['lat'];
    lng.value = routeData[3]['lng'];
  }

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }

  cardValidateApi() async {
    isLoading.value = true;
    update();
    month = expiryDate.split('/').first;
    year = expiryDate.split('/').last;

    // String stripeSecretKey = 'sk_live_vfLFh5HwFXe0UQ22blkVfsvB';
    String stripeSecretKey = ApiKeys.dev_sec_key;

    String url = 'https://api.stripe.com/v1/payment_methods';

    final headers = {
      'Authorization': 'Bearer $stripeSecretKey',
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    var body = {
      'type': 'card',
      'card[number]': cardNumber,
      'card[exp_month]': month,
      'card[exp_year]': year,
      'card[cvc]': cvv
    };
    dprint(body);

    try {
      con.Response response = await dio.post(url,
          data: body, options: con.Options(headers: headers));
      dprint(response);
      if (response.statusCode == 200) {
        //call next api
        var paymentMethodID = response.data["id"];
        paymentContributionApi(paymentMethodID);

        log("card validate api run successfully");
        isLoading.value = false;
        update();
      } else {
        Utils.showSnackbar(
            "Something Went Wrong.Please try again after some time");
        isLoading.value = false;
        update();
      }
    } catch (e) {
      dprint(e);
      isLoading.value = false;
      update();
      Utils.showSnackbar("Card Failed. Please check you card details.");
    }
  }

  CheckoutController checkoutController = Get.find<CheckoutController>();
  paymentContributionApi(paymentMethodID) async {
    String url =
        'https://us-central1-famooshed-314209.cloudfunctions.net/StripePayEndPointMethodId';

    // int amount = 0;
    // double doubleAmount =
    //     double.parse(getBasketResponse!.basketTotalWithTax) * 100;
    // amount = doubleAmount.toInt();

    var body = {
      "useStripeSdk": true,
      "paymentMethodId": paymentMethodID,
      "currency": "gbp",
      "amount": getBasketResponse!.basketTotalWithTax,
    };

    try {
      con.Response response = await dio.post(url, data: jsonEncode(body));
      dprint(response.data);

      if (response.data["status"] == "succeeded") {
        // addToCart();
        await checkoutController.saveVehicleData().then((value) {
          resetBasket();
        });
      } else {
        Utils.showSnackbar("Something Went Wrong.");
      }

      dprint(response.data["status"]);
    } catch (e, trace) {
      dprint(e);
      log(e.toString(), stackTrace: trace);
    }
  }

  addToCart() {
    var body = {
      "total": getBasketResponse!.basketTotalWithTax,
      "address": addValue.value,
      "phone": "",
      "pstatus": "Waiting for client",
      "lat": lat.value,
      "lng": lng.value,
      "curbsidePickup": "false",
      "send": "1",
      "tax": getBasketResponse!.defaultTax,
      "hint": "abcd",
      "couponName": getBasketResponse!.order.couponName,
      "restaurant": getBasketResponse!.restaurantData.id,
      "method": "card",
      "fee": getBasketResponse!.order.fee,
      "data": getBasketResponse!.orderdetails
    };
    dprint(body);
    apiHelper.addBasket(AppUrl.addToBasket, body).futureValue(
      (value) {
        walletSetId(orderId: getBasketResponse!.order.id);
      },
      retryFunction: addToCart,
    );
  }

  walletSetId({orderId}) {
    var body = {"walletId": "", "orderId": orderId};
    apiHelper.postApiCall(AppUrl.walletSetId, body).futureValue(
      (value) {
        if (value["error"] == 0) {
          Get.toNamed(Routes.ORDER_SUCESS);
        }
      },
      retryFunction: walletSetId,
    );
  }

  resetBasket() {
    apiHelper.postApiCall(AppUrl.resetBasket, {}).futureValue(
      (value) {
        Get.delete<CartController>();
        Get.delete<CheckoutController>();
        Get.delete<PaymentMethodsController>();

        walletSetId(orderId: getBasketResponse!.order.id);

        // addToCart();
      },
      retryFunction: resetBasket,
    );
  }
}
