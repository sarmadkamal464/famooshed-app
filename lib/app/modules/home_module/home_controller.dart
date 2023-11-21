// ignore_for_file: invalid_use_of_protected_member

import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/common/storage/storage.dart';
import 'package:famooshed/app/common/util/loading_dialog.dart';
import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/get_home_response.dart';
import 'package:famooshed/app/data/models/get_second_step_response.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/utils/dprint.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;
  // FavoriteController favController = Get.find<FavoriteController>(tag: "N");
  @override
  void onClose() {
    dprint('Home Controller Closed');
    super.onClose();
  }

  // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // RxList<String> banner1 = <String>[].obs;
  // RxBool isLoading = true.obs;
  RxList<Category> category = <Category>[].obs;
  RxList<ExclusiveonFamooshed> popularMerchants = <ExclusiveonFamooshed>[].obs;
  RxList<ExclusiveonFamooshed> newToFamooshed = <ExclusiveonFamooshed>[].obs;
  RxList<ExclusiveonFamooshed> highestRatedMarkets =
      <ExclusiveonFamooshed>[].obs;
  RxList<ExclusiveonFamooshed> popularMerchantsMain =
      <ExclusiveonFamooshed>[].obs;

  RxList<ExclusiveonFamooshed> offerNearYou = <ExclusiveonFamooshed>[].obs;
  RxList<ExclusiveonFamooshed> spotlight = <ExclusiveonFamooshed>[].obs;
  RxDouble myLat = 0.0.obs;
  RxDouble myLong = 0.0.obs;
  final RxList<String> _bannerList = RxList();
  List<String> get bannerList => _bannerList;
  set bannerList(List<String> bannerList) => _bannerList.addAll(bannerList);

  final RxList<String> _bannerList2 = RxList();
  List<String> get bannerList2 => _bannerList2;
  set bannerList2(List<String> bannerList2) => _bannerList2.addAll(bannerList2);
  var currentIndex = 0.obs;
  @override
  void onReady() {
    getDistance();
    getBannerData();
    getCategoryData();
    super.onReady();
  }

  void getBannerData() async {
    LoadingDialog.showLoadingDialog();

    try {
      Response response = await _apiHelper.getApiCall(AppUrl.getSecondStep);

      if (response.statusCode == 200) {
        var data = GetSecondStepResponse.fromJson(response.body);
        bannerList.clear();
        bannerList2.clear();

        for (var item in data.banner1) {
          bannerList.add(Constants.imgUrl + item.image);
        }
        for (var item in data.banner2) {
          bannerList2.add(Constants.imgUrl + item.image);
        }
        update();
      }
    } catch (e) {
      print(e.toString());
      update();

      LoadingDialog.closeLoadingDialog();
    }
    LoadingDialog.closeLoadingDialog();
    // _apiHelper.getApiCall(AppUrl.getSecondStep).futureValue(
    //   (value) async {
    //     try {
    //       var response = GetSecondStepResponse.fromJson(value);
    //       bannerList.clear();
    //       bannerList2.clear();
    //
    //       for (var item in response.banner1) {
    //         bannerList.add(Constants.imgUrl + item.image);
    //       }
    //       for (var item in response.banner2) {
    //         bannerList2.add(Constants.imgUrl + item.image);
    //       }
    //       await getCategoryData();
    //     } catch (e, trace) {
    //       log(e.toString(), stackTrace: trace);
    //     }
    //   },
    //   retryFunction: getBannerData,
    // );
    // update();
  }

  Future<void> getCategoryData() async {
    LoadingDialog.showLoadingDialog();
    try {
      String userId = Storage.getValue(Constants.userId).toString();
      Uri mUri = Uri.parse(AppUrl.getHome).replace(queryParameters: {
        "userId": userId.toString(),
        // "lat": myLat.value,
        // "long": myLong.value,
      });

      Response response = await _apiHelper.getApiCall(mUri.toString());
      var data = GetHomeResponse.fromJson(response.body);
      category.value = data.categories;
      popularMerchants.value = data.featured;
      offerNearYou.value = data.offersNearYou;
      spotlight.value = data.spotlightResturents;
      popularMerchantsMain.value = data.toppicks;
      newToFamooshed.value = data.newonFamooshed;
      highestRatedMarkets.value = data.topRated;
      update();
      LoadingDialog.closeLoadingDialog();
    } catch (e) {
      print(e.toString());
      update();
      LoadingDialog.closeLoadingDialog();
    }

    // String userId = Storage.getValue(Constants.userId).toString();
    // Uri mUri = Uri.parse(AppUrl.getHome)
    //     .replace(queryParameters: {"userId": userId.toString()});
    // _apiHelper.getHome(mUri.toString()).futureValue(
    //   (value) {
    //     try {
    //       var response = GetHomeResponse.fromJson(value);
    //       category.value = response.categories;
    //       popularMerchants.value = response.featured;
    //       offerNearYou.value = response.offersNearYou;
    //       spotlight.value = response.spotlightResturents;
    //       isLoading.value = false;
    //       update();
    //     } catch (e, trace) {
    //       log(e.toString(), stackTrace: trace);
    //     }
    //   },
    //   retryFunction: getCategoryData,
    // );
  }

  reDirectSearch() {
    Get.toNamed(Routes.SEARCH, arguments: category.value);
  }

  reDirectToViewAll(data) {
    Get.toNamed(Routes.VIEW_ALL, arguments: data);
  }

  void determinePosition() async {
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
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();

      myLat.value = position.latitude;
      myLong.value = position.longitude;
      update();

      // update();

      // await getBannerData().whenComplete(() async {
      //   await getCategoryData();
      //   update();
      // });
    }
  }

  getDistance() {
    determinePosition();
    // Position myLocation = await determinePosition();

    // Future.delayed(Duration(seconds: 0)).then((value) async {
    // myLat.value = myLocation.latitude;
    // myLong.value = myLocation.longitude;
    // update();
    //
    // await getBannerData().whenComplete(() async {
    //   await getCategoryData();
    //   update();
    // });

    // });
  }
}
