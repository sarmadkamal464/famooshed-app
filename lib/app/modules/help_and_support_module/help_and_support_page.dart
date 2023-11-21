import 'package:famooshed/app/modules/help_and_support_module/help_and_support_controller.dart';
import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/values/app_colors.dart';
import '../widgets/custom_default_button.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class HelpAndSupportPage extends GetView<HelpAndSupportController> {
  HelpAndSupportPage(this.isShowAppBar);
  GlobalKey<FormState> fKey = GlobalKey();
  bool isShowAppBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isShowAppBar
          ? CustomAppbarWidget(
              centerTitle: true,
              title: "Help and Support",
            )
          : null,
      body: GetBuilder<HelpAndSupportController>(
        // init: HelpAndSupportController(),
        builder: (HelpAndSupportController controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16)),
            child: Form(
              key: fKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                        height: 2,
                        fontSize: getProportionalFontSize(14),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(4),
                  ),
                  TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      fillColor: Color(0xFF353535),
                      hintText: "Enter name",
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(letterSpacing: .3),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text(
                    "Email",
                    style: TextStyle(
                        height: 2,
                        fontSize: getProportionalFontSize(14),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(4),
                  ),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      fillColor: Color(0xFF353535),
                      hintText: "Enter email",
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(letterSpacing: .3),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(16),
                  ),
                  Text(
                    "Ticket Type",
                    style: TextStyle(
                        height: 2,
                        fontSize: getProportionalFontSize(14),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(4),
                  ),
                  SizedBox(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField<String>(
                        isDense: true,
                        alignment: Alignment.bottomLeft,
                        icon: Icon(Icons.keyboard_arrow_down),
                        borderRadius: BorderRadius.circular(8),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: getProportionateScreenHeight(14),
                              bottom: getProportionateScreenHeight(14),
                              left: getProportionateScreenWidth(0),
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
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select plan';
                          }
                          return null;
                        },
                        items: controller.ticketTypes
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontSize:
                                                  getProportionalFontSize(14),
                                              height: 2),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        selectedItemBuilder: (context) {
                          return controller.ticketTypes
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item.toString(),
                                    style: TextStyle(
                                      fontSize: getProportionalFontSize(14),
                                      overflow: TextOverflow.visible,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              )
                              .toList();
                        },
                        onChanged: (T) {
                          controller.selectedTicket = T as String;
                          controller.update();
                        },
                        value: controller.selectedTicket.isNotEmpty
                            ? controller.selectedTicket
                            : controller.ticketTypes[0],
                        hint: const Text("Select Ticket type"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  ListTile(
                    title: const Text('Priority 1 - Normal Request'),
                    leading: Radio(
                      value: "Priority 1 - Normal Request",
                      activeColor: AppColors.appTheme,
                      groupValue: controller.selectedPriority,
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedPriority = value;
                          controller.update();
                        }
                      },
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  ListTile(
                    title: const Text('Priority 2 - Rush Request'),
                    contentPadding: EdgeInsets.zero,
                    leading: Radio(
                      activeColor: AppColors.appTheme,
                      value: "Priority 2 - Rush Request",
                      groupValue: controller.selectedPriority,
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedPriority = value;
                          controller.update();
                        }
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Priority 3 - Emergency Request'),
                    contentPadding: EdgeInsets.zero,
                    leading: Radio(
                      value: "Priority 3 - Emergency Request",
                      activeColor: AppColors.appTheme,
                      groupValue: controller.selectedPriority,
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedPriority = value;
                          controller.update();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text(
                    "Description",
                    style: TextStyle(
                        height: 2,
                        fontSize: getProportionalFontSize(14),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(4),
                  ),
                  TextFormField(
                    controller: controller.descriptionController,
                    decoration: InputDecoration(
                      fillColor: Color(0xFF353535),
                      hintText: "Enter description",
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(letterSpacing: .3),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {},
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(16),
                  ),
                  DefaultButton(
                      buttonColor: AppColors.appTheme,
                      text: "Submit Ticket",
                      textColor: AppColors.white,
                      width: Get.width,
                      onTap: () {
                        if (fKey.currentState!.validate()) {
                          controller.createTicket();
                        }
                      }),
                  SizedBox(
                    height: getProportionateScreenHeight(isShowAppBar ? 0 : 90),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
