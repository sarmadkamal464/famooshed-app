import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/modules/search_module/search_controller.dart';
import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../theme/size_config.dart';
import '../widgets/custom_rect_button.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class SearchPage extends GetView<SearchFoodController> {
  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.appBarbackground,
        appBar: CustomAppbarWidget(
          title: "Search",
          centerTitle: true,
          bottom: Container(
            decoration: BoxDecoration(color: AppColors.appBarbackground),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: controller.searchController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        onChanged: (v) {
                          if (controller.selectedCategoryList.isNotEmpty) {
                            controller.getSearch(
                              categoryId: controller.selectedCategoryIds
                                  .join(',')
                                  .toString(),
                              price: controller.selectedPrice,
                            );
                          } else {
                            controller.getSearch(
                              price: controller.selectedPrice,
                            );
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.white,
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          prefixIcon: const Icon(Icons.search),
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
                  IconButton(
                    icon: const CircleAvatar(
                        backgroundImage: AssetImage(AppImages.filter)),
                    onPressed: () {
                      Get.toNamed(Routes.FILTER);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: GetBuilder(
          builder: (SearchFoodController searchController) {
            return SingleChildScrollView(
              child: Column(
                children: [product(context)],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget filter() {
    return Obx(() => DropdownButton(
          isExpanded: true,
          hint: Text('Filter',
              style: TextStyle(
                  fontSize: Dimens.fontSize14, color: AppColors.black)),
          items: controller.filterList.map((data) {
            return DropdownMenuItem(
              value: data,
              child: Text(
                data,
              ),
            );
          }).toList(),
          value: controller.filterDropDown.value,
          onChanged: (value) {},
        ));
  }

  product(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
            childAspectRatio: 1.2 / 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 20),
        itemCount: controller.foodList.length,
        itemBuilder: (BuildContext ctx, index) {
          return productItem(index);
        });
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
                height: getProportionateScreenHeight(200),
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        Constants.imgUrl + controller.foodList[index].image),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      controller.foodList[index].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: beVietnamProSemiBold.copyWith(
                        color: AppColors.appTheme,
                        fontSize: getProportionalFontSize(16),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(controller.foodList[index].stars.toString()),
                      Image.asset(AppImages.star)
                    ],
                  )
                ],
              ),
              Center(
                  // padding:
                  //     EdgeInsets.only(top: getProportionateScreenHeight(8)),
                  // child:

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       child: Text(
                  //         "£${double.parse(controller.foodList[index].price).toInt().toString()}",
                  //         maxLines: 1,
                  //         overflow: TextOverflow.ellipsis,
                  //         style: beVietnamProSemiBold.copyWith(
                  //             fontSize: getProportionalFontSize(18),
                  //             color: AppColors.appThemeText),
                  //       ),
                  //     ),
                  //     DefaultRectButton(
                  //         buttonColor: AppColors.appTheme,
                  //         textColor: AppColors.white,
                  //         height: 35,
                  //         text: "Add to Cart",
                  //         width: Get.width * .25,
                  //         onTap: () {
                  //           // controller.addToCart(index);
                  //           Get.bottomSheet(GetBuilder(
                  //             builder: (SearchFoodController controller) {
                  //               return Container(
                  //                 decoration:
                  //                     const BoxDecoration(color: AppColors.white),
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.only(
                  //                       left: 20.0, right: 20.0, top: 10.0),
                  //                   child: Row(
                  //                     children: [
                  //                       Container(
                  //                         height: 48,
                  //                         width: 90,
                  //                         decoration: BoxDecoration(
                  //                             color: AppColors.blueColorLight,
                  //                             borderRadius:
                  //                                 BorderRadius.circular(5.0)),
                  //                         child: Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.center,
                  //                           children: [
                  //                             GestureDetector(
                  //                                 onTap: () {
                  //                                   controller.decrement();
                  //                                 },
                  //                                 child:
                  //                                     const Icon(Icons.remove)),
                  //                             const SizedBox(width: 10.0),
                  //                             Text('${controller.counter.value}'),
                  //                             const SizedBox(width: 10.0),
                  //                             GestureDetector(
                  //                                 onTap: () {
                  //                                   controller.increment();
                  //                                 },
                  //                                 child: const Icon(Icons.add)),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       const Spacer(),
                  //                       DefaultRectButton(
                  //                           buttonColor: AppColors.appTheme,
                  //                           textColor: AppColors.white,
                  //                           height: 40,
                  //                           text: "Add to Cart",
                  //                           width: Get.width * .3,
                  //                           onTap: () {
                  //                             controller.addToCart(index);
                  //                           })
                  //                     ],
                  //                   ),
                  //                 ),
                  //               );
                  //             },
                  //           ));
                  //         })
                  //   ],
                  // ),

                  child: DefaultRectButton(
                      buttonColor: AppColors.appTheme,
                      textColor: AppColors.white,
                      height: 40,
                      text: "View Market",
                      width: Get.width * .5,
                      onTap: () {
                        controller.goToDetailPage(index);
                        // controller.addToCart(index);
                      })),
            ],
          ),
        ),
      ),
    );
    // return GestureDetector(
    //   onTap: () {
    //     controller.goToDetailPage(index);
    //   },
    //   child: Card(
    //     elevation: 3.0,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         ClipRRect(
    //             borderRadius: BorderRadius.circular(12.0),
    //             child: CachedNetworkImage(
    //                 imageUrl:
    //                     Constants.imgUrl + controller.foodList[index].image)),
    //         Text(
    //           controller.foodList[index].name,
    //           style: beVietnamProSemiBold.copyWith(
    //               color: AppColors.appTheme, fontSize: 16),
    //         ),
    //         GestureDetector(
    //           onTap: () {
    //             Get.bottomSheet(GetBuilder(
    //               builder: (SearchFoodController searchController) {
    //                 return Container(
    //                   decoration: const BoxDecoration(color: AppColors.white),
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(
    //                         left: 20.0, right: 20.0, top: 10.0),
    //                     child: Row(
    //                       children: [
    //                         Container(
    //                           height: 48,
    //                           width: 90,
    //                           decoration: BoxDecoration(
    //                               color: AppColors.blueColorLight,
    //                               borderRadius: BorderRadius.circular(5.0)),
    //                           child: Row(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               GestureDetector(
    //                                   onTap: () {
    //                                     searchController.decrement();
    //                                   },
    //                                   child: const Icon(Icons.remove)),
    //                               const SizedBox(width: 10.0),
    //                               Text('${searchController.counter.value}'),
    //                               const SizedBox(width: 10.0),
    //                               GestureDetector(
    //                                   onTap: () {
    //                                     searchController.increment();
    //                                   },
    //                                   child: const Icon(Icons.add)),
    //                             ],
    //                           ),
    //                         ),
    //                         const Spacer(),
    //                         DefaultRectButton(
    //                             buttonColor: AppColors.appTheme,
    //                             textColor: AppColors.white,
    //                             height: 40,
    //                             text: "Add to Cart",
    //                             width: Get.width * .3,
    //                             onTap: () {
    //                               searchController.addToCart(index);
    //                             })
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //               },
    //             ));
    //           },
    //           child: Container(
    //             height: 40,
    //             width: Get.width,
    //             decoration: const BoxDecoration(
    //               color: AppColors.appTheme,
    //               borderRadius: BorderRadius.only(
    //                   bottomRight: Radius.circular(12.0),
    //                   bottomLeft: Radius.circular(12.0)),
    //             ),
    //             child: Center(
    //               child: Text(
    //                 "Add to cart",
    //                 style: urbanistBold.copyWith(
    //                     fontSize: 16, color: AppColors.white),
    //               ),
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
