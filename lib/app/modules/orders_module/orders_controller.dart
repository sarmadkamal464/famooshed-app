import 'package:dio/dio.dart' as d;
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/get_oredrs_response.dart';
import 'package:famooshed/app/modules/dashboard_module/dashboard_controller.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../common/constants.dart';
import '../../common/storage/storage.dart';
import '../../common/util/loading_dialog.dart';
import '../../common/values/app_colors.dart';
import '../../common/values/app_urls.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/size_config.dart';
import '../../utils/dprint.dart';

class OrdersController extends GetxController {
  @override
  void onReady() {
    getOrders();
    super.onReady();
  }

  @override
  void onClose() {
    dprint('Orders Controller Closed');
    super.onClose();
  }

  dynamic showAppBar = Get.arguments ?? false;
  final ApiHelper _apiHelper = ApiHelper.to;
  final RxList<Order> _orderList = RxList();
  List<Order> get orderList => _orderList;
  set orderList(List<Order> orderList) => _orderList.addAll(orderList);

  final RxList<Ordersdetail> _orderDetailsList = RxList();
  List<Ordersdetail> get orderDetailsList => _orderDetailsList;
  set orderDetailsList(List<Ordersdetail> orderList) =>
      _orderDetailsList.addAll(orderDetailsList);

  // ReOrderModel reOrderModel = ReOrderModel();

  void getOrders() {
    var body = {"start_date": sortStartDate, "end_date": sortEndDate};
    _apiHelper.postApiCall(AppUrl.getOrders, body).futureValue(
      (value) {
        dprint(value);
        try {
          var response = GetOrdersResponse.fromJson(value);
          orderList.clear();
          if (response.data != null && response.data!.isNotEmpty) {
            orderList = response.data!;
          }
          update();
        } catch (e) {
          print(e.toString());
        }
      },
      retryFunction: getOrders,
    );
  }

  // Future<void> reOrder(orderId) async {
  //   LoadingDialog.showLoadingDialog();
  //
  //   try {
  //     Response data = await _apiHelper
  //         .postApiCall(AppUrl.reOrder, {"orderId": orderId.toString()});
  //     if (data.statusCode == 200) {
  //       if (data.body['error'] == '0' && data.body['data'] != null) {
  //         reOrderModel = ReOrderModel.fromJson(data.body['data'][0]);
  //         if (reOrderModel.ordersdetails != null &&
  //             reOrderModel.ordersdetails!.isNotEmpty) {
  //           await _apiHelper.postApiCall(AppUrl.resetBasket, {});
  //
  //           List<Map<String, dynamic>> dataList = [];
  //           reOrderModel.ordersdetails!.forEach((element) {
  //             dataList.add({
  //               "food": element.food,
  //               "count": element.count,
  //               "foodprice": element.foodprice,
  //               "extras": element.extras,
  //               "extrascount": element.extrascount,
  //               "extrasprice": element.extrasprice,
  //               "foodid": element.foodid,
  //               "extrasid": element.extrasid,
  //               "image": element.image
  //             });
  //           });
  //
  //           var body = {
  //             "total": reOrderModel.total,
  //             "address": "",
  //             "phone": "",
  //             "pstatus": "Waiting for client",
  //             "lat": reOrderModel.shopLat,
  //             "lng": reOrderModel.shopLng,
  //             "curbsidePickup": reOrderModel.curbsidePickup,
  //             "send": "0",
  //             "tax": reOrderModel.tax,
  //             "hint": "hint",
  //             "couponName": "",
  //             "restaurant": reOrderModel.restaurant,
  //             "method": "Cash on Delivery",
  //             "fee": reOrderModel.fee,
  //             "data": dataList
  //           };
  //
  //           Response cartRes =
  //               await _apiHelper.addBasket(AppUrl.addToBasket, body);
  //           if (cartRes.statusCode == 200) {
  //             if (cartRes.body['error'] == '0') {
  //               LoadingDialog.closeLoadingDialog();
  //               // Utils.showSnackbar("Added to cart successfully");
  //               // Get.toNamed(Routes.CART);
  //               var result = await Get.toNamed(Routes.CART);
  //
  //               if (result != null) {
  //                 CartController().getBasket();
  //               }
  //             }
  //           }
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     LoadingDialog.closeLoadingDialog();
  //   }
  //   LoadingDialog.closeLoadingDialog();
  // }

  reDirect(index) {
    Get.toNamed(Routes.ORDER_TRACK, arguments: orderList[index]);
  }

  String startDate =
          Jiffy.parse(DateTime.now().toString()).format(pattern: 'dd MMM'),
      endDate =
          Jiffy.parse(DateTime.now().toString()).format(pattern: 'dd MMM');
  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    //  =
    //     DateFormat('dd MMMM yyyy').format(args.value.startDate).toString();
    // endDate = DateFormat('dd MMMM yyyy').format(args.value.endDate).toString();

    startDate =
        Jiffy.parse(args.value.startDate.toString()).format(pattern: 'dd MMM');
    endDate =
        Jiffy.parse(args.value.endDate.toString()).format(pattern: 'dd MMM');
    update();
    dprint(startDate);
    dprint(endDate);
  }

  getLocalDate(String inputDate) {
    DateTime utcDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(inputDate, true).toLocal();
    String localString = DateFormat('dd MMM yyyy, h:mm a').format(utcDate);

    return localString;
  }

  reOrderMethod(int? orderid) async {
    if (orderid != null) {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: new Text('Delete Cart'),
                content: new Text(
                  // 'You can add to cart, only products from single market. Your existing cart will be reset. Do you want to repeat order?',
                  'Are you sure to remove existing cart items if any and replace it with this order items?',
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
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
                      Get.back();
                      LoadingDialog.showLoadingDialog();
                      int uid = await Storage.getValue(Constants.userId);

                      print(uid);
                      try {
                        var body = {
                          "isApp": true,
                          "uid": uid.toString(),
                          "order_id": orderid,
                        };

                        d.Response response = await _apiHelper.postApiNew(
                            AppUrl.repeatOrder, {}, body);

                        if (response.statusCode == 200) {
                          DashboardController dashBoardController =
                              Get.find<DashboardController>();
                          dashBoardController.getCartNew();
                          LoadingDialog.closeLoadingDialog();
                          await Get.toNamed(Routes.CART);
                          dashBoardController.getCartNew();
                        } else {}
                      } catch (e) {
                        print(e.toString());
                        LoadingDialog.closeLoadingDialog();
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
    }
  }

  PickerDateRange? range;

  String sortStartDate = '';
  String sortEndDate = '';
}
