import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/common/util/loading_dialog.dart';
import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/favorites_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../common/storage/storage.dart';
import '../home_module/home_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class FavoriteController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  @override
  void onInit() {
    getMyLocation();
    super.onInit();
  }

  @override
  void onReady() {
    getFavProducts();
    super.onReady();
  }

  final ApiHelper _apiHelper = ApiHelper.to;

  final RxList<FavoritesModel> _favList = RxList();
  List<FavoritesModel> get favList => _favList;
  set favList(List<FavoritesModel> favLists) => _favList.addAll(favLists);

  getFavProducts() async {
    LoadingDialog.showLoadingDialog();
    String token = Storage.getValue(Constants.token);

    try {
      Uri mUri = Uri.parse(AppUrl.getFavorites)
          .replace(queryParameters: {"Authorization": "$token"});
      Response response = await _apiHelper.getApiCall(mUri.toString());
      if (response.body['error'] == '0') {
        if (response.body['favorites'] != null &&
            (response.body['favorites'] is List &&
                response.body['favorites'].isNotEmpty)) {
          favList.clear();
          for (int i = 0; i < response.body['favorites'].length; i++) {
            favList.add(
              FavoritesModel.fromJson(
                response.body['favorites'][i],
              ),
            );
          }
        } else {
          favList.clear();
        }
      }
    } catch (e) {
      LoadingDialog.closeLoadingDialog();
    }
    update();
    LoadingDialog.closeLoadingDialog();
  }

  addFavProducts(String resId) async {
    print("ADDDDDD");
    // Uri mUri = Uri.parse(AppUrl.addFavorites);
    try {
      Response response = await _apiHelper
          .postApiCall(AppUrl.addFavorites, {"restaurant": resId});
      if (response.body['error'] == '0') {
        await homeController.getCategoryData();
        homeController.update();
        Utils.showSnackbar("Added to favorites");
      }
    } catch (e) {
      print(e);
    }
  }

  deleteFavProducts(String resId, bool isGetCall) async {
    print("DELETE");

    // Uri mUri = Uri.parse(AppUrl.deleteFavorites);
    // .replace(queryParameters: {"Authorization": "$token"});
    Response response = await _apiHelper
        .postApiCall(AppUrl.deleteFavorites, {"restaurant": resId});
    if (response.statusCode == 200) {
      if (response.body['error'] == '0') {
        print("DELETED");
        homeController.getCategoryData();
        if (isGetCall) {
          homeController.popularMerchants.forEach((element) {
            if (element.id.toString() == resId) {
              element.favStatus = 'false';
            }
          });

          homeController.offerNearYou.forEach((element) {
            if (element.id.toString() == resId) {
              element.favStatus = 'false';
            }
          });

          homeController.update();
          getFavProducts();
        }
      }
      update();
    }
  }

  RxDouble myLat = 0.0.obs;
  RxDouble myLong = 0.0.obs;
  getMyLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    myLat.value = position.latitude;
    myLong.value = position.longitude;
    update();
  }
}
