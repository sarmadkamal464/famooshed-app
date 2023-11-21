import 'package:famooshed/app/common/values/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/util/exports.dart';
import '../../theme/app_text_theme.dart';

class NoItemFound extends StatelessWidget {
  const NoItemFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
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
      ],
    );
  }
}
