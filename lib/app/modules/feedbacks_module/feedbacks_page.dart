import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed/app/modules/widgets/custom_default_button.dart';
import 'package:famooshed/app/theme/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:famooshed/app/modules/feedbacks_module/feedbacks_controller.dart';

import '../../common/util/exports.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class FeedbacksPage extends GetView<FeedbacksController> {
  FeedbacksPage({super.key});

  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        centerTitle: true,
        title: "Feedback",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.feedback,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'Enter your feedback here',
                      filled: true,
                    ),
                    maxLines: 5,
                    maxLength: 4096,
                    textInputAction: TextInputAction.done,
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                  ),
                  DefaultButton(
                    text: "Submit",
                    width: Get.width * .8,
                    onTap: () {
                      controller.autoPress();
                      // Get.toNamed(Routes.PAYMENT_METHODS);
                    },
                    buttonColor: AppColors.appTheme,
                    textColor: AppColors.white,
                  )
                ],
              ),
            ),
            Obx(() => Visibility(
                visible: controller.isLoading.value,
                child: const Center(
                  child: Loader(),
                )))
          ],
        ),
      ),
    );
  }
}
