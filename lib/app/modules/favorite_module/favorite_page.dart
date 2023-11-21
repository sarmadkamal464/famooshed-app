import 'package:cached_network_image/cached_network_image.dart';
import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/data/models/favorites_model.dart';
import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';

import '../../common/constants.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/size_config.dart';
import 'favorite_controller.dart';

class FavoritePage extends GetView<FavoriteController> {
  FavoritePage({super.key});
  @override
  Widget build(BuildContext context) {
    // controller.getFavProducts();

    return Scaffold(
      appBar: CustomAppbarWidget(
        centerTitle: true,
        title: "Favourites",
        backgroundColor: AppColors.white,
        statusBarColor: AppColors.white,
      ),
      body: GetBuilder<FavoriteController>(
        // init: FavoriteController(),
        builder: (FavoriteController favoriteController) {
          return popularMerchants(favoriteController);
        },
      ),
    );
  }

  Widget popularMerchants(FavoriteController favoriteController) {
    return SingleChildScrollView(
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(8),
              vertical: getProportionateScreenHeight(10)),
          // scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: getProportionateScreenWidth(190) /
                  getProportionateScreenHeight(280),
              crossAxisSpacing: 8,
              mainAxisSpacing: 20,
              crossAxisCount: 2),
          itemCount: favoriteController.favList.length,
          itemBuilder: (BuildContext ctx, index) {
            FavoritesModel data = favoriteController.favList[index];
            return favoriteController.favList[index].restaurant != null
                ? listItemCard(index, data.restaurant!)
                : SizedBox();
          }),
    );
  }

  listItemCard(index, Restaurant item) {
    return GestureDetector(
      onTap: () {
        // controller.goToMerchant(item);

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
                      fit: BoxFit.cover,
                      imageUrl: Constants.imgUrl + item.image.toString()),
                ),
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
                        Flexible(
                          child: Text(item.name!.capitalize.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: beVietnamProaBold.copyWith(
                                  color: AppColors.appTheme, fontSize: 16)),
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(
                              Constants.imgUrl + item.image.toString()),
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
                                item.businessAddress ?? '-',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: urbanistSemiBold.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                    color: AppColors.doveGray,
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: getProportionateScreenWidth(5)),
                      Expanded(
                        child: Text(
                          "${item.lat != null && item.lng != null ? Utils.calcuDistance(item.lat!, item.lng!) + " Miles" : '-'}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: urbanistSemiBold.copyWith(
                              color: AppColors.doveGray, fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Container(
                    //   height: 25,
                    //   width: 74,
                    //   decoration: BoxDecoration(
                    //       color: AppColors.white,
                    //       border: Border.all(
                    //         color: AppColors.white,
                    //       ),
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(20))),
                    //   // child: Row(
                    //   //     mainAxisAlignment: MainAxisAlignment.center,
                    //   //     children: [
                    //   //       const Text('4.5'),
                    //   //       Image.asset(AppImages.star),
                    //   //       const Text('(25)'),
                    //   //     ]),
                    // ),
                    GestureDetector(
                      onTap: () {
                        print("onTAp");
                        controller.deleteFavProducts(item.id.toString(), true);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5, top: 5),
                        // icon: CircleAvatar(
                        //     backgroundColor: AppColors.white,
                        //     child: SvgPicture.asset(AppIcons.heart)),
                        child: CircleAvatar(
                            backgroundColor: AppColors.white,
                            child: Icon(
                              Icons.favorite,
                              color: AppColors.appTheme,
                              size: 22,
                            )),
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
}
