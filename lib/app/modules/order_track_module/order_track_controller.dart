import 'dart:developer';

import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/get_order_status_response.dart';
import 'package:famooshed/app/utils/dprint.dart';
import 'package:get/get.dart';

import '../../data/models/get_oredrs_response.dart';

class OrderTrackController extends GetxController {
  @override
  void onReady() {
    getOrdersStatus();
    super.onReady();
  }

  var currentStep = 0.obs;
  Order order = Get.arguments;
  final ApiHelper _apiHelper = ApiHelper.to;
  GetOrdersStatusResponse? getOrdersStatusResponse;
  final RxList<OrderData> _orderData = RxList([]);
  List<OrderData> get orderData => _orderData;
  set orderData(List<OrderData> orderData) => _orderData.addAll(orderData);

  RxString driverName = "".obs;
  RxString vehicleName = "".obs;
  RxString profilePic = "".obs;
  RxString orederId = "".obs;
  RxString restaurantName = "".obs;
  RxString restaurantAdd = "".obs;

  getOrdersStatus() {
    dprint(order.orderid);
    _apiHelper
        .getApiCall(AppUrl.getOrdersStatus + order.orderid.toString())
        .futureValue(
      (value) {
        dprint(value);
        try {
          if (value["error"] == "0") {
            restaurantName.value = value['data'][0]['restaurantName'] ?? '-';
            restaurantAdd.value = value['data'][0]['address'] ?? '-';
            var response = GetOrdersStatusResponse.fromJson(value);
            getOrdersStatusResponse = response;
            orderData = response.data;
            driverName.value = response.data[0].drivername;
            vehicleName.value = response.data[0].vehicle;
            profilePic.value = response.data[0].profilepic;
            orederId.value = response.data[0].orderid.toString();
          } else {
            Utils.showSnackbar(value["message"] ?? "Something went wrong");
          }
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
        update();
      },
      retryFunction: getOrdersStatus,
    );
  }
}
