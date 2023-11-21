import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/get_home_response.dart';
import 'package:famooshed/app/data/models/get_search_response.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../data/models/get_merchant_response.dart' as mr;
import '../../data/models/price_range_model.dart';
import '../../data/models/product_category.dart';

class SearchFoodController extends GetxController {
  @override
  void onReady() {
    getRoterdata();
    super.onReady();
  }

  RxString filterDropDown = 'Filter'.obs;
  RxInt counter = 0.obs;
  RxBool showFilter = false.obs;
  final ApiHelper _apiHelper = ApiHelper.to;
  final searchController = TextEditingController();
  RxList<Category> category = <Category>[].obs;
  RxList<String> filterList = <String>[].obs;

  dynamic routeData = Get.arguments;
  final RxList<Food> _foodList = RxList();
  List<Food> get foodList => _foodList;
  set foodList(List<Food> foodList) => _foodList.addAll(foodList);
  final dio = Dio();

  List<ProductCategory> selectedCategoryList = [];
  List<PriceRange> priceRangeList = [];
  List<String> selectedCategoryIds = [];
  String selectedPrice = '';
  bool isGeoLocation = false;

  getRoterdata() {
    category.value = routeData;
    filterDropDown.value = category[0].name;
    for (var item in category) {
      filterList.add(item.name);
    }
    update();
  }

  getSearch({String? categoryId, String? price}) async {
    var url = Constants.baseUrl + AppUrl.getSearch + searchController.text;
    Map<String, dynamic> queryParams = {
      "category": categoryId,
      "price": price,
    };

    if (isGeoLocation) {
      Position position = await determinePosition();
      queryParams.addAll(
        {"latitude": position.latitude, "longitude": position.longitude},
      );
    }
    final value = await dio.get(url, queryParameters: queryParams);
    var response = GetSearchResponse.fromJson(value.data);
    if (foodList.isNotEmpty) {
      foodList.clear();
      foodList = response.foods;
    } else {
      foodList = response.foods;
    }

    update();
  }

  goToDetailPage(index) {
    _apiHelper
        .getApiCall(
            AppUrl.getRestaurants + foodList[index].restaurant.toString())
        .futureValue(
      (value) async {
        try {
          var response = mr.GetMerchantResponse.fromJson(value);
          if (response.error == '0') {
            Get.toNamed(Routes.MERCHANTS, arguments: response.restaurant);
          }
// lat1, lon1, lat2, lon2

          // dprint(myLat.value);
          // dprint(myLong.value);
          // dprint(response.restaurant.lat);
          // dprint(response.restaurant.lng);

          update();
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
      },
      retryFunction: () {},
    );
  }

  void increment() {
    counter++;
    update();
  }

  void decrement() {
    counter <= 0 ? counter : counter--;

    update();
  }

  addToCart(index) {
    var body = {
      "total": "0.00",
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
      "data": [
        {
          "food": foodList[index].name,
          "count": counter.value,
          "foodprice": foodList[index].price,
          "extras": "0",
          "extrascount": "0",
          "extrasprice": "0",
          "foodid": foodList[index].id,
          "extrasid": "0",
          "image": foodList[index].image
        }
      ]
    };
    _apiHelper.addBasket(AppUrl.addToBasket, body).futureValue(
          (value) {},
          retryFunction: () {},
        );
    update();
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
