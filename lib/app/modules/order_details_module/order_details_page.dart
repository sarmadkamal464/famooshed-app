import 'package:famooshed/app/modules/order_details_module/order_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class OrderDetailsPage extends GetView<OrderDetailsController> {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OrderDetails Page')),
      body: Obx(() => Text(controller.obj)),
    );
  }
}
