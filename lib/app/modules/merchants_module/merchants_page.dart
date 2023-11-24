// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:badges/badges.dart' as badges;
import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/data/models/get_merchant_response.dart';
import 'package:famooshed/app/modules/merchants_module/merchants_controller.dart';
import 'package:famooshed/app/modules/widgets/offer_widget.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/uil.dart';

import '../../common/values/app_icons.dart';
import '../../libraries/custom_dropdown/dropdown_textfield.dart';
import '../../routes/app_pages.dart';
import '../../theme/size_config.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_rect_button.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class MerchantsPage extends GetView<MerchantsController> {
  const MerchantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MerchantsController>(
      init: MerchantsController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar:

              // CustomAppbarWidget(
              //   centerTitle: true,
              //   // title: controller.merchantName.value,
              //   title: "Merchants",
              //   backgroundColor: AppColors.white,
              //   statusBarColor: AppColors.white,
              //   actions: <Widget>[
              //     InkWell(
              //         onTap: () async {
              //           // Get.toNamed(Routes.CART);
              //           var result = await Get.toNamed(Routes.CART);
              //
              //           if (result != null) {
              //             controller.getBasket();
              //           }
              //         },
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: shoppingCartBadge(),
              //         )),
              //   ],
              // ),
              AppBar(
            leading: CustomBackButton(
              onBackTap: () {
                Get.back();
              },
              backbuttonColor: AppColors.appTheme,
            ),
            leadingWidth: 45.w,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Merchants",
                  style:
                      beVietnamProaBold24.copyWith(color: AppColors.appTheme),
                ),
                // controller.restaurant != null &&
                //         controller.restaurant!.isFeatured == 1
                //     ? Container(
                //         margin: EdgeInsets.only(
                //             left: getProportionateScreenWidth(8)),
                //         height: getProportionateScreenHeight(25),
                //         width: getProportionateScreenWidth(25),
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             color: AppColors.appTheme),
                //         child: SvgPicture.asset(
                //           AppIcons.reward,
                //           fit: BoxFit.cover,
                //           color: Colors.white,
                //           width: getProportionateScreenWidth(16),
                //           height: getProportionateScreenHeight(16),
                //         ),
                //       )
                //     : SizedBox(),
              ],
            ),
            centerTitle: true,
            backgroundColor: AppColors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppColors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
                systemNavigationBarColor: Colors.transparent),
            elevation: 0,
            actions: <Widget>[
              InkWell(
                onTap: () async {
// Get.toNamed(Routes.CART);
                  var result = await Get.toNamed(Routes.CART);

                  if (result != null) {
                    // controller.getBasket();
                    _.getCartNew(); // Assuming controller instance is accessible here
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: shoppingCartBadge(),
                ),
              ),
            ],
          ),
          body: _.isLoading.value
              ? const CircularProgressIndicator(color: Colors.transparent)
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: AppColors.white,
                      pinned: true,
                      floating: true,
                      expandedHeight: MediaQuery.of(context).size.height * 0.55,
                      flexibleSpace: FlexibleSpaceBar(
                        background: merchantInfo(),
                      ),
                      // Add actions or other SliverAppBar properties if needed
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 3), // Adjust the height as needed
                    ),
                    SliverFillRemaining(
                      child: DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            // SizedBox(height: getProportionateScreenHeight(5)),
                            // _tabSection(context),
                            SizedBox(
                              height: getProportionateScreenHeight(60),
                              child: TabBar(
                                automaticIndicatorColorAdjustment: true,
                                indicatorColor: AppColors.appTheme,
                                labelColor: AppColors.appTheme,
                                unselectedLabelColor: AppColors.appTheme,
                                labelStyle: beVietnamProaBold.copyWith(
                                  color: Color(0xFF204F33),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                tabs: [
                                  Tab(text: Strings.products),
                                  Tab(text: Strings.offers),
                                  Tab(text: Strings.reviews),
                                ],
                              ),
                            ),
                            Expanded(
                              //Add this to give height
                              // height: MediaQuery.of(context).size.height,
                              child: TabBarView(children: [
                                product(),
                                offerPage(),
                                reviewPage(),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  merchantInfo() {
    return Column(
      children: [
        merchentName(),
        SizedBox(
          height: getProportionateScreenHeight(8),
        ),
        productAndLocation(),
        SizedBox(
          height: getProportionateScreenHeight(8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Iconify(
              size: 18,
              Uil.map_marker,
              color: AppColors.doveGray,
            ),
            const SizedBox(
              width: 5,
            ),
            Flexible(
              child: Text(
                "${controller.restaurant!.businessAddress}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: urbanistSemiBold.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.doveGray,
                    fontSize: 14),
              ),
            )
          ],
        ),
        // SizedBox(height: getProportionateScreenHeight(7)),
        // propertiesSection(),
        // SizedBox(height: getProportionateScreenHeight(9)),
        // DefaultButton(
        //     height: getProportionateScreenHeight(44),
        //     buttonColor: AppColors.appTheme,
        //     textStyle:
        //         urbanistBold.copyWith(fontSize: 18, color: AppColors.white),
        //     text: "Contact",
        //     width: Get.width * .4,
        //     onTap: () {}),

        merchantsDecription()
      ],
    );
  }

  merchentName() {
    return Column(
      children: [
        controller.restaurant!.isFeatured == 1
            ? Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(
                          Constants.imgUrl + controller.restaurant!.image),
                    ),
                    // Positioned(
                    //   bottom: -2,
                    //   right: 10,
                    //   // alignment: Alignment.bottomRight,
                    //   child: Container(
                    //     height: getProportionateScreenHeight(25),
                    //     width: getProportionateScreenWidth(25),
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //         shape: BoxShape.circle, color: AppColors.appTheme),
                    //     child: SvgPicture.asset(
                    //       AppIcons.reward,
                    //       fit: BoxFit.cover,
                    //       color: Colors.white,
                    //       width: getProportionateScreenWidth(16),
                    //       height: getProportionateScreenHeight(16),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              )
            : CircleAvatar(
                radius: 48,
                backgroundImage: NetworkImage(
                    Constants.imgUrl + controller.restaurant!.image),
              ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.restaurant!.name.capitalize!,
              style: beVietnamProaBold.copyWith(
                  fontSize: 20, color: AppColors.appTheme),
            ),
            controller.restaurant != null &&
                    controller.restaurant!.isFeatured == 1
                ? Container(
                    margin:
                        EdgeInsets.only(left: getProportionateScreenWidth(8)),
                    height: getProportionateScreenHeight(25),
                    width: getProportionateScreenWidth(25),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.appTheme),
                    child: SvgPicture.asset(
                      AppIcons.reward,
                      fit: BoxFit.cover,
                      color: Colors.white,
                      width: getProportionateScreenWidth(16),
                      height: getProportionateScreenHeight(16),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        // controller.restaurant!.isFeatured == 1
        //     ? Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Text(
        //             controller.restaurant!.name.capitalize!,
        //             style: beVietnamProaBold.copyWith(
        //                 fontSize: 20, color: AppColors.appTheme),
        //           ),
        //           SizedBox(
        //             width: getProportionateScreenWidth(4),
        //           ),
        //           SvgPicture.asset(
        //             AppIcons.reward,
        //             fit: BoxFit.fill,
        //             width: getProportionateScreenWidth(15),
        //             height: getProportionateScreenHeight(20),
        //           ),
        //         ],
        //       )
        //     : Text(
        //         controller.restaurant!.name.capitalize!,
        //         style: beVietnamProaBold.copyWith(
        //             fontSize: 20, color: AppColors.appTheme),
        //       ),
      ],
    );
  }

  propertiesSection() {
    return SizedBox(
      width: Get.width * .9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: const [
              Iconify(
                Carbon.delivery_parcel,
                color: Color(0xFF9D9D9D),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "free delivery",
                style: TextStyle(
                  color: Color(0xFF9D9D9D),
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Iconify(
                Ic.round_access_time,
                color: Color(0xFF9D9D9D),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "10-15 mins",
                style: TextStyle(
                  color: Color(0xFF9D9D9D),
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Iconify(
                Uil.map_marker,
                color: Color(0xFF9D9D9D),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Farmland",
                style: TextStyle(
                  color: Color(0xFF9D9D9D),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  productAndLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${controller.foodList.length} products",
          style: TextStyle(
            color: Color(0xFF9D9D9D),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: HexColor('#9D9D9D'),
              borderRadius: BorderRadius.circular(50)),
        ),
        Text(
          "${controller.merchantDistance.value} miles away",
          style: TextStyle(
            color: Color(0xFF9D9D9D),
          ),
        )
      ],
    );
  }

  merchantsDecription() {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(8)),
        Text(
          controller.restaurant!.desc,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 70,
            child: TabBar(
                automaticIndicatorColorAdjustment: true,
                indicatorColor: AppColors.appTheme,
                labelColor: AppColors.appTheme,
                unselectedLabelColor: AppColors.appTheme,
                labelStyle: beVietnamProaBold.copyWith(
                  color: Color(0xFF204F33),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                tabs: [
                  Tab(text: Strings.products),
                  Tab(text: Strings.offers),
                  Tab(text: Strings.reviews),
                ]),
          ),
          SizedBox(
            //Add this to give height
            height: MediaQuery.of(context).size.height,
            child: TabBarView(children: [
              product(),
              offerPage(),
              reviewPage(),
            ]),
          ),
        ],
      ),
    );
  }

  product() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(10),
              vertical: getProportionateScreenHeight(10)),
          child: DropDownTextField.multiSelection(
            clearOption: false,
            textFieldDecoration: InputDecoration(
                hintStyle: AppTextStyle.regularStyle.copyWith(
                  color: AppColors.mineShaft,
                  fontSize: Dimens.fontSize12,
                ),
                fillColor: Colors.black12,
                filled: true,
                contentPadding: EdgeInsets.only(
                    top: getProportionateScreenHeight(8),
                    bottom: getProportionateScreenHeight(8),
                    left: getProportionateScreenWidth(16)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                hintText: "Select product category"),
            displayCompleteItem: true,
            submitButtonColor: AppColors.appTheme,
            submitButtonTextStyle: TextStyle(color: Colors.white),
            listPadding: ListPadding(
                top: getProportionateScreenHeight(7),
                bottom: getProportionateScreenHeight(7)),
            submitButtonText: "Okay",
            dropDownList: controller.productCategoryList
                .map((e) => DropDownValueModel(value: e, name: e.name ?? '-'))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                controller.selectedProductCategoryList.clear();
                List<DropDownValueModel> result = value;
                if (result.isNotEmpty) {
                  result.forEach((element) {
                    controller.selectedProductCategoryList.add(element.value);
                  });
                }
                controller.update();
                controller.getMerchantData(false);
              }
              print(controller.selectedProductCategoryList);
            },
            checkBoxProperty: CheckBoxProperty(
              checkColor: AppColors.appTheme,
              fillColor: MaterialStateProperty.all(Colors.transparent),
              side: MaterialStateBorderSide.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return BorderSide(color: AppColors.appTheme, width: 1.3);
                  }
                  return const BorderSide(color: Colors.grey, width: 1.3);
                },
              ),
            ),
            textStyle: AppTextStyle.regularStyle.copyWith(
              color: AppColors.mineShaft,
              fontSize: Dimens.fontSize13,
            ),
            listTextStyle: AppTextStyle.regularStyle.copyWith(
              color: AppColors.mineShaft,
              fontSize: Dimens.fontSize13,
            ),
            dropDownIconProperty: IconProperty(
                icon: Icons.arrow_drop_down, color: Colors.grey, size: 25),
            dropdownColor: Colors.white,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select stall category';
              }
              return null;
            },
          ),
        ),
        controller.foodList.isNotEmpty
            ? Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(10),
                        vertical: getProportionateScreenHeight(10)),
                    // physics: const NeverScrollableScrollPhysics(),
                    // scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: getProportionateScreenWidth(190) /
                            getProportionateScreenHeight(300),
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 20),
                    itemCount: controller.foodList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return productItem(index);
                    }),
              )
            : Center(
                child: Text(
                  "Products not available",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: beVietnamProMedium.copyWith(
                    color: AppColors.black,
                    fontSize: getProportionalFontSize(14),
                  ),
                ),
              ),
      ],
    );
  }

  // productPage() {
  //   return GridView.count(
  //     physics: const NeverScrollableScrollPhysics(),
  //     mainAxisSpacing: 20,
  //     crossAxisSpacing: 20,
  //     crossAxisCount: 2,
  //     padding: EdgeInsets.zero,
  //     childAspectRatio: 1.2 / 2,
  //     children: [
  //       productItem(),
  //       productItem(),
  //       productItem(),
  //       productItem(),
  //       productItem(),
  //     ],
  //   );
  // }

  offerPage() {
    return ListView.builder(
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.restaurantsoffer.length,
      // shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        var data = controller.restaurantsoffer[index];
        return offerItem(data);
      },
    );
  }

  offerItem(Restaurantsoffer offers) {
    return InkWell(
      onTap: () {
        controller.getCartNewForCoupon(offers);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            CustomPaint(
              size: Size(
                  SizeConfig.deviceWidth!, getProportionateScreenHeight(110)),
              painter: RPSCustomPainter(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: getProportionateScreenWidth(30),
                  ),
                  Text(
                    "${offers.inpercents == 1 ? '' : '£'}${int.parse(double.parse(offers.discount).round().toString())} ${offers.inpercents == 1 ? '%' : ''}\noff",
                    style: beVietnamProSemiBold.copyWith(
                        fontSize: getProportionalFontSize(22),
                        color: AppColors.appThemeText),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(40),
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(
                            getProportionateScreenHeight(10)),
                      ),
                      Text(
                        'This is a coupon code',
                        style: beVietnamProSemiBold.copyWith(
                            fontSize: getProportionalFontSize(16),
                            color: AppColors.appTheme),
                      ),
                      Text(
                        offers.desc,
                        style: urbanistSemiBold.copyWith(
                            fontSize: getProportionalFontSize(13),
                            color: AppColors.greyText),
                      ),
                      Text(
                        offers.name,
                        style: beVietnamProSemiBold.copyWith(
                            fontSize: getProportionalFontSize(21),
                            color: AppColors.appThemeText),
                      ),
                      Text(
                        '*You can use it on your first order only',
                        style: urbanistRegular.copyWith(
                            fontSize: getProportionalFontSize(10),
                            color: AppColors.greyText),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  reviewPage() {
    return ListView.builder(
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.reviewList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return reviewItem(index);
      },
    );
  }

  productItem(index) {
    return GestureDetector(
      onTap: () {
        controller.goToDetailPage(index);
      },
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.50,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: Color(0xFFE9EDEB),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: getProportionateScreenWidth(160),
                height: getProportionateScreenHeight(150),
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        Constants.imgUrl + controller.foodList[index].image),
                    fit: BoxFit.fitHeight,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              // ClipRRect(
              //     borderRadius: BorderRadius.circular(12.0),
              //     child: SizedBox(
              //       child: CachedNetworkImage(
              //           imageUrl:
              //               Constants.imgUrl + controller.foodList[index].image),
              //     )),
              Text(
                controller.foodList[index].name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: beVietnamProSemiBold.copyWith(
                  color: AppColors.appTheme,
                  fontSize: getProportionalFontSize(16),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  controller.foodList[index].itemStock != null &&
                          controller.foodList[index].itemStock! < 10
                      ? controller.foodList[index].itemStock != null &&
                              controller.foodList[index].itemStock! <= 0
                          ? Text(
                              'OUT OF STOCK',
                              style: urbanistSemiBold.copyWith(
                                  color: AppColors.redColor,
                                  fontSize: getProportionalFontSize(12)),
                            )
                          : SizedBox()
                      // : Text(
                      //     'Remaining (${controller.foodList[index].itemStock})',
                      //     style: urbanistSemiBold.copyWith(
                      //         color: HexColor('#9D9D9D'),
                      //         fontSize: getProportionalFontSize(13)),
                      //   )
                      : SizedBox(),
                  Row(
                    children: [
                      Text(controller.foodList[index].stars.toString()),
                      SizedBox(
                        width: getProportionateScreenWidth(2),
                      ),
                      Image.asset(AppImages.star)
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: getProportionateScreenHeight(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "£${double.parse(controller.foodList[index].price).toString()}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: beVietnamProSemiBold.copyWith(
                            fontSize: getProportionalFontSize(18),
                            color: AppColors.appThemeText),
                      ),
                    ),
                    DefaultRectButton(
                        buttonColor:
                            controller.foodList[index].itemStock != null &&
                                    controller.foodList[index].itemStock! <= 0
                                ? AppColors.greyText
                                : AppColors.appTheme,
                        textColor: AppColors.white,
                        height: 35,
                        text: "Add to Cart",
                        width: Get.width * .25,
                        onTap: controller.foodList[index].itemStock != null &&
                                controller.foodList[index].itemStock! <= 0
                            ? null
                            : () {
                                // controller.addToCart(index);
                                controller.counter.value = 1;
                                controller.update();
                                Get.bottomSheet(GetBuilder(
                                  builder: (MerchantsController controller) {
                                    return SafeArea(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: AppColors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0,
                                              right: 20.0,
                                              top: 10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 48,
                                                width: 90,
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .blueColorLight,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .decrement();
                                                        },
                                                        child: const Icon(
                                                            Icons.remove)),
                                                    const SizedBox(width: 10.0),
                                                    Text(
                                                        '${controller.counter.value}'),
                                                    const SizedBox(width: 10.0),
                                                    GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .increment();
                                                        },
                                                        child: const Icon(
                                                            Icons.add)),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              DefaultRectButton(
                                                  buttonColor:
                                                      AppColors.appTheme,
                                                  textColor: AppColors.white,
                                                  height: 40,
                                                  text: "Add to Cart",
                                                  width: Get.width * .3,
                                                  onTap: () async {
                                                    // controller.addToCart(index);

                                                    await controller
                                                        .addToCartNew(controller
                                                            .foodList[index]);
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ));
                              })
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget shoppingCartBadge() {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 3),
      badgeAnimation: const badges.BadgeAnimation.slide(),
      showBadge: true,
      badgeStyle: const badges.BadgeStyle(
        badgeColor: AppColors.appTheme,
      ),
      badgeContent: Text(
        controller.count.value.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      child: const CircleAvatar(
          radius: 22, backgroundImage: AssetImage(AppImages.cart)),
    );
  }

  reviewItem(index) {
    // Container(
    //   width: 398,
    //   height: 210,
    //   decoration: ShapeDecoration(
    //     color: Colors.white,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(16),
    //     ),
    //     shadows: [
    //       BoxShadow(
    //         color: Color(0x19204F33),
    //         blurRadius: 20,
    //         offset: Offset(0, 4),
    //         spreadRadius: 0,
    //       )
    //     ],
    //   ),
    // );
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    Constants.imgUrl + controller.reviewList[index].image),
              ),
              title: Text(
                'Rezwan Nahid',
                // controller.reviewList[index].name.toString(),
                style: beVietnamProSemiBold.copyWith(
                    color: AppColors.appTheme,
                    fontSize: getProportionalFontSize(16)),
              ),
              subtitle: Text(
                'Ordered Items: 150',
                style: urbanistSemiBold.copyWith(
                    color: HexColor('#9D9D9D'),
                    fontSize: getProportionalFontSize(14)),
              ),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  controller.reviewList[index].rate,
                  style: urbanistBold.copyWith(
                      color: AppColors.appTheme,
                      fontSize: getProportionalFontSize(14)),
                ),
                const SizedBox(
                  width: 5,
                ),
                Image.asset(AppImages.star)
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(20),
                  bottom: getProportionateScreenHeight(8),
                  right: getProportionateScreenWidth(20)),
              child: Text(
                controller.reviewList[index].desc,
                style: urbanistRegular.copyWith(
                  color: Color(0xFF204F33),
                  fontSize: getProportionalFontSize(13),
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
