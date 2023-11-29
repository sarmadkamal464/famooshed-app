// ignore_for_file: unused_import

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/common/values/app_icons.dart';
import 'package:famooshed/app/data/models/variant_model.dart';
import 'package:famooshed/app/modules/signle_item_module/signle_item_controller.dart';
import 'package:famooshed/app/modules/signle_item_module/single_product_variant_detail_page.dart';
import 'package:famooshed/app/modules/widgets/custom_back_button.dart';
import 'package:famooshed/app/modules/widgets/custom_default_button.dart';
import 'package:famooshed/app/modules/widgets/no_item_found.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:famooshed/app/utils/dprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/uil.dart';

import '../../theme/size_config.dart';
import '../merchants_module/merchants_controller.dart';
import '../widgets/custom_rect_button.dart';
import 'package:flutter_html/flutter_html.dart';

class VariantDetailPage extends GetView<SignleItemController> {
  const VariantDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignleItemController>(
        builder: (SignleItemController signleItemController) {
      return signleItemController.isLoading.value
          ? const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            )
          : SafeArea(
              top: false,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: Container(
                  decoration: const BoxDecoration(color: AppColors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container(
                        //   height: 48,
                        //   width: 90,
                        //   decoration: BoxDecoration(
                        //       color: AppColors.blueColorLight,
                        //       borderRadius: BorderRadius.circular(5.0)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       GestureDetector(
                        //           onTap: () {
                        //             signleItemController.decrement();
                        //           },
                        //           child: const Icon(Icons.remove)),
                        //       const SizedBox(width: 10.0),
                        //       Text('${controller.counter.value}'),
                        //       const SizedBox(width: 10.0),
                        //       GestureDetector(
                        //           onTap: () {
                        //             signleItemController.increment();
                        //           },
                        //           child: const Icon(Icons.add)),
                        //     ],
                        //   ),
                        // ),
                        // const Spacer(),
                      ],
                    ),
                  ),
                ),
                body: DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              // child: Text(
                              //     signleItemController
                              //         .getVariantsDetailsResponse!.foods[0].name,
                              //     maxLines: 3,
                              //     overflow: TextOverflow.clip,
                              //     style: beVietnamProaBold.copyWith(
                              //         fontSize: 24, color: AppColors.black)),
                            ),
                            expandedHeight: 300.0,
                            floating: false,
                            pinned: true,
                            leading: const CustomBackButton(
                              leading: Icon(
                                Icons.arrow_back,
                                color: AppColors.black,
                              ),
                            ),
                            elevation: 0.0,
                            backgroundColor: AppColors.white,
                            systemOverlayStyle: const SystemUiOverlayStyle(
                              statusBarColor: AppColors.white,
                              statusBarIconBrightness: Brightness.dark,
                              statusBarBrightness: Brightness.light,
                            ),
                            flexibleSpace: FlexibleSpaceBar(
                              centerTitle: true,
                              background: Image.network(
                                Constants.imgUrl +
                                    (signleItemController
                                            .getVariantsDetailsResponse!
                                            .variantImage ??
                                        ''),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          // SliverPersistentHeader(
                          //   delegate:
                          // _SliverAppBarDelegate(

                          // TabBar(
                          //   indicatorColor: AppColors.appTheme,
                          //   // indicator: const BoxDecoration(color: Colors.blue),
                          //   // indicator: const UnderlineTabIndicator(
                          //   //   borderSide: BorderSide(color: Color(0xDD613896), width: 8.0),
                          //   //   insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                          //   // ),
                          //
                          //   labelColor: AppColors.appTheme,
                          //
                          //   unselectedLabelColor: AppColors.appTheme,
                          //   labelStyle: beVietnamProSemiBold.copyWith(
                          //       fontSize: getProportionalFontSize(16),
                          //       color: AppColors.appTheme),
                          //   tabs: [
                          //     Tab(
                          //       text: "general description".capitalize,
                          //     ),
                          //     Tab(text: "nutritional information".capitalize),
                          //   ],
                          // ),
                          // ),
                          //   pinned: true,
                          // ),
                        ];
                      },
                      body: generalDescription(signleItemController)
                      // TabBarView(
                      //   // controller: _tabController,
                      //
                      //   children: [
                      //     generalDescription(signleItemController),
                      //     Container(
                      //       child: signleItemController.getVariantsDetailsResponse!
                      //                   .foods[0].ingredients ==
                      //               ""
                      //           ? const NoItemFound()
                      //           : Column(
                      //               children: [
                      //                 Row(
                      //                   children: [
                      //                     SvgPicture.asset(AppIcons.arrow),
                      //                     const Text("1 item = 1.4 Kg")
                      //                   ],
                      //                 ),
                      //                 Row(
                      //                   children: [
                      //                     SvgPicture.asset(AppIcons.arrow),
                      //                     const Text("Fresh & Green")
                      //                   ],
                      //                 ),
                      //                 const Divider(thickness: 1),
                      //               ],
                      //             ),
                      //     ),
                      //   ],
                      // ),
                      ),
                ),
              ),
            );
    });
  }

  propertiesSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
        SizedBox(
          width: getProportionateScreenWidth(10),
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
        SizedBox(
          width: getProportionateScreenWidth(10),
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
    );
  }

  Widget generalDescription(SignleItemController signleItemController) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              signleItemController.getVariantsDetailsResponse!.variant!.name ??
                  '',
              maxLines: 3,
              overflow: TextOverflow.clip,
              style: beVietnamProaBold.copyWith(
                  fontSize: getProportionalFontSize(22),
                  color: AppColors.appTheme)),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          if (signleItemController.getVariantsDetailsResponse!.variantImage !=
              null)
            Image.network(
              Constants.imgUrl +
                  signleItemController
                      .getVariantsDetailsResponse!.variantImage!,
              fit: BoxFit.fitHeight,
            ),
        ],
      ),
    );
  }

//   Widget reviewPage(SignleItemController signleItemController) {
//     return ListView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: signleItemController.foodsReview.length >= 5
//           ? 3
//           : signleItemController.foodsReview.length,
//       padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
//       shrinkWrap: true,
//       itemBuilder: (BuildContext context, int index) {
//         // var data = signleItemController.foodsreview[index];
//         var data = signleItemController.foodsReview[index];
//         return reviewItem(index, signleItemController, data);
//       },
//     );
//   }

//   reviewItem(index, SignleItemController signleItemController,
//       Foodsreview foodsreview) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: ShapeDecoration(
//           color: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           shadows: [
//             BoxShadow(
//               color: Color(0x19204F33),
//               blurRadius: 20,
//               offset: Offset(0, 4),
//               spreadRadius: 0,
//             )
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ListTile(
//               leading: CircleAvatar(
//                 radius: 20,
//                 backgroundImage:
//                     NetworkImage(Constants.imgUrl + foodsreview.image),
//               ),
//               title: Text(
//                 foodsreview.userName.toString(),
//                 style: beVietnamProSemiBold.copyWith(
//                     color: AppColors.appTheme,
//                     fontSize: getProportionalFontSize(14)),
//               ),
//               subtitle: Text(
//                 'Ordered Items: 150',
//                 style: urbanistSemiBold.copyWith(
//                     color: HexColor('#9D9D9D'),
//                     fontSize: getProportionalFontSize(14)),
//               ),
//               trailing: Row(mainAxisSize: MainAxisSize.min, children: [
//                 Text(
//                   foodsreview.rate,
//                   style: urbanistBold.copyWith(
//                       color: AppColors.appTheme,
//                       fontSize: getProportionalFontSize(12)),
//                 ),
//                 const SizedBox(
//                   width: 5,
//                 ),
//                 Image.asset(AppImages.star)
//               ]),
//             ),
//             foodsreview.desc.isNotEmpty
//                 ? Padding(
//                     padding: EdgeInsets.only(
//                         left: getProportionateScreenWidth(20),
//                         bottom: getProportionateScreenHeight(10),
//                         right: getProportionateScreenWidth(20)),
//                     child: Text(
//                       foodsreview.desc,
//                       style: urbanistRegular.copyWith(
//                         color: Color(0xFF204F33),
//                         letterSpacing: .2,
//                         wordSpacing: .5,
//                         fontSize: getProportionalFontSize(12),
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   )
//                 : SizedBox()
//           ],
//         ),
//       ),
//     );
//   }

//   Widget popularMerchants() {
//     return GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         // scrollDirection: Axis.vertical,
//         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 200,
//             childAspectRatio: 1.6 / 2.6,
//             mainAxisSpacing: 20),
//         itemCount: controller.similarPrductList.length,
//         itemBuilder: (BuildContext ctx, index) {
//           var data = controller.similarPrductList[index];
//           return productItem(data);
//         });
//   }

//   // productItem(SimilarFood data) {
//     return GestureDetector(
//       onTap: () {
//         controller.getFoodDetailById(id: data.id.toString());
//       },
//       child: Container(
//         decoration: ShapeDecoration(
//           shape: RoundedRectangleBorder(
//             side: BorderSide(
//               width: 0.50,
//               strokeAlign: BorderSide.strokeAlignCenter,
//               color: Color(0xFFE9EDEB),
//             ),
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: getProportionateScreenWidth(160),
//                 height: getProportionateScreenHeight(150),
//                 decoration: ShapeDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(Constants.imgUrl + data.image),
//                     fit: BoxFit.fill,
//                   ),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8)),
//                 ),
//               ),
//               // ClipRRect(
//               //     borderRadius: BorderRadius.circular(12.0),
//               //     child: SizedBox(
//               //       child: CachedNetworkImage(
//               //           imageUrl:
//               //               Constants.imgUrl + controller.foodList[index].image),
//               //     )),
//               Text(
//                 data.name,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: beVietnamProSemiBold.copyWith(
//                   color: AppColors.appTheme,
//                   fontSize: getProportionalFontSize(16),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Remaining (200)',
//                     style: urbanistSemiBold.copyWith(
//                         color: HexColor('#9D9D9D'),
//                         fontSize: getProportionalFontSize(13)),
//                   ),
//                   Row(
//                     children: [
//                       Text(data.stars.toString()),
//                       Image.asset(AppImages.star)
//                     ],
//                   )
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: getProportionateScreenHeight(8)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       "£${double.parse(data.price).toInt().toString()}",
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: beVietnamProSemiBold.copyWith(
//                           fontSize: getProportionalFontSize(18),
//                           color: AppColors.appThemeText),
//                     ),
//                     // DefaultRectButton(
//                     //     buttonColor: AppColors.appTheme,
//                     //     textColor: AppColors.white,
//                     //     height: 35,
//                     //     text: "Add to Cart",
//                     //     width: Get.width * .25,
//                     //     onTap: () {
//                     //       // controller.addToCart(index);
//                     //       Get.bottomSheet(GetBuilder(
//                     //         builder: (MerchantsController controller) {
//                     //           return Container(
//                     //             decoration:
//                     //                 const BoxDecoration(color: AppColors.white),
//                     //             child: Padding(
//                     //               padding: const EdgeInsets.only(
//                     //                   left: 20.0, right: 20.0, top: 10.0),
//                     //               child: Row(
//                     //                 children: [
//                     //                   Container(
//                     //                     height: 48,
//                     //                     width: 90,
//                     //                     decoration: BoxDecoration(
//                     //                         color: AppColors.blueColorLight,
//                     //                         borderRadius:
//                     //                             BorderRadius.circular(5.0)),
//                     //                     child: Row(
//                     //                       mainAxisAlignment:
//                     //                           MainAxisAlignment.center,
//                     //                       children: [
//                     //                         GestureDetector(
//                     //                             onTap: () {
//                     //                               controller.decrement();
//                     //                             },
//                     //                             child:
//                     //                                 const Icon(Icons.remove)),
//                     //                         const SizedBox(width: 10.0),
//                     //                         Text('${controller.counter.value}'),
//                     //                         const SizedBox(width: 10.0),
//                     //                         GestureDetector(
//                     //                             onTap: () {
//                     //                               controller.increment();
//                     //                             },
//                     //                             child: const Icon(Icons.add)),
//                     //                       ],
//                     //                     ),
//                     //                   ),
//                     //                   const Spacer(),
//                     //                   DefaultRectButton(
//                     //                       buttonColor: AppColors.appTheme,
//                     //                       textColor: AppColors.white,
//                     //                       height: 40,
//                     //                       text: "Add to Cart",
//                     //                       width: Get.width * .3,
//                     //                       onTap: () {
//                     //                         // controller.addToCart(index);
//                     //                         controller.addToCartNew(
//                     //                             controller.foodList[index]);
//                     //                       })
//                     //                 ],
//                     //               ),
//                     //             ),
//                     //           );
//                     //         },
//                     //       ));
//                     //     })
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // listItemCard(SimilarFood data) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6),
//         child: Stack(
//           children: [
//             Column(children: [
//               GestureDetector(
//                 onTap: () {
//                   controller.getFoodDetailById(id: data.id.toString());
//                 },
//                 child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: Image.network(Constants.imgUrl + data.image)),
//               ),
//               // ClipRRect(
//               //   borderRadius: BorderRadius.circular(8.0),
//               //   child: CachedNetworkImage(
//               //       height: 220,
//               //       fit: BoxFit.cover,
//               //       imageUrl:  AssetImage(AppImages.dummyFood)),
//               // ),
//               const SizedBox(height: 10),
//               GestureDetector(
//                 onTap: () {
//                   printInfo(info: "Hello");
//                   // Get.toNamed(Routes.MERCHANTS, arguments: item.id);
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     SizedBox(
//                       width: Get.width * .35,
//                       child: Text(
//                           // controller.restaurByCat[index].name.capitalize
//                           //     .toString(),
//                           data.name.capitalize.toString(),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: beVietnamProaBold.copyWith(
//                               color: AppColors.appTheme, fontSize: 16)),
//                     ),
//                     // const CircleAvatar(
//                     //     backgroundImage: AssetImage(AppImages.dummyFood)),
//                     CircleAvatar(
//                       radius: 15,
//                       backgroundImage:
//                           NetworkImage(Constants.imgUrl + data.image),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
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
//                     const SizedBox(width: 5),
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
//                       width: 50,
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
//                             Text(data.stars.toString()),
//                             Image.asset(AppImages.star),
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
//     );
//   }

// //   Widget addCartButton() {
// //     return GestureDetector(
// //       onTap: () {
// //         // controller.addToCart();
// //         controller.addToCartNew();
// //       },
// //       child: Container(
// //         width: Get.width * .6,
// //         margin:
// //             EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
// //         height: getProportionateScreenHeight(48),
// //         decoration: BoxDecoration(
// //             color: AppColors.appTheme,
// //             borderRadius: BorderRadius.circular(5.0)),
// //         child: Center(
// //           child: Text(
// //             "Add To Cart",
// //             style: urbanistBold.copyWith(fontSize: 18, color: AppColors.white),
// //             textAlign: TextAlign.center,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate(this._tabBar);

//   final TabBar _tabBar;

//   @override
//   double get minExtent => _tabBar.preferredSize.height;
//   @override
//   double get maxExtent => _tabBar.preferredSize.height;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: AppColors.white,
//       child: _tabBar,
//     );
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return false;
//   }
// }
}
