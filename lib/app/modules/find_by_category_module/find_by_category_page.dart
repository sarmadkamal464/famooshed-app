import 'package:cached_network_image/cached_network_image.dart';
import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/common/values/app_icons.dart';
import 'package:famooshed/app/modules/find_by_category_module/find_by_category_controller.dart';
import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';

import '../../common/util/exports.dart';
import '../../data/models/get_restaurants_by_cat_response.dart';
import '../../theme/size_config.dart';
import '../favorite_module/favorite_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class FindByCategoryPage extends GetView<FindByCategoryController> {
  const FindByCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppbarWidget(
            backgroundColor: AppColors.white,
            statusBarColor: AppColors.white,
            centerTitle: controller.isLoading.value,
            title: "Find By Category"),
        body: GetBuilder(
          builder: (FindByCategoryController findByCategoryController) {
            return Column(
              children: [
                findByCategoryController.categoryy.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: CircleAvatar(
                                  backgroundColor: AppColors.white,
                                  child: Image.network(Constants.imgUrl +
                                      findByCategoryController
                                          .categoryy[0].filename)

                                  // SvgPicture.asset(AppIcons.heart),

                                  ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              findByCategoryController.categoryy[0].name,
                              style: beVietnamProSemiBold.copyWith(
                                color: const Color(0xFF204F33),
                                fontSize: 20,
                                fontFamily: 'Be Vietnam Pro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  ListView.builder(
                                    itemCount:
                                        findByCategoryController.alCat.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var data =
                                          findByCategoryController.alCat[index];
                                      return InkWell(
                                        onTap: () {
                                          findByCategoryController.catId =
                                              data.id;
                                          findByCategoryController.update();
                                          Get.back();
                                          findByCategoryController
                                              .getCategoryDataNew();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  getProportionateScreenWidth(
                                                      16),
                                              vertical:
                                                  getProportionateScreenHeight(
                                                      8)),
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            horizontalTitleGap:
                                                getProportionateScreenWidth(25),
                                            leading: CachedNetworkImage(
                                              imageUrl: Constants.imgUrl +
                                                  data.filename,
                                              width:
                                                  getProportionateScreenWidth(
                                                      48),
                                              height:
                                                  getProportionateScreenHeight(
                                                      48),
                                              fit: BoxFit.fitWidth,
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                              imageProvider)),
                                                );
                                              },
                                              errorWidget:
                                                  (context, url, error) {
                                                return Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.black12,
                                                    ),
                                                    child: Icon(Icons.error));
                                              },
                                            ),
                                            // leading: CircleAvatar(
                                            //   radius: 25,
                                            //   backgroundImage: NetworkImage(
                                            //       Constants.imgUrl +
                                            //           data.image),
                                            // ),
                                            title: Text(data.name),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                );
                              },
                              child: Text(
                                "Change category",
                                style: beVietnamProSemiBold.copyWith(
                                    color: AppColors.appThemeText,
                                    fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
                Divider(
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: AppColors.doveGray.withOpacity(.5),
                ),
                findByCategoryController.categoryData.isEmpty
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
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: popularMerchants(findByCategoryController),
                      )),
              ],
            );
          },
        ));
  }

  Widget popularMerchants(FindByCategoryController findByCategoryController) {
    return SingleChildScrollView(
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          // scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: getProportionateScreenWidth(190) /
                  getProportionateScreenHeight(260),
              crossAxisSpacing: 8,
              mainAxisSpacing: 20,
              crossAxisCount: 2),
          itemCount: findByCategoryController.restaurByCat.length,
          itemBuilder: (BuildContext ctx, index) {
            RestaurantByCat data = findByCategoryController.restaurByCat[index];
            return listItemCard(index, data);
          }),
    );
  }

  listItemCard(index, RestaurantByCat item) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.MERCHANTS, arguments: item);
      },
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
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Stack(
            children: [
              Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                      height: getProportionateScreenHeight(150),
                      fit: BoxFit.fill,
                      imageUrl: controller.restaurByCat[index].image!),
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(8.0),
                //   child: CachedNetworkImage(
                //       height: 220,
                //       fit: BoxFit.cover,
                //       imageUrl:  AssetImage(AppImages.dummyFood)),
                // ),
                SizedBox(height: getProportionateScreenHeight(10)),
                GestureDetector(
                  onTap: () {
                    printInfo(info: "Hello");
                    // Get.toNamed(Routes.MERCHANTS, arguments: item.id);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            controller.restaurByCat[index].name ??
                                '-'.capitalize.toString(),
                            style: beVietnamProaBold.copyWith(
                                color: AppColors.appTheme, fontSize: 16)),
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(
                              controller.restaurByCat[index].image!),
                        )
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: getProportionateScreenWidth(5),
                //       vertical: 5.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Expanded(
                //         child: Row(
                //           children: [
                //             const Iconify(
                //               Carbon.delivery_parcel,
                //               color: Color(0xFF9D9D9D),
                //               size: 16,
                //             ),
                //             const SizedBox(width: 3),
                //             Expanded(
                //               child: Text(
                //                 "free delivery".capitalize!,
                //                 maxLines: 1,
                //                 overflow: TextOverflow.ellipsis,
                //                 style: urbanistSemiBold.copyWith(
                //                     color: const Color(0xFF9D9D9D),
                //                     fontSize: getProportionalFontSize(11)),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       SizedBox(width: getProportionateScreenWidth(5)),
                //       Expanded(
                //         child: Row(
                //           children: [
                //             const Iconify(
                //               Ic.round_access_time,
                //               color: Color(0xFF9D9D9D),
                //               size: 16,
                //             ),
                //             const SizedBox(
                //               width: 3,
                //             ),
                //             Expanded(
                //               child: Text(
                //                 "10-15 mins",
                //                 maxLines: 1,
                //                 overflow: TextOverflow.ellipsis,
                //                 style: urbanistSemiBold.copyWith(
                //                     color: const Color(0xFF9D9D9D),
                //                     fontSize: getProportionalFontSize(11)),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Iconify(
                              Uil.map_marker,
                              color: Color(0xFF9D9D9D),
                              size: 16,
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                "${item.businessAddress}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: urbanistSemiBold.copyWith(
                                    color: AppColors.doveGray, fontSize: 12),
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
                      ),
                      // SizedBox(width: getProportionateScreenWidth(5)),
                      // Expanded(
                      //   child: Row(
                      //     children: [
                      //       const Iconify(
                      //         Uil.shopping_basket,
                      //         color: Color(0xFF9D9D9D),
                      //         size: 16,
                      //       ),
                      //       const SizedBox(
                      //         width: 3,
                      //       ),
                      //       Text(
                      //         "{250 items}",
                      //         maxLines: 1,
                      //         overflow: TextOverflow.ellipsis,
                      //         style: urbanistSemiBold.copyWith(
                      //             color: const Color(0xFF9D9D9D),
                      //             fontSize: getProportionalFontSize(11)),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ]),
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
                          Text('(${item.numberOfRating ?? 0})'),
                        ]),
                      ),
                    ),
                    item.favStatus == 'true'
                        ? InkWell(
                            onTap: () {
                              print("onTAp FALSE");

                              FavoriteController()
                                  .deleteFavProducts(item.id.toString(), false);
                              controller.restaurByCat.forEach((element) {
                                if (element.id == item.id) {
                                  element.favStatus = 'false';
                                }
                              });
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

                              controller.restaurByCat.forEach((element) {
                                if (element.id == item.id) {
                                  element.favStatus = 'true';
                                }
                              });
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
              // GestureDetector(
              //   onTap: () {},
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 8.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Container(
              //           height: 25,
              //           width: 74,
              //           decoration: BoxDecoration(
              //               color: AppColors.white,
              //               border: Border.all(
              //                 color: AppColors.white,
              //               ),
              //               borderRadius:
              //                   const BorderRadius.all(Radius.circular(20))),
              //           child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 const Text('4.5'),
              //                 Image.asset(AppImages.star),
              //                 const Text('(25)'),
              //               ]),
              //         ),
              //         IconButton(
              //           icon: CircleAvatar(
              //               backgroundColor: AppColors.white,
              //               child: SvgPicture.asset(AppIcons.heart)),
              //           onPressed: () {},
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
