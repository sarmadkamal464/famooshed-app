// ignore_for_file: must_be_immutable

import 'package:famooshed/app/data/models/card_model.dart';
import 'package:famooshed/app/modules/checkout_module/checkout_controller.dart';
import 'package:famooshed/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../common/util/exports.dart';
import '../../common/util/validators.dart';
import '../../theme/app_text_theme.dart';
import '../../utils/dprint.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/custom_default_button.dart';

class PaymentPage extends GetView<CheckoutController> {
  PaymentPage({super.key});

  GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getCards();
    });
    return Scaffold(
      appBar: CustomAppbarWidget(
        centerTitle: true,
        backgroundColor: AppColors.white,
        statusBarColor: AppColors.white,
        title: "Payment Method",
      ),
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: GetBuilder<CheckoutController>(
        initState: (state) {},
        builder: (CheckoutController checkoutController) {
          return SingleChildScrollView(
            clipBehavior: Clip.none,
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16),
                vertical: getProportionateScreenHeight(16)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // // Padding(
                  // //   padding: const EdgeInsets.all(8.0),
                  // //   child: Image.asset("assets/svg/card.png"),
                  // // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Text(
                    "Saved Cards",
                    style: beVietnamProaBold.copyWith(
                        color: AppColors.appTheme, fontSize: 20),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
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
                    child: savedCard(),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Container(
                    // margin: const EdgeInsets.all(8),
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
                    child: ExpansionTile(
                      textColor: AppColors.appTheme,
                      title: Text('Add another card'.capitalize!,
                          style: beVietnamProaBold.copyWith(
                            fontSize: getProportionalFontSize(16),
                            fontWeight: FontWeight.w700,
                          )),
                      children: [
                        // Container(
                        //   margin: const EdgeInsets.symmetric(
                        //       horizontal: 20, vertical: 10),
                        //   child: Text('Card details'.capitalize!,
                        //       style: beVietnamProaBold.copyWith(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.w700,
                        //       )),
                        // ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            controller: controller.cardNameController,
                            validator: Validators.validateEmpty,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.50, color: Color(0x33204F33)),
                                ),
                                hintText: 'Card holder name',
                                counterText: "",
                                hintStyle: urbanistRegular.copyWith(
                                  color: const Color(0xFF9D9D9D),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                )),
                            onChanged: (value) {},
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: controller.cardNoController,
                            validator: Validators.validateCardNumber,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.50, color: Color(0x33204F33)),
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
                              // final newCardNumber = value.trim();
                              // var newStr = '';
                              // const step = 4;
                              //
                              // for (var i = 0;
                              //     i < newCardNumber.length;
                              //     i += step) {
                              //   newStr += newCardNumber.substring(
                              //       i,
                              //       math.min(i + step,
                              //           newCardNumber.length));
                              //   if (i + step < newCardNumber.length) {
                              //     newStr += ' ';
                              //   }
                              // }
                              //
                              // controller.cardNumber.value = newStr;
                              // controller.update();
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
                                controller: controller.cardExpController,
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
                                  final isPressingBackspace =
                                      controller.expiryDate.value.length >
                                          newDateValue.length;
                                  final containsSlash =
                                      newDateValue.contains('/');

                                  if (newDateValue.length >= 2 &&
                                      !containsSlash &&
                                      !isPressingBackspace) {
                                    newDateValue =
                                        '${newDateValue.substring(0, 2)}/${newDateValue.substring(2)}';
                                  }

                                  controller.cardExpController.text =
                                      newDateValue;
                                  controller.cardExpController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: newDateValue.length));
                                  controller.expiryDate.value = newDateValue;
                                  controller.update();
                                },
                              ),
                            )),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 25),
                                child: TextFormField(
                                  controller: controller.cardCvvController,
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
                                      hintStyle: urbanistRegular.copyWith(
                                        color: const Color(0xFF9D9D9D),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  maxLength: 3,
                                  onChanged: (value) {
                                    // controller.cvv.value = value;
                                    // controller.update();
                                  },
                                  // focusNode: controller.focusNode,
                                ),
                              ),
                            ),
                          ],
                        ),
                        CheckboxListTile(
                          value: controller.isCardSave,
                          onChanged: (value) {
                            if (value != null) {
                              controller.isCardSave = value;
                              controller.update();
                            }
                          },
                          checkColor: AppColors.white,
                          activeColor: AppColors.appTheme,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text("Save Card"),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(16),
                              vertical: getProportionateScreenHeight(10)),
                          child: DefaultButton(
                            text:
                                "Save & Pay £${controller.cartResponse.data!.payable}",
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                double to = (double.parse(controller
                                            .cartResponse
                                            .data!
                                            .cart!
                                            .payableAmount ??
                                        1.toString()) *
                                    100);
                                int total = to.toInt();
                                payWithNewCard(total, '£');
                              }
                              // Get.toNamed(Routes.ORDER_SUCESS);
                            },
                            buttonColor: AppColors.appTheme,
                            textColor: AppColors.white,
                            width: SizeConfig.deviceWidth!,
                            height: getProportionateScreenHeight(50),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(25),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16),
                        vertical: getProportionateScreenHeight(10)),
                    child: DefaultButton(
                      text: "Pay £${controller.cartResponse.data!.payable}",
                      onTap: () async {
                        // Get.toNamed(Routes.ORDER_SUCESS);
                        double to = (double.parse(controller
                                    .cartResponse.data!.cart!.payableAmount ??
                                1.toString()) *
                            100);
                        int total = to.toInt();
                        //
                        if (controller.selectedCard.paymentMethodId != null) {
                          payWithExistingCard(total, '£');
                        } else {
                          Utils.showSnackbar(
                              "Please add card to process payment");
                        }
                      },
                      buttonColor: AppColors.appTheme,
                      textColor: AppColors.white,
                      width: SizeConfig.deviceWidth!,
                      height: getProportionateScreenHeight(50),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
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
                    controller.cardNoController.text.startsWith(RegExp(r'[4]'))
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

  savedCard() {
    return controller.cards.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: controller.cards.length,
            itemBuilder: (context, index) {
              CardModel card = controller.cards[index];
              return InkWell(
                onTap: () {
                  controller.selectedCard = card;
                  controller.update();
                },
                child: Container(
                  width: SizeConfig.deviceWidth!,
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(10),
                      horizontal: getProportionateScreenWidth(16)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${card.brand}".toUpperCase(),
                              style: beVietnamProSemiBold,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("********${card.savedCard}"),
                          ],
                        ),
                        controller.selectedCard.paymentMethodId != null &&
                                controller.selectedCard.paymentMethodId ==
                                    card.paymentMethodId!
                            ? Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.appTheme),
                                    shape: BoxShape.circle),
                                child: Container(
                                  height: getProportionateScreenHeight(10),
                                  width: getProportionateScreenWidth(10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.appTheme),
                                ),
                              )
                            : SizedBox()
                      ]),
                ),
              );
            },
          )
        : SizedBox();
  }

  payWithNewCard(int total, String currency) async {
    int month = int.parse(controller.expiryDate.value.split('/').first);
    int year = int.parse(controller.expiryDate.value.split('/').last);
    print(month);
    print(year);

    double basketWithTotal = double.parse(
      controller.cartResponse.data!.cart!.payableAmount ?? 0.toString(),
    );
    final cardDetails = CardDetails(
      number: controller.cardNoController.text,
      expirationMonth: month,
      expirationYear: year,
      cvc: controller.cardCvvController.text,
    );
    await Stripe.instance.dangerouslyUpdateCardDetails(cardDetails);

    final billingDetails = BillingDetails(
      name: controller.cardNameController.text,
    );

    try {
      /// create payment method
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(billingDetails: billingDetails),
        ),
      );

      print(paymentMethod.id);
      if (paymentMethod.id.isNotEmpty) {
        controller.saveCard(paymentMethod.id, total.toString(),
            controller.isCardSave ? "Yes" : "No", basketWithTotal.toString());
      }
    } on StripeException catch (e) {
      dprint(e.toString());
      Utils.showSnackbar(e.error.message ?? "Something went wrong");
    } catch (e) {
      print(e.toString());
    }
  }

  payWithExistingCard(int total, String currency) async {
    // double basketWithTotal = double.parse(
    //   controller.cartResponse.data!.cart!.payableAmount ?? 0.toString(),
    // );

    double basketWithTotal = double.parse(
      controller.cartResponse.data!.cart!.payableAmount!.replaceAll('£', '') ??
          0.toString(),
    );

    if (controller.selectedCard.paymentMethodId != null &&
        controller.selectedCard.paymentMethodId!.isNotEmpty) {
      controller.saveCard(controller.selectedCard.paymentMethodId!,
          total.toString(), "Yes", basketWithTotal.toString());
    }
  }
}
