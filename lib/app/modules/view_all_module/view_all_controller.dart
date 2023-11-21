import 'package:famooshed/app/data/models/get_home_response.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class ViewAllController extends GetxController {
  @override
  void onReady() {
    getMyLocation();
    getRoterdata();
    super.onReady();
  }

  RxList<ExclusiveonFamooshed> popularMerchants = <ExclusiveonFamooshed>[].obs;
  RxList<ExclusiveonFamooshed> offerNearYou = <ExclusiveonFamooshed>[].obs;
  RxList<ExclusiveonFamooshed> spotlight = <ExclusiveonFamooshed>[].obs;
  dynamic data = Get.arguments;

  getRoterdata() {
    popularMerchants.value = data;
    offerNearYou.value = data;
    spotlight.value = data;
    update();
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
