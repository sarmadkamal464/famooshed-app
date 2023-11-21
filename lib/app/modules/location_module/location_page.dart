import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:famooshed/app/modules/location_module/location_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class LocationPage extends GetView<LocationController> {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Page')),
      body: Obx(() => Text(controller.obj)),
    );
  }
}
