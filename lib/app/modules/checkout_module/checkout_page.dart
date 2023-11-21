// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:famooshed/app/data/models/get_address_new_response.dart';
import 'package:famooshed/app/modules/checkout_module/checkout_controller.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/util/exports.dart';
import '../../theme/size_config.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/custom_default_button.dart';

/// GetX Template Generator - fb.com/htngu.99
///
enum AddressEnum { home, work }

enum PaymentEnum { card, paypal, cod }

PaymentEnum? paymentType = PaymentEnum.card;

class CheckoutPage extends GetView<CheckoutController> {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        centerTitle: controller.centerTitle,
        backgroundColor: AppColors.white,
        statusBarColor: AppColors.white,
        title: "Delivery Method",
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        // clipBehavior: Clip.none,
        child: GetBuilder<CheckoutController>(
          init: CheckoutController(),
          builder: (CheckoutController checkoutController) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Column(
                children: [
                  marketInfo(),
                  controller.takeOrderMySelf.value
                      ? SizedBox()
                      : addressType(checkoutController),

                  selectDeliveryOption(context),
                  // paymentType(),
                  // billTotal(),
                  const SizedBox(height: 20),
                  DefaultButton(
                    text: "Continue",
                    width: Get.width * .9,
                    onTap: () {
                      if (controller.takeOrderMySelf.value == true) {
                        if ((controller.startTimeController.isEmpty ||
                            controller.selectedDate.isEmpty)) {
                          Utils.showSnackbar("Please select Arrival Date/Time");
                        } else {
                          controller.checkoutOption();
                        }
                      } else {
                        if (controller.selectedAddress != null) {
                          controller.checkoutOption();
                        } else {
                          Utils.showSnackbar("Please select Delivery Address");
                        }
                      }
                      // if (controller.takeOrderMySelf.value == true &&
                      //     controller.takeOrderMySelf.value !=
                      //         controller.pickupFromMarket.value) {
                      //   // if (controller.vehicleNoController.text.isEmpty) {
                      //   //   // controller.saveVehicleData();
                      //   //   Utils.showSnackbar(
                      //   //       "Please enter vehicle information");
                      //   // } else
                      //   if ((controller.takeOrderMySelf.value ||
                      //           controller.pickupFromMarket.value) &&
                      //       (controller.startTimeController.isEmpty ||
                      //           controller.selectedDate.isEmpty)) {
                      //     Utils.showSnackbar("Please select Arrival Date/Time");
                      //   } else {
                      //     controller.checkoutOption();
                      //   }
                      // } else {
                      //   if ((controller.takeOrderMySelf.value ||
                      //           controller.pickupFromMarket.value) &&
                      //       (controller.startTimeController.isEmpty ||
                      //           controller.selectedDate.isEmpty)) {
                      //     Utils.showSnackbar("Please select Arrival Date/Time");
                      //   } else {
                      //     controller.checkoutOption();
                      //   }
                      //
                      //   // else if (controller.takeOrderMySelf.value == true &&
                      //   //     controller.pickupFromMarket.value == true) {
                      //   //   controller.saveVehicleData();
                      //   // }
                      // }

                      // Get.toNamed(Routes.PAYMENT_METHODS);
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
            );
          },
        ),
      ),
    );
  }

  _selectStartTime(context) async {
    DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      isDismissible: false,
      builder: (context) {
        DateTime? tempPickedDate =
            controller.selectedStartDate ?? DateTime.now();
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    initialDateTime: tempPickedDate,
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (DateTime? dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != controller.selectedStartDate) {
      controller.selectedStartDate = pickedDate;
      controller.startTimeController =
          DateFormat("HH:mm:ss").format(pickedDate);
      controller.update();
    }
  }

  addressType(checkoutController) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Delivery Address",
              style: beVietnamProaBold.copyWith(
                color: Color(0xFF204F33),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            width: Get.width,
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
            child: Column(
              children: [
                const SizedBox(height: 25),
                getAddress(controller.addressList, checkoutController),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.ADD_NEW_LOCATION);
                  },
                  child: Container(
                      height: getProportionateScreenHeight(50),
                      width: Get.width * .8,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF3F8FC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(64),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset("assets/svg/marker.svg"),
                            Text(
                              "Add New Location",
                              style: urbanistBold.copyWith(
                                color: Color(0xFF204F33),
                                fontSize: getProportionalFontSize(15),
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      )),
                ),
                const SizedBox(height: 12),
                DefaultButton(
                  text: "Select Address",
                  height: getProportionateScreenHeight(50),
                  width: Get.width * .8,
                  color: AppColors.appTheme,
                  buttonColor: AppColors.appTheme,
                  textColor: AppColors.white,
                  textStyle: urbanistBold.copyWith(
                    color: AppColors.white,
                    fontSize: getProportionalFontSize(15),
                    fontWeight: FontWeight.w700,
                  ),
                  onTap: () {
                    Get.toNamed(Routes.SELECT_ADDRESS);
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  paymentType() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Payment Method",
              style: beVietnamProaBold.copyWith(
                  color: AppColors.appTheme, fontSize: 20),
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  RadioListTile<PaymentEnum>(
                    activeColor: AppColors.appTheme,
                    contentPadding: EdgeInsets.zero,
                    title: Row(children: [
                      // SizedBox(
                      //     width: 40,
                      //     child: SvgPicture.asset("assets/svg/Chip.svg")),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Master / Visa Card",
                            style: beVietnamProSemiBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("********4545"),
                        ],
                      )
                    ]),
                    value: PaymentEnum.card,
                    groupValue: controller.payment,
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (PaymentEnum? value) {
                      controller.payment = value;
                      controller.update();
                    },
                  ),
                  // const Divider(
                  //   thickness: 1,
                  // ),
                  // RadioListTile<PaymentEnum>(
                  //   activeColor: AppColors.appTheme,
                  //   title: Row(children: [
                  //     SizedBox(width: 40, child: Image.asset(AppImages.paypal)),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "Paypal",
                  //           style: beVietnamProSemiBold,
                  //         ),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         const Text("nightcoder***@gmail.com"),
                  //       ],
                  //     ),
                  //   ]),
                  //   contentPadding: EdgeInsets.zero,
                  //   value: PaymentEnum.paypal,
                  //   groupValue: controller.payment,
                  //   controlAffinity: ListTileControlAffinity.trailing,
                  //   onChanged: (PaymentEnum? value) {
                  //     controller.payment = value;
                  //     controller.update();
                  //   },
                  // ),
                  // const Divider(
                  //   thickness: 1,
                  // ),
                  // RadioListTile<PaymentEnum>(
                  //   activeColor: AppColors.appTheme,
                  //   title: Row(children: [
                  //     SizedBox(width: 40, child: Image.asset(AppImages.cod)),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "Cash on delivery",
                  //           style: beVietnamProSemiBold,
                  //         ),
                  //       ],
                  //     ),
                  //   ]),
                  //   contentPadding: EdgeInsets.zero,
                  //   value: PaymentEnum.cod,
                  //   groupValue: controller.payment,
                  //   controlAffinity: ListTileControlAffinity.trailing,
                  //   onChanged: (PaymentEnum? value) {
                  //     controller.payment = value;
                  //     controller.update();
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  billTotal() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Items",
                style: beVietnamProaBold.copyWith(
                    color: AppColors.appTheme.withOpacity(.5), fontSize: 20),
              ),
              Text(
                "${controller.cartResponse.data!.cart!.products!.length} Items",
                style: beVietnamProaBold.copyWith(
                    color: AppColors.appTheme.withOpacity(.5), fontSize: 20),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: beVietnamProaBold.copyWith(
                    color: AppColors.appTheme, fontSize: 20),
              ),
              Text(
                "£${controller.cartResponse.data!.cart!.payableAmount}",
                style: beVietnamProaBold.copyWith(
                    color: AppColors.appTheme, fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getAddress(
      List<AddressResponse> address, CheckoutController checkoutController) {
    return checkoutController.addressList.isNotEmpty &&
            checkoutController.selectedAddress != null
        ? SizedBox(
            width: Get.width,
            child: Padding(
              padding:
                  EdgeInsets.only(left: Get.width * .05, top: Get.height * .01),
              child: Column(
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage(AppImages.locationPlaceholder),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              checkoutController.selectedAddress!.type ??
                                  '-'.capitalize.toString(),
                              style: beVietnamProSemiBold.copyWith(
                                color: Color(0xFF204F33),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 5),
                            checkoutController.selectedAddress!
                                        .addressResponseDefault ==
                                    "true"
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: AppColors.appTheme,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      "Default",
                                      style: urbanistRegular.copyWith(
                                          color: AppColors.white, fontSize: 14),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                        const SizedBox(height: 3),
                        // SizedBox(
                        //   width: Get.width * .5,
                        //   child: Text(
                        //     checkoutController.selectedAddress!.text ??
                        //         '-'.capitalize.toString(),
                        //     style: urbanistMedium.copyWith(
                        //       color: Color(0xFF9D9D9D),
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.w600,
                        //     ),
                        //   ),
                        // ),
                        Text(
                          checkoutController.selectedAddress!.flatHouseNo ??
                              '-'.capitalize.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: urbanistRegular.copyWith(
                            color: const Color(0xFF9D9D9D),
                            fontSize: getProportionalFontSize(13),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          checkoutController.selectedAddress!.text ??
                              '-'.capitalize.toString(),
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
                    SizedBox(width: 20),
                    // Radio(
                    //     activeColor: AppColors.appTheme,
                    //     value: address[i].text,
                    //     groupValue: controller.addValue.value,
                    //     onChanged: (val) {
                    //       checkoutController.addValue.value = val as String;
                    //       checkoutController.update();
                    //     })
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                    endIndent: 20,
                  )
                ],
              ),
            ),
          )
        : SizedBox(
            height: 50,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "No Address Found",
                  style: beVietnamProSemiBold,
                ),
              ),
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
                        child: Text(
                            "${controller.cartResponse.data!.cart!.restaurantName}",
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
                        child: Text(
                          "${controller.cartResponse.data!.cart!.restaurantAddress}",
                          style: TextStyle(),
                        ),
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

  selectDeliveryOption(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (controller.nextDayCourierDelivery.value == false &&
                    controller.onlyFamooshed.value == false) &&
                (controller.deliveryOptions.value.pickUp != null &&
                    controller.deliveryOptions.value.pickUp == 1)
            ? CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                checkColor: AppColors.white,
                activeColor: AppColors.appTheme,
                title: Text("I will collect my order in person",
                    style: beVietnamProSemiBold.copyWith(
                        fontSize: getProportionalFontSize(14))),
                value: controller.takeOrderMySelf.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.takeOrderMySelf.value = value;
                    // controller.pickupFromMarket.value = false;
                    if (value == true) {
                      controller.deliveryFee.value = 0;
                    } else {
                      controller.deliveryFee.value = double.parse(
                          controller.deliveryOptions.value.homeDeliFee ?? '0');
                    }
                    controller.update();
                  }
                },
              )
            : SizedBox(),
        (controller.takeOrderMySelf.value == false &&
                    controller.onlyFamooshed.value == false) &&
                (controller.deliveryOptions.value.nextDay != null &&
                    controller.deliveryOptions.value.nextDay == 1)
            ? CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                checkColor: AppColors.white,
                activeColor: AppColors.appTheme,
                title: Text("Next Day National Courier Delivery",
                    style: beVietnamProSemiBold.copyWith(
                        fontSize: getProportionalFontSize(14))),
                subtitle: Text(
                    "£${controller.deliveryOptions.value.nextDayFee ?? 0}",
                    style: beVietnamProSemiBold.copyWith(
                        fontSize: getProportionalFontSize(12))),
                value: controller.nextDayCourierDelivery.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.nextDayCourierDelivery.value = value;
                    if (value == true) {
                      controller.deliveryFee.value = double.parse(
                          controller.deliveryOptions.value.nextDayFee ?? '0');
                    } else {
                      controller.deliveryFee.value = double.parse(
                          controller.deliveryOptions.value.homeDeliFee ?? '0');
                    }
                    controller.update();
                  }
                },
              )
            : SizedBox(),
        // (controller.takeOrderMySelf.value == false &&
        //             controller.nextDayCourierDelivery.value == false) &&
        //         (controller.deliveryOptions.value.onlyfamooshed != null &&
        //             controller.deliveryOptions.value.onlyfamooshed == 1)
        //     ? CheckboxListTile(
        //         controlAffinity: ListTileControlAffinity.leading,
        //         contentPadding: EdgeInsets.zero,
        //         checkColor: AppColors.white,
        //         activeColor: AppColors.appTheme,
        //         title: Text("Famooshed Delivery Driver",
        //             style: beVietnamProSemiBold.copyWith(
        //                 fontSize: getProportionalFontSize(14))),
        //         subtitle: Text(
        //             "£${controller.deliveryOptions.value.onlyfamooshedFee ?? 0}",
        //             style: beVietnamProSemiBold.copyWith(
        //                 fontSize: getProportionalFontSize(12))),
        //         value: controller.onlyFamooshed.value,
        //         onChanged: (value) {
        //           if (value != null) {
        //             controller.onlyFamooshed.value = value;
        //             if (value == true) {
        //               controller.deliveryFee.value = double.parse(
        //                   controller.deliveryOptions.value.onlyfamooshedFee ??
        //                       '0');
        //             } else {
        //               controller.deliveryFee.value = double.parse(
        //                   controller.deliveryOptions.value.homeDeliFee ?? '0');
        //             }
        //             controller.update();
        //           }
        //         },
        //       )
        //     : SizedBox(),
        (controller.takeOrderMySelf.value == true)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: getProportionateScreenHeight(8)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Color(0xFFcff2df),
                    ),
                    child: Text(
                      "When your order is ready, you will receive an update letting you know that your order is available for collection. Check your order summary for your selected pick up date/time and pick up address.",
                    ),
                    // "When your order is ready, you will receive an update order status to advise that your order is available for collection. Then when you arrive at the pickup location, open My Orders and tap on Order for view details. Click on button I’ve Arrived."),
                  ),
                  // DefaultButton(
                  //   text: "Enter Vehicle Information",
                  //   width: SizeConfig.deviceWidth! * .6,
                  //   height: getProportionateScreenHeight(45),
                  //   buttonColor: AppColors.appTheme,
                  //   textColor: Colors.white,
                  //   onTap: () {
                  //     Get.toNamed(Routes.VEHICLE_INFO);
                  //   },
                  // )
                ],
              )
            : SizedBox(),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        controller.takeOrderMySelf.value
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            "Arriving Date:  ${controller.selectedDate}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionalFontSize(16))),
                      ),
                      GestureDetector(
                          onTap: () async {
                            DateTime? initialDate;
                            if (controller.selectedDate.isNotEmpty) {
                              initialDate = DateFormat("yyyy-MM-dd")
                                  .parse(controller.selectedDate);
                            }

                            String? sel = await Utils.datePicker(context,
                                initalDate: initialDate);

                            if (sel != null && sel.isNotEmpty) {
                              controller.selectedDate = sel;
                              controller.update();
                            }
                            // else {
                            //   if (controller.selectedDate.isNotEmpty) {
                            //     controller.selectedDate =
                            //         controller.selectedDate;
                            //   } else {
                            //     controller.selectedDate = '';
                            //   }
                            // }
                            // controller.update();
                          },
                          child: Text("Change >"))
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            "Arriving Time:  ${controller.startTimeController}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionalFontSize(16))),
                      ),
                      GestureDetector(
                          onTap: () {
                            _selectStartTime(context);
                          },
                          child: Text("Change >"))
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                ],
              )
            : SizedBox(),
        Text(
          " Comments",
          style: TextStyle(
              height: 2,
              fontSize: getProportionalFontSize(14),
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: getProportionateScreenHeight(4),
        ),
        TextFormField(
          controller: controller.commentsController,
          decoration: InputDecoration(
            fillColor: Color(0xFF353535),
            hintText: "Enter comments",
            hintStyle: TextStyle(
                color: Colors.black54, fontSize: getProportionalFontSize(14)),
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
          validator: (value) {},
        ),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        // Divider(
        //   color: Colors.black,
        // )
      ],
    );
  }
}
