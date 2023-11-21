import 'dart:developer';

import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/get_profile_response.dart';
import 'package:famooshed/app/utils/dprint.dart';
import 'package:get/get.dart';

import '../../common/util/exports.dart';
import '../../common/util/loading_dialog.dart';
import '../../routes/app_pages.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class MyProfileController extends GetxController {
  GetProfileResponse? getProfileResponse;
  @override
  void onReady() {
    getProfile();
    super.onReady();
  }

  @override
  void onClose() {
    dprint('Profile Controller Closed');
    super.onClose();
  }

  dynamic showAppBar = Get.arguments ?? false;

  RxBool isLoading = true.obs;
  final ApiHelper _apiHelper = ApiHelper.to;

  getProfile() async {
    var userId = await Storage.getValue(Constants.userId);

    _apiHelper.postApiCall("${AppUrl.getProfile}", {"id": userId}).futureValue(
      (value) {
        try {
          getProfileResponse = GetProfileResponse.fromJson(value);
          isLoading.value = false;

          update();
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
      },
      retryFunction: getProfile,
    );
  }

  deleteProfile() async {
    LoadingDialog.showLoadingDialog();
    try {
      var userId = await Storage.getValue(Constants.userId);

      Response response = await _apiHelper
          .postApiCall("${AppUrl.customerDelete}", {"id", userId});
      if (response.statusCode == 200) {
        LoadingDialog.closeLoadingDialog();
        await Storage.clearStorage();
        Get.offAllNamed(Routes.SIGN_IN);
      }
    } catch (e) {
      print(e);
      LoadingDialog.closeLoadingDialog();
    }
    // _apiHelper
    //     .postApi(
    //   "${AppUrl.customerDelete}",{"id",userId}
    // )
    //     .futureValue(
    //   (value) {
    //     try {
    //       getProfileResponse = GetProfileResponse.fromJson(value);
    //       isLoading.value = false;
    //
    //       update();
    //     } catch (e, trace) {
    //       log(e.toString(), stackTrace: trace);
    //     }
    //   },
    //   retryFunction: deleteProfile,
    // );
  }
}
