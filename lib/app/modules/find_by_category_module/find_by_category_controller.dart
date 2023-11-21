import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/get_restaurants_by_cat_response.dart';
import 'package:famooshed/app/routes/app_pages.dart';
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

  goToDetailPage(index) {
    Get.toNamed(Routes.SIGNLE_ITEM, arguments: category[index].id);
  }
}
