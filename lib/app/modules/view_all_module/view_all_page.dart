import 'package:cached_network_image/cached_network_image.dart';
import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/data/models/get_home_response.dart';
import 'package:famooshed/app/modules/view_all_module/view_all_controller.dart';
import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';

import '../../common/util/exports.dart';
import '../../theme/size_config.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class ViewAllPage extends GetView<ViewAllController> {
  const ViewAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
          backgroundColor: AppColors.white,
          statusBarColor: AppColors.white,
          centerTitle: true,
          title: 'ViewAll'),
      body: GetBuilder(
        builder: (ViewAllController viewAllController) {
          return SingleChildScrollView(
            child: Column(
              children: [popularMerchants(viewAllController)],
            ),
          );
        },
      ),
    );
  }

  Widget popularMerchants(ViewAllController viewAllController) {
    return SingleChildScrollView(
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(8),
              vertical: getProportionateScreenHeight(10)),
          // scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: getProportionateScreenWidth(190) /
                  getProportionateScreenHeight(260),
              crossAxisSpacing: 8,
              mainAxisSpacing: 20,
              crossAxisCount: 2),
          itemCount: viewAllController.popularMerchants.length,
          itemBuilder: (BuildContext ctx, index) {
            return listItemCard(viewAllController.popularMerchants[index]);
          }),
    );
  }

  // listItemCard(ExclusiveonFamooshed item) {
  //   return GestureDetector(
  //     onTap: () {
  //       Get.toNamed(Routes.MERCHANTS, arguments: item);
  //     },
  //     child: Card(
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 8),
  //         child: Stack(
  //           children: [
  //             Column(children: [
  //               ClipRRect(
  //                 borderRadius: BorderRadius.circular(8.0),
  //                 child: CachedNetworkImage(
  //                   height: 150,
  //                   fit: BoxFit.cover,
  //                   imageUrl: Constants.imgUrl + item.image,
  //                 ),
  //               ),
  //               // ClipRRect(
  //               //   borderRadius: BorderRadius.circular(8.0),
  //               //   child: CachedNetworkImage(
  //               //       height: 220,
  //               //       fit: BoxFit.cover,
  //               //       imageUrl:  AssetImage(AppImages.dummyFood)),
  //               // ),
  //               const SizedBox(height: 10),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 10),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(item.name.capitalize.toString(),
  //                         style: beVietnamProaBold.copyWith(
  //                             color: AppColors.appTheme, fontSize: 16)),
  //                     CircleAvatar(
  //                       radius: 15,
  //                       backgroundImage:
  //                           NetworkImage(Constants.imgUrl + item.image),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                     horizontal: 8.0, vertical: 5.0),
  //                 child: Row(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         const Iconify(
  //                           Carbon.delivery_parcel,
  //                           color: AppColors.doveGray,
  //                           size: 16,
  //                         ),
  //                         const SizedBox(width: 3),
  //                         Text(
  //                           "free delivery".capitalize!,
  //                           style: urbanistSemiBold.copyWith(
  //                               color: AppColors.doveGray, fontSize: 12),
  //                         ),
  //                       ],
  //                     ),
  //                     const SizedBox(width: 8),
  //                     Row(
  //                       children: [
  //                         const Iconify(
  //                           Ic.round_access_time,
  //                           color: AppColors.doveGray,
  //                           size: 16,
  //                         ),
  //                         const SizedBox(
  //                           width: 3,
  //                         ),
  //                         Text(
  //                           "10-15 mins",
  //                           style: urbanistSemiBold.copyWith(
  //                               color: AppColors.doveGray, fontSize: 12),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(height: 10),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                 child: Row(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         const Iconify(
  //                           size: 16,
  //                           Uil.map_marker,
  //                           color: AppColors.doveGray,
  //                         ),
  //                         const SizedBox(
  //                           width: 5,
  //                         ),
  //                         Text(
  //                           "Farmland",
  //                           style: urbanistSemiBold.copyWith(
  //                               color: AppColors.doveGray, fontSize: 12),
  //                         )
  //                       ],
  //                     ),
  //                     const SizedBox(width: 8),
  //                     Row(
  //                       children: [
  //                         const Iconify(
  //                           size: 16,
  //                           Uil.shopping_basket,
  //                           color: AppColors.doveGray,
  //                         ),
  //                         const SizedBox(
  //                           width: 5,
  //                         ),
  //                         Text(
  //                           "250 items",
  //                           style: urbanistSemiBold.copyWith(
  //                               color: AppColors.doveGray, fontSize: 12),
  //                         )
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               )
  //             ]),
  //             GestureDetector(
  //               onTap: () {},
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 8.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Container(
  //                       height: 25,
  //                       width: 74,
  //                       decoration: BoxDecoration(
  //                           color: AppColors.white,
  //                           border: Border.all(
  //                             color: AppColors.white,
  //                           ),
  //                           borderRadius:
  //                               const BorderRadius.all(Radius.circular(20))),
  //                       child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             const Text('4.5'),
  //                             Image.asset(AppImages.star),
  //                             const Text('(25)'),
  //                           ]),
  //                     ),
  //                     IconButton(
  //                       icon: CircleAvatar(
  //                           backgroundColor: AppColors.white,
  //                           child: SvgPicture.asset(AppIcons.heart)),
  //                       onPressed: () {},
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  listItemCard(ExclusiveonFamooshed item) {
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
                        Text(item.name!.capitalize.toString(),
                            style: beVietnamProaBold.copyWith(
                                color: AppColors.appTheme, fontSize: 16)),
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
                          "${item.lat != null && item.lat!.isNotEmpty && item.lat != null && item.lng!.isNotEmpty ? Utils.calcuDistance(item.lat!, item.lng!) + " Miles" : '-'}",
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
            ],
          ),
        ),
      ),
    );
  }
}
