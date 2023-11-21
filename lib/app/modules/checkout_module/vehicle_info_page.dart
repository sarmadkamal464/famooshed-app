import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/values/app_colors.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/size_config.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/custom_default_button.dart';
import 'checkout_controller.dart';

class VehicleInfoPage extends GetView<CheckoutController> {
  VehicleInfoPage({super.key});

  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        centerTitle: true,
        backgroundColor: AppColors.white,
        statusBarColor: AppColors.white,
        title: "Vehicle Information",
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        // clipBehavior: Clip.none,
        child: GetBuilder<CheckoutController>(
          init: CheckoutController(),
          builder: (CheckoutController checkoutController) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16)),
              child: Form(
                key: fKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      "Select Vehicle Type",
                      style: TextStyle(
                          fontSize: getProportionalFontSize(15),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Wrap(
                      children: [
                        GestureDetector(
                          child: commonCarWidget("assets/suv.png", "SUV",
                              controller.isSUVSelected),
                          onTap: () {
                            controller.isSedanSelected = false;
                            controller.isCoupeSelected = false;
                            controller.isTruckSelected = false;
                            controller.isBikeSelected = false;
                            controller.isOtherSelected = false;
                            controller.isSUVSelected = true;
                            controller.selectedVehicleName = "suv";
                            controller.update();
                          },
                        ),
                        GestureDetector(
                          child: commonCarWidget("assets/sedan.png", "Sedan",
                              controller.isSedanSelected),
                          onTap: () {
                            controller.isSUVSelected = false;
                            controller.isCoupeSelected = false;
                            controller.isTruckSelected = false;
                            controller.isBikeSelected = false;
                            controller.isOtherSelected = false;
                            controller.isSedanSelected = true;
                            controller.selectedVehicleName = "sedan";
                            controller.update();
                          },
                        ),
                        GestureDetector(
                          child: commonCarWidget("assets/coupe.png", "Coupe",
                              controller.isCoupeSelected),
                          onTap: () {
                            controller.isSUVSelected = false;
                            controller.isSedanSelected = false;
                            controller.isTruckSelected = false;
                            controller.isBikeSelected = false;
                            controller.isOtherSelected = false;
                            controller.isCoupeSelected = true;
                            controller.selectedVehicleName = "coupe";
                            controller.update();
                          },
                        ),
                        GestureDetector(
                          child: commonCarWidget("assets/truck.png", "Truck",
                              controller.isTruckSelected),
                          onTap: () {
                            controller.isSUVSelected = false;
                            controller.isSedanSelected = false;
                            controller.isCoupeSelected = false;
                            controller.isBikeSelected = false;
                            controller.isOtherSelected = false;
                            controller.isTruckSelected = true;
                            controller.selectedVehicleName = "truck";
                            controller.update();
                          },
                        ),
                        GestureDetector(
                          child: commonCarWidget("assets/byke.png", "Bike",
                              controller.isBikeSelected),
                          onTap: () {
                            controller.isSUVSelected = false;
                            controller.isSedanSelected = false;
                            controller.isCoupeSelected = false;
                            controller.isTruckSelected = false;
                            controller.isOtherSelected = false;
                            controller.isBikeSelected = true;
                            controller.selectedVehicleName = "bike";
                            controller.update();
                          },
                        ),
                        GestureDetector(
                          child: commonCarWidget("assets/other.png", "Other",
                              controller.isOtherSelected),
                          onTap: () {
                            controller.isSUVSelected = false;
                            controller.isSedanSelected = false;
                            controller.isCoupeSelected = false;
                            controller.isTruckSelected = false;
                            controller.isBikeSelected = false;
                            controller.isOtherSelected = true;
                            controller.selectedVehicleName = "other";
                            controller.update();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Text(
                      "Select Vehicle Color",
                      style: TextStyle(
                          fontSize: getProportionalFontSize(15),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _color(Colors.black, "Black"), // Black
                        _color(Colors.red, "Red"), // "Red"
                        _color(Colors.white, "White"), // White
                        _color(Colors.grey, "Grey"), // Gray
                        _color(Colors.grey.withAlpha(100), "Silver"), // Silver
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _color(Colors.green, "Green"), // Green
                        _color(Colors.blue, "Blue"), // Blue
                        _color(Colors.brown, "Brown"), // Brown
                        _color(Colors.yellow, "Yellow"), // Gold
                        _color(Colors.cyanAccent, "Other"), // Other
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Text(
                      " Vehicle Number",
                      style: TextStyle(
                          height: 2,
                          fontSize: getProportionalFontSize(14),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(4),
                    ),
                    TextFormField(
                      controller: controller.vehicleNoController,
                      decoration: InputDecoration(
                        fillColor: Color(0xFF353535),
                        hintText: "Enter vehicle no",
                        hintStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: getProportionalFontSize(14)),
                        contentPadding: EdgeInsets.only(
                            top: getProportionateScreenHeight(16),
                            bottom: getProportionateScreenHeight(16),
                            left: getProportionateScreenWidth(16),
                            right: getProportionateScreenWidth(16)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorMaxLines: 2,
                        errorStyle: TextStyle(
                          overflow: TextOverflow.visible,
                          color: Colors.redAccent,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please vehicle no";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    DefaultButton(
                      text: "Save Vehicle Information",
                      width: Get.width * .9,
                      onTap: () {
                        if (fKey.currentState!.validate()) {
                          Get.back();
                        }
                        // controller.saveVehicleData();
                      },
                      buttonColor: AppColors.appTheme,
                      textColor: AppColors.white,
                      textStyle: urbanistRegular.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  commonCarWidget(String image, String name, bool isSelected) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(6),
          vertical: getProportionateScreenHeight(8)),
      height: getProportionateScreenHeight(100),
      width: getProportionateScreenWidth(100),
      decoration: BoxDecoration(
        border: Border.all(
            color: isSelected ? AppColors.appTheme : Colors.black,
            width: isSelected ? 3 : 0),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: AssetImage(
              image,
            ),
            scale: 1.5),
      ),
      child: Text(name),
    );
  }

  _color(Color _color, String text) {
    var _select = Colors.transparent;
    if (controller.selectColorId == text) _select = AppColors.appTheme;
    return InkWell(
        onTap: () {
          controller.selectColorId = text;
          controller.update();
        },
        child: Column(
          children: [
            Container(
                width: SizeConfig.deviceWidth! / 7 + 10,
                height: SizeConfig.deviceWidth! / 7 + 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: _select,
                      width: controller.selectColorId == text ? 2 : 0),
                ),
                child: UnconstrainedBox(
                  child: Container(
                    width: SizeConfig.deviceWidth! / 7,
                    height: SizeConfig.deviceWidth! / 7,
                    decoration: BoxDecoration(
                      color: _color,
                      border: Border.all(color: Colors.black.withAlpha(130)),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 5,
            ),
            Text(text)
          ],
        ));
  }
}
