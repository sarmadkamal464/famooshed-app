import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed/app/modules/widgets/no_item_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:famooshed/app/modules/my_reward_module/my_reward_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class MyRewardPage extends GetView<MyRewardController> {
  const MyRewardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        centerTitle: true,
        title: "My Reward",
      ),
      body: const NoItemFound(),
    );
  }
}
