// ignore_for_file: unused_import

import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/util/loading_dialog.dart';
import '../../common/values/app_urls.dart';
import '../../data/api_helper.dart';
import '../orders_module/orders_bindings.dart';
import '../orders_module/orders_page.dart';

class AboutUsController extends GetxController {
  @override
  void onReady() {
    getDocumentData();
    super.onReady();
  }

  final ApiHelper _apiHelper = ApiHelper.to;

  String aboutText = '';

  getDocumentData() async {
    LoadingDialog.showLoadingDialog();
    try {
      Uri privacyUri = Uri.parse(AppUrl.getDocument)
          .replace(queryParameters: {"doc": 'about'});

      Response privacyRes = await _apiHelper.getApiCall(privacyUri.toString());

      if (privacyRes.body['error'] == '0') {
        if (privacyRes.body['doc'] != null) {
          aboutText = privacyRes.body['doc'];
        }
      }
    } catch (e) {
      LoadingDialog.closeLoadingDialog();
    }

    LoadingDialog.closeLoadingDialog();
    update();
  }
}
