// ignore_for_file: must_be_immutable

import 'package:famooshed/app/modules/add_new_location_module/add_new_location_controller.dart';
import 'package:famooshed/app/modules/checkout_module/checkout_page.dart';
import 'package:famooshed/app/modules/dashboard_module/dashboard_controller.dart';
import 'package:famooshed/app/utils/dprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../../common/util/exports.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/size_config.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/custom_default_button.dart';

class AddNewLocationPage extends GetView<AddNewLocationController> {
  AddNewLocationPage({super.key});

  AddressEnum? address = AddressEnum.home;
  PaymentEnum? payment = PaymentEnum.card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        centerTitle: true,
        backgroundColor: AppColors.white,
        statusBarColor: AppColors.white,
        title: "Add New Location",
      ),
      backgroundColor: AppColors.white,
      body: GetBuilder<AddNewLocationController>(
        builder: (AddNewLocationController addNewLocationController) {
          return SingleChildScrollView(
            clipBehavior: Clip.none,
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // serachBar(),
                // controller.searchController.text.isNotEmpty
                //     ? radioButtons()
                //     : const SizedBox(),
                // controller.searchController.text.isNotEmpty
                //     ? checkBox()
                //     : const SizedBox(),
                SizedBox(
                  height: getProportionateScreenHeight(16),
                ),
                DefaultButton(
                  text: Strings.addNew,
                  width: Get.width * .8,
                  height: getProportionateScreenHeight(50),
                  onTap: () {
                    // controller.saveAddress();
                    DashboardController dashBoardController =
                        Get.find<DashboardController>();
                    dashBoardController.screenName = "AddNew";
                    dashBoardController.initialLatLong = null;
                    dashBoardController.update();

                    Get.toNamed(
                      Routes.MAP,
                    );
                  },
                  buttonColor: AppColors.appTheme,
                  textStyle:
                      beVietnamProSemiBold.copyWith(color: AppColors.white),
                ),
                addressWidget(),
              ],
            ),
          );
        },
      ),
    );
  }

  addressWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Saved Address",
              style: beVietnamProaBold.copyWith(
                  color: AppColors.appTheme,
                  fontSize: getProportionalFontSize(18)),
            ),
          ),
          Container(
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
            child: ListView.separated(
              itemCount: controller.address.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var data = controller.address[index];

                return ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                      AppImages.locationPlaceholder,
                    ),
                  ),
                  titleAlignment: ListTileTitleAlignment.top,
                  contentPadding: EdgeInsets.all(8),
                  title: Text(
                    data.type ?? '-'.capitalize.toString(),
                    style: beVietnamProSemiBold.copyWith(
                      color: const Color(0xFF204F33),
                      fontSize: getProportionalFontSize(16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data.addressResponseDefault != null &&
                              data.addressResponseDefault == "true"
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                  color: AppColors.appTheme,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "Default",
                                style: urbanistRegular.copyWith(
                                    color: AppColors.white,
                                    fontSize: getProportionalFontSize(13)),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: getProportionateScreenHeight(8),
                      ),
                      Text(
                        data.flatHouseNo ?? '-'.capitalize.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: urbanistRegular.copyWith(
                          color: const Color(0xFF9D9D9D),
                          fontSize: getProportionalFontSize(13),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        data.text ?? '-'.capitalize.toString(),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: urbanistRegular.copyWith(
                          color: const Color(0xFF9D9D9D),
                          fontSize: getProportionalFontSize(13),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: SizeConfig.deviceWidth! * .25,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            controller.editAdd = data;
                            controller.update();
                            DashboardController dashBoardController =
                                Get.find<DashboardController>();
                            dashBoardController.initialLatLong = LatLng(
                                double.parse(data.lat ?? 0.toString()),
                                double.parse(data.lng ?? 0.toString()));
                            dashBoardController.screenName = "AddNew";
                            dashBoardController.update();
                            await Get.toNamed(
                              Routes.MAP,
                            );
                            controller.editAdd = null;
                            controller.update();
                            // controller.editAddressSheet(data);
                            // controller.deleteAddress(id: data.id);
                          },
                          icon: SvgPicture.asset('assets/svg/edit-pencil.svg',
                              width: getProportionateScreenWidth(20)),
                          color: AppColors.appTheme,
                        ),
                        IconButton(
                          onPressed: () {
                            controller.deleteAddress(id: data.id);
                          },
                          icon: SvgPicture.asset('assets/svg/delete.svg',
                              width: getProportionateScreenWidth(20)),
                          color: AppColors.appTheme,
                        ),
                      ],
                    ),
                  ),
                  // trailing: Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         // controller.deleteAddress(id: data.id);
                  //       },
                  //       icon: SvgPicture.asset('assets/svg/edit-pencil.svg'),
                  //       color: AppColors.appTheme,
                  //     ),
                  //     IconButton(
                  //       onPressed: () {
                  //         // controller.deleteAddress(id: data.id);
                  //       },
                  //       icon: SvgPicture.asset('assets/svg/delete.svg'),
                  //       color: AppColors.appTheme,
                  //     ),
                  //   ],
                  // ),
                );
                // return Padding(
                //   padding: const EdgeInsets.all(12),
                //   child: Column(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Expanded(
                //               child: Row(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     const CircleAvatar(
                //                       radius: 25,
                //                       backgroundImage: AssetImage(
                //                           AppImages.locationPlaceholder),
                //                     ),
                //                     Padding(
                //                       padding: EdgeInsets.symmetric(
                //                           horizontal:
                //                               getProportionateScreenWidth(8)),
                //                       child: Expanded(
                //                         child: Column(
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             Row(
                //                               children: [
                //                                 Text(
                //                                   data.type ??
                //                                       '-'.capitalize.toString(),
                //                                   style: beVietnamProSemiBold
                //                                       .copyWith(
                //                                     color:
                //                                         const Color(0xFF204F33),
                //                                     fontSize:
                //                                         getProportionalFontSize(
                //                                             16),
                //                                     fontWeight: FontWeight.w600,
                //                                   ),
                //                                 ),
                //                                 const SizedBox(width: 5),
                //                                 data.addressResponseDefault !=
                //                                             null &&
                //                                         data.addressResponseDefault ==
                //                                             "true"
                //                                     ? Container(
                //                                         padding:
                //                                             const EdgeInsets
                //                                                     .symmetric(
                //                                                 horizontal: 6,
                //                                                 vertical: 4),
                //                                         decoration: BoxDecoration(
                //                                             color: AppColors
                //                                                 .appTheme,
                //                                             borderRadius:
                //                                                 BorderRadius
                //                                                     .circular(
                //                                                         8)),
                //                                         child: Text(
                //                                           "Default",
                //                                           style: urbanistRegular
                //                                               .copyWith(
                //                                                   color:
                //                                                       AppColors
                //                                                           .white,
                //                                                   fontSize:
                //                                                       getProportionalFontSize(
                //                                                           14)),
                //                                         ),
                //                                       )
                //                                     : const SizedBox()
                //                               ],
                //                             ),
                //                             const SizedBox(
                //                               height: 10,
                //                             ),
                //                             SizedBox(
                //                               width: Get.width * .5,
                //                               child: Text(
                //                                 data.text ??
                //                                     '-'.capitalize.toString(),
                //                                 style: urbanistRegular.copyWith(
                //                                   color:
                //                                       const Color(0xFF9D9D9D),
                //                                   fontSize:
                //                                       getProportionalFontSize(
                //                                           14),
                //                                   fontWeight: FontWeight.w600,
                //                                 ),
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                     )
                //                   ]),
                //             ),
                //             Row(
                //               children: [
                //                 IconButton(
                //                   onPressed: () {
                //                     // controller.deleteAddress(id: data.id);
                //                   },
                //                   icon: SvgPicture.asset(
                //                       'assets/svg/edit-pencil.svg'),
                //                   color: AppColors.appTheme,
                //                 ),
                //                 IconButton(
                //                   onPressed: () {
                //                     // controller.deleteAddress(id: data.id);
                //                   },
                //                   icon:
                //                       SvgPicture.asset('assets/svg/delete.svg'),
                //                   color: AppColors.appTheme,
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 2,
                color: "#215034".fromHex.withOpacity(.5),
                indent: 20,
                endIndent: 20,
              ),
            ),
          )
        ],
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
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.search,
              color: AppColors.appTheme,
              size: 26,
            ),
          ),
          Expanded(
            child: TextField(
              onTap: () async {
                // controller.handlePressButton();
                DashboardController dashBoardController =
                    Get.find<DashboardController>();
                dashBoardController.screenName = "AddNew";

                dashBoardController.update();
                Get.toNamed(
                  Routes.MAP,
                );
              },
              readOnly: true,
              controller: controller.searchController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search Location..",
                hintStyle: urbanistRegular.copyWith(
                  color: const Color(0xFF9D9D9D),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                isDense: true,
              ),
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  radioButtons() {
    return RadioGroup<String>.builder(
      direction: Axis.horizontal,
      groupValue: controller.verticalGroupValue,
      onChanged: (value) {
        dprint(value);
        controller.verticalGroupValue = value!;
        controller.update();
      },
      items: controller.status,
      itemBuilder: (item) => RadioButtonBuilder(item),
      fillColor: AppColors.appTheme,
    );
  }

  checkBox() {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      checkColor: AppColors.white,
      activeColor: AppColors.appTheme,
      controlAffinity: ListTileControlAffinity.leading,
      title: const Text('default'),
      value: controller.isDefault.value,
      onChanged: (bool? value) {
        controller.isDefault.value = value!;
        controller.update();
      },
    );
  }
}
