// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/data/models/get_order_status_response.dart';
import 'package:famooshed/app/data/models/get_oredrs_response.dart';
import 'package:famooshed/app/modules/map_screen/order_track.dart';
import 'package:famooshed/app/modules/order_track_module/order_track_controller.dart';
import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed/app/modules/widgets/custom_default_button.dart';
import 'package:famooshed/app/modules/widgets/timeline.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../theme/size_config.dart';
// import 'package:timeline_list/timeline.dart';
// import 'package:timeline_list/timeline_model.dart';

class OrderTrackPage extends GetView<OrderTrackController> {
  OrderTrackPage({super.key});

  OrderData? orderData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(
          centerTitle: true,
          title: "Order Details",
          backgroundColor: AppColors.white,
          statusBarColor: AppColors.white,
        ),
        backgroundColor: AppColors.white,
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: AppColors.orderSucess,
        //   title: const Text('Order Track'),
        // ),
        body: GetBuilder<OrderTrackController>(
          init: OrderTrackController(),
          builder: (OrderTrackController orderTrackController) {
            if (controller.orderData.isNotEmpty) {
              orderData = controller.orderData.first;
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Get.height * .02, horizontal: Get.width * .04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderId(),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Order Summary",
                        style: beVietnamProaBold.copyWith(
                            color: AppColors.appTheme, fontSize: 20),
                      ),
                    ),
                    cartCard(controller.order),
                    // marketInfo(),
                    SizedBox(
                      height: 20,
                    ),
                    orderData != null &&
                            orderData!.deliveryMethod != null &&
                            orderData!.deliveryMethod == 'pickup'
                        ? curbSidePickUp()
                        : SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Timeline",
                        style: beVietnamProaBold.copyWith(
                            fontSize: 20, color: AppColors.appTheme)),
                    SizedBox(height: Get.height * .02),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x19204F33),
                            blurRadius: 20,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: orderData != null
                          ? orderData!.deliveryMethod != null &&
                                  orderData!.deliveryMethod == 'pickup'
                              ? curbSidePickUpTimeLine()
                              : commonTimeLine()
                          : SizedBox(),
                    ),
                    SizedBox(height: Get.height * .02),
                    orderData != null &&
                            (orderData!.status == 4 ||
                                orderData!.status == 5) &&
                            (orderData!.deliveryMethod != 'pickup')
                        ? byDeliver(orderData!)
                        : SizedBox(),
                    SizedBox(height: 100),
                    orderData != null && orderData!.deliveryMethod != 'pickup'
                        ? GestureDetector(
                            onTap: () =>
                                orderData != null && (orderData!.status == 4)
                                    ? Get.to(() => MapTrackingScreen(
                                          item: orderData!,
                                        ))
                                    : null,
                            child: Container(
                                width: Get.width,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: AppColors.blueColorLight,
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.my_location_sharp,
                                          size: 16,
                                          color: orderData != null &&
                                                  orderData!.status >= 3
                                              ? AppColors.appTheme
                                              : Colors.grey),
                                      const SizedBox(width: 5),
                                      Text("Track My Order",
                                          style: urbanistBold.copyWith(
                                              fontSize: 16,
                                              color: orderData != null &&
                                                      orderData!.status >= 3
                                                  ? AppColors.appTheme
                                                  : Colors.grey),
                                          textAlign: TextAlign.center)
                                    ])))
                        : SizedBox(),
                    SizedBox(height: Get.height * .02),
                    DefaultButton(
                        buttonColor: AppColors.appTheme,
                        text: "Back To Home",
                        textColor: AppColors.white,
                        width: Get.width,
                        onTap: () {
                          Get.back();
                        })
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget orderId() {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.blueColorLight,
          borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        title: Text(
          "Order ID",
          style: beVietnamProaBold.copyWith(
              fontSize: 20, color: AppColors.appTheme),
        ),
        subtitle: Text("#${controller.orederId.value}",
            style: urbanistSemiBold.copyWith(
                fontSize: 14, color: AppColors.appTheme)),
        trailing: const Icon(
          Icons.copy,
          color: AppColors.appTheme,
        ),
      ),
    );
  }

  Widget cartCard(Order order) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 12,
              color: Color.fromRGBO(0, 0, 0, 0.16),
            )
          ]),
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                leading: order.image != null && order.image!.isNotEmpty
                    ? CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(order.image!),
                      )
                    : SizedBox(),
                title: Text(
                  "${order.restaurant}",
                  style: beVietnamProaBold.copyWith(
                      fontSize: 20, color: AppColors.appTheme),
                ),
                trailing: Text(
                  "${order.ordersdetails!.length} Items",
                  style: urbanistMedium.copyWith(
                      fontSize: 16, color: AppColors.appTheme),
                ),
              ),
              const Divider(thickness: 2),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: order.ordersdetails!.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = order.ordersdetails![index];
                  return cartItem(data);
                },
              ),
            ],
          )),
    );
  }

  Widget cartItem(Ordersdetail detail) {
    return ListTile(
      leading: detail.image != null && detail.image!.isNotEmpty
          ? CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(detail.image!),
            )
          : SizedBox(),
      title: Text(
        "${detail.food!.capitalize}".toString(),
        style: beVietnamProSemiBold.copyWith(
            fontSize: 18, color: AppColors.appTheme),
      ),
      subtitle: Text(
        "Price : £${detail.foodprice}",
        style:
            urbanistSemiBold.copyWith(fontSize: 14, color: AppColors.greyText),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // InkWell(
          //   onTap: () {
          //     controller.decrement(detail);
          //   },
          //   child: const Icon(
          //     Icons.remove_circle_outline,
          //     color: AppColors.appTheme,
          //     size: 18,
          //   ),
          // ),
          // const SizedBox(width: 10),
          Text('${detail.count}',
              style: beVietnamProaBold24.copyWith(
                  fontSize: 16, color: AppColors.appTheme)),
          const SizedBox(width: 10),
          // InkWell(
          //     onTap: () {
          //       controller.increment(detail);
          //     },
          //     child: const Icon(
          //       Icons.add_circle_outline,
          //       color: AppColors.appTheme,
          //       size: 18,
          //     )),
        ],
      ),
    );
  }

  Widget customTimeLine() {
    return Flexible(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, i) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Row(
                    children: [
                      const SizedBox(width: 0.1),
                      const SizedBox(
                        width: 0.2,
                        child: Text("items"),
                      ),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("items"),
                            Text(
                              "items description",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 50,
                  child: Container(
                    height: Get.height * 0.7,
                    width: 1.0,
                    color: Colors.grey.shade400,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Container(
                      height: 20.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                        color: AppColors.amaranth,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  // Widget timelineList() {
  //   return Timeline(
  //     shrinkWrap: true,
  //     children: <TimelineModel>[
  //       TimelineModel(
  //         isFirst: true,
  //         isLast: true,
  //         position: TimelineItemPosition.random,
  //         const SizedBox(
  //           height: 100,
  //           child: Center(
  //             child: Text("data"),
  //           ),
  //         ),
  //         icon: const Icon(Icons.receipt, color: Colors.white),
  //         iconBackground: Colors.blue,
  //       ),
  //       TimelineModel(

  //         const SizedBox(
  //           height: 100,
  //           child: Center(
  //             child: Text("data"),
  //           ),
  //         ),
  //         icon: const Icon(Icons.android),
  //         iconBackground: Colors.cyan,
  //       ),
  //     ],
  //     position: TimelinePosition.Left,
  //     iconSize: 40,
  //     lineColor: Colors.blue,
  //   ); //TimelinePage(title: 'Muslim Civilisation Doodles'),
  // }

  // Widget timelineStepper(OrderTrackController orderTrackController) {
  //   return Stepper(
  //       elevation: 0,
  //       type: StepperType.vertical,
  //       physics: const NeverScrollableScrollPhysics(),
  //       steps: buildStep(Get.context!),
  //       controlsBuilder: (BuildContext context, ControlsDetails details) {
  //         return const SizedBox();
  //       });
  // }

  List<Step> buildStep(BuildContext context) {
    return [
      Step(
          title: Text(
            "In Processing",
            style: beVietnamProSemiBold.copyWith(
                fontSize: 18, color: AppColors.appTheme),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Processing your order",
                style: urbanistMedium.copyWith(
                    fontSize: 14, color: AppColors.appTheme),
              ),
              Text(
                "2:30 PM",
                style: urbanistSemiBold.copyWith(
                    fontSize: 16, color: AppColors.appTheme),
              ),
            ],
          ),
          content: const SizedBox()),
      Step(
          title: Text(
            "Packaging",
            style: beVietnamProSemiBold.copyWith(
                fontSize: 18, color: AppColors.appTheme),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Processing your order",
                style: urbanistMedium.copyWith(
                    fontSize: 14, color: AppColors.appTheme),
              ),
              Text(
                "2:40 PM",
                style: urbanistSemiBold.copyWith(
                    fontSize: 16, color: AppColors.appTheme),
              ),
            ],
          ),
          content: const SizedBox()),
      Step(
          title: Text(
            "Delivery",
            style: beVietnamProSemiBold.copyWith(
                fontSize: 18, color: AppColors.appTheme),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Processing your order",
                style: urbanistSemiBold.copyWith(
                    fontSize: 16, color: AppColors.appTheme),
              ),
              Text(
                "- - -",
                style: urbanistSemiBold.copyWith(
                    fontSize: 16, color: AppColors.appTheme),
              ),
            ],
          ),
          content: const SizedBox()),
      Step(
          title: Text(
            "At your home",
            style: beVietnamProSemiBold.copyWith(
                fontSize: 18, color: AppColors.appTheme),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Processing your order",
                style: urbanistMedium.copyWith(
                    fontSize: 14, color: AppColors.appTheme),
              ),
              Text(
                "In 5 minutes",
                style: urbanistSemiBold.copyWith(
                    fontSize: 16, color: AppColors.appTheme),
              ),
            ],
          ),
          content: const SizedBox())
    ];
  }

  Widget byDeliver(OrderData orderData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Delivery By",
            style: beVietnamProaBold.copyWith(
                fontSize: 20, color: AppColors.appTheme)),
        SizedBox(height: Get.height * .02),
        SizedBox(
          height: Get.height * .1,
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x19204F33),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              leading: Container(
                width: 52,
                height: 52,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(Constants.dummyImageUrl),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              title: Text(
                "${orderData.drivername}",
                style: beVietnamProaBold.copyWith(
                    fontSize: 18, color: AppColors.appTheme),
              ),
              trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF3F8FC),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: SvgPicture.asset(
                            AppImages.message,
                            fit: BoxFit.scaleDown,
                          )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF3F8FC),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: SvgPicture.asset(
                            AppImages.call,
                            fit: BoxFit.scaleDown,
                          )),
                    )
                  ]),
              subtitle: Text("${orderData.vehicle}",
                  style: urbanistSemiBold.copyWith(
                      fontSize: 14, color: AppColors.appTheme)),
            ),
          ),
        ),
      ],
    );
    // return controller.driverName.value == ""
    //     ? SizedBox()
    //     : Column(
    //         children: [
    //           Text("Delivery By",
    //               style: beVietnamProaBold.copyWith(
    //                   fontSize: 20, color: AppColors.appTheme)),
    //           SizedBox(height: Get.height * .02),
    //           SizedBox(
    //             height: Get.height * .12,
    //             child: Card(
    //               elevation: 5,
    //               child: ListTile(
    //                 contentPadding: EdgeInsets.symmetric(
    //                     vertical: Get.height * .01,
    //                     horizontal: Get.width * .03),
    //                 leading: Image.network(
    //                     Constants.imgUrl + controller.profilePic.value),
    //                 title: Text(
    //                   controller.driverName.value.capitalize.toString(),
    //                   style: beVietnamProaBold.copyWith(
    //                       fontSize: 20, color: AppColors.appTheme),
    //                 ),
    //                 subtitle: Text(
    //                     controller.vehicleName.value.capitalize.toString(),
    //                     style: urbanistSemiBold.copyWith(
    //                         fontSize: 14, color: AppColors.appTheme)),

    //               ),
    //             ),
    //           ),
    //         ],
    //       );
  }

  Widget indicators(bool isDone) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isDone ? AppColors.appTheme : Colors.grey),
      child: const Icon(
        Icons.check,
        color: AppColors.white,
      ),
    );
  }

  marketInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Market Info",
              style: beVietnamProaBold.copyWith(
                  color: AppColors.appTheme, fontSize: 20),
            ),
          ),
          Container(
            width: SizeConfig.deviceWidth!,
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Name: ",
                          style: beVietnamProSemiBold.copyWith(
                              fontSize: getProportionalFontSize(15))),
                      Expanded(
                        child: Text("${controller.restaurantName.value}",
                            style: TextStyle()),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Address: ",
                          style: beVietnamProSemiBold.copyWith(
                              fontSize: getProportionalFontSize(15))),
                      Expanded(
                        child: Text("${controller.restaurantAdd.value}",
                            style: TextStyle()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  curbSidePickUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Curbside Pickup",
            style: beVietnamProaBold.copyWith(
                fontSize: 20, color: AppColors.appTheme)),
        SizedBox(height: Get.height * .02),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x19204F33),
                blurRadius: 20,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Arrival Date :",
                      style: beVietnamProSemiBold.copyWith(
                          fontSize: 14, color: AppColors.appTheme),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${orderData!.arrivalDate ?? '-'}",
                      style: urbanistMedium.copyWith(
                          fontSize: 14, color: AppColors.appTheme),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Arrival Time :",
                      style: beVietnamProSemiBold.copyWith(
                          fontSize: 14, color: AppColors.appTheme),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${orderData!.arrivalTime ?? '-'}",
                      style: urbanistMedium.copyWith(
                          fontSize: 14, color: AppColors.appTheme),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Comments :",
                      style: beVietnamProSemiBold.copyWith(
                          fontSize: 14, color: AppColors.appTheme),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${orderData!.comment ?? '-'}",
                      style: urbanistMedium.copyWith(
                          fontSize: 14, color: AppColors.appTheme),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  curbSidePickUpTimeLine() {
    return Timelines(
      indicators: [
        indicators(orderData!.status >= 1 || orderData!.status >= 2),
        indicators(orderData!.status >= 3),
        indicators((orderData!.status == 5)),
      ],
      lineColor: Colors.grey,
      indicatorColor: AppColors.appTheme,
      lineGap: 43.0,
      itemGap: 40.0,
      gutterSpacing: 15.0,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "In Processing",
              style: beVietnamProSemiBold.copyWith(
                  fontSize: 18, color: AppColors.appTheme),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    "Processing your order",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: urbanistMedium.copyWith(
                        fontSize: 14, color: AppColors.appTheme),
                  ),
                ),
                // Text(
                //   "${(orderData!.status >= 1 || orderData!.status >= 2) ? Utils.getLocalDate(orderData!.date != null && orderData!.date!.toString().isNotEmpty ? orderData!.date!.toString() : DateTime.now().toString()) : ''}",
                //   style: urbanistSemiBold.copyWith(
                //       fontSize: 12.5, color: AppColors.appTheme),
                // ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ready",
              style: beVietnamProSemiBold.copyWith(
                  fontSize: 18, color: AppColors.appTheme),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    "Your order is ready for pickup",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: urbanistMedium.copyWith(
                        fontSize: 14, color: AppColors.appTheme),
                  ),
                ),
                // Text(
                //   "${(orderData!.status >= 3) ? Utils.getLocalDate(orderData!.date != null && orderData!.date!.toString().isNotEmpty ? orderData!.date!.toString() : DateTime.now().toString()) : ''}",
                //   style: urbanistSemiBold.copyWith(
                //       fontSize: 12, color: AppColors.appTheme),
                // ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pick up",
              style: beVietnamProSemiBold.copyWith(
                  fontSize: 18, color: AppColors.appTheme),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    // "Your order has been picked",
                    "You picked up your order",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: urbanistMedium.copyWith(
                        fontSize: 14, color: AppColors.appTheme),
                  ),
                ),
                // Text(
                //   "${(orderData!.status == 5) ? Utils.getLocalDate(orderData!.date != null && orderData!.date!.toString().isNotEmpty ? orderData!.date!.toString() : DateTime.now().toString()) : ''}",
                //   style: urbanistSemiBold.copyWith(
                //       fontSize: 12, color: AppColors.appTheme),
                // ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  commonTimeLine() {
    return Timelines(
      indicators: [
        // indicators(orderData!.status >= 1),
        // indicators(orderData!.status >= 2),
        // indicators((orderData!.status >= 3 || orderData!.status >= 4)),
        // indicators(orderData!.status == 5)

        indicators(orderData!.status >= 1),
        indicators(orderData!.status >= 2),
        indicators((orderData!.status >= 3 || orderData!.status >= 4)),
        indicators(orderData!.status == 5)
      ],
      lineColor: Colors.grey,
      indicatorColor: AppColors.appTheme,
      lineGap: 43.0,
      itemGap: 40.0,
      gutterSpacing: 15.0,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "In Processing",
              style: beVietnamProSemiBold.copyWith(
                  fontSize: 18, color: AppColors.appTheme),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Your order has been received by merchant",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: urbanistMedium.copyWith(
                        fontSize: 14, color: AppColors.appTheme),
                  ),
                ),
                // Text(
                //   "${orderData!.status >= 1 ? Utils.getLocalDate(orderData!.date != null && orderData!.date!.toString().isNotEmpty ? orderData!.date!.toString() : DateTime.now().toString()) : ''}",
                //   style: urbanistSemiBold.copyWith(
                //       fontSize: 12.5, color: AppColors.appTheme),
                // ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Packaging",
              style: beVietnamProSemiBold.copyWith(
                  fontSize: 18, color: AppColors.appTheme),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    "Preparing your order",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: urbanistMedium.copyWith(
                        fontSize: 14, color: AppColors.appTheme),
                  ),
                ),
                // Text(
                //   "${orderData!.status >= 2 ? Utils.getLocalDate(orderData!.date != null && orderData!.date!.toString().isNotEmpty ? orderData!.date!.toString() : DateTime.now().toString()) : ''}",
                //   style: urbanistSemiBold.copyWith(
                //       fontSize: 12, color: AppColors.appTheme),
                // ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery",
              style: beVietnamProSemiBold.copyWith(
                  fontSize: 18, color: AppColors.appTheme),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    "Your order is ready for delivery",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: urbanistMedium.copyWith(
                        fontSize: 14, color: AppColors.appTheme),
                  ),
                ),
                // Text(
                //   "${(orderData!.status >= 3 || orderData!.status >= 4) ? Utils.getLocalDate(orderData!.date != null && orderData!.date!.toString().isNotEmpty ? orderData!.date!.toString() : DateTime.now().toString()) : ''}",
                //   style: urbanistSemiBold.copyWith(
                //       fontSize: 12, color: AppColors.appTheme),
                // ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "At your home",
              style: beVietnamProSemiBold.copyWith(
                  fontSize: 18, color: AppColors.appTheme),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    "Order delivered",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: urbanistMedium.copyWith(
                        fontSize: 14, color: AppColors.appTheme),
                  ),
                ),
                // Text(
                //   "${orderData!.status == 5 ? Utils.getLocalDate(orderData!.date != null && orderData!.date!.toString().isNotEmpty ? orderData!.date!.toString() : DateTime.now().toString()) : ''}",
                //   style: urbanistSemiBold.copyWith(
                //       fontSize: 12, color: AppColors.appTheme),
                // ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
