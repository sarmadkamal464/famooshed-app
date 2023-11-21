import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed/app/modules/widgets/custom_default_button.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:famooshed/app/utils/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:famooshed/app/modules/edit_profile_module/edit_profile_controller.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => backPop(),
      child: Scaffold(
        appBar: CustomAppbarWidget(
          centerTitle: true,
          title: "Edit Profile",
          backgroundColor: AppColors.white,
          statusBarColor: AppColors.white,
        ),
        // floatingActionButton:  Padding(
        //   padding: EdgeInsets.symmetric(horizontal: Get.width * .06),
        //   child: DefaultButton(
        //       buttonColor: AppColors.appTheme,
        //       textColor: AppColors.white,
        //       text: "Save",
        //       width: Get.width * .8,
        //       onTap: () {
        //         controller.changeProfile();
        //       }),
        // ),
        backgroundColor: AppColors.white,
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Get.width * .06, vertical: 15),
          child: DefaultButton(
              buttonColor: AppColors.appTheme,
              textColor: AppColors.white,
              text: "Save",
              height: 60,
              textStyle:
                  urbanistBold.copyWith(fontSize: 16, color: AppColors.white),
              width: Get.width * .8,
              onTap: () {
                controller.changeProfile();
              }),
        ),
        body: GetBuilder(
          builder: (EditProfileController controller) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                              backgroundColor: AppColors.appTheme, radius: 40),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              controller.uploadAvatar();
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  border: Border.all(
                                    color: AppColors.appTheme,
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                  "Change profile picture",
                                  style: urbanistBold.copyWith(
                                      fontSize: 16, color: AppColors.appTheme),
                                ))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      headingText("Full Name"),
                      const SizedBox(height: 10),
                      TextField(
                        style: urbanistMedium.copyWith(
                            color: AppColors.appTheme, fontSize: 16),
                        controller: controller.fullName,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Full Name',
                          hintStyle: urbanistMedium.copyWith(
                              color: AppColors.appTheme, fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                width: 1, color: AppColors.appTheme),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              borderSide:
                                  BorderSide(color: AppColors.appTheme)),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      headingText("Email"),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: urbanistMedium.copyWith(
                            color: AppColors.appTheme, fontSize: 16),
                        controller: controller.emailController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              borderSide:
                                  BorderSide(color: AppColors.appTheme)),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      headingText("Phone"),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: urbanistMedium.copyWith(
                            color: AppColors.appTheme, fontSize: 16),
                        controller: controller.phoneController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Phone',
                          hintStyle: const TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              borderSide:
                                  BorderSide(color: AppColors.appTheme)),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      headingText("Location"),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: urbanistMedium.copyWith(
                            color: AppColors.appTheme, fontSize: 16),
                        controller: controller.addressController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Location',
                          hintStyle: const TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              borderSide:
                                  BorderSide(color: AppColors.appTheme)),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }

  headingText(text) {
    return Text(text,
        style:
            urbanistSemiBold.copyWith(color: AppColors.appTheme, fontSize: 18));
  }
}
