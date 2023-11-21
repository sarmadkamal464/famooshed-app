import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/price_range_model.dart';
import 'package:famooshed/app/data/models/product_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/get_restaurants_by_cat_response.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class FilterController extends GetxController {
  @override
  void onReady() {
    // getCategoryData();
    getProductCategory();
    super.onReady();
  }

  bool value = false;

  TextStyle style = const TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
  TextStyle style2 = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  CustomGroupController customGroupController = CustomGroupController();
  final ApiHelper _apiHelper = ApiHelper.to;

  // List<String> quickFilter = ["Store Near By", "Delivery Time", "Rating"];
  List<String> quickFilter = [
    "Store Near By",
  ];

  List<String> reportList = [];
  RxBool storeNearBy = false.obs;
  RxBool deliveryTime = false.obs;
  RxBool ratingFilter = false.obs;

  List<String> selectedReportList = [];
  List<ProductCategory> selectedCategoryList = [];

  final RxList<String> _allCat = RxList();
  List<String> get allCat => _allCat;
  set allCat(List<String> allCat) => _allCat.addAll(allCat);

  final RxList<ProductCategory> _productCat = RxList();
  List<ProductCategory> get productCat => _productCat;
  set productCat(List<ProductCategory> productCat) =>
      _productCat.addAll(productCat);

  getCategoryData() {
    _apiHelper
        .getRestaurantsByCat("${AppUrl.getRestaurantByCat}69")
        .futureValue(
      (value) {
        var response = GetRestaurantByCatResponse.fromJson(value);
        if (allCat.isNotEmpty) {
          allCat.clear();
          allCat.add("All");
          for (var item in response.allcat) {
            allCat.add(item.name);
          }
        } else {
          allCat.add("All");
          for (var item in response.allcat) {
            allCat.add(item.name);
          }
        }

        // if (allCat.isNotEmpty) {
        //   allCat.clear();

        //   allCat = response.allcat;
        // } else {
        //   allCat = response.allcat;
        // }

        update();
      },
      retryFunction: getCategoryData,
    );
  }

  getProductCategory() {
    _apiHelper.postApiCall("${AppUrl.getCategories}", {}).futureValue(
      (value) {
        if (value['error'] == '0') {
          if (value['category'] != null &&
              (value['category'] is List && value['category'].isNotEmpty)) {
            productCat.clear();
            for (int i = 0; i < value['category'].length; i++) {
              productCat.add(ProductCategory.fromJson(value['category'][i]));
            }
          }
        }
        // var response = ProductCategory.fromJson(value);
        // if (productCat.isNotEmpty) {
        //   productCat.clear();
        //
        //   for (var item in response.productCat) {
        //     allCat.add(item.name);
        //   }
        // }

        print(value);
        update();
      },
      retryFunction: getProductCategory,
    );
  }

  List<PriceRange> priceRangeList = [
    PriceRange("5", false),
    PriceRange("10", true),
    PriceRange("30", false),
    PriceRange("50", false),
    PriceRange("180", false),
  ];
  String selectedPrice = '';

  resetFilter() {}
}
