import 'package:cached_network_image/cached_network_image.dart';
import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/common/values/app_icons.dart';
import 'package:famooshed/app/data/models/get_home_response.dart';
import 'package:famooshed/app/modules/favorite_module/favorite_controller.dart';
import 'package:famooshed/app/modules/home_module/home_controller.dart';
import 'package:famooshed/app/modules/widgets/banner.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:super_banners/super_banners.dart';

import '../../theme/size_config.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // key: controller.scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/appbar_bg.png",
                    ))),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextField(
                        onTap: () {
                          controller.reDirectSearch();
                        },
                        readOnly: true,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.white,
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(AppIcons.search),
                          ),
                          hintText: "Search Product",
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 8.0),
                              borderRadius: BorderRadius.circular(8.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 8.0),
                              borderRadius: BorderRadius.circular(8.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 8.0),
                              borderRadius: BorderRadius.circular(8.0)),
                        )),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 5),
                //   child: IconButton(
                //     icon: const CircleAvatar(
                //         backgroundImage:
                //             AssetImage(AppImages.filter)),
                //     onPressed: () {
                //       Get.toNamed(Routes.FILTER);
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
        body: GetBuilder<HomeController>(
          builder: (homeController) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // CachedNetworkImage(
                      //     imageUrl:
                      //         "${Constants.imgUrl}/${homeController.banner1[2].image}"),
                      // controller.isLoading.value
                      //     ? const CircularProgressIndicator(
                      //         color: Colors.transparent)
                      //     :
                      homeController.bannerList.isNotEmpty
                          ? IBanner(
                              homeController.bannerList,
                              width: Get.width * 0.95,
                              height: Get.width * .5,
                              colorActivy: AppColors.appTheme,
                              colorProgressBar: AppColors.appTheme,
                              radius: 8,
                              style: beVietnamProMedium,
                              seconds: 4,
                            )
                          : SizedBox(),
                      byCategory(),
                      spotlightMerchants(),
                      controller.popularMerchantsMain.isNotEmpty
                          ? SizedBox(
                              height: getProportionateScreenHeight(340),
                              child: popularMerchantsMain(),
                            )
                          : SizedBox(),
                      controller.newToFamooshed.isNotEmpty
                          ? SizedBox(
                              height: getProportionateScreenHeight(340),
                              child: newToFamooshed(),
                            )
                          : SizedBox(),
                      controller.offerNearYou.isNotEmpty
                          ? SizedBox(
                              height: getProportionateScreenHeight(340),
                              child: offerNearYou(),
                            )
                          : SizedBox(),
                      controller.spotlight.isNotEmpty
                          ? SizedBox(
                              height: getProportionateScreenHeight(340),
                              child: mostFavoriteMarkets(),
                            )
                          : SizedBox(),
                      controller.highestRatedMarkets.isNotEmpty
                          ? SizedBox(
                              height: getProportionateScreenHeight(340),
                              child: highestRatedMarkets(),
                            )
                          : SizedBox(),
                      // const SizedBox(height: 20),
                      // spotlightMerchants(),
                      // // const SizedBox(height: 20),
                      // // controller.isLoading.value
                      // //     ? const CircularProgressIndicator(
                      // //         color: Colors.transparent)
                      // //     :
                      homeController.bannerList2.isNotEmpty
                          ? IBanner(
                              homeController.bannerList2,
                              width: Get.width * 0.95,
                              height: Get.width * .5,
                              colorActivy: AppColors.appTheme,
                              colorProgressBar: AppColors.appTheme,
                              radius: 8,
                              style: beVietnamProMedium,
                              seconds: 4,
                            )
                          : SizedBox(),
                      const SizedBox(height: 90),
                      // Expanded(child: spotlightMerchants())
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }

  spotlightMerchants() {
    return controller.popularMerchants.isNotEmpty
        ? Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              headingSectionWithViewAll(
                  "Featured Merchants", controller.popularMerchants),
              const SizedBox(height: 15),
              controller.popularMerchants.isNotEmpty
                  ? SizedBox(
                      height: getProportionateScreenHeight(220),
                      child: ListView.builder(
                        itemCount: controller.popularMerchants.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return spotlightItem(
                              controller.popularMerchants[index]);
                        },
                      ),
                    )
                  : SizedBox()
            ],
          )
        : SizedBox();
  }

  spotlightItem(ExclusiveonFamooshed item) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.MERCHANTS, arguments: item);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: SizeConfig.deviceWidth! * .75,
            height: getProportionateScreenHeight(220),
            decoration: item.image != null
                ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(Constants.imgUrl + item.image!),
                      fit: BoxFit.cover,
                    ),
                  )
                : BoxDecoration(),
            child: Stack(
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(
                                    color: AppColors.white,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                                  Text(
                                    '${item.rate ?? 0}',
                                    style: urbanistBold.copyWith(
                                        fontSize: 14,
                                        color: AppColors.appTheme),
                                  ),
                                  Image.asset(AppImages.star),
                                  item.numberOfRating != null
                                      ? Text(
                                          '(${item.numberOfRating})',
                                          style: urbanistBold.copyWith(
                                              fontSize: 14,
                                              color: AppColors.appTheme
                                                  .withOpacity(.25)),
                                        )
                                      : const SizedBox(),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                AppColors.black.withOpacity(.04),
                                AppColors.black,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.1, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: ListTile(
                          horizontalTitleGap: 10,
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(Constants.imgUrl + item.image!),
                          ),
                          title: Text(
                            item.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: beVietnamProaBold.copyWith(
                                color: AppColors.white, fontSize: 20),
                          ),
                          subtitle: Text(
                              Utils.calcuDistance(item.lat ?? 0.toString(),
                                      item.lng ?? 0.toString()) +
                                  " Miles",
                              style: urbanistSemiBold.copyWith(
                                  color: AppColors.white, fontSize: 14)),
                        ),
                      )
                    ]),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CornerBanner(
                    bannerPosition: CornerBannerPosition.bottomRight,
                    bannerColor: HexColor("#E0FF86"),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("10% Off"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  offerNearYou() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: getProportionateScreenHeight(15)),
        headingSectionWithViewAll("Offers Near You", controller.offerNearYou),
        SizedBox(height: getProportionateScreenHeight(10)),
        Expanded(
          child: controller.offerNearYou.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.offerNearYou.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return listItemCard(controller.offerNearYou[index], false);
                  },
                )
              : SizedBox(),
        )
      ],
    );
  }

  mostFavoriteMarkets() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: getProportionateScreenHeight(15)),
        headingSectionWithViewAll(
            "Most Favourited Markets", controller.spotlight),
        SizedBox(height: getProportionateScreenHeight(10)),
        Expanded(
          child: controller.spotlight.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.spotlight.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return listItemCard(controller.spotlight[index], false);
                  },
                )
              : SizedBox(),
        )
      ],
    );
  }

  highestRatedMarkets() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: getProportionateScreenHeight(15)),
        headingSectionWithViewAll(
            "Highest Rated Markets", controller.highestRatedMarkets),
        SizedBox(height: getProportionateScreenHeight(10)),
        Expanded(
          child: controller.highestRatedMarkets.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.highestRatedMarkets.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return listItemCard(
                        controller.highestRatedMarkets[index], false);
                  },
                )
              : SizedBox(),
        )
      ],
    );
  }

  Widget byCategory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingSection(),
        const SizedBox(
          height: 10,
        ),
        horizontalListViewCategory()
      ],
    );
  }

  Widget featuredMerchants() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        headingSectionWithViewAll(
            "Featured Merchants", controller.popularMerchants),
        const SizedBox(height: 15),
        Expanded(
          child: controller.popularMerchants.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.popularMerchants.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return listItemCard(
                        controller.popularMerchants[index], true);
                  },
                )
              : SizedBox(),
        )
      ],
    );
  }

  Widget popularMerchantsMain() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        headingSectionWithViewAll(
            "Popular Merchants", controller.popularMerchantsMain),
        const SizedBox(height: 15),
        Expanded(
          child: controller.popularMerchantsMain.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.popularMerchantsMain.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return listItemCard(
                        controller.popularMerchantsMain[index], true);
                  },
                )
              : SizedBox(),
        )
      ],
    );
  }

  Widget newToFamooshed() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        headingSectionWithViewAll(
            "New To Famooshed", controller.newToFamooshed),
        const SizedBox(height: 15),
        Expanded(
          child: controller.newToFamooshed.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.newToFamooshed.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return listItemCard(controller.newToFamooshed[index], true);
                  },
                )
              : SizedBox(),
        )
      ],
    );
  }

  listItemCard(ExclusiveonFamooshed item, isPopular) {
    return Card(
      color: AppColors.white,
      child: SizedBox(
        width: Get.width * .65,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.MERCHANTS, arguments: item);
                },
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                          height: getProportionateScreenHeight(190),
                          fit: BoxFit.cover,
                          imageUrl: Constants.imgUrl + item.image!),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                    item.name ?? '-'.capitalize.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: beVietnamProaBold.copyWith(
                                        color: AppColors.appTheme,
                                        fontSize: 16)),
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(
                                    Constants.imgUrl + item.image!),
                              )
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          // Row(
                          //   children: [
                          //     Row(
                          //       children: [
                          //         Iconify(
                          //           Carbon.delivery_parcel,
                          //           color: AppColors.doveGray,
                          //           size: 16,
                          //         ),
                          //         const SizedBox(width: 3),
                          //         Text(
                          //           "free delivery".capitalize!,
                          //           style: urbanistSemiBold.copyWith(
                          //               color: AppColors.doveGray,
                          //               fontSize: 12),
                          //         ),
                          //       ],
                          //     ),
                          //     const SizedBox(width: 8),
                          //     Row(
                          //       children: [
                          //         Iconify(
                          //           Ic.round_access_time,
                          //           color: AppColors.doveGray,
                          //           size: 16,
                          //         ),
                          //         const SizedBox(
                          //           width: 3,
                          //         ),
                          //         Text(
                          //           "10-15 mins",
                          //           style: urbanistSemiBold.copyWith(
                          //               color: AppColors.doveGray,
                          //               fontSize: 12),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    const Iconify(
                                      size: 16,
                                      Uil.map_marker,
                                      color: AppColors.doveGray,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "${item.businessAddress}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: urbanistSemiBold.copyWith(
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColors.doveGray,
                                            fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Row(
                                  children: [
                                    const Iconify(
                                      size: 16,
                                      Uil.location_arrow,
                                      color: AppColors.doveGray,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "${Utils.calcuDistance(item.lat ?? 0.toString(), item.lng ?? 0.toString()) + " Miles"}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: urbanistSemiBold.copyWith(
                                            color: AppColors.doveGray,
                                            fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                            color: AppColors.white,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Text(
                            "${item.rate ?? 0}",
                            style: urbanistBold.copyWith(
                                fontSize: 14, color: AppColors.appTheme),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Image.asset(AppImages.star),
                          item.numberOfRating != null
                              ? Text(
                                  "(${item.numberOfRating.toString()})",
                                  style: urbanistBold.copyWith(
                                      fontSize: 14,
                                      color:
                                          AppColors.appTheme.withOpacity(.5)),
                                )
                              : const SizedBox(),
                        ]),
                      ),
                    ),
                    item.favStatus != null && item.favStatus == 'true'
                        ? InkWell(
                            onTap: () {
                              print("onTAp FALSE");

                              FavoriteController()
                                  .deleteFavProducts(item.id.toString(), false);

                              if (isPopular) {
                                controller.popularMerchants.forEach((element) {
                                  if (element.id == item.id) {
                                    element.favStatus = 'false';
                                  }
                                });
                              } else {
                                controller.offerNearYou.forEach((element) {
                                  if (element.id == item.id) {
                                    element.favStatus = 'false';
                                  }
                                });
                              }
                              controller.update();
                            },
                            child: Container(
                              child: CircleAvatar(
                                  backgroundColor: AppColors.white,
                                  child: Icon(
                                    Icons.favorite,
                                    color: AppColors.appTheme,
                                    size: 22,
                                  )),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              print("onTAp TRUE");

                              FavoriteController()
                                  .addFavProducts(item.id.toString());

                              if (isPopular) {
                                controller.popularMerchants.forEach((element) {
                                  if (element.id == item.id) {
                                    element.favStatus = 'true';
                                  }
                                });
                              } else {
                                controller.offerNearYou.forEach((element) {
                                  if (element.id == item.id) {
                                    element.favStatus = 'true';
                                  }
                                });
                              }

                              controller.update();
                            },
                            child: Container(
                              child: CircleAvatar(
                                  backgroundColor: AppColors.white,
                                  child: SvgPicture.asset(AppIcons.heart)),
                            ),
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  headingSectionWithViewAll(String title, List<ExclusiveonFamooshed> data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: beVietnamProaBold24.copyWith(color: AppColors.appTheme),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.reDirectToViewAll(data);
          },
          child: Row(
            children: [
              Text("View All",
                  style: urbanistBold.copyWith(
                      fontSize: 16, color: AppColors.viewAllText)),
              Image.asset(AppImages.arroeRight)
            ],
          ),
        )
      ],
    );
  }

  headingSection() {
    return Text(
      "Find Merchants By Category",
      style: beVietnamProSemiBold.copyWith(
          color: AppColors.appTheme, fontSize: 18),
    );
  }

  horizontalListViewCategory() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: getProportionateScreenHeight(100),
        width: SizeConfig.deviceWidth,
        child: controller.category.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: controller.category.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: getProportionateScreenWidth(90),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.FIND_BY_CATEGORY,
                            arguments: controller.category[index].id);
                      },
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                "${Constants.imgUrl}/${controller.category[index].image}",
                            width: getProportionateScreenWidth(60),
                            height: getProportionateScreenHeight(60),
                            fit: BoxFit.fitWidth,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: imageProvider)),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black12,
                                  ),
                                  child: Icon(Icons.error));
                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(controller.category[index].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: beVietnamProSemiBold.copyWith(
                                      fontSize: getProportionalFontSize(14),
                                      color: AppColors.appTheme)),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            : SizedBox(),
      ),
    );
  }
}
