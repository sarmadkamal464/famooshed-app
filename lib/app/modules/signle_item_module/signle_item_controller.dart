import 'dart:developer';

import 'package:dio/dio.dart' as d;
import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/add_food_reviews_response.dart';
import 'package:famooshed/app/data/models/get_food_details_response.dart';
import 'package:famooshed/app/data/models/variant_model.dart';
import 'package:famooshed/app/modules/signle_item_module/single_product_variant_detail_page.dart';
import 'package:famooshed/app/utils/dprint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/constants.dart';
import '../../common/storage/storage.dart';
import '../../common/util/loading_dialog.dart';
import '../../common/values/app_colors.dart';
import '../../data/models/get_cart_model.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/size_config.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class SignleItemController extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  void onReady() {
    getFoodDetails();
    super.onReady();
  }

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 3);
    super.onInit();
  }

  TabController? tabController;

  final ApiHelper _apiHelper = ApiHelper.to;

  RxInt counter = 1.obs;
  RxBool isLoading = true.obs;
  RxDouble subTotalPrice = 0.0.obs;
  RxDouble servicePrice = 0.0.obs;
  dynamic arguments = Get.arguments;
  GetFoodDetailsResponse? getFoodDetailsResponse;
  GetVariantResponse? getVariantsDetailsResponse;
  AddFoodReviewsResponse? addFoodReviewsResponse;
  final descController = TextEditingController();

  RxDouble rating = 5.0.obs;
  final RxList<Foodsreview> _foodsreview = RxList();
  List<Foodsreview> get foodsReview => _foodsreview;
  set foodsReview(List<Foodsreview> foodsReview) =>
      _foodsreview.addAll(foodsReview);

  final RxList<Review> _review = RxList();
  List<Review> get review => _review;
  set review(List<Review> review) => _review.addAll(review);

  final RxList<SimilarFood> _similarPrductList = RxList();
  List<SimilarFood> get similarPrductList => _similarPrductList;
  set similarPrductList(List<SimilarFood> similarPrductList) =>
      _similarPrductList.addAll(similarPrductList);

  void increment() {
    counter++;
    subTotalPrice.value = servicePrice * counter.toInt();
    update();
  }

  void decrement() {
    counter <= 1 ? counter : counter--;
    subTotalPrice.value = servicePrice * counter.toInt();
    update();
  }

  getFoodDetails() {
    _apiHelper.getApiCall("${AppUrl.getFoodDetails}$arguments").futureValue(
      (value) {
        try {
          var response = GetFoodDetailsResponse.fromJson(value);
          getFoodDetailsResponse = response;
          foodsReview = response.foods[0].foodsreviews;
          if (similarPrductList.isNotEmpty) {
            similarPrductList.clear();
            similarPrductList = response.similarFood;
          } else {
            similarPrductList = response.similarFood;
          }
          // selectedVariant.value = response.variants[0].id.toString();
          // print('The value of the selected variant is: $selectedVariant.value');
        } catch (e, stack) {
          log(e.toString(), stackTrace: stack);
        }
        isLoading.value = false;
        update();
      },
      retryFunction: getFoodDetails,
    );
  }

  addFoodReviews() {
    var body = {
      "food": arguments.toString(),
      "rate": rating.value,
      "desc": descController.text,
    };
    dprint(body);
    _apiHelper.postApiCall(AppUrl.addFoodReviews, body).futureValue((value) {
      var response = AddFoodReviewsResponse.fromJson(value);
      if (response.error == "0") {
        descController.clear();
        getFoodDetails();
      } else {
        dprint("Something Went Wrong");
      }

      update();
    }, retryFunction: addFoodReviews);
  }

  addToCart() {
    var body = {
      "total": "0.00",
      "address": "",
      "phone": "",
      "pstatus": "Waiting for client",
      "lat": "0.0",
      "lng": "0.0",
      "curbsidePickup": "false",
      "send": "0",
      "tax": getFoodDetailsResponse!.defaultTax,
      "hint": "hint",
      "couponName": "",
      "restaurant": getFoodDetailsResponse!.restaurant,
      "method": "Cash on Delivery",
      "fee": getFoodDetailsResponse!.fee,
      "data": [
        {
          "food": getFoodDetailsResponse!.name,
          "count": counter.value,
          "foodprice": getFoodDetailsResponse!.price,
          "extras": "0",
          "extrascount": "0",
          "extrasprice": "0",
          "foodid": getFoodDetailsResponse!.id,
          "extrasid": "0",
          "image": getFoodDetailsResponse!.image
        }
      ]
    };
    _apiHelper.addBasket(AppUrl.addToBasket, body).futureValue(
          (value) {},
          retryFunction: () {},
        );
    update();
  }

  getFoodDetailById({id}) {
    _apiHelper.getApiCall(AppUrl.getFoodDetails + id).futureValue(
      (value) {
        var response = GetFoodDetailsResponse.fromJson(value);
        getFoodDetailsResponse = response;
        foodsReview = response.foods[0].foodsreviews;
        if (similarPrductList.isNotEmpty) {
          similarPrductList.clear();
          similarPrductList = response.similarFood;
        } else {
          similarPrductList = response.similarFood;
        }
        isLoading.value = false;
        update();
      },
      retryFunction: getFoodDetailById,
    );
  }

  // getFoodVariantsById({id}) {
  //   _apiHelper.postApiCall(AppUrl.getFoodVariantDetails).futureValue(
  //     (value) {
  //       var response = GetVariantResponse.fromJson(value);
  //       getVariantsDetailsResponse = response;
  //       print("getVariantDetails is $getVariantsDetailsResponse");
  //       isLoading.value = false;
  //       update();
  //     },
  //     retryFunction: getFoodDetailById,
  //   );
  // }
  Future<void> getFoodVariantsById({required String id}) async {
    // Construct the body for the POST request
    Map<String, dynamic> requestBody = {
      'id': id, // Assuming 'id' is the key for the ID parameter
      // Other parameters if needed
    };

    _apiHelper
        .postApiCall(AppUrl.getFoodVariantDetails, requestBody)
        .futureValue(
      (value) {
        var response = GetVariantResponse.fromJson(value);
        getVariantsDetailsResponse = response;
        print("getVariantDetails is $getVariantsDetailsResponse");
        isLoading.value = false;
        update();
        Get.to(() => const VariantDetailPage());
      },
      retryFunction: getFoodDetailById,
    );
  }

  final RxList<Product> _productList = RxList();
  List<Product> get productList => _productList;
  set productList(List<Product> productList) =>
      _productList.addAll(productList);

  CartResponse sendCartResponse = CartResponse();
  // getCartNew() async {
  //   LoadingDialog.showLoadingDialog();
  //   int uid = await Storage.getValue(Constants.userId);
  //
  //   print(uid);
  //   try {
  //     var queryParams = {
  //       "isApp": true,
  //       "uid": uid.toString(),
  //     };
  //
  //     d.Response response = await _apiHelper.getApiNew(
  //       AppUrl.getCart,
  //       {},
  //       queryParams,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       productList.clear();
  //       dprint(response.data);
  //       CartResponse cartResponse = CartResponse.fromJson(response.data);
  //
  //       sendCartResponse = cartResponse;
  //       if (cartResponse.data != null) {
  //         if (cartResponse.data!.cart != null) {
  //           // if (cartResponse.data!.cart!.products != null &&
  //           //     cartResponse.data!.cart!.products!.isNotEmpty) {
  //           //   productList.addAll(cartResponse.data!.cart!.products!);
  //           // }
  //         }
  //       }
  //       LoadingDialog.closeLoadingDialog();
  //       update();
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     LoadingDialog.closeLoadingDialog();
  //   }
  // }

  addToCartNew() async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var body = {
        "id": getFoodDetailsResponse!.id,
        "qty": counter.value,
        "isApp": true,
        "uid": uid.toString(),
      };

      d.Response response =
          await _apiHelper.postApiNew(AppUrl.addToCart, {}, body);

      if (response.statusCode == 200) {
        if (response.data['status'] != null &&
            response.data['status'] == true) {
          if (response.data['data']['is_same_restaurant'] == 1) {
            LoadingDialog.closeLoadingDialog();
            // await getCartNew();
            Utils.showSnackbar("Added to cart successfully");
          }
        } else {
          if (response.data['showStockMessage'] != null &&
              response.data['showStockMessage'] == true) {
            LoadingDialog.closeLoadingDialog();
            Utils.showSnackbar(
                response.data['message'] ?? "Something went wrong!!!");
          } else if (response.data['data']['is_same_restaurant'] == 0) {
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
                                  // await getCartNew();
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
            // await getCartNew();
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

  addToCartVariantNew() async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var body = {
        "id": getVariantsDetailsResponse!.variant?.id,
        "qty": counter.value,
        "isApp": true,
        "uid": uid.toString(),
      };
      print('cart body is $body');
      d.Response response =
          await _apiHelper.postApiNew(AppUrl.addToCart, {}, body);

      if (response.statusCode == 200) {
        if (response.data['status'] != null &&
            response.data['status'] == true) {
          if (response.data['data']['is_same_restaurant'] == 1) {
            LoadingDialog.closeLoadingDialog();
            // await getCartNew();
            Utils.showSnackbar("Added to cart successfully");
          }
        } else {
          if (response.data['showStockMessage'] != null &&
              response.data['showStockMessage'] == true) {
            LoadingDialog.closeLoadingDialog();
            Utils.showSnackbar(
                response.data['message'] ?? "Something went wrong!!!");
          } else if (response.data['data']['is_same_restaurant'] == 0) {
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
                                  // await getCartNew();
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
            // await getCartNew();
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

  void deleteAccount() {}

  var isVariantSelected = false.obs;
  var selectedVariant = Variant('', '').obs; // Initialize with an empty Variant

  void updateSelectedVariant(Variant variant) {
    selectedVariant.value = variant;
    isVariantSelected.value = true;
    print('Variant is ${variant.name}, ID is ${variant.id}');
    // Additional logic if needed based on the selected variant
    getFoodVariantsById(id: variant.id);
  }

  void resetState() {
    isVariantSelected.value = false;
    selectedVariant.value = Variant('', '');
    // Reset other relevant state variables if needed
  }
}

class Variant {
  final String id;
  final String name;

  Variant(this.id, this.name);
}
