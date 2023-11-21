import 'dart:developer';

import 'package:dio/dio.dart' as d;
import 'package:famooshed/app/common/util/loading_dialog.dart';
import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/get_basket_response.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/utils/dprint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/constants.dart';
import '../../common/storage/storage.dart';
import '../../data/models/get_cart_model.dart';

class CartController extends GetxController {
  @override
  void onReady() {
    // getBasket();

    getCartNew();
    super.onReady();
  }

  final ApiHelper _apiHelper = ApiHelper.to;
  RxBool isCenter = true.obs;
  RxInt counter = 1.obs;
  RxDouble servicePrice = 0.0.obs;
  final couponController = TextEditingController();
  RxDouble subTotalPrice = 0.0.obs;
  RxString orderId = "".obs;
  RxString restaturntName = "".obs;
  RxString restaurantImage = "".obs;
  RxString subTotal = "".obs;
  RxString discount = "".obs;
  RxString shipping = "".obs;
  RxString taxAmount = "".obs;
  RxString total = "".obs;
  RxString curruncySign = "".obs;
  GetBasketResponse? getBasketResponse;
  final RxList<Orderdetail> _orderList = RxList();
  List<Orderdetail> get orderList => _orderList;
  set orderList(List<Orderdetail> orderList) => _orderList.addAll(orderList);

  getBasket() async {
    LoadingDialog.showLoadingDialog();

    try {
      Response data = await _apiHelper.getBasket(AppUrl.getBasket, {});

      print(data.body);
      orderList.clear();
      if (data.body['orderdetails'] != null &&
          data.body['orderdetails'].isNotEmpty) {
        var response = GetBasketResponse.fromJson(data.body);
        getBasketResponse = response;
        if (response.orderdetails.isNotEmpty) {
          restaturntName.value = response.restaurantData.name;
          restaurantImage.value = response.restaurantData.image;
          orderId.value = response.order.id.toString();
          counter.value = response.orderdetails[0].count;
          subTotal.value = response.basketTotal;
          discount.value = response.discount.toString();
          shipping.value = response.shippingFee;
          taxAmount.value = response.taxAmount;
          curruncySign.value = response.currency;
          total.value = response.basketTotalWithTax;
          dprint(counter.value);
          if (orderList.isNotEmpty) {
            orderList.clear();
            orderList = response.orderdetails;
          } else {
            orderList = response.orderdetails;
          }
        }
      }
    } catch (e) {
      LoadingDialog.closeLoadingDialog();
      update();
    }
    LoadingDialog.closeLoadingDialog();
    update();
    // _apiHelper.getBasket(AppUrl.getBasket, {}).futureValue(
    //   (value) {
    //     try {
    //       if (value['orderdetails'] != null) {
    //         var response = GetBasketResponse.fromJson(value);
    //         getBasketResponse = response;
    //         if (response.orderdetails.isNotEmpty) {
    //           restaturntName.value = response.restaurantData.name;
    //           restaurantImage.value = response.restaurantData.image;
    //           orderId.value = response.order.id.toString();
    //           counter.value = response.orderdetails[0].count;
    //           subTotal.value = response.basketTotal;
    //           discount.value = response.discount.toString();
    //           shipping.value = response.shippingFee;
    //           taxAmount.value = response.taxAmount;
    //           curruncySign.value = response.currency;
    //           total.value = response.basketTotalWithTax;
    //           dprint(counter.value);
    //           if (orderList.isNotEmpty) {
    //             orderList.clear();
    //             orderList = response.orderdetails;
    //           } else {
    //             orderList = response.orderdetails;
    //           }
    //         }
    //       }
    //       update();
    //     } catch (e, trace) {
    //       log(e.toString(), stackTrace: trace);
    //     }
    //   },
    //   retryFunction: getBasket,
    // );
  }

  final RxList<Product> _productList = RxList();
  List<Product> get productList => _productList;
  set productList(List<Product> productList) =>
      _productList.addAll(productList);

  CartResponse sendCartResponse = CartResponse();
  getCartNew() async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var queryParams = {
        "isApp": true,
        "uid": uid.toString(),
      };

      d.Response response = await _apiHelper.getApiNew(
        AppUrl.getCart,
        {},
        queryParams,
      );

      if (response.statusCode == 200) {
        productList.clear();
        dprint(response.data);
        CartResponse cartResponse = CartResponse.fromJson(response.data);

        sendCartResponse = cartResponse;
        if (cartResponse.data != null) {
          if (cartResponse.data!.cart != null) {
            if (cartResponse.data!.cart!.products != null &&
                cartResponse.data!.cart!.products!.isNotEmpty) {
              productList.addAll(cartResponse.data!.cart!.products!);
            }

            restaurantImage.value =
                cartResponse.data!.cart!.restaurantProfile ?? '-';
            restaturntName.value =
                cartResponse.data!.cart!.restaurantName ?? '-';
            subTotal.value = cartResponse.data!.cart!.subTotal ?? '0';
            discount.value = cartResponse.data!.cart!.discountAmount ?? '0';
            shipping.value = cartResponse.data!.cart!.deliveryPrice ?? '0';
            // taxAmount.value = cartResponse.data!.cart!.tax ?? '-';
            curruncySign.value = '£';
            total.value = cartResponse.data!.cart!.payableAmount ?? '0';
          }
        }
        LoadingDialog.closeLoadingDialog();
        update();
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  addItemsToCart(Product product) {
    if (product.quantity != null) {
      addToCartNew(product, true);
    }
  }

  deleteItemsToCart(Product product) {
    if (product.quantity != null) {
      if (product.quantity! > 1) {
        addToCartNew(product, false);
      } else {
        removeCart(
          product,
        );
      }
    }
  }

  addToCartNew(Product product, bool isAdd) async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var body = {
        "id": product.productId,
        "qty":
            isAdd ? (product.quantity ?? 1) + 1 : (product.quantity ?? 1) - 1,
        "isApp": true,
        "uid": uid.toString(),
      };

      d.Response response =
          await _apiHelper.postApiNew(AppUrl.addToCart, {}, body);

      if (response.statusCode == 200) {
        if (response.data['status'] != null &&
            response.data['status'] == true) {
          if (response.data['data']['is_same_restaurant'] == 1) {
            await getCartNew();
            LoadingDialog.closeLoadingDialog();
          }
        } else {
          await getCartNew();
          LoadingDialog.closeLoadingDialog();
          Utils.showSnackbar(
              response.data['message'] ?? "Something went wrong!!!");
        }
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  removeCart(
    Product product,
  ) async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var body = {
        "id": product.id,
        "isApp": true,
        "uid": uid.toString(),
      };

      d.Response response =
          await _apiHelper.postApiNew(AppUrl.removeCart, {}, body);

      if (response.statusCode == 200) {
        await getCartNew();
        LoadingDialog.closeLoadingDialog();
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  applyCoupon() async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var body = {
        "couponName": couponController.text,
        "isApp": true,
        "uid": uid.toString(),
      };

      d.Response response =
          await _apiHelper.postApiNew(AppUrl.checkCouponCode, {}, body);

      if (response.statusCode == 200) {
        LoadingDialog.closeLoadingDialog();
        if (response.data['status'] != null &&
            response.data['status'] == true) {
          await getCartNew();
        } else {
          Utils.showSnackbar("Coupon not found");
        }
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  setCountInBasket(int count, int foodid) async {
    var body = {"orderid": orderId.value, "foodid": foodid, "count": count};
    dprint(body);
    await _apiHelper.postApiCall(AppUrl.setCountInBasket, body);
    getBasket();
  }

  void increment(Orderdetail detail) {
    // counter.value++;
    setCountInBasket(detail.count + 1, detail.foodid);
  }

  void decrement(Orderdetail detail) {
    // counter.value <= 0 ? counter.value : counter.value--;
    // if (counter.value <= 0) {
    //   deleteFromBasket();
    // } else {
    //   setCountInBasket();
    // }
    // orderList.forEach((element) {
    //   if (element.id == detail.id) {
    //     element.count = element.count - 1;
    //   }
    // });

    if (detail.count <= 1) {
      deleteFromBasket(detail);
    } else {
      setCountInBasket(detail.count - 1, detail.foodid);
    }
  }

  apllyCoupon() {
    if (couponController.text.isNotEmpty) {
      _apiHelper.getBasket(
          "${AppUrl.getBasket}?couponName=${couponController.text}",
          {}).futureValue(
        (value) {
          try {
            var response = GetBasketResponse.fromJson(value);
            getBasketResponse = response;
            restaturntName.value = response.restaurantData.name;
            restaurantImage.value = response.restaurantData.image;
            orderId.value = response.order.id.toString();
            counter.value = response.orderdetails[0].count;
            subTotal.value = response.basketTotal;
            discount.value = response.discount.toString();
            shipping.value = response.shippingFee;
            total.value = response.basketTotalWithTax;

            dprint(counter.value);
            if (orderList.isNotEmpty) {
              orderList.clear();
              orderList = response.orderdetails;
            } else {
              orderList = response.orderdetails;
            }
            update();
          } catch (e, trace) {
            log(e.toString(), stackTrace: trace);
          }
        },
        retryFunction: apllyCoupon,
      );
    } else {
      Utils.showSnackbar("Enter coupon code");
    }
  }

  reDirectToCheckout() async {
    var result =
        await Get.toNamed(Routes.CHECKOUT, arguments: sendCartResponse);
    if (result != null) {
      await getCartNew();
    }
  }

  deleteFromBasket(Orderdetail detail) async {
    var body = {"orderid": getBasketResponse!.order.id, "id": detail.foodid};
    dprint(body);
    await _apiHelper.postApiCall(AppUrl.deleteFromBasket, body);
    getBasket();
  }
}
