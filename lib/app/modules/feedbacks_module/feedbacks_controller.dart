import 'dart:async';

import 'package:famooshed/app/common/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbacksController extends GetxController {
  TextEditingController feedback = TextEditingController();

  Timer? timer;
  RxBool isLoading = false.obs;
  @override
  void onClose() {
    timer!.cancel();
    super.onClose();
  }

  void autoPress() {
    isLoading.value = true;
    timer = Timer(const Duration(seconds: 2), () {
      Utils.showDialog("Thankyou", title: "Famooshed");
    });

    isLoading.value = false;
  }
}
