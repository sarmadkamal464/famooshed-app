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

class DocumentController extends GetxController {
  @override
  void onReady() {
    getDocumentData();
    super.onReady();
  }

  final ApiHelper _apiHelper = ApiHelper.to;

  String privacyText = '';
  String termsText = '';
  String refundText = '';

  getDocumentData() async {
    LoadingDialog.showLoadingDialog();
    try {
      Uri privacyUri = Uri.parse(AppUrl.getDocument)
          .replace(queryParameters: {"doc": 'privacy'});

      Response privacyRes = await _apiHelper.getApiCall(privacyUri.toString());

      if (privacyRes.body['error'] == '0') {
        if (privacyRes.body['doc'] != null) {
          privacyText = privacyRes.body['doc'];
        }
      }
    } catch (e) {
      LoadingDialog.closeLoadingDialog();
    }

    try {
      Uri termsUri = Uri.parse(AppUrl.getDocument)
          .replace(queryParameters: {"doc": 'terms'});

      Response termsRes = await _apiHelper.getApiCall(termsUri.toString());

      if (termsRes.body['error'] == '0') {
        if (termsRes.body['doc'] != null) {
          termsText = termsRes.body['doc'];
        }
      }
    } catch (e) {
      LoadingDialog.closeLoadingDialog();
    }

    try {
      Uri refundUri = Uri.parse(AppUrl.getDocument)
          .replace(queryParameters: {"doc": 'refund'});

      Response refundRes = await _apiHelper.getApiCall(refundUri.toString());

      if (refundRes.body['error'] == '0') {
        if (refundRes.body['doc'] != null) {
          refundText = refundRes.body['doc'];
        }
      }
    } catch (e) {
      LoadingDialog.closeLoadingDialog();
    }
    LoadingDialog.closeLoadingDialog();
    update();
  }
}
