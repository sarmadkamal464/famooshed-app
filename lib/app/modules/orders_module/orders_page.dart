import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/data/models/get_oredrs_response.dart';
import 'package:famooshed/app/modules/orders_module/orders_controller.dart';
import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:famooshed/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:popover/popover.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../common/values/app_icons.dart';
import '../widgets/custom_default_button.dart';

class OrdersPage extends GetView<OrdersController> {
  OrdersPage({super.key});
  GlobalKey btnKey3 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: GetBuilder(
          builder: (OrdersController ordersController) {
            return Column(children: [
              ordersController.showAppBar
                  ? CustomAppbarWidget(
                      centerTitle: true,
                      backgroundColor: AppColors.white,
                      statusBarColor: AppColors.white,
                      // backgroundColor: AppColors.white,
                      title: 'My Orders')
                  : const SizedBox(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: getProportionateScreenHeight(60),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.blueColorLight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Text(
                        "Sort By Date",
                        style: beVietnamProaBold.copyWith(
                            color: AppColors.appTheme,
                            fontSize: getProportionalFontSize(18)),
                      ),
                      const Spacer(),
                      InkWell(
                        key: btnKey3,
                        onTap: () {
                          showPopover(
                            context: btnKey3.currentContext!,
                            height: getProportionateScreenHeight(370),
                            width: SizeConfig.deviceWidth! * .92,
                            constraints: BoxConstraints(
                                maxWidth: SizeConfig.deviceWidth!),
                            // isParentAlive: true,
                            bodyBuilder: (context) => StatefulBuilder(
                              builder: (context, mSetState) {
                                return Container(
                                  child: Utils.showDateRangePicker(
                                      context, controller.range, (p0) {
                                    if (p0 != null) {
                                      controller.range = p0 as PickerDateRange;

                                      controller.sortStartDate =
                                          DateFormat("yyyy-MM-dd").format(
                                              controller.range!.startDate ??
                                                  DateTime.now());
                                      controller.sortEndDate =
                                          DateFormat("yyyy-MM-dd").format(
                                              controller.range!.endDate ??
                                                  DateTime.now());
                                      controller.update();
                                      mSetState(() {});
                                      Get.back();

                                      controller.getOrders();
                                    } else {
                                      Utils.showSnackbar("Please select range");
                                    }
                                  }, true),
                                );
                              },
                            ),
                            onPop: () {
                              Future.delayed(Duration.zero).then((value) {
                                // controller.getOrders();
                              });
                            },
                            direction: PopoverDirection.bottom,
                            arrowHeight: 15,
                            arrowWidth: 30,
                          );
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(AppIcons.calendar),
                            const SizedBox(width: 10),
                            controller.sortStartDate.isNotEmpty
                                ? Text(
                                    "${controller.sortStartDate} - ${controller.sortEndDate}",
                                    style: urbanistMedium.copyWith(
                                        fontSize: getProportionalFontSize(14),
                                        color: AppColors.appTheme),
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Get.dialog(
                      //         getDateRangePicker(ordersController));
                      //   },
                      //   child: Row(
                      //     children: [
                      //       SvgPicture.asset(AppIcons.calendar),
                      //       const SizedBox(width: 10),
                      //       Text(
                      //         "${controller.startDate} - ${controller.endDate}",
                      //         style: urbanistMedium.copyWith(
                      //             fontSize: 14,
                      //             color: AppColors.appTheme),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              ordersController.orderList.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: SvgPicture.asset(AppIcons.noItemFoound),
                            ),
                            Text(
                              "Nothing Found!",
                              style: beVietnamProSemiBold.copyWith(
                                color: AppColors.appTheme,
                                fontSize: 26,
                              ),
                            ),
                            Text(
                              "You must order first to get your order history",
                              style: urbanistRegular,
                            )
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: Column(
                        children: [
                          // ordersController.showAppBar
                          //     ? CustomAppbarWidget(
                          //         backgroundColor: AppColors.white,
                          //         statusBarColor: AppColors.white,
                          //         centerTitle: true,
                          //         // backgroundColor: AppColors.white,
                          //         title: 'Orders')
                          //     : const SizedBox(),
                          // Container(
                          //   margin: const EdgeInsets.symmetric(horizontal: 10),
                          //   height: 64,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(10),
                          //       color: AppColors.blueColorLight),
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          //     child: Row(
                          //       children: [
                          //         Text(
                          //           "Sort By Date",
                          //           style: beVietnamProaBold.copyWith(
                          //               color: AppColors.appTheme, fontSize: 20),
                          //         ),
                          //         const Spacer(),
                          //         InkWell(
                          //           key: btnKey3,
                          //           onTap: () {
                          //             showPopover(
                          //               context: btnKey3.currentContext!,
                          //               height: getProportionateScreenHeight(310),
                          //               width: SizeConfig.deviceWidth! * .92,
                          //               constraints: BoxConstraints(
                          //                   maxWidth: SizeConfig.deviceWidth!),
                          //               // isParentAlive: true,
                          //               bodyBuilder: (context) => StatefulBuilder(
                          //                 builder: (context, mSetState) {
                          //                   return Container(
                          //                     child: Utils.showDateRangePicker(
                          //                         context, controller.range, (p0) {
                          //                       if (p0 != null) {
                          //                         controller.range =
                          //                             p0 as PickerDateRange;
                          //
                          //                         controller.sortStartDate =
                          //                             DateFormat("yyyy-MM-dd")
                          //                                 .format(controller.range!
                          //                                         .startDate ??
                          //                                     DateTime.now());
                          //                         controller.sortEndDate =
                          //                             DateFormat("yyyy-MM-dd")
                          //                                 .format(controller
                          //                                         .range!.endDate ??
                          //                                     DateTime.now());
                          //                         controller.update();
                          //                         mSetState(() {});
                          //                         Get.back();
                          //
                          //                         controller.getOrders();
                          //                       } else {
                          //                         Utils.showSnackbar(
                          //                             "Please select range");
                          //                       }
                          //                     }, true),
                          //                   );
                          //                 },
                          //               ),
                          //               onPop: () {
                          //                 Future.delayed(Duration.zero)
                          //                     .then((value) {
                          //                   // controller.getOrders();
                          //                 });
                          //               },
                          //               direction: PopoverDirection.bottom,
                          //               arrowHeight: 15,
                          //               arrowWidth: 30,
                          //             );
                          //           },
                          //           child: Row(
                          //             children: [
                          //               SvgPicture.asset(AppIcons.calendar),
                          //               const SizedBox(width: 10),
                          //               controller.sortStartDate.isNotEmpty
                          //                   ? Text(
                          //                       "${controller.sortStartDate} - ${controller.sortEndDate}",
                          //                       style: urbanistMedium.copyWith(
                          //                           fontSize: 14,
                          //                           color: AppColors.appTheme),
                          //                     )
                          //                   : SizedBox()
                          //             ],
                          //           ),
                          //         ),
                          //         // InkWell(
                          //         //   onTap: () {
                          //         //     Get.dialog(
                          //         //         getDateRangePicker(ordersController));
                          //         //   },
                          //         //   child: Row(
                          //         //     children: [
                          //         //       SvgPicture.asset(AppIcons.calendar),
                          //         //       const SizedBox(width: 10),
                          //         //       Text(
                          //         //         "${controller.startDate} - ${controller.endDate}",
                          //         //         style: urbanistMedium.copyWith(
                          //         //             fontSize: 14,
                          //         //             color: AppColors.appTheme),
                          //         //       )
                          //         //     ],
                          //         //   ),
                          //         // ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Expanded(child: orderList()),
                          ordersController.showAppBar
                              ? const SizedBox()
                              : const SizedBox(
                                  height: 80,
                                )
                        ],
                      ),
                    )
            ]);
          },
        ),
        // body: SingleChildScrollView(
        //   child: Column(children: [
        //     orderItem(AppColors.orderPending),
        //     orderItem(AppColors.orderSucess),
        //     orderItem(AppColors.orderCancel),
        //   ]),
        // ),
      ),
    );
  }

  Widget getDateRangePicker(OrdersController ordersController) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 200, 30, 150),
      child: SfDateRangePicker(
          backgroundColor: AppColors.white,
          selectionColor: AppColors.appTheme,
          endRangeSelectionColor: AppColors.appTheme,
          rangeSelectionColor: AppColors.appThemeLight,
          startRangeSelectionColor: AppColors.appTheme,
          todayHighlightColor: AppColors.appTheme,
          monthViewSettings:
              const DateRangePickerMonthViewSettings(viewHeaderHeight: 80),
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.range,
          cancelText: "Cancel",
          confirmText: "Ok",
          showActionButtons: true,
          onSubmit: (v) {
            Get.back();
          },
          onCancel: () {
            Get.back();
          },

          // onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
          //   ordersController.onSelectionChanged(args);
          // },
          onSelectionChanged: ordersController.selectionChanged),
    );
  }

  Widget orderList() {
    return ListView.builder(
      itemCount: controller.orderList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        var data = controller.orderList[index];
        return GestureDetector(
            onTap: () {
              controller.reDirect(index);
              // Get.toNamed(Routes.ORDER_TRACK);
            },
            child: orderItem(AppColors.amaranth, data));
      },
    );
  }

  Widget orderItem(Color color, Order order) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadows: const [
            BoxShadow(
              color: Color(0x19204F33),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: order.image != null && order.image!.isNotEmpty
                          ? Image.network(
                              order.image!,
                              fit: BoxFit.fill,
                              height: getProportionateScreenHeight(75),
                              width: getProportionateScreenWidth(75),
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                    height: getProportionateScreenHeight(75),
                                    width: getProportionateScreenWidth(75),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black12,
                                    ),
                                    child: Icon(Icons.error));
                              },
                            )
                          : Container(
                              height: getProportionateScreenHeight(75),
                              width: getProportionateScreenWidth(75),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black12,
                              ),
                              child: Icon(Icons.error)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 190,
                          child: Text(
                            order.name ?? '-'.capitalize!,
                            style: beVietnamProaBold.copyWith(
                                fontSize: 18, color: AppColors.appTheme),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller
                                  .getLocalDate(order.date.toString())
                                  .toString(),
                              style: urbanistSemiBold.copyWith(
                                  color: AppColors.doveGray, fontSize: 14),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 6,
                                  width: 6,
                                  color: AppColors.doveGray,
                                ),
                              ),
                            ),
                            Text('${order.ordersdetails!.length} items',
                                style: urbanistSemiBold.copyWith(
                                    color: AppColors.doveGray, fontSize: 14)),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                getOrderStatus(order.statusName ?? 'Received')
                // Text(
                //   orderDetail.statusName,
                //   style: urbanistSemiBold.copyWith(color: color, fontSize: 14),
                // )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order id: #${order.orderid}',
                    style: urbanistSemiBold.copyWith(
                        color: AppColors.doveGray, fontSize: 16)),
                Text('£${order.total}',
                    style: beVietnamProaBold.copyWith(
                        color: AppColors.appTheme, fontSize: 20))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'From: ',
                          style: urbanistSemiBold.copyWith(
                              color: AppColors.doveGray, fontSize: 16)),
                      TextSpan(
                          text: order.restaurant,
                          style: urbanistBold.copyWith(
                              color: AppColors.appTheme, fontSize: 16)),
                    ],
                  ),
                ),
                DefaultButton(
                  height: 40,
                  textColor: AppColors.white,
                  buttonColor: AppColors.appTheme,
                  color: AppColors.white,
                  text: Strings.reorder,
                  width: Get.width * 0.3,
                  onTap: () {
                    // controller.reOrder(order.orderid);
                    controller.reOrderMethod(order.orderid);
                  },
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  getOrderStatus(String status) {
    if (status == "Received") {
      return Text(
        status,
        style: urbanistSemiBold.copyWith(
            color: AppColors.orderSucess, fontSize: 14),
      );
    } else if (status == "Ready") {
      return Text(
        status,
        style:
            urbanistSemiBold.copyWith(color: AppColors.appTheme, fontSize: 14),
      );
    } else if (status == "Pending") {
      return Text(
        status,
        style: urbanistSemiBold.copyWith(
            color: AppColors.orderPending, fontSize: 14),
      );
    } else {
      return Text(
        status,
        style: urbanistSemiBold.copyWith(
            color: AppColors.orderCancel, fontSize: 14),
      );
    }
  }
}
