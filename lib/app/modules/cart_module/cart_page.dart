import 'package:famooshed/app/data/models/get_cart_model.dart';
import 'package:famooshed/app/modules/cart_module/cart_controller.dart';
import 'package:famooshed/app/modules/widgets/custom_default_button.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:famooshed/app/utils/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../common/util/exports.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/no_item_found.dart';

class CartPage extends GetView<CartController> {
  CartPage({super.key});
  final couponVerify = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => backPop(),
      child: GetBuilder<CartController>(
        init: CartController(),
        builder: (CartController cartController) {
          return Scaffold(
              appBar: CustomAppbarWidget(
                centerTitle: true,
                title: "My Cart",
                backgroundColor: AppColors.white,
                statusBarColor: AppColors.white,
              ),
              backgroundColor: AppColors.white,
              body: cartController.productList.isNotEmpty
                  ? SafeArea(
                      child: SingleChildScrollView(
                          clipBehavior: Clip.none,
                          child: Column(
                            children: [
                              cartCard(cartController),
                              promoCodeSection(),
                              billCard(),
                              const SizedBox(height: 10),
                              DefaultButton(
                                text: Strings.continueText,
                                width: Get.width * .9,
                                height: 60,
                                onTap: () {
                                  controller.reDirectToCheckout();
                                },
                                buttonColor: AppColors.appTheme,
                                textColor: AppColors.white,
                              )
                            ],
                          )),
                    )
                  : const NoItemFound());
        },
      ),
    );
  }

  Widget cartCard(CartController cartController) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage(controller.restaurantImage.value),
                  ),
                  title: Text(
                    controller.restaturntName.value,
                    style: beVietnamProaBold.copyWith(
                        fontSize: 19, color: AppColors.appTheme),
                  ),
                  trailing: Text(
                    "${controller.productList.length} Items",
                    style: urbanistMedium.copyWith(
                        fontSize: 16, color: AppColors.appTheme),
                  ),
                ),
                const Divider(thickness: 2),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartController.productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = cartController.productList[index];
                    return cartItem(data);
                  },
                ),
              ],
            )),
      ),
    );
  }

  Widget billCard() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: HexColor('EBF9DC').withOpacity(.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            billItems("Subtotal", "£${controller.subTotal.value}"),
            const Divider(
              thickness: 2,
            ),
            billItems("Discount", "£${controller.discount.value}"),
            const Divider(
              thickness: 2,
            ),
            billItems("Shipping", "£${controller.shipping.value}"),
            const Divider(
              thickness: 2,
            ),
            // billItems("Tax ", "${controller.taxAmount}"),
            // const Divider(
            //   thickness: 2,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            style: urbanistSemiBold.copyWith(
                                color: AppColors.appTheme, fontSize: 16),
                            text: "Total ",
                            children: [
                              TextSpan(
                                text:
                                    "(${controller.productList.length} Items)",
                                style: urbanistBold.copyWith(
                                    fontSize: 16,
                                    color: "#215034".fromHex.withOpacity(.5)),
                              )
                            ])
                      ])),
                  Text(
                    "${controller.curruncySign.value}${controller.total.value}",
                    style: urbanistBold.copyWith(color: HexColor("#215034")),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  promoCodeSection() {
    return Form(
      key: couponVerify,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: "#F3F8FC".fromHex,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Get.width * .5,
                    child: TextFormField(
                      controller: controller.couponController,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Promo Code'),
                    ),
                  ),
                  DefaultButton(
                    text: "Apply",
                    width: Get.width * .3,
                    onTap: () {
                      // controller.apllyCoupon();
                      controller.applyCoupon();
                    },
                    buttonColor: AppColors.appTheme,
                    height: 40,
                    textColor: AppColors.white,
                  )
                ]),
          ),
        ),
      ),
    );
  }

  billItems(title, value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: urbanistSemiBold.copyWith(
                color: AppColors.appTheme, fontSize: 16),
          ),
          Text(
            value,
            style: urbanistBold.copyWith(
                fontSize: 16, color: HexColor("215034").withOpacity(.5)),
          ),
        ],
      ),
    );
  }

  Widget cartItem(Product product) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(product.image!),
      ),
      title: Text(
        product.productName ?? '-'.capitalize.toString(),
        style: beVietnamProSemiBold.copyWith(
            fontSize: 16, color: AppColors.appTheme),
      ),
      subtitle: Row(
        children: [
          Text(
            "Price : ",
            style: urbanistSemiBold.copyWith(
                fontSize: 14, color: AppColors.greyText),
          ),
          product.discountprice != null && product.discountprice! == 0
              ? Text(
                  "£${product.discountprice}",
                  style: urbanistSemiBold.copyWith(
                    fontSize: 14,
                    color: AppColors.greyText,
                  ),
                )
              : Container(), // or Text('') if you prefer an empty text widget

          Text(
            " £${product.unitPrice}",
            style: urbanistSemiBold.copyWith(
              fontSize: 13,
              color: AppColors.greyText.withOpacity(
                product.discountprice != null && product.discountprice! == 0
                    ? 0.5 // Apply line-through if discount price is available
                    : 1.0, // No line-through if discount price is not available
              ),
              decoration: product.discountprice != null &&
                      product.discountprice! == 0
                  ? TextDecoration
                      .lineThrough // Apply line-through if discount price is available
                  : null, // No decoration if discount price is not available
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () {
              controller.deleteItemsToCart(product);
            },
            child: const Icon(
              Icons.remove_circle_outline,
              color: AppColors.appTheme,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Text('${product.quantity ?? 1}',
              style: beVietnamProaBold24.copyWith(
                  fontSize: 16, color: AppColors.appTheme)),
          const SizedBox(width: 10),
          InkWell(
              onTap: () {
                // controller.increment(product);
                controller.addItemsToCart(product);
              },
              child: const Icon(
                Icons.add_circle_outline,
                color: AppColors.appTheme,
                size: 18,
              )),
        ],
      ),
    );
  }
}
