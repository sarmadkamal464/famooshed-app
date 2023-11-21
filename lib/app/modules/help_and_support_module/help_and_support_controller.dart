import 'dart:developer';

import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/get_faq_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpAndSupportController extends GetxController {
  @override
  void onReady() {
    // getFaq();
    super.onReady();
  }

  List<String> ticketTypes = [
    "Request",
    "Inquiry",
    "Technical Issue",
  ];
  String selectedTicket = '';
  String selectedPriority = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final ApiHelper _apiHelper = ApiHelper.to;

  final RxList<FaqItem> _allCat = RxList();
  List<FaqItem> get allCat => _allCat;
  set allCat(List<FaqItem> allCat) => _allCat.addAll(allCat);

  getFaq() {
    _apiHelper.getApiCall(AppUrl.getfaq).futureValue(
      (value) {
        var response = GetFaqResponse.fromJson(value);

        if (allCat.isNotEmpty) {
          allCat.clear();
          allCat = response.faqData!;
        } else {
          allCat = response.faqData!;
        }

        update();
      },
      retryFunction: getFaq,
    );
  }

  createTicket() async {
    _apiHelper.postApiCall(AppUrl.createTicket, {
      "username": nameController.text,
      "useremail": emailController.text,
      "ticketcat": selectedTicket,
      "priority": selectedPriority,
      "description": descriptionController.text,
    }).futureValue(
      (value) {
        try {
          if (value['error'] == '0') {
            Utils.showSnackbar(value['message']);
          }
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
      },
      retryFunction: createTicket,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
