// ignore_for_file: unused_import

import 'dart:ui';

import 'package:badges/badges.dart' as badges;
import 'package:famooshed/app/common/values/app_icons.dart';
import 'package:famooshed/app/common/values/app_logo.dart';
import 'package:famooshed/app/modules/about_us_module/about_controller.dart';
import 'package:famooshed/app/modules/cart_module/cart_page.dart';
import 'package:famooshed/app/modules/dashboard_module/dashboard_controller.dart';
import 'package:famooshed/app/modules/document_module/document_controller.dart';
import 'package:famooshed/app/modules/home_module/home_controller.dart';
import 'package:famooshed/app/modules/home_module/home_page.dart';
import 'package:famooshed/app/modules/my_profile_module/my_profile_controller.dart';
import 'package:famooshed/app/modules/my_profile_module/my_profile_page.dart';
import 'package:famooshed/app/modules/notification_module/notification_controller.dart';
import 'package:famooshed/app/modules/notification_module/notification_page.dart';
import 'package:famooshed/app/modules/orders_module/orders_controller.dart';
import 'package:famooshed/app/modules/orders_module/orders_page.dart';
import 'package:famooshed/app/modules/verify_module/verify_controller.dart';
import 'package:famooshed/app/modules/widgets/custom_bottom_bar/gbutton.dart';
import 'package:famooshed/app/modules/widgets/custom_bottom_bar/gnav.dart';
import 'package:famooshed/app/modules/widgets/custom_default_button.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/util/exports.dart';
import '../../theme/size_config.dart';
import '../verify_module/verify_page.dart';
import '../widgets/custom_appbar_widget.dart';

/// GetX Template Generator - fb.com/htngu.99

class AboutUsPage extends GetView<AboutUsController> {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutUsController>(
      builder: (AboutUsController documentController) {
        return Scaffold(
          appBar: CustomAppbarWidget(
              centerTitle: true,
              backgroundColor: AppColors.white,
              statusBarColor: AppColors.white,
              // backgroundColor: AppColors.white,
              title: "About Us"),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Html(data: documentController.aboutText),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
