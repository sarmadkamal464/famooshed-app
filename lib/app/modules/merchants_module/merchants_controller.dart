import 'dart:developer';

import 'package:dio/dio.dart' as d;
import 'package:famooshed/app/common/util/loading_dialog.dart';
import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/get_basket_response.dart';
import 'package:famooshed/app/data/models/get_cart_model.dart';
import 'package:famooshed/app/data/models/get_merchant_response.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/utils/common_helper.dart';
import 'package:famooshed/app/utils/dprint.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../common/constants.dart';
import '../../common/storage/storage.dart';
import '../../common/values/app_colors.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/size_config.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class MerchantsController extends GetxController {
  @override
  void onReady() {
    // getFoodCatList();
    getDistance();
    getMerchantData(true);
    // getBasket();
    getCartNew();
    super.onReady();
  }

  RxInt counter = 1.obs;

  RxDouble subTotalPrice = 0.0.obs;
  RxDouble servicePrice = 0.0.obs;
  final ApiHelper _apiHelper = ApiHelper.to;
  dynamic merchant = Get.arguments;
  Restaurant? restaurant;

  RxDouble myLat = 0.0.obs;
  RxDouble myLong = 0.0.obs;
  RxString merchantDistance = "".obs;
  RxString merchantName = "".obs;
  RxInt count = 0.obs;
  final RxList<Food> _foodList = RxList();
  List<Food> get foodList => _foodList;
  set foodList(List<Food> foodList) => _foodList.addAll(foodList);
  RxBool isLoading = true.obs;
  GetMerchantResponse? getMerchantResponse;
  final RxList<Sreview> _reviewList = RxList();
  List<Sreview> get reviewList => _reviewList;
  set reviewList(List<Sreview> reviewList) => _reviewList.addAll(reviewList);

  final RxList<Restaurantsoffer> _restaurantsoffer = RxList();
  List<Restaurantsoffer> get restaurantsoffer => _restaurantsoffer;
  set restaurantsoffer(List<Restaurantsoffer> reviewList) =>
      _restaurantsoffer.addAll(reviewList);

  final RxList<Category> _productCategoryList = RxList();
  List<Category> get productCategoryList => _productCategoryList;
  set productCategoryList(List<Category> productCategoryList) =>
      _productCategoryList.addAll(productCategoryList);

  List<Category> selectedProductCategoryList = [];

  getBasket() {
    try {
      _apiHelper.postApiCall(AppUrl.getBasket, {}).futureValue((value) {
        if (value['orderdetails'] != null) {
          var response = GetBasketResponse.fromJson(value);
          count.value = response.orderdetails.length;
        }
        update();
      }, retryFunction: getBasket);
    } catch (e, trace) {
      log(e.toString(), stackTrace: trace);
    }
    update();
  }

  getMerchantData(bool isFirstTime) {
    String productCarList = '';
    if (selectedProductCategoryList.isNotEmpty) {
      productCarList = selectedProductCategoryList.map((e) => e.id).toString();
      productCarList = productCarList.replaceAll('(', '');
      productCarList = productCarList.replaceAll(')', '');
      productCarList = productCarList.trim();
      print(productCarList);
    }
    Uri uri = Uri.parse(AppUrl.getRestaurantsNew).replace(queryParameters: {
      "restaurant": merchant.id.toString(),
      "cat_ids": productCarList
    });
    _apiHelper.getApiCall(uri.toString()).futureValue(
      (value) async {
        try {
          foodList.clear();
          var response = GetMerchantResponse.fromJson(value);

          restaurant = response.restaurant;
          foodList = response.foods;
          reviewList = response.restaurantsreviews;
          merchantName.value = response.restaurant.name;
          restaurantsoffer = response.restaurantsoffers;
          if (isFirstTime) {
            productCategoryList = response.categories;
          }
// lat1, lon1, lat2, lon2

          if (response.restaurant.lat.isNotEmpty &&
              response.restaurant.lng.isNotEmpty) {
            var dis = calculateDistance(
                myLat.value,
                myLong.value,
                double.parse(response.restaurant.lat),
                double.parse(response.restaurant.lng));
            merchantDistance.value = dis.toStringAsFixed(0);
          } else {
            merchantDistance.value = '-';
          }

          // dprint(myLat.value);
          // dprint(myLong.value);
          // dprint(response.restaurant.lat);
          // dprint(response.restaurant.lng);
          isLoading.value = false;

          update();
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
      },
      retryFunction: () {},
    );
    update();
  }

  addToCart(index) async {
    LoadingDialog.showLoadingDialog();

    try {
      List dataList = [];
      dataList.add({
        "food": foodList[index].name,
        "count": counter.value,
        "foodprice": foodList[index].price,
        "extras": "0",
        "extrascount": "0",
        "extrasprice": "0",
        "foodid": foodList[index].id,
        "extrasid": "0",
        "image": foodList[index].image
      });
      // List cartList = Storage.getValue(Constants.cartList) ?? [];
      // String cartRestId = Storage.getValue(Constants.cartRestId) ?? '';
      // if (cartRestId == foodList[index].restaurant.toString()) {
      //   cartList = cartList + dataList;
      //   await Storage.saveValue(Constants.cartList, cartList);
      //
      //   // cartList.forEach((element) {
      //   //   dataList.add(element);
      //   // });
      // } else {
      //   Storage.removeValue(Constants.cartList);
      //   Storage.removeValue(Constants.cartRestId);
      // }
      var body = {
        "total": foodList[index].price,
        "address": "",
        "phone": "",
        "pstatus": "Waiting for client",
        "lat": "0.0",
        "lng": "0.0",
        "curbsidePickup": "false",
        "send": "0",
        "tax": "20.0",
        "hint": "hint",
        "couponName": "",
        "restaurant": foodList[index].restaurant,
        "method": "Cash on Delivery",
        "fee": foodList[index].fee,
        "data": dataList
      };

      Response cartRes = await _apiHelper.postApiCall(AppUrl.addToBasket, body);
      if (cartRes.statusCode == 200) {
        if (cartRes.body['error'] == '0') {
          getBasket();
          LoadingDialog.closeLoadingDialog();
          Utils.showSnackbar("Added to cart successfully");
        }
      }
    } catch (e) {
      LoadingDialog.closeLoadingDialog();
    }
    LoadingDialog.closeLoadingDialog();
    // _apiHelper.addBasket(AppUrl.addToBasket, body).futureValue(
    //   (value) async {
    //     if (value['error'] == "0") {
    //       // String cartRestid = Storage.getValue(Constants.cartRestId) ?? '';
    //       //
    //       // if (cartRestid == foodList[index].restaurant.toString()) {
    //       //   // await Storage.saveValue(Constants.cartList, dataList);
    //       // } else {
    //       //   Storage.saveValue(
    //       //       Constants.cartRestId, foodList[index].restaurant.toString());
    //       //   Storage.saveValue(Constants.cartList, dataList);
    //       // }
    //       Utils.showSnackbar("Added to cart successfully");
    //       LoadingDialog.closeLoadingDialog();
    //     } // var token = Storage.getValue(Constants.token);
    //   },
    //   retryFunction: () {},
    // );
    update();
  }

  // final RxList<ProductCategoryModel> _productCategoryList = RxList();
  // List<ProductCategoryModel> get productCategoryList => _productCategoryList;
  // set productCategoryList(List<ProductCategoryModel> productCategoryList) =>
  //     _productCategoryList.addAll(productCategoryList);
  //
  // List<ProductCategoryModel> selectedProductCategoryList = [];
  //
  // getFoodCatList() async {
  //   // LoadingDialog.showLoadingDialog();
  //   try {
  //     Response response = await _apiHelper.getApiCall(
  //       AppUrl.getFoodCatList,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       productCategoryList.clear();
  //       if (response.body['error'] != null && response.body['error'] == '0') {
  //         if (response.body['catList'] != null) {
  //           List data = response.body['catList'];
  //           if (data.isNotEmpty) {
  //             data.forEach((element) {
  //               productCategoryList.add(ProductCategoryModel.fromJson(element));
  //             });
  //           }
  //         }
  //       }
  //     }
  //     update();
  //   } catch (e) {
  //     dprint(e);
  //     // LoadingDialog.closeLoadingDialog();
  //   }
  //
  //   // LoadingDialog.closeLoadingDialog();
  // }

  Future<void> addToCartNew(Food food) async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var body = {
        "id": food.id,
        "qty": counter.value,
        "isApp": true,
        "uid": uid.toString(),
      };

      d.Response response =
          await _apiHelper.postApiNew(AppUrl.addToCart, {}, body);

      if (response.statusCode == 200) {
        if (response.data['status'] != null &&
            response.data['status'] == true) {
          if (response.data['data']['is_same_restaurant'] != null &&
              response.data['data']['is_same_restaurant'] == 1) {
            LoadingDialog.closeLoadingDialog();

            await getCartNew();
            Utils.showSnackbar("Added to cart successfully");
          }
        } else {
          if (response.data['showStockMessage'] != null &&
              response.data['showStockMessage'] == true) {
            LoadingDialog.closeLoadingDialog();
            await getCartNew();
            Utils.showSnackbar(
                response.data['message'] ?? "Something went wrong!!!");
          } else if (response.data['data']['is_same_restaurant'] != null &&
              response.data['data']['is_same_restaurant'] == 0) {
            showDialog(
                context: Get.context!,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: new Text('Delete Cart'),
                      content: new Text(
                          'You can add to cart, only products from single market. Do you want to reset cart? And add new product.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            LoadingDialog.closeLoadingDialog();
                            Get.back();
                          }, //<-- SEE HERE
                          child: new Text(
                            'CANCEL',
                            style: urbanistSemiBold.copyWith(
                              color: AppColors.greyText,
                              fontSize: getProportionalFontSize(12),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await resetCart();
                            d.Response response2 = await _apiHelper.postApiNew(
                                AppUrl.addToCart, {}, body);

                            if (response2.statusCode == 200) {
                              if (response2.data['status'] != null &&
                                  response2.data['status'] == true) {
                                if (response2.data['data']
                                        ['is_same_restaurant'] ==
                                    1) {
                                  LoadingDialog.closeLoadingDialog();
                                  await getCartNew();
                                  Utils.showSnackbar(
                                      "Added to cart successfully");
                                }
                              }
                            }
                          },
                          child: new Text(
                            'OK',
                            style: urbanistSemiBold.copyWith(
                              color: AppColors.redColor,
                              fontSize: getProportionalFontSize(12),
                            ),
                          ),
                        ),
                      ],
                    ));
          } else {
            LoadingDialog.closeLoadingDialog();
            await getCartNew();
            Utils.showSnackbar(
                response.data['message'] ?? "Something went wrong!!!");
          }
        }
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  Future<void> resetCart() async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var body = {
        "isApp": true,
        "uid": uid.toString(),
      };

      d.Response response =
          await _apiHelper.getApiNew(AppUrl.resetCart, {}, body);

      if (response.statusCode == 200) {
        if (response.data['status'] != null &&
            response.data['status'] == true) {
          LoadingDialog.closeLoadingDialog();
        }
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

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
        dprint(response.data);
        CartResponse cartResponse = CartResponse.fromJson(response.data);

        if (cartResponse.data != null) {
          if (cartResponse.data!.cart != null &&
              (cartResponse.data!.cart!.products != null)) {
            count.value = cartResponse.data!.cart!.products!.length;
          }
        } else {
          count.value = 0;
        }
        update();
        LoadingDialog.closeLoadingDialog();
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  getCartNewForCoupon(Restaurantsoffer offers) async {
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
        dprint(response.data);
        CartResponse cartResponse = CartResponse.fromJson(response.data);

        if (cartResponse.data != null) {
          if (cartResponse.data!.cart != null &&
              (cartResponse.data!.cart!.products != null)) {
            var body = {
              "couponName": offers.name,
              "isApp": true,
              "uid": uid.toString(),
            };

            d.Response response2 =
                await _apiHelper.postApiNew(AppUrl.checkCouponCode, {}, body);
            if (response2.statusCode == 200) {
              LoadingDialog.closeLoadingDialog();

              if (response.data['status'] != null &&
                  response.data['status'] == true) {
                Utils.showSnackbar("Coupon Applied");
              } else {
                Utils.showSnackbar(
                    response.data['message'] ?? "Error applying coupon");
              }
            }
          } else {
            LoadingDialog.closeLoadingDialog();
            Utils.showSnackbar("Cart Empty");
          }
        } else {
          LoadingDialog.closeLoadingDialog();
          Utils.showSnackbar("Cart Empty");
        }
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  goToDetailPage(index) async {
    await Get.toNamed(Routes.SIGNLE_ITEM, arguments: foodList[index].id);
    getCartNew();
  }

  void increment() {
    counter++;

    update();
  }

  void decrement() {
    counter <= 1 ? counter : counter--;

    update();
  }

  getDistance() async {
    var myLocation = await determinePosition();
    myLat.value = myLocation.latitude;
    myLong.value = myLocation.longitude;
    update();
    // getMerchantData();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
