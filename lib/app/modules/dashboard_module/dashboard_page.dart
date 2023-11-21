// ignore_for_file: unused_import

import 'dart:ui';

import 'package:badges/badges.dart' as badges;
import 'package:famooshed/app/common/values/app_icons.dart';
import 'package:famooshed/app/common/values/app_logo.dart';
import 'package:famooshed/app/modules/cart_module/cart_page.dart';
import 'package:famooshed/app/modules/dashboard_module/dashboard_controller.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/util/exports.dart';
import '../../theme/size_config.dart';
import '../help_and_support_module/help_and_support_page.dart';
import '../verify_module/verify_page.dart';

/// GetX Template Generator - fb.com/htngu.99

class DashboardPage extends GetView<DashboardController> {
  DashboardPage({super.key});

  GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'scaffoldKey');
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return controller.onWillPop();
      },
      child: GetBuilder<DashboardController>(
        builder: (DashboardController dashboardController) {
          return SafeArea(
              child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: dashboardController.currentIndex.value == 0
                  ? AppColors.appThemeLight
                  : AppColors.white,
            ),
            child: Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                // foregroundColor: AppColors.darkGreenColor,
                flexibleSpace: dashboardController.currentIndex.value == 0
                    ? const Image(
                        image: AssetImage('assets/images/appbar_bg.png'),
                        fit: BoxFit.cover,
                      )
                    : null,
                centerTitle: true,
                backgroundColor: dashboardController.currentIndex.value == 0
                    ? AppColors.appThemeLight
                    : AppColors.white,
                elevation: 0,
                leading: GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppIcons.drawer),
                  ),
                ),
                actions: <Widget>[
                  InkWell(
                      onTap: () async {
                        await Get.toNamed(Routes.CART);

                        dashboardController.getCartNew();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: shoppingCartBadge(),
                      )),
                ],
                title: dashboardController.currentIndex.value == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Text(
                              'Location',
                              style: beVietnamProMedium.copyWith(
                                color: HexColor('#215034').withOpacity(.6),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.screenName = "DASHBOARD";
                                controller.initialLatLong = null;
                                controller.update();
                                Get.toNamed(
                                  Routes.MAP,
                                );
                                // HomeController homeController =
                                //     Get.find<HomeController>();
                                // homeController.getCategoryData();
                                // controller.handlePressButton();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppIcons.location),
                                  Flexible(
                                    child: Text(
                                      '${controller.myLocation}',
                                      // 'Linsted Lane, Headly',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: beVietnamProSemiBold.copyWith(
                                          color: HexColor(
                                            '#215034',
                                          ),
                                          fontSize:
                                              getProportionalFontSize(14)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ])
                    : Text(
                        dashboardController.getAppTitle(),
                        style: beVietnamProaBold24.copyWith(
                            color: AppColors.appTheme),
                      ),
              ),
              drawer: Drawer(
                width: Get.width,
                backgroundColor: AppColors.appTheme.withOpacity(.4),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(
                    width: Get.width * .8,
                    height: Get.height,
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(10),
                        vertical: getProportionateScreenHeight(10)),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/drawerbg.png"),
                            fit: BoxFit.fill)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                AppLogo.appLogoNameImage,
                                width: getProportionateScreenWidth(55),
                                height: getProportionateScreenHeight(50),
                                fit: BoxFit.cover,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(20),
                                      vertical:
                                          getProportionateScreenHeight(10)),
                                  child: SvgPicture.asset(
                                    AppIcons.cancel,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Expanded(
                            child: ListView(
                              children: dashboardController
                                  .getDrawerOption(scaffoldKey),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(10),
                                top: getProportionateScreenHeight(10),
                                bottom: getProportionateScreenHeight(40)),
                            child: DefaultButton(
                                onTap: () {
                                  controller.logout();
                                  //logout  here
                                  // Get.toNamed(Routes.SIGN_IN);
                                },
                                textStyle: urbanistBold.copyWith(
                                  color: AppColors.white,
                                  fontSize: getProportionalFontSize(16),
                                ),
                                buttonColor: AppColors.appTheme,
                                textColor: AppColors.white,
                                text: Strings.logOut,
                                height: getProportionateScreenHeight(46),
                                width: getProportionateScreenWidth(145)),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Follow Us",
                                      style: beVietnamProaBold.copyWith(
                                          color: AppColors.darkGreenColor,
                                          fontSize: 16)),
                                  SizedBox(
                                      height: getProportionateScreenHeight(10)),
                                  Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            launchUrl(
                                                Uri.parse(
                                                    "https://www.facebook.com/famooshed"),
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: SvgPicture.asset(
                                              AppIcons.facebook)),
                                      // SizedBox(width: Get.width * .03),
                                      // SvgPicture.asset(AppIcons.twitter),
                                      SizedBox(width: Get.width * .03),
                                      GestureDetector(
                                          onTap: () {
                                            launchUrl(
                                                Uri.parse(
                                                    "https://www.instagram.com/famooshed/"),
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child:
                                              SvgPicture.asset(AppIcons.insta)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]

                        // ListTile(
                        //   leading: SvgPicture.asset(AppLogo.appLogoNameImage),
                        // )
                        ),
                  ),
                ),
              ),
              body: Stack(
                children: [
                  // Scaffold(body: Obx(() {
                  //   // WidgetsBinding.instance.addPostFrameCallback((_) {
                  //   // Future.delayed(Duration.zero).then((value) {
                  //   if (dashboardController.currentIndex.value == 0) {
                  //     // Get.lazyPut(() => HomeController());
                  //     HomeController().onReady();
                  //
                  //     // Get.find<HomeController>().onReady();
                  //   } else if (dashboardController.currentIndex.value == 1) {
                  //     // Get.lazyPut(() => OrdersController());
                  //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  //       OrdersController().onReady();
                  //     });
                  //
                  //     // Get.find<OrdersController>().onReady();
                  //   } else if (dashboardController.currentIndex.value == 2) {
                  //     // Get.lazyPut(() => MyProfileController());
                  //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  //       MyProfileController().onReady();
                  //     });
                  //
                  //     // Get.find<MyProfileController>().onReady();
                  //   } else if (dashboardController.currentIndex.value == 3) {
                  //     // Get.lazyPut(() => NotificationController());
                  //
                  //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  //       NotificationController().onReady();
                  //     });
                  //     // Get.find<NotificationController>().onReady();
                  //   } else if (dashboardController.currentIndex.value == 4) {
                  //     // Get.lazyPut(() => VerifyController());
                  //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  //       VerifyController().onReady();
                  //     });
                  //
                  //     // Get.find<MyProfileController>().onReady();
                  //   }
                  //   // });
                  //
                  //   // });
                  //   switch (dashboardController.currentIndex.value) {
                  //     case 0:
                  //       return HomePage();
                  //     case 1:
                  //       return const OrdersPage();
                  //     case 2:
                  //       return const MyProfilePage();
                  //     case 3:
                  //       return const NotificationPage();
                  //     case 4:
                  //       return HelpAndSupportPage(false);
                  //     default:
                  //       return Container();
                  //   }
                  // })),
                  Scaffold(body: getScreen()),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: BottomAppBar(
                      color: Colors.transparent,
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(64)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5),
                            child: GNav(
                              tabBackgroundGradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: ["#217041".fromHex, "#217041".fromHex],
                              ),
                              gap: 8,
                              tabBorderRadius: 15,
                              color: Colors.grey[600],
                              activeColor: Colors.white,
                              iconSize: 16,
                              textStyle: beVietnamProMedium.copyWith(
                                  color: Colors.white, fontSize: 16),
                              tabBackgroundColor: Colors.grey[800]!,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 16.5),
                              duration: const Duration(milliseconds: 800),
                              tabs: [
                                GButton(
                                  icon: SizedBox(
                                    width: 20,
                                    child: SvgPicture.asset(
                                      AppIcons.home,
                                      color: controller.currentIndex.value == 0
                                          ? AppColors.appThemeLight
                                          : AppColors.appTheme,
                                    ),
                                  ),
                                  onPressed: () {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                      HomeController().onReady();
                                    });
                                  },
                                  text: 'Home',
                                ),
                                GButton(
                                  icon: SizedBox(
                                    width: 24,
                                    child: SvgPicture.asset(
                                      AppIcons.paper,
                                      color: controller.currentIndex.value == 1
                                          ? AppColors.appThemeLight
                                          : AppColors.appTheme,
                                    ),
                                  ),
                                  onPressed: () {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                      OrdersController().onReady();
                                    });
                                  },
                                  text: 'My Orders',
                                ),
                                GButton(
                                  icon: SizedBox(
                                    width: 24,
                                    child: SvgPicture.asset(
                                      AppIcons.account,
                                      color: controller.currentIndex.value == 2
                                          ? AppColors.appThemeLight
                                          : AppColors.appTheme,
                                    ),
                                  ),
                                  onPressed: () {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                      MyProfileController().onReady();
                                    });
                                  },
                                  text: 'Profile',
                                ),
                                GButton(
                                  icon: SizedBox(
                                    width: 24,
                                    child: SvgPicture.asset(
                                      AppIcons.notification,
                                      color: controller.currentIndex.value == 3
                                          ? AppColors.appThemeLight
                                          : AppColors.appTheme,
                                    ),
                                  ),
                                  onPressed: () {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                      NotificationController().onReady();
                                    });
                                  },
                                  text: 'Notification',
                                ),
                                GButton(
                                  icon: SizedBox(
                                    width: 24,
                                    child: SvgPicture.asset(
                                      AppIcons.help,
                                      color: controller.currentIndex.value == 4
                                          ? AppColors.appThemeLight
                                          : AppColors.appTheme,
                                    ),
                                  ),
                                  onPressed: () {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                      VerifyController().onReady();
                                    });
                                  },
                                  text: 'Help',
                                ),
                              ],
                              selectedIndex: controller.currentIndex.value,
                              onTabChange: controller.changePage,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
        },
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

  getScreen() {
    switch (controller.currentIndex.value) {
      case 0:
        return HomePage();
      case 1:
        return OrdersPage();
      case 2:
        return const MyProfilePage();
      case 3:
        return const NotificationPage();
      case 4:
        return HelpAndSupportPage(false);
      default:
        return Container();
    }
  }
}
