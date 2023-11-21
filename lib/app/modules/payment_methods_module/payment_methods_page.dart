import 'dart:math' as math;

import 'package:famooshed/app/common/util/validators.dart';
import 'package:famooshed/app/modules/payment_methods_module/payment_methods_controller.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/util/exports.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/custom_default_button.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class PaymentMethodsPage extends GetView<PaymentMethodsController> {
  PaymentMethodsPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppbarWidget(
        centerTitle: true,
        backgroundColor: AppColors.white,
        statusBarColor: AppColors.white,
        title: "Card",
      ),
      backgroundColor: AppColors.white,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: DefaultButton(
          text: "Done",
          width: Get.width * .85,
          onTap: () {
            if (_formKey.currentState!.validate()) {
              controller.cardValidateApi();
            }
            // Get.toNamed(Routes.ORDER_SUCESS);
          },
          buttonColor: AppColors.appTheme,
          textColor: AppColors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GetBuilder<PaymentMethodsController>(
          builder: (PaymentMethodsController controller) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Image.asset("assets/svg/card.png"),
                    // ),
                    cardWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text('Card details'.capitalize!,
                                  style: beVietnamProaBold.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: TextFormField(
                                    validator: Validators.validateEmpty,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.50,
                                              color: Color(0x33204F33)),
                                        ),
                                        hintText: 'Card holder name',
                                        counterText: "",
                                        hintStyle: urbanistRegular.copyWith(
                                          color: const Color(0xFF9D9D9D),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    onChanged: (value) {
                                      controller.cardHolderName.value = value;
                                      controller.update();
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: controller.cardNumberCtrl,
                                    validator: Validators.validateEmpty,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.50,
                                              color: Color(0x33204F33)),
                                        ),
                                        hintText: 'Card number',
                                        counterText: "",
                                        hintStyle: urbanistRegular.copyWith(
                                          color: const Color(0xFF9D9D9D),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    maxLength: 16,
                                    onChanged: (value) {
                                      final newCardNumber = value.trim();
                                      var newStr = '';
                                      const step = 4;

                                      for (var i = 0;
                                          i < newCardNumber.length;
                                          i += step) {
                                        newStr += newCardNumber.substring(
                                            i,
                                            math.min(i + step,
                                                newCardNumber.length));
                                        if (i + step < newCardNumber.length) {
                                          newStr += ' ';
                                        }
                                      }

                                      controller.cardNumber.value = newStr;
                                      controller.update();
                                    },
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        validator: Validators.validateEmpty,
                                        controller: controller.expiryFieldCtrl,
                                        decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.50,
                                                  color: Color(0x33204F33)),
                                            ),
                                            hintText: 'MM/YY',
                                            counterText: "",
                                            hintStyle: urbanistRegular.copyWith(
                                              color: const Color(0xFF9D9D9D),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        maxLength: 5,
                                        onChanged: (value) {
                                          var newDateValue = value.trim();
                                          final isPressingBackspace = controller
                                                  .expiryDate.value.length >
                                              newDateValue.length;
                                          final containsSlash =
                                              newDateValue.contains('/');

                                          if (newDateValue.length >= 2 &&
                                              !containsSlash &&
                                              !isPressingBackspace) {
                                            newDateValue =
                                                '${newDateValue.substring(0, 2)}/${newDateValue.substring(2)}';
                                          }

                                          controller.expiryFieldCtrl.text =
                                              newDateValue;
                                          controller.expiryFieldCtrl.selection =
                                              TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset:
                                                          newDateValue.length));
                                          controller.expiryDate.value =
                                              newDateValue;
                                          controller.update();
                                        },
                                      ),
                                    )),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 25),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          validator: Validators.validateEmpty,
                                          decoration: InputDecoration(
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.50,
                                                    color: Color(0x33204F33)),
                                              ),
                                              hintText: 'CVV',
                                              counterText: "",
                                              hintStyle:
                                                  urbanistRegular.copyWith(
                                                color: const Color(0xFF9D9D9D),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              )),
                                          maxLength: 3,
                                          onChanged: (value) {
                                            controller.cvv.value = value;
                                            controller.update();
                                          },
                                          focusNode: controller.focusNode,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.isSaved.value =
                                        !controller.isSaved.value;
                                    controller.update();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, bottom: 30, left: 20),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            height: 24.0,
                                            width: 24.0,
                                            child: Theme(
                                              data: Theme.of(context).copyWith(
                                                unselectedWidgetColor:
                                                    AppColors.appTheme,
                                              ),
                                              child: Checkbox(
                                                  checkColor: Colors.white,
                                                  activeColor:
                                                      "#44CB7B".fromHex,
                                                  value:
                                                      controller.isSaved.value,
                                                  onChanged: (v) {
                                                    controller.isSaved.value =
                                                        v!;
                                                  }),
                                            )),
                                        const Text("Save Card")
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ]),
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: controller.isLoading.value,
                  child: SizedBox(
                    height: Get.height,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.appTheme,
                      ),
                    ),
                  ))
            ],
          ),
        );
      }),
    );
  }

  Widget cardWidget() {
    return Center(
      child: Container(
        // width: 390,
        height: 260,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1.13, color: Colors.white),
            borderRadius: BorderRadius.circular(18.14),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: -0,
              child: Container(
                width: 390,
                height: 244.88,
                decoration: ShapeDecoration(
                  color: const Color(0xFF85D7A7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.14),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 122.44,
              child: Container(
                width: 390,
                height: 122.44,
                decoration: const BoxDecoration(color: Color(0xFF232323)),
              ),
            ),
            Positioned(
              left: 38.55,
              top: 140.36,
              child: SvgPicture.asset("assets/svg/number.svg"),
            ),
            const Positioned(
              left: 38.55,
              top: 176.36,
              child: Text(
                'Mick Gardy',
                style: TextStyle(
                  color: Color(0xFFFAFAFA),
                  fontSize: 10.88,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Positioned(
              left: 119.72,
              top: 176.36,
              child: Text(
                '12/24',
                style: TextStyle(
                  color: Color(0xFFFAFAFA),
                  fontSize: 10.88,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 45.35,
              top: 74.83,
              child: SizedBox(
                width: 50.79,
                height: 36.28,
                child:
                    Stack(children: [SvgPicture.asset("assets/svg/Chip.svg")]),
              ),
            ),
            Positioned(
              left: 324.70,
              top: 36.28,
              child: Container(
                width: 29.02,
                height: 29.02,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: Stack(
                    children: [SvgPicture.asset("assets/svg/Paypass.svg")]),
              ),
            ),
            Positioned(
              left: 299.76,
              top: 176.86,
              child: Container(
                width: 67.68,
                height: 45.35,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.63),
                  ),
                ),
                child: Stack(
                  children: [
                    controller.cardNumber.value.startsWith(RegExp(r'[4]'))
                        ? Image.asset('assets/svg/visa_logo.png')
                        : SvgPicture.asset("assets/svg/Mastercard.svg")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
