import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/get_restaurants_by_cat_response.dart';
import 'package:famooshed/app/data/models/get_restaurants_by_cat_response_new.dart';
import 'package:famooshed/app/modules/dashboard_module/dashboard_controller.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class FindByCategoryController extends GetxController {
  @override
  void onReady() {
    getCategoryData();
    super.onReady();
  }

  final ApiHelper _apiHelper = ApiHelper.to;
  dynamic catId = Get.arguments;
  RxBool isLoading = true.obs;
  final RxList<Resturneartous> _categoryData = RxList();
  List<Resturneartous> get categoryData => _categoryData;
  set categoryData(List<Resturneartous> categoryData) =>
      _categoryData.addAll(categoryData);

  // void setCategoryDetailData(GetRestaurantByCatNewResponse value) =>
  //     categoryData.value = value;
  final RxList<Allcat> _allCat = RxList();
  List<Allcat> get allCat => _allCat;
  set allCat(List<Allcat> allCat) => _allCat.addAll(allCat);

  final RxList<RestaurantByCat> _restaurByCat = RxList();
  List<RestaurantByCat> get restaurByCat => _restaurByCat;
  set restaurByCat(List<RestaurantByCat> restaurByCat) =>
      _restaurByCat.addAll(restaurByCat);
  final RxList<Allcat> _category = RxList();
  List<Allcat> get category => _category;
  set category(List<Allcat> category) => _category.addAll(category);
  final dio = Dio();

  getCategoryData() {
    _apiHelper
        .getRestaurantsByCat(AppUrl.getRestaurantByCat + catId.toString())
        .futureValue(
      (value) {
        var response = GetRestaurantByCatResponse.fromJson(value);

        if (allCat.isNotEmpty) {
          allCat.clear();
          allCat = response.allcat;
        } else {
          allCat = response.allcat;
        }

        if (category.isNotEmpty) {
          category.clear();
          category = response.category;
        } else {
          category = response.category;
        }

        if (restaurByCat.isNotEmpty) {
          restaurByCat.clear();
          restaurByCat = response.restaurantByCat;
        } else {
          restaurByCat = response.restaurantByCat;
        }

        update();
      },
      retryFunction: getCategoryData,
    );
  }

  Future<void> getCategoryDataNew() async {
    DashboardController dashboardController = Get.find<DashboardController>();
    double latitude = dashboardController.lat.value;
    double longitude = dashboardController.lng.value;
    String apiUrl = AppUrl.getRestaurantByCatNew + 266.toString();

    // Add latitude and longitude to the URL as query parameters
    apiUrl += '&restlat=$latitude&restlongi=$longitude';

    try {
      print('Fetching data from: $apiUrl');
      var response = await dio.get(apiUrl);

      // Verify the response status code and data content
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      var responseData = GetRestaurantByCatNewResponse.fromJson(response.data);

      print('Parsed response: $responseData');
      print('API called');
      if (categoryData.isNotEmpty) {
        categoryData.clear();
        categoryData = responseData.resturneartous!;
      } else {
        categoryData = responseData.resturneartous!;
      }
    } catch (e) {
      // Handle any errors that might occur during the API call
      print('Error: $e');
    }
  }

  goToDetailPage(index) {
    Get.toNamed(Routes.SIGNLE_ITEM, arguments: category[index].id);
  }
}
