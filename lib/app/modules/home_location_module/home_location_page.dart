// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:famooshed/app/modules/home_location_module/home_location_controller.dart';

import '../../common/util/exports.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/custom_default_button.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class HomeLocationPage extends GetView<HomeLocationController> {
  const HomeLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        centerTitle: true,
        title: "Set Home Address",
      ),
      backgroundColor: AppColors.loginBackgroud,
      floatingActionButton: DefaultButton(
        text: Strings.addNew,
        width: Get.width * .85,
        onTap: () {},
        buttonColor: AppColors.appTheme,
        textColor: AppColors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          children: [
            serachBar(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  serachBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      margin: const EdgeInsets.all(12),
      child: Row(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.search,
              color: AppColors.appTheme,
              size: 26,
            ),
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search Location..",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                isDense: true,
              ),
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
