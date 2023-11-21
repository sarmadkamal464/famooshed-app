import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed/app/modules/widgets/no_item_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:famooshed/app/modules/settings_module/settings_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        centerTitle: true,
        title: "My Setting",
      ),
      body: const NoItemFound(),
    );
  }
}
