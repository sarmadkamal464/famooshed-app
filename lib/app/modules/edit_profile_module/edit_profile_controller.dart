import 'dart:developer';

import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/get_profile_response.dart';
import 'package:famooshed/app/utils/dprint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/constants.dart';
import '../../common/storage/storage.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class EditProfileController extends GetxController {
  @override
  void onReady() {
    getProfile();
    super.onReady();
  }

  TextEditingController emailController =
      TextEditingController(text: "frankterry@gmail.com");
  TextEditingController phoneController =
      TextEditingController(text: "+1 8382 122 333");
  TextEditingController addressController =
      TextEditingController(text: "12/A Dernim Street, Texas");

  TextEditingController fullName = TextEditingController(text: "Frank Terryl");
  TextEditingController userName = TextEditingController(text: "frankt9");

  final ApiHelper _apiHelper = ApiHelper.to;

  uploadAvatar() async {
    Utils.showImagePicker(
      onGetImage: (image) {
        dprint(image);
        // uploadAvatarApi(image);
      },
    );
    update();
  }

  uploadAvatarApi(image) async {
    try {
      var formData = FormData({
        'file': image,
      });

      _apiHelper.postApiCall(AppUrl.uploadAvatar, formData).futureValue(
          (value) {
        dprint(value);

        update();
      }, retryFunction: () {});
    } catch (e, trace) {
      log(e.toString(), stackTrace: trace);
    }
    update();
  }

  getProfile() async {
    var userId = await Storage.getValue(Constants.userId);
    _apiHelper.postApiCall("${AppUrl.getProfile}", {"id": userId}).futureValue(
      (value) {
        try {
          var response = GetProfileResponse.fromJson(value);
          // isLoading.value = false;
          // dprint(getProfileResponse);
          // dprint(value);
          fullName.text = response.user.name;
          emailController.text = response.user.email;
          phoneController.text = response.user.phone;
          addressController.text = response.user.address;
          update();
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
      },
      retryFunction: getProfile,
    );
  }

  changeProfile() {
    var body = {
      "name": fullName.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "address": addressController.text
    };
    _apiHelper.postApiCall(AppUrl.changeProfile, body).futureValue(
      (value) {
        dprint(value);
        getProfile();
        update();
      },
      retryFunction: changeProfile,
    );
  }
}
