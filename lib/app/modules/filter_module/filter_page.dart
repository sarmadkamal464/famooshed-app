import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/modules/filter_module/filter_controller.dart';
import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed/app/modules/widgets/custom_default_button.dart';
import 'package:famooshed/app/modules/widgets/multi_select_chips.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../data/models/price_range_model.dart';
import '../../theme/size_config.dart';
import '../search_module/search_controller.dart';

class FilterPage extends GetView<FilterController> {
  FilterPage({super.key});
  SearchFoodController searchController = Get.find<SearchFoodController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        centerTitle: true,
        title: "Filters",
        backgroundColor: AppColors.white,
        statusBarColor: AppColors.white,
        actions: [
          TextButton(
              onPressed: () {
                controller.priceRangeList = [
                  PriceRange("5", false),
                  PriceRange("10", true),
                  PriceRange("30", false),
                  PriceRange("50", false),
                  PriceRange("180", false),
                ];
                controller.storeNearBy.value = false;
                controller.onReady();
              },
              child: Text(
                "Reset",
                style: TextStyle(color: HexColor('#29AD5F')),
              ))
        ],
      ),
      body: GetBuilder<FilterController>(
        init: FilterController(),
        autoRemove: false,
        global: true,
        dispose: (state) {},
        initState: (_) {
          // setSearchParams();
        },
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Quick Filter",
                      style: beVietnamProaBold.copyWith(
                          color: HexColor("#215034"), fontSize: 20),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19204F33),
                            blurRadius: 20,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(children: [
                        Center(
                          child: CheckboxListTile(
                            title: Text(
                              "Store Nearby",
                              style: beVietnamProaBold.copyWith(
                                color: const Color(0xFF204F33),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            autofocus: false,
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            selected: controller.storeNearBy.value,
                            value: controller.storeNearBy.value,
                            onChanged: (v) {
                              controller.storeNearBy.value = v!; // select

                              controller.update();
                            },
                          ),
                        ),
                        // const Divider(),
                        // Center(
                        //   child: CheckboxListTile(
                        //     title: Text(
                        //       "Delivery Time",
                        //       style: beVietnamProaBold.copyWith(
                        //         color: const Color(0xFF204F33),
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //     autofocus: false,
                        //     activeColor: Colors.green,
                        //     checkColor: Colors.white,
                        //     selected: controller.deliveryTime.value,
                        //     value: controller.deliveryTime.value,
                        //     onChanged: (v) {
                        //       controller.deliveryTime.value = v!; // select
                        //
                        //       controller.update();
                        //     },
                        //   ),
                        // ),
                        // const Divider(),
                        // Center(
                        //   child: CheckboxListTile(
                        //     title: Text(
                        //       "Rating",
                        //       style: beVietnamProaBold.copyWith(
                        //         color: const Color(0xFF204F33),
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //     autofocus: false,
                        //     activeColor: Colors.green,
                        //     checkColor: Colors.white,
                        //     selected: controller.ratingFilter.value,
                        //     value: controller.ratingFilter.value,
                        //     onChanged: (v) {
                        //       controller.ratingFilter.value = v!; // select
                        //
                        //       controller.update();
                        //     },
                        //   ),
                        // ),
                      ]),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      "Price Range (Up To)",
                      style: beVietnamProaBold.copyWith(
                          color: HexColor("#215034"), fontSize: 20),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(80),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.priceRangeList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.priceRangeList.forEach((element) {
                                element.isSelected = false;
                              });

                              controller.priceRangeList[index].isSelected =
                                  true;
                              controller.selectedPrice =
                                  controller.priceRangeList[index].price;

                              controller.update();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: getProportionateScreenHeight(65),
                                width: getProportionateScreenWidth(65),
                                decoration: BoxDecoration(
                                    color: controller
                                            .priceRangeList[index].isSelected
                                        ? AppColors.appTheme
                                        : HexColor('#F5FCED'),
                                    border: Border.all(
                                      color: AppColors.appTheme,
                                    ),
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: Text(
                                  "£${controller.priceRangeList[index].price}",
                                  style: beVietnamProSemiBold.copyWith(
                                      color: controller
                                              .priceRangeList[index].isSelected
                                          ? Colors.white
                                          : AppColors.appTheme,
                                      fontSize: getProportionalFontSize(16)),
                                )),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Container(
                    //           height: 70,
                    //           width: 70,
                    //           decoration: BoxDecoration(
                    //               color: HexColor('#F5FCED'),
                    //               border: Border.all(
                    //                 color: AppColors.appTheme,
                    //               ),
                    //               borderRadius: const BorderRadius.all(
                    //                   Radius.circular(50))),
                    //           child: Center(
                    //               child: Text(
                    //             "£5",
                    //             style: beVietnamProSemiBold.copyWith(
                    //                 color: AppColors.appTheme, fontSize: 18),
                    //           )),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Container(
                    //           height: 70,
                    //           width: 70,
                    //           decoration: BoxDecoration(
                    //               color: HexColor('#F5FCED'),
                    //               border: Border.all(
                    //                 color: AppColors.appTheme,
                    //               ),
                    //               borderRadius: const BorderRadius.all(
                    //                   Radius.circular(50))),
                    //           child: Center(
                    //               child: Text(
                    //             "£10",
                    //             style: beVietnamProSemiBold.copyWith(
                    //                 color: AppColors.appTheme, fontSize: 18),
                    //           )),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Container(
                    //           height: 70,
                    //           width: 70,
                    //           decoration: BoxDecoration(
                    //               color: AppColors.appTheme,
                    //               border: Border.all(
                    //                 color: AppColors.appTheme,
                    //               ),
                    //               borderRadius: const BorderRadius.all(
                    //                   Radius.circular(50))),
                    //           child: Center(
                    //               child: Text(
                    //             "£30",
                    //             style: beVietnamProSemiBold.copyWith(
                    //                 color: AppColors.white, fontSize: 18),
                    //           )),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Container(
                    //           height: 70,
                    //           width: 70,
                    //           decoration: BoxDecoration(
                    //               color: HexColor('#F5FCED'),
                    //               border: Border.all(
                    //                 color: AppColors.appTheme,
                    //               ),
                    //               borderRadius: const BorderRadius.all(
                    //                   Radius.circular(50))),
                    //           child: Center(
                    //               child: Text(
                    //             "£50",
                    //             style: beVietnamProSemiBold.copyWith(
                    //                 color: AppColors.appTheme, fontSize: 18),
                    //           )),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Container(
                    //           height: 70,
                    //           width: 70,
                    //           decoration: BoxDecoration(
                    //               color: HexColor('#F5FCED'),
                    //               border: Border.all(
                    //                 color: AppColors.appTheme,
                    //               ),
                    //               borderRadius: const BorderRadius.all(
                    //                   Radius.circular(50))),
                    //           child: Center(
                    //               child: Text(
                    //             "£180",
                    //             style: beVietnamProSemiBold.copyWith(
                    //                 color: AppColors.appTheme, fontSize: 18),
                    //           )),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Container(
                    //           height: 70,
                    //           width: 70,
                    //           decoration: BoxDecoration(
                    //               color: HexColor('#F5FCED'),
                    //               border: Border.all(
                    //                 color: AppColors.appTheme,
                    //               ),
                    //               borderRadius: const BorderRadius.all(
                    //                   Radius.circular(50))),
                    //           child: Center(
                    //               child: Text(
                    //             "£X",
                    //             style: beVietnamProSemiBold.copyWith(
                    //                 color: AppColors.appTheme, fontSize: 18),
                    //           )),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      "Categories",
                      style: beVietnamProaBold.copyWith(
                          color: HexColor("#215034"), fontSize: 20),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    MultiSelectChip(
                      controller.productCat,
                      onSelectionChanged: (selectedList) {
                        controller.selectedCategoryList = selectedList;
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    DefaultButton(
                        buttonColor: AppColors.appTheme,
                        textColor: AppColors.white,
                        text: "Apply Filter",
                        width: Get.width,
                        onTap: () {
                          updateSearchParams();
                          if (controller.selectedCategoryList.isNotEmpty) {
                            searchController.getSearch(
                              categoryId: searchController.selectedCategoryIds
                                  .join(',')
                                  .toString(),
                              price: controller.selectedPrice.length != 0
                                  ? controller.selectedPrice
                                  : '10',
                            );
                          } else {
                            searchController.getSearch(
                              price: controller.selectedPrice.length != 0
                                  ? controller.selectedPrice
                                  : '10',
                            );
                          }
                        })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void updateSearchParams() {
    Get.back();
    searchController.selectedCategoryList.clear();
    searchController.selectedCategoryIds.clear();
    // searchController.selectedPrice = '10';

    searchController.selectedCategoryList = controller.selectedCategoryList;
    controller.selectedCategoryList.forEach((element) {
      searchController.selectedCategoryIds.add(element.id.toString());
    });
    searchController.priceRangeList = controller.priceRangeList;
    searchController.selectedPrice =
        controller.selectedPrice.length != 0 ? controller.selectedPrice : '10';
    searchController.isGeoLocation = controller.storeNearBy.value;
    searchController.update();
  }
}
