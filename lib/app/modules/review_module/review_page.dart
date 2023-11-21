import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/data/models/get_food_details_response.dart';
import 'package:famooshed/app/modules/review_module/review_controller.dart';
import 'package:famooshed/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../common/util/exports.dart';
import '../../theme/size_config.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class ReviewPage extends GetView<ReviewController> {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
          title: "Reviews", centerTitle: controller.isCenterTitle.value),
      body: reviewPage(),
    );
  }

  reviewPage() {
    return Obx(() => ListView.builder(
          // physics: const A(),
          itemCount: controller.foodsReview.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            var data = controller.foodsReview[index];
            return reviewItem(data);
          },
        ));
  }

  reviewItem(Foodsreview data) {
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
                backgroundImage: NetworkImage(Constants.imgUrl + data.image),
              ),
              title: Text(
                data.userName.toString(),
                style: beVietnamProSemiBold.copyWith(
                    color: AppColors.appTheme,
                    fontSize: getProportionalFontSize(14)),
              ),
              subtitle: Text(
                'Ordered Items: ${data.food}',
                style: urbanistSemiBold.copyWith(
                    color: HexColor('#9D9D9D'),
                    fontSize: getProportionalFontSize(14)),
              ),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  data.rate,
                  style: urbanistBold.copyWith(
                      color: AppColors.appTheme,
                      fontSize: getProportionalFontSize(12)),
                ),
                const SizedBox(
                  width: 5,
                ),
                Image.asset(AppImages.star)
              ]),
            ),
            data.desc.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(20),
                        bottom: getProportionateScreenHeight(10),
                        right: getProportionateScreenWidth(20)),
                    child: Text(
                      data.desc,
                      style: urbanistRegular.copyWith(
                        color: Color(0xFF204F33),
                        letterSpacing: .2,
                        wordSpacing: .5,
                        fontSize: getProportionalFontSize(12),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Card(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(Constants.imgUrl + data.image),
                ),
                title: Text(
                  data.userName.capitalize.toString(),
                  // controller.reviewList[index].name.toString(),
                  style: beVietnamProSemiBold.copyWith(
                      color: AppColors.appTheme, fontSize: 18),
                ),
                subtitle: Text(
                  'Ordered Items: 150',
                  style: urbanistSemiBold.copyWith(
                      color: HexColor('#9D9D9D'), fontSize: 16),
                ),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    data.rate,
                    style: urbanistBold.copyWith(
                        color: AppColors.appTheme, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(AppImages.star)
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data.desc.capitalize.toString(),
                  style: urbanistRegular.copyWith(
                      fontSize: 16, color: AppColors.appTheme),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
