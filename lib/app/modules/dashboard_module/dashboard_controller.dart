// ignore_for_file: unused_import

import 'dart:developer';

import 'package:dio/dio.dart' as d;
import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/common/values/app_icons.dart';
import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/get_basket_response.dart';
import 'package:famooshed/app/modules/add_new_location_module/add_new_location_controller.dart';
import 'package:famooshed/app/modules/home_module/home_bindings.dart';
import 'package:famooshed/app/modules/home_module/home_page.dart';
import 'package:famooshed/app/modules/my_profile_module/my_profile_bindings.dart';
import 'package:famooshed/app/modules/my_profile_module/my_profile_page.dart';
import 'package:famooshed/app/modules/notification_module/notification_bindings.dart';
import 'package:famooshed/app/modules/notification_module/notification_page.dart';
import 'package:famooshed/app/modules/orders_module/orders_controller.dart';
import 'package:famooshed/app/modules/widgets/drawer_item.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location_geocoder/location_geocoder.dart';

import '../../common/util/exports.dart';
import '../../common/util/loading_dialog.dart';
import '../../data/models/get_cart_model.dart';
import '../../theme/size_config.dart';
import '../../utils/dprint.dart';
import '../home_module/home_controller.dart';
import '../orders_module/orders_bindings.dart';
import '../orders_module/orders_page.dart';
import '../widgets/custom_default_button.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    setLocation();
    super.onInit();
  }

  @override
  void onReady() {
    // getBasket();
    getCartNew();
    super.onReady();
  }

  getLocalData() async {
    isLoggedIn.value = await Storage.getValue(Constants.isLoggedIn);
  }

  static DashboardController get to => Get.find();
  final ApiHelper _apiHelper = ApiHelper.to;
  RxInt count = 0.obs;
  var currentIndex = 0.obs;
  RxBool isLoggedIn = false.obs;
  RxString appBarTitle = "".obs;
  getAppTitle() {
    return pagesTitle[currentIndex.value];
  }

  // final pages = <String>[
  //   '/home',
  //   '/order',
  //   '/profile',
  //   '/notification',
  //   '/chat'
  // ];

  final pagesTitle = <String>[
    '',
    'My Orders',
    'My Account',
    'Notifications',
    'Help and Support'
  ];

  getBasket() {
    try {
      _apiHelper.postApiCall(AppUrl.getBasket, {}).futureValue((value) {
        if (value['orderdetails'] != null) {
          var response = GetBasketResponse.fromJson(value);
          count.value = response.orderdetails.length;
        }
        update();
      }, retryFunction: getBasket);
    } catch (e, trace) {
      log(e.toString(), stackTrace: trace);
    }
    update();
  }

  Future<void> getCartNew() async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var queryParams = {
        "isApp": true,
        "uid": uid.toString(),
      };

      d.Response response = await _apiHelper.getApiNew(
        AppUrl.getCart,
        {},
        queryParams,
      );

      if (response.statusCode == 200) {
        dprint(response.data);
        CartResponse cartResponse = CartResponse.fromJson(response.data);

        if (cartResponse.data != null) {
          if (cartResponse.data!.cart != null) {
            if (cartResponse.data!.cart!.products != null) {
              count.value = cartResponse.data!.cart!.products!.length;
            }
          }
        } else {
          count.value = 0;
        }
        LoadingDialog.closeLoadingDialog();
        update();
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  void changePage(int index) {
    currentIndex.value = index;
    // final selectedPage = pagesList1[index];
    //  selectedPage.on;
    // selectedPage.
    // Get.toNamed(pages[index], id: 1);
    update();
  }

  final iconLinearGradiant = List<Color>.from([
    const Color.fromARGB(255, 251, 2, 197),
    const Color.fromARGB(255, 72, 3, 80)
  ]);

  // Route? onGenerateRoute(RouteSettings settings) {
  //   if (settings.name == '/home') {
  //     return GetPageRoute(
  //       settings: settings,
  //       // transition: Transition.fadeIn,
  //       page: () => const HomePage(),
  //       binding: HomeBinding(),
  //     );
  //   }

  //   if (settings.name == '/order') {
  //     return GetPageRoute(
  //       settings: settings,
  //       page: () => const OrdersPage(),
  //       binding: OrdersBinding(),
  //     );
  //   }

  //   if (settings.name == '/profile') {
  //     return GetPageRoute(
  //       settings: settings,
  //       page: () => const MyProfilePage(),
  //       binding: MyProfileBinding(),
  //     );
  //   }

  //   if (settings.name == '/notification') {
  //     return GetPageRoute(
  //       settings: settings,
  //       page: () => const NotificationPage(),
  //       binding: NotificationBinding(),
  //     );
  //   }
  //   if (settings.name == '/chat') {
  //     return GetPageRoute(
  //       settings: settings,
  //       page: () => const MyProfilePage(),
  //       binding: MyProfileBinding(),
  //     );
  //   }

  //   return null;
  // }

  var drawerItem = [
    DrawerItem(Strings.home, AppIcons.home),
    DrawerItem(Strings.order, AppIcons.order),
    DrawerItem(Strings.account, AppIcons.account),
    DrawerItem(Strings.help, AppIcons.help),
    // DrawerItem(Strings.promotion, AppIcons.promotion),
    DrawerItem(Strings.feedback, AppIcons.feedback),
    // DrawerItem(Strings.reward, AppIcons.reward),
    // DrawerItem(Strings.settings, AppIcons.setting),
    DrawerItem(Strings.favorites, AppIcons.favorite),
    // DrawerItem(Strings.deliveryInfo, AppIcons.setting),
    // DrawerItem(Strings.about, AppIcons.setting),
    DrawerItem(Strings.termsOfUsage, AppIcons.privacy),
  ];

  getDrawerOption(scaffoldKey) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < drawerItem.length; i++) {
      var d = drawerItem[i];
      drawerOptions.add(ListTile(
          onTap: () {
            if (i == 1) {
              if (i == currentIndex.value) {
                Get.back();
              } else {
                Get.toNamed(Routes.ORDERS, arguments: true);
              }
            } else if (i == 2) {
              if (i == currentIndex.value) {
                Get.back();
              } else {
                Get.toNamed(Routes.MY_PROFILE, arguments: true);
              }
            } else if (i == 3) {
              Get.toNamed(Routes.HELP_AND_SUPPORT);
            }
            // else if (i == 4) {
            //   Get.toNamed(Routes.PROMOTIONS);
            // }
            else if (i == 4) {
              Get.toNamed(Routes.FEEDBACKS);
            }
            // else if (i == 5) {
            //   Get.toNamed(Routes.MY_REWARD);
            // }
            // else if (i == 5) {
            //   Get.toNamed(Routes.SETTINGS);
            // }
            else if (i == 5) {
              Get.toNamed(Routes.FAVORITES);
            }
            // else if (i == 9) {
            //   Get.toNamed(Routes.DELIVERY_INFO);
            // }
            // else if (i == 6) {
            //   Get.toNamed(Routes.ABOUT_US);
            // }
            else if (i == 6) {
              Get.toNamed(Routes.PRIVACY_POLICY);
            }
            // else if (i == 11) {
            //   Get.toNamed(Routes.TNC, arguments: {
            //     "title": "Terms and Condition",
            //     "key": "terms",
            //   });
            // } else if (i == 12) {
            //   Get.toNamed(Routes.REFUND_POLICY, arguments: {
            //     "title": "Refund Policy",
            //     "key": "refund",
            //   });
            // }
            else {
              clickItem(i, scaffoldKey);
            }
          },
          leading: SvgPicture.asset(d.icon,
              color: AppColors.darkGreenColor,
              height: getProportionateScreenHeight(25),
              width: getProportionateScreenWidth(25),
              fit: BoxFit.cover),
          title: Text(d.title,
              style: beVietnamProSemiBold.copyWith(
                  color: AppColors.darkGreenColor))));
    }
    return drawerOptions;
  }

  clickItem(int index, scaffoldKey) {
    currentIndex.value = index;
    toggleDrawer(scaffoldKey);
  }

  toggleDrawer(scaffoldKey) async {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openEndDrawer();
    } else {
      scaffoldKey.currentState!.openDrawer();
    }
    update();
  }

  logout() async {
    await Storage.clearStorage();
    Get.offAllNamed(Routes.SIGN_IN);
  }

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Utils.showSnackbar("Tap back again to leave");
      return Future.value(false);
    }
    return Future.value(true);
  }

  // var kGoogleApiKey = "AIzaSyBRPxjNN-yrJh2tGSCmsx0fdYX83Wodei4";
  var kGoogleApiKey = "AIzaSyAyrWhY3ALKo6NORh9f_gcwGGdWPT3Phdk";
  final searchController = TextEditingController();

  String myLocation = '';
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;

  HomeController homeController = Get.find<HomeController>();
  AddNewLocationController addNewLocationController =
      Get.find<AddNewLocationController>();
  Future<void> handlePressButton() async {
    void onError(PlacesAutocompleteResponse response) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }

    final p = await PlacesAutocomplete.show(
      context: Get.context!,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.fullscreen,
      language: 'en',
      logo: Padding(
        padding: EdgeInsets.only(
            left: getProportionateScreenWidth(15),
            top: getProportionateScreenHeight(8)),
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(15)),
            child: Icon(Icons.my_location),
          ),
          dense: true,
          onTap: () async {
            Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
            );

            final address = await LocatitonGeocoder(Constants.kGoogleMapKey)
                .findAddressesFromCoordinates(
                    Coordinates(position.latitude, position.longitude));

            lat.value = position.latitude;
            lng.value = position.longitude;

            //homeController
            // homeController.myLat.value = position.latitude;
            // homeController.myLong.value = position.longitude;

            // myLocation = address.first.featureName ?? '-';
            dprint(address);
            googleMapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: currentZoom,
                ),
              ),
            );
            update();
            Get.back();
            // addMark(LatLng(position.latitude, position.longitude));
          },
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          minLeadingWidth: getProportionateScreenWidth(60),
          title: Text("Use My Current Location",
              style: Theme.of(Get.context!).textTheme.titleMedium),
          titleAlignment: ListTileTitleAlignment.titleHeight,
        ),
      ),
      components: [
        // Component(Component.country, 'gb'),
        // Component(Component.country, 'in')
      ],
      resultTextStyle: Theme.of(Get.context!).textTheme.titleMedium,
    );
    await displayPrediction(p, ScaffoldMessenger.of(Get.context!));
  }

  Future<void> displayPrediction(
      Prediction? p, ScaffoldMessengerState messengerState) async {
    if (p == null) {
      return;
    }

    final places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    final detail = await places.getDetailsByPlaceId(p.placeId!);
    final geometry = detail.result.geometry!;
    lat.value = geometry.location.lat;
    lng.value = geometry.location.lng;

    //homeController
    // homeController.myLat.value = geometry.location.lat;
    // homeController.myLong.value = geometry.location.lat;
    //
    // myLocation = p.description ?? '-';
    dprint(p.description);
    searchController.text = p.description!;
    googleMapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(geometry.location.lat, geometry.location.lng),
          zoom: currentZoom,
        ),
      ),
    );
    update();
    // addMark(LatLng(geometry.location.lat, geometry.location.lng));
  }

  Future<void> setLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final address = await LocatitonGeocoder(Constants.kGoogleMapKey)
        .findAddressesFromCoordinates(
            Coordinates(position.latitude, position.longitude));

    lat.value = position.latitude;
    lng.value = position.longitude;

    //homeController
    homeController.myLat.value = position.latitude;
    homeController.myLong.value = position.longitude;
    homeController.update();

    myLocation = address.first.featureName ?? '-';
    update();
    dprint(address);
  }

  GoogleMapController? googleMapController;
  double currentZoom = 18;
  LatLng? initialLatLong;

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (initialLatLong != null) {
      address = await LocatitonGeocoder(Constants.kGoogleMapKey)
          .findAddressesFromCoordinates(
              Coordinates(initialLatLong!.latitude, initialLatLong!.longitude));
      dprint(address);
      googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(initialLatLong!.latitude, initialLatLong!.longitude),
            zoom: currentZoom,
          ),
        ),
      );
    } else {
      initialLatLong = LatLng(position.latitude, position.longitude);
      address = await LocatitonGeocoder(Constants.kGoogleMapKey)
          .findAddressesFromCoordinates(
              Coordinates(position.latitude, position.longitude));
      myLocation = address.first.featureName ?? '-';
      dprint(address);
      googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: currentZoom,
          ),
        ),
      );
    }
    update();

    // addMark(LatLng(position.latitude, position.longitude));
  }

  List<Marker> markers = [];

  void addMark(LatLng pos) {
    Future.delayed(Duration(seconds: 0)).then((value) async {
      MarkerId _sourceMarkerId = MarkerId("lcoationMarkerId");
      final marker1 = Marker(
          markerId: _sourceMarkerId,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),

          // rotation: currentLatLng.,
          position: pos,
          onTap: () {
            Utils.showSnackbar(pos.latitude.toString());
          });
      final oldSourceMarkerId = markers.indexWhere(
          (marker) => marker.markerId == MarkerId('lcoationMarkerId'));
      if (oldSourceMarkerId >= 0) {
        // If it exists
        markers[oldSourceMarkerId] = marker1;
      } else {
        markers.add(marker1);
      }

      final address = await LocatitonGeocoder(Constants.kGoogleMapKey)
          .findAddressesFromCoordinates(
              Coordinates(pos.latitude, pos.longitude));

      lat.value = pos.latitude;
      lng.value = pos.longitude;

      //homeController
      homeController.myLat.value = pos.latitude;
      homeController.myLong.value = pos.longitude;

      myLocation = address.first.featureName ?? '-';
      dprint(address);
      update();
    });
  }

  List<Address> address = [];
  updateLocation(LatLng pos) async {
    lat.value = pos.latitude;
    lng.value = pos.longitude;

    address = await LocatitonGeocoder(Constants.kGoogleMapKey)
        .findAddressesFromCoordinates(Coordinates(pos.latitude, pos.longitude));
    myLocation = address.first.featureName ?? '-';
    dprint(address);
    //homeController
    // homeController.myLat.value = pos.latitude;
    // homeController.myLong.value = pos.longitude;

    update();
  }

  String screenName = '';
  Future<void> showBottomSheet() async {
    final address = await LocatitonGeocoder(Constants.kGoogleMapKey)
        .findAddressesFromCoordinates(Coordinates(lat.value, lng.value));
    myLocation = address.first.featureName ?? '-';
    update();
    dprint(address);
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24))),
      context: Get.context!,
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: getProportionateScreenWidth(16),
              right: getProportionateScreenWidth(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(16),
              ),
              Center(
                child: Container(
                  height: getProportionateScreenHeight(5),
                  width: getProportionateScreenWidth(48),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(16),
              ),
              Flexible(
                child: Text(
                  '${address.first.featureName ?? '-'}',
                  // 'Linsted Lane, Headly',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: beVietnamProSemiBold.copyWith(
                      color: AppColors.black,
                      fontSize: getProportionalFontSize(14)),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(8),
              ),
              Flexible(
                child: Text(
                  '${address.first.addressLine ?? '-'}',
                  // 'Linsted Lane, Headly',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: beVietnamProMedium.copyWith(
                      color: AppColors.lightBlack,
                      fontSize: getProportionalFontSize(13)),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(16),
              ),
              DefaultButton(
                text: 'Enter Complete Address',
                textStyle: beVietnamProaBold.copyWith(
                    fontSize: getProportionalFontSize(14),
                    color: AppColors.white),
                width: SizeConfig.deviceWidth!,
                height: getProportionateScreenHeight(50),
                buttonColor: AppColors.appTheme,
                textColor: AppColors.white,
                onTap: () {
                  if (screenName.isNotEmpty) {
                    if (screenName == "DASHBOARD") {
                      //homeController
                      homeController.myLat.value = lat.value;
                      homeController.myLong.value = lng.value;

                      homeController.update();

                      Get.back();
                      Get.back();
                      homeController.getCategoryData();
                    } else if (screenName == "AddNew") {
                      // addNewLocationController.text.value =
                      //     address.first.addressLine ?? '';
                      // addNewLocationController.lat.value = lat.value;
                      // addNewLocationController.lat.value = lng.value;
                      // addNewLocationController.update();

                      areaController.text = address.first.featureName ?? '';
                      update();

                      showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(24),
                                topLeft: Radius.circular(24))),
                        context: Get.context!,
                        builder: (context) => StatefulBuilder(
                          builder: (context, mSetState) {
                            return SafeArea(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                    left: getProportionateScreenWidth(16),
                                    right: getProportionateScreenWidth(16)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: getProportionateScreenHeight(16),
                                    ),
                                    Center(
                                      child: Container(
                                        height: getProportionateScreenHeight(5),
                                        width: getProportionateScreenWidth(48),
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(2.5),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(16),
                                    ),
                                    Text(
                                      'Enter complete address',
                                      // 'Linsted Lane, Headly',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: beVietnamProaBold.copyWith(
                                          color: AppColors.appTheme,
                                          fontSize:
                                              getProportionalFontSize(16)),
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(16),
                                    ),
                                    radioButtons(mSetState),
                                    checkBox(mSetState),
                                    SizedBox(
                                      height: getProportionateScreenHeight(12),
                                    ),
                                    TextFormField(
                                      controller: flatController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: AppColors.black),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                          left: getProportionateScreenWidth(12),
                                          right:
                                              getProportionateScreenWidth(12),
                                        ),
                                        filled: true,
                                        labelStyle: beVietnamProMedium.copyWith(
                                            fontSize:
                                                getProportionalFontSize(12),
                                            color: AppColors.lightBlack),
                                        labelText:
                                            "Flat / House no / Floor / Building",
                                        // hintText: "Flat / House no/ Floor / Building"
                                      ),
                                      style: beVietnamProMedium.copyWith(
                                        fontSize: getProportionalFontSize(13),
                                      ),
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(14),
                                    ),
                                    TextFormField(
                                      controller: areaController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: AppColors.black),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                          left: getProportionateScreenWidth(12),
                                          right:
                                              getProportionateScreenWidth(12),
                                        ),
                                        filled: true,
                                        labelStyle: beVietnamProMedium.copyWith(
                                            fontSize:
                                                getProportionalFontSize(12),
                                            color: AppColors.lightBlack),
                                        labelText: "Area / Sector / Locality",
                                        // hintText: "Flat / House no/ Floor / Building"
                                      ),
                                      style: beVietnamProMedium.copyWith(
                                        fontSize: getProportionalFontSize(13),
                                      ),
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(14),
                                    ),
                                    TextFormField(
                                      controller: landMarkController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: AppColors.black),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                          left: getProportionateScreenWidth(12),
                                          right:
                                              getProportionateScreenWidth(12),
                                        ),
                                        filled: true,
                                        labelStyle: beVietnamProMedium.copyWith(
                                            fontSize:
                                                getProportionalFontSize(12),
                                            color: AppColors.lightBlack),
                                        labelText: "Nearby landmark (optional)",
                                        // hintText: "Flat / House no/ Floor / Building"
                                      ),
                                      style: beVietnamProMedium.copyWith(
                                        fontSize: getProportionalFontSize(13),
                                      ),
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(22),
                                    ),
                                    DefaultButton(
                                      text: 'Save Address',
                                      textStyle: beVietnamProaBold.copyWith(
                                          fontSize: getProportionalFontSize(14),
                                          color: AppColors.white),
                                      width: SizeConfig.deviceWidth!,
                                      height: getProportionateScreenHeight(50),
                                      buttonColor: AppColors.appTheme,
                                      textColor: AppColors.white,
                                      onTap: () {
                                        print(lat.value.toString());
                                        print(lng.value.toString());

                                        // await addNewLocationController
                                        //     .saveAddressNew(
                                        //         flat: flatController.text,
                                        //         area: areaController.text,
                                        //         landMark:
                                        //             landMarkController.text,
                                        //         lat: lat.value,
                                        //         long: lng.value,
                                        //         type: verticalGroupValue,
                                        //         isDefault: isDefault.value);
                                        // Get.back();
                                        // Get.back();
                                      },
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(16),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              ),
              SizedBox(
                height: getProportionateScreenHeight(16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController flatController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();

  String verticalGroupValue = "Home";
  final status = ["Home", "Work", "Other"];
  RxBool isDefault = true.obs;

  radioButtons(StateSetter mSetState) {
    return RadioGroup<String>.builder(
      direction: Axis.horizontal,
      groupValue: verticalGroupValue,
      onChanged: (value) {
        dprint(value);
        verticalGroupValue = value!;
        mSetState(() {});
        update();
      },
      textStyle:
          beVietnamProMedium.copyWith(fontSize: getProportionalFontSize(13)),
      items: status,
      itemBuilder: (item) => RadioButtonBuilder(item),
      fillColor: AppColors.appTheme,
    );
  }

  checkBox(StateSetter mSetState) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      checkColor: AppColors.white,
      activeColor: AppColors.appTheme,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        'Default',
        style:
            beVietnamProMedium.copyWith(fontSize: getProportionalFontSize(13)),
      ),
      value: isDefault.value,
      onChanged: (bool? value) {
        isDefault.value = value!;
        mSetState(() {});
        update();
      },
    );
  }

  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  getAddressWidget() {
    return address.isNotEmpty
        ? Padding(
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(16),
                right: getProportionateScreenWidth(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(16),
                ),
                Flexible(
                  child: Text(
                    '${address.first.featureName ?? '-'}',
                    // 'Linsted Lane, Headly',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: beVietnamProSemiBold.copyWith(
                        color: AppColors.black,
                        fontSize: getProportionalFontSize(14)),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(12),
                ),
                Flexible(
                  child: Text(
                    '${address.first.addressLine ?? '-'}',
                    // 'Linsted Lane, Headly',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: beVietnamProMedium.copyWith(
                        color: AppColors.lightBlack,
                        fontSize: getProportionalFontSize(13)),
                  ),
                ),
                Spacer(),
                DefaultButton(
                  text:
                      '${screenName.isNotEmpty && screenName == "AddNew" ? 'Enter Complete Address' : 'Choose Address'}',
                  textStyle: beVietnamProaBold.copyWith(
                      fontSize: getProportionalFontSize(14),
                      color: AppColors.white),
                  width: SizeConfig.deviceWidth!,
                  height: getProportionateScreenHeight(50),
                  buttonColor: AppColors.appTheme,
                  textColor: AppColors.white,
                  onTap: () {
                    if (screenName.isNotEmpty) {
                      if (screenName == "DASHBOARD") {
                        //homeController
                        homeController.myLat.value = lat.value;
                        homeController.myLong.value = lng.value;

                        homeController.update();

                        Get.back();
                        Get.back();
                        homeController.getCategoryData();
                      } else if (screenName == "AddNew") {
                        // addNewLocationController.text.value =
                        //     address.first.addressLine ?? '';
                        // addNewLocationController.lat.value = lat.value;
                        // addNewLocationController.lat.value = lng.value;
                        // addNewLocationController.update();
                        if (addNewLocationController.editAdd != null) {
                          flatController.text =
                              addNewLocationController.editAdd!.flatHouseNo ??
                                  '';

                          areaController.text =
                              addNewLocationController.editAdd!.text ?? '';

                          landMarkController.text = addNewLocationController
                                  .editAdd!.nearByLandmark ??
                              '';
                          verticalGroupValue =
                              addNewLocationController.editAdd!.type ?? 'Home';
                          isDefault.value = addNewLocationController
                                      .editAdd!.addressResponseDefault ==
                                  'true'
                              ? true
                              : false;
                        } else {
                          areaController.text = address.first.featureName ?? '';
                        }
                        update();
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  topLeft: Radius.circular(24))),
                          context: Get.context!,
                          builder: (context) => StatefulBuilder(
                            builder: (context, mSetState) {
                              return SafeArea(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                      left: getProportionateScreenWidth(16),
                                      right: getProportionateScreenWidth(16)),
                                  child: Form(
                                    key: fKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(16),
                                        ),
                                        Center(
                                          child: Container(
                                            height:
                                                getProportionateScreenHeight(5),
                                            width:
                                                getProportionateScreenWidth(48),
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(16),
                                        ),
                                        Text(
                                          'Enter complete address',
                                          // 'Linsted Lane, Headly',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: beVietnamProaBold.copyWith(
                                              color: AppColors.appTheme,
                                              fontSize:
                                                  getProportionalFontSize(16)),
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(16),
                                        ),
                                        radioButtons(mSetState),
                                        checkBox(mSetState),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(12),
                                        ),
                                        TextFormField(
                                          controller: flatController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Field required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: AppColors.black),
                                            ),
                                            contentPadding: EdgeInsets.only(
                                              left: getProportionateScreenWidth(
                                                  12),
                                              right:
                                                  getProportionateScreenWidth(
                                                      12),
                                            ),
                                            filled: true,
                                            labelStyle:
                                                beVietnamProMedium.copyWith(
                                                    fontSize:
                                                        getProportionalFontSize(
                                                            12),
                                                    color:
                                                        AppColors.lightBlack),
                                            labelText:
                                                "Flat / House no / Floor / Building",
                                            // hintText: "Flat / House no/ Floor / Building"
                                          ),
                                          style: beVietnamProMedium.copyWith(
                                            fontSize:
                                                getProportionalFontSize(13),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(14),
                                        ),
                                        TextFormField(
                                          controller: areaController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Field required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: AppColors.black),
                                            ),
                                            contentPadding: EdgeInsets.only(
                                              left: getProportionateScreenWidth(
                                                  12),
                                              right:
                                                  getProportionateScreenWidth(
                                                      12),
                                            ),
                                            filled: true,
                                            labelStyle:
                                                beVietnamProMedium.copyWith(
                                                    fontSize:
                                                        getProportionalFontSize(
                                                            12),
                                                    color:
                                                        AppColors.lightBlack),
                                            labelText:
                                                "Area / Sector / Locality",
                                            // hintText: "Flat / House no/ Floor / Building"
                                          ),
                                          style: beVietnamProMedium.copyWith(
                                            fontSize:
                                                getProportionalFontSize(13),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(14),
                                        ),
                                        TextFormField(
                                          controller: landMarkController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: AppColors.black),
                                            ),
                                            contentPadding: EdgeInsets.only(
                                              left: getProportionateScreenWidth(
                                                  12),
                                              right:
                                                  getProportionateScreenWidth(
                                                      12),
                                            ),
                                            filled: true,
                                            labelStyle:
                                                beVietnamProMedium.copyWith(
                                                    fontSize:
                                                        getProportionalFontSize(
                                                            12),
                                                    color:
                                                        AppColors.lightBlack),
                                            labelText:
                                                "Nearby landmark (optional)",
                                            // hintText: "Flat / House no/ Floor / Building"
                                          ),
                                          style: beVietnamProMedium.copyWith(
                                            fontSize:
                                                getProportionalFontSize(13),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(22),
                                        ),
                                        DefaultButton(
                                          text: 'Save Address',
                                          textStyle: beVietnamProaBold.copyWith(
                                              fontSize:
                                                  getProportionalFontSize(14),
                                              color: AppColors.white),
                                          width: SizeConfig.deviceWidth!,
                                          height:
                                              getProportionateScreenHeight(50),
                                          buttonColor: AppColors.appTheme,
                                          textColor: AppColors.white,
                                          onTap: () async {
                                            if (fKey.currentState!.validate()) {
                                              if (addNewLocationController
                                                      .editAdd !=
                                                  null) {
                                                await addNewLocationController
                                                    .editAddress(
                                                        editId:
                                                            addNewLocationController
                                                                .editAdd!.id!
                                                                .toString(),
                                                        flat:
                                                            flatController.text,
                                                        area:
                                                            areaController.text,
                                                        landMark:
                                                            landMarkController
                                                                .text,
                                                        lat: lat.value,
                                                        long: lng.value,
                                                        type:
                                                            verticalGroupValue,
                                                        isDefault:
                                                            isDefault.value);

                                                flatController.clear();
                                                areaController.clear();
                                                landMarkController.clear();
                                                Get.back();
                                                Get.back();
                                              } else {
                                                await addNewLocationController
                                                    .saveAddressNew(
                                                        flat:
                                                            flatController.text,
                                                        area:
                                                            areaController.text,
                                                        landMark:
                                                            landMarkController
                                                                .text,
                                                        lat: lat.value,
                                                        long: lng.value,
                                                        type:
                                                            verticalGroupValue,
                                                        isDefault:
                                                            isDefault.value);
                                                flatController.clear();
                                                areaController.clear();
                                                landMarkController.clear();
                                                Get.back();
                                                Get.back();
                                              }
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(16),
                ),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
