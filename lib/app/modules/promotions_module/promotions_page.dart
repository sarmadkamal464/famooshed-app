import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed/app/modules/widgets/no_item_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:famooshed/app/modules/promotions_module/promotions_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class PromotionsPage extends GetView<PromotionsController> {
  const PromotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        centerTitle: true,
        title: "Promotions & Deals",
      ),
      body: Container(
        child: const NoItemFound(),
      ),
    );
  }
}
