import 'package:dio/dio.dart' as d;
import 'package:famooshed/app/common/storage/storage.dart';
import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/save_address_response.dart';
import 'package:famooshed/app/modules/checkout_module/checkout_controller.dart';
import 'package:famooshed/app/utils/dprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

import '../../common/constants.dart';
import '../../common/util/loading_dialog.dart';
import '../../common/values/app_colors.dart';
import '../../data/models/get_address_new_response.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/size_config.dart';

class AddNewLocationController extends GetxController {
  @override
  void onReady() {
    // getAddress();
    getAddressNew();
    super.onReady();
  }

  var kGoogleApiKey = "AIzaSyBRPxjNN-yrJh2tGSCmsx0fdYX83Wodei4";
  final searchController = TextEditingController();
  final ApiHelper apiHelper = ApiHelper.to;
  String verticalGroupValue = "home";
  final status = ["home", "work"];
  RxBool isDefault = true.obs;

  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;

  // final RxList<Address> _address = RxList();
  // List<Address> get address => _address;
  // set address(List<Address> address) => _address.addAll(address);

  final RxList<AddressResponse> _address = RxList();
  List<AddressResponse> get address => _address;
  set address(List<AddressResponse> address) => _address.addAll(address);

  getAddressNew() async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var queryParams = {
        "isApp": true,
        "uid": uid.toString(),
      };

      d.Response response = await apiHelper.getApiNew(
        AppUrl.getAddresses,
        {},
        queryParams,
      );

      if (response.statusCode == 200) {
        address.clear();
        dprint(response.data);
        if (response.data['error'] == '0') {
          if (response.data['address'] != null) {
            List data = response.data['address'];
            if (data.isNotEmpty) {
              data.forEach((element) {
                address.add(AddressResponse.fromJson(element));
              });
            }
            update();
          }
        }
      }
      LoadingDialog.closeLoadingDialog();
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  Future<void> handlePressButton() async {
    void onError(PlacesAutocompleteResponse response) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }

    final p = await PlacesAutocomplete.show(
      context: Get.context!,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.fullscreen,
      language: 'en',
      components: [
        // Component(Component.country, 'gb'),
        // Component(Component.country, 'in')
      ],
      resultTextStyle: Theme.of(Get.context!).textTheme.titleMedium,
    );
    await displayPrediction(p, ScaffoldMessenger.of(Get.context!));
  }

  Future<void> displayPrediction(
      Prediction? p, ScaffoldMessengerState messengerState) async {
    if (p == null) {
      return;
    }

    final places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    final detail = await places.getDetailsByPlaceId(p.placeId!);
    final geometry = detail.result.geometry!;
    lat.value = geometry.location.lat;
    lng.value = geometry.location.lng;
    dprint(p.description);
    searchController.text = p.description!;
    update();
  }

  RxString text = RxString("");
  // saveAddress() {
  //   var body = {
  //     "text": text.value,
  //     "lat": lat.value,
  //     "lng": lng.value,
  //     "type": verticalGroupValue,
  //     "default": isDefault.value
  //   };
  //   dprint(body);
  //   apiHelper.saveAddress(AppUrl.saveAddress, body).futureValue((value) {
  //     dprint(value);
  //     var response = SaveAddresstResponse.fromJson(value);
  //     if (address.isNotEmpty) {
  //       address.clear();
  //       address = response.address;
  //     } else {
  //       address = response.address;
  //     }
  //     Get.find<CheckoutController>().getAddressNew();
  //     Get.find<CheckoutController>().update();
  //     update();
  //   }, retryFunction: saveAddress);
  // }

  Future<void> saveAddressNew(
      {required String flat,
      required String area,
      required String landMark,
      required double lat,
      required double long,
      required String type,
      required bool isDefault}) async {
    var body = {
      "text": area,
      "lat": lat,
      "lng": long,
      "type": type,
      "default": isDefault.toString(),
      "flat_house_no": flat,
      "near_by_landmark": landMark,
    };
    dprint(body);
    LoadingDialog.showLoadingDialog();
    try {
      Response response = await apiHelper.saveAddress(AppUrl.saveAddress, body);
      if (response.statusCode == 200) {
        address.clear();
        var value = SaveAddresstResponse.fromJson(response.body);

        if (value.error == '0') {
          await getAddressNew();
          await Get.find<CheckoutController>().getAddressNew();
        } else {
          Utils.showSnackbar(
              response.body['message'] ?? "Error Fetching Address");
        }
        update();
        LoadingDialog.closeLoadingDialog();
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  Future<void> editAddress(
      {required String editId,
      required String flat,
      required String area,
      required String landMark,
      required double lat,
      required double long,
      required String type,
      required bool isDefault}) async {
    var body = {
      "edit": 1,
      "edit_id": editId,
      "text": area,
      "lat": lat,
      "lng": long,
      "type": type,
      "default": isDefault.toString(),
      "flat_house_no": flat,
      "near_by_landmark": landMark,
    };
    dprint(body);
    LoadingDialog.showLoadingDialog();
    try {
      Response response = await apiHelper.saveAddress(AppUrl.saveAddress, body);
      if (response.statusCode == 200) {
        address.clear();
        var value = SaveAddresstResponse.fromJson(response.body);

        if (value.error == '0') {
          await getAddressNew();
          await Get.find<CheckoutController>().getAddressNew();
        } else {
          Utils.showSnackbar(
              response.body['message'] ?? "Error Fetching Address");
        }
        update();
        LoadingDialog.closeLoadingDialog();
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  // getAddress() {
  //   apiHelper.postApiCall(AppUrl.getAddress, {}).futureValue((value) {
  //     var response = GetAddresstResponse.fromJson(value);
  //     address.clear();
  //     address = response.address;
  //     // if (address.isNotEmpty) {
  //     //   address.clear();
  //     //   address = response.address;
  //     // }
  //     // else {
  //     //   address = response.address;
  //     // }
  //     update();
  //   }, retryFunction: getAddress);
  // }

  deleteAddress({id}) {
    if (id != null) {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: new Text('Delete Cart'),
                content: new Text(
                  'Are you sure you want to delete the address?',
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
                        var body = {"id": id};
                        Response response = await apiHelper.postApiCall(
                            AppUrl.delAddress, body);
                        if (response.statusCode == 200) {
                          if (response.body['error'] == '0') {
                            await getAddressNew();
                            await Get.find<CheckoutController>().getAddressNew();

                            update();
                            LoadingDialog.closeLoadingDialog();
                          }
                        }
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

  AddressResponse? editAdd;

  // void editAddressSheet(AddressResponse address) {
  //
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topRight: Radius.circular(24),
  //             topLeft: Radius.circular(24))),
  //     context: Get.context!,
  //     builder: (context) => StatefulBuilder(
  //       builder: (context, mSetState) {
  //         return SafeArea(
  //           child: Padding(
  //             padding: EdgeInsets.only(
  //                 bottom: MediaQuery.of(context)
  //                     .viewInsets
  //                     .bottom,
  //                 left: getProportionateScreenWidth(16),
  //                 right: getProportionateScreenWidth(16)),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment:
  //               CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   height:
  //                   getProportionateScreenHeight(16),
  //                 ),
  //                 Center(
  //                   child: Container(
  //                     height:
  //                     getProportionateScreenHeight(5),
  //                     width:
  //                     getProportionateScreenWidth(48),
  //                     decoration: BoxDecoration(
  //                       color: Colors.grey,
  //                       borderRadius:
  //                       BorderRadius.circular(2.5),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height:
  //                   getProportionateScreenHeight(16),
  //                 ),
  //                 Text(
  //                   'Enter complete address',
  //                   // 'Linsted Lane, Headly',
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: beVietnamProaBold.copyWith(
  //                       color: AppColors.appTheme,
  //                       fontSize:
  //                       getProportionalFontSize(16)),
  //                 ),
  //                 SizedBox(
  //                   height:
  //                   getProportionateScreenHeight(16),
  //                 ),
  //                 radioButtons(mSetState),
  //                 checkBox(mSetState),
  //                 SizedBox(
  //                   height:
  //                   getProportionateScreenHeight(12),
  //                 ),
  //                 TextFormField(
  //                   controller: flatController,
  //                   decoration: InputDecoration(
  //                     border: OutlineInputBorder(
  //                       borderRadius:
  //                       BorderRadius.circular(8),
  //                     ),
  //                     focusedBorder: OutlineInputBorder(
  //                       borderRadius:
  //                       BorderRadius.circular(8),
  //                       borderSide: BorderSide(
  //                           color: AppColors.black),
  //                     ),
  //                     contentPadding: EdgeInsets.only(
  //                       left:
  //                       getProportionateScreenWidth(12),
  //                       right:
  //                       getProportionateScreenWidth(12),
  //                     ),
  //                     filled: true,
  //                     labelStyle:
  //                     beVietnamProMedium.copyWith(
  //                         fontSize:
  //                         getProportionalFontSize(
  //                             12),
  //                         color: AppColors.lightBlack),
  //                     labelText:
  //                     "Flat / House no / Floor / Building",
  //                     // hintText: "Flat / House no/ Floor / Building"
  //                   ),
  //                   style: beVietnamProMedium.copyWith(
  //                     fontSize: getProportionalFontSize(13),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height:
  //                   getProportionateScreenHeight(14),
  //                 ),
  //                 TextFormField(
  //                   controller: areaController,
  //                   decoration: InputDecoration(
  //                     border: OutlineInputBorder(
  //                       borderRadius:
  //                       BorderRadius.circular(8),
  //                     ),
  //                     focusedBorder: OutlineInputBorder(
  //                       borderRadius:
  //                       BorderRadius.circular(8),
  //                       borderSide: BorderSide(
  //                           color: AppColors.black),
  //                     ),
  //                     contentPadding: EdgeInsets.only(
  //                       left:
  //                       getProportionateScreenWidth(12),
  //                       right:
  //                       getProportionateScreenWidth(12),
  //                     ),
  //                     filled: true,
  //                     labelStyle:
  //                     beVietnamProMedium.copyWith(
  //                         fontSize:
  //                         getProportionalFontSize(
  //                             12),
  //                         color: AppColors.lightBlack),
  //                     labelText: "Area / Sector / Locality",
  //                     // hintText: "Flat / House no/ Floor / Building"
  //                   ),
  //                   style: beVietnamProMedium.copyWith(
  //                     fontSize: getProportionalFontSize(13),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height:
  //                   getProportionateScreenHeight(14),
  //                 ),
  //                 TextFormField(
  //                   controller: landMarkController,
  //                   decoration: InputDecoration(
  //                     border: OutlineInputBorder(
  //                       borderRadius:
  //                       BorderRadius.circular(8),
  //                     ),
  //                     focusedBorder: OutlineInputBorder(
  //                       borderRadius:
  //                       BorderRadius.circular(8),
  //                       borderSide: BorderSide(
  //                           color: AppColors.black),
  //                     ),
  //                     contentPadding: EdgeInsets.only(
  //                       left:
  //                       getProportionateScreenWidth(12),
  //                       right:
  //                       getProportionateScreenWidth(12),
  //                     ),
  //                     filled: true,
  //                     labelStyle:
  //                     beVietnamProMedium.copyWith(
  //                         fontSize:
  //                         getProportionalFontSize(
  //                             12),
  //                         color: AppColors.lightBlack),
  //                     labelText:
  //                     "Nearby landmark (optional)",
  //                     // hintText: "Flat / House no/ Floor / Building"
  //                   ),
  //                   style: beVietnamProMedium.copyWith(
  //                     fontSize: getProportionalFontSize(13),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height:
  //                   getProportionateScreenHeight(22),
  //                 ),
  //                 DefaultButton(
  //                   text: 'Save Address',
  //                   textStyle: beVietnamProaBold.copyWith(
  //                       fontSize:
  //                       getProportionalFontSize(14),
  //                       color: AppColors.white),
  //                   width: SizeConfig.deviceWidth!,
  //                   height:
  //                   getProportionateScreenHeight(50),
  //                   buttonColor: AppColors.appTheme,
  //                   textColor: AppColors.white,
  //                   onTap: () async {
  //                     print(lat.value.toString());
  //                     print(lng.value.toString());
  //                     await addNewLocationController
  //                         .saveAddressNew(
  //                         flat: flatController.text,
  //                         area: areaController.text,
  //                         landMark:
  //                         landMarkController.text,
  //                         lat: lat.value,
  //                         long: lng.value,
  //                         type: verticalGroupValue,
  //                         isDefault: isDefault.value);
  //                     Get.back();
  //                     Get.back();
  //                     // Get.back();
  //                   },
  //                 ),
  //                 SizedBox(
  //                   height:
  //                   getProportionateScreenHeight(16),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
