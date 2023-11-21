// To parse this JSON data, do
//
//     final getHomeResponse = getHomeResponseFromJson(jsonString);

import 'dart:convert';

GetHomeResponse getHomeResponseFromJson(String str) =>
    GetHomeResponse.fromJson(json.decode(str));

String getHomeResponseToJson(GetHomeResponse data) =>
    json.encode(data.toJson());

class GetHomeResponse {
  bool success;
  List<Category> categories;
  List<ExclusiveonFamooshed> toppicks;
  List<ExclusiveonFamooshed> featured;
  List<ExclusiveonFamooshed> offersNearYou;
  List<ExclusiveonFamooshed> spotlightResturents;
  List<ExclusiveonFamooshed> topRated;
  List<ExclusiveonFamooshed> exclusiveonFamooshed;
  List<ExclusiveonFamooshed> newonFamooshed;
  String defaultTax;
  String currency;
  List<Coupon> coupons;
  Payments payments;
  Settings settings;

  GetHomeResponse({
    required this.success,
    required this.categories,
    required this.toppicks,
    required this.featured,
    required this.offersNearYou,
    required this.spotlightResturents,
    required this.topRated,
    required this.exclusiveonFamooshed,
    required this.newonFamooshed,
    required this.defaultTax,
    required this.currency,
    required this.coupons,
    required this.payments,
    required this.settings,
  });

  factory GetHomeResponse.fromJson(Map<String, dynamic> json) =>
      GetHomeResponse(
        success: json["success"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        toppicks: List<ExclusiveonFamooshed>.from(
            json["toppicks"].map((x) => ExclusiveonFamooshed.fromJson(x))),
        featured: List<ExclusiveonFamooshed>.from(
            json["featured"].map((x) => ExclusiveonFamooshed.fromJson(x))),
        offersNearYou: List<ExclusiveonFamooshed>.from(
            json["OffersNearYou"].map((x) => ExclusiveonFamooshed.fromJson(x))),
        spotlightResturents: List<ExclusiveonFamooshed>.from(
            json["SpotlightResturents"]
                .map((x) => ExclusiveonFamooshed.fromJson(x))),
        topRated: List<ExclusiveonFamooshed>.from(
            json["TopRated"].map((x) => ExclusiveonFamooshed.fromJson(x))),
        exclusiveonFamooshed: List<ExclusiveonFamooshed>.from(
            json["ExclusiveonFamooshed"]
                .map((x) => ExclusiveonFamooshed.fromJson(x))),
        newonFamooshed: List<ExclusiveonFamooshed>.from(json["NewonFamooshed"]
            .map((x) => ExclusiveonFamooshed.fromJson(x))),
        defaultTax: json["default_tax"],
        currency: json["currency"],
        coupons:
            List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))),
        payments: Payments.fromJson(json["payments"]),
        settings: Settings.fromJson(json["settings"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "toppicks": List<dynamic>.from(toppicks.map((x) => x.toJson())),
        "featured": List<dynamic>.from(featured.map((x) => x.toJson())),
        "OffersNearYou":
            List<dynamic>.from(offersNearYou.map((x) => x.toJson())),
        "SpotlightResturents":
            List<dynamic>.from(spotlightResturents.map((x) => x.toJson())),
        "TopRated": List<dynamic>.from(topRated.map((x) => x.toJson())),
        "ExclusiveonFamooshed":
            List<dynamic>.from(exclusiveonFamooshed.map((x) => x.toJson())),
        "NewonFamooshed":
            List<dynamic>.from(newonFamooshed.map((x) => x.toJson())),
        "default_tax": defaultTax,
        "currency": currency,
        "coupons": List<dynamic>.from(coupons.map((x) => x.toJson())),
        "payments": payments.toJson(),
        "settings": settings.toJson(),
      };
}

class Category {
  int id;
  String name;
  String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}

class Coupon {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  DateTime dateStart;
  DateTime dateEnd;
  String discount;
  int published;
  int inpercents;
  String amount;
  String desc;
  int allRestaurants;
  int allCategory;
  int allFoods;
  String restaurantsList;
  String categoryList;
  String foodsList;
  String vendor;

  Coupon({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.dateStart,
    required this.dateEnd,
    required this.discount,
    required this.published,
    required this.inpercents,
    required this.amount,
    required this.desc,
    required this.allRestaurants,
    required this.allCategory,
    required this.allFoods,
    required this.restaurantsList,
    required this.categoryList,
    required this.foodsList,
    required this.vendor,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        dateStart: DateTime.parse(json["dateStart"]),
        dateEnd: DateTime.parse(json["dateEnd"]),
        discount: json["discount"],
        published: json["published"],
        inpercents: json["inpercents"],
        amount: json["amount"],
        desc: json["desc"],
        allRestaurants: json["allRestaurants"],
        allCategory: json["allCategory"],
        allFoods: json["allFoods"],
        restaurantsList: json["restaurantsList"],
        categoryList: json["categoryList"],
        foodsList: json["foodsList"],
        vendor: json["vendor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "dateStart": dateStart.toIso8601String(),
        "dateEnd": dateEnd.toIso8601String(),
        "discount": discount,
        "published": published,
        "inpercents": inpercents,
        "amount": amount,
        "desc": desc,
        "allRestaurants": allRestaurants,
        "allCategory": allCategory,
        "allFoods": allFoods,
        "restaurantsList": restaurantsList,
        "categoryList": categoryList,
        "foodsList": foodsList,
        "vendor": vendor,
      };
}

// class ExclusiveonFamooshed {
//   int id;
//   String name;
//   String lat;
//   String lng;
//   int onlyfamooshed;
//   String? businessAddress;
//   String? desc;
//   String? rate;
//   String image;
//   int? countOrdersRestaurant;
//   String? favStatus;
//
//   ExclusiveonFamooshed(
//       {required this.id,
//       required this.name,
//       required this.lat,
//       required this.lng,
//       required this.onlyfamooshed,
//       required this.businessAddress,
//       this.desc,
//       this.rate,
//       required this.image,
//       this.countOrdersRestaurant,
//       this.favStatus});
//
//   factory ExclusiveonFamooshed.fromJson(Map<String, dynamic> json) =>
//       ExclusiveonFamooshed(
//         id: json["id"],
//         name: json["name"],
//         lat: json["lat"],
//         lng: json["lng"],
//         onlyfamooshed: json["onlyfamooshed"],
//         businessAddress: json["business_address"],
//         desc: json["desc"],
//         rate: json["rate"],
//         image: json["image"],
//         countOrdersRestaurant: json["COUNT(orders.restaurant)"] ?? 0,
//         favStatus: json["favStatus"] ?? 'false',
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "lat": lat,
//         "lng": lng,
//         "onlyfamooshed": onlyfamooshed,
//         "business_address": businessAddress,
//         "desc": desc,
//         "rate": rate,
//         "image": image,
//         "COUNT(orders.restaurant)": countOrdersRestaurant,
//         "favStatus": favStatus,
//       };
// }

class ExclusiveonFamooshed {
  int? id;
  String? name;
  String? lat;
  String? lng;
  String? businessAddress;
  int? rate;
  String? desc;
  int? onlyfamooshed;
  String? image;
  int? numberOfRating;
  String? favStatus;

  ExclusiveonFamooshed({
    this.id,
    this.name,
    this.lat,
    this.lng,
    this.businessAddress,
    this.rate,
    this.desc,
    this.onlyfamooshed,
    this.image,
    this.numberOfRating,
    this.favStatus,
  });

  factory ExclusiveonFamooshed.fromJson(Map<String, dynamic> json) =>
      ExclusiveonFamooshed(
        id: json["id"],
        name: json["name"],
        lat: json["lat"],
        lng: json["lng"],
        businessAddress: json["business_address"],
        rate: json["rate"],
        desc: json["desc"],
        onlyfamooshed: json["onlyfamooshed"],
        image: json["image"],
        numberOfRating: json["number_of_rating"],
        favStatus: json["favStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lat": lat,
        "lng": lng,
        "business_address": businessAddress,
        "rate": rate,
        "desc": desc,
        "onlyfamooshed": onlyfamooshed,
        "image": image,
        "number_of_rating": numberOfRating,
        "favStatus": favStatus,
      };
}

class Payments {
  String stripeEnable;
  String stripeKey;
  String stripeSecretKey;
  String razEnable;
  String razKey;
  String razName;
  String cashEnable;
  String code;
  String payPalEnable;
  String payPalSandBox;
  String payPalClientId;
  String payPalSecret;
  String payStackEnable;
  String payStackKey;
  String yandexKassaEnable;
  String yandexKassaShopId;
  String yandexKassaClientAppKey;
  String yandexKassaSecretKey;
  String instamojoEnable;
  String instamojoSandBoxMode;
  String instamojoApiKey;
  String instamojoPrivateToken;
  String flutterWaveEnable;
  String flutterWaveEncryptionKey;
  String flutterWavePublicKey;
  String mercadoPagoEnable;
  String mercadoPagoAccessToken;
  String mercadoPagoPublicKey;
  String payMobEnable;
  String payMobApiKey;
  String payMobFrame;
  String payMobIntegrationId;

  Payments({
    required this.stripeEnable,
    required this.stripeKey,
    required this.stripeSecretKey,
    required this.razEnable,
    required this.razKey,
    required this.razName,
    required this.cashEnable,
    required this.code,
    required this.payPalEnable,
    required this.payPalSandBox,
    required this.payPalClientId,
    required this.payPalSecret,
    required this.payStackEnable,
    required this.payStackKey,
    required this.yandexKassaEnable,
    required this.yandexKassaShopId,
    required this.yandexKassaClientAppKey,
    required this.yandexKassaSecretKey,
    required this.instamojoEnable,
    required this.instamojoSandBoxMode,
    required this.instamojoApiKey,
    required this.instamojoPrivateToken,
    required this.flutterWaveEnable,
    required this.flutterWaveEncryptionKey,
    required this.flutterWavePublicKey,
    required this.mercadoPagoEnable,
    required this.mercadoPagoAccessToken,
    required this.mercadoPagoPublicKey,
    required this.payMobEnable,
    required this.payMobApiKey,
    required this.payMobFrame,
    required this.payMobIntegrationId,
  });

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        stripeEnable: json["StripeEnable"],
        stripeKey: json["stripeKey"],
        stripeSecretKey: json["stripeSecretKey"],
        razEnable: json["razEnable"],
        razKey: json["razKey"],
        razName: json["razName"],
        cashEnable: json["cashEnable"],
        code: json["code"],
        payPalEnable: json["payPalEnable"],
        payPalSandBox: json["payPalSandBox"],
        payPalClientId: json["payPalClientId"],
        payPalSecret: json["payPalSecret"],
        payStackEnable: json["payStackEnable"],
        payStackKey: json["payStackKey"],
        yandexKassaEnable: json["yandexKassaEnable"],
        yandexKassaShopId: json["yandexKassaShopId"],
        yandexKassaClientAppKey: json["yandexKassaClientAppKey"],
        yandexKassaSecretKey: json["yandexKassaSecretKey"],
        instamojoEnable: json["instamojoEnable"],
        instamojoSandBoxMode: json["instamojoSandBoxMode"],
        instamojoApiKey: json["instamojoApiKey"],
        instamojoPrivateToken: json["instamojoPrivateToken"],
        flutterWaveEnable: json["FlutterWaveEnable"],
        flutterWaveEncryptionKey: json["FlutterWaveEncryptionKey"],
        flutterWavePublicKey: json["FlutterWavePublicKey"],
        mercadoPagoEnable: json["MercadoPagoEnable"],
        mercadoPagoAccessToken: json["MercadoPagoAccessToken"],
        mercadoPagoPublicKey: json["MercadoPagoPublicKey"],
        payMobEnable: json["payMobEnable"],
        payMobApiKey: json["payMobApiKey"],
        payMobFrame: json["payMobFrame"],
        payMobIntegrationId: json["payMobIntegrationId"],
      );

  Map<String, dynamic> toJson() => {
        "StripeEnable": stripeEnable,
        "stripeKey": stripeKey,
        "stripeSecretKey": stripeSecretKey,
        "razEnable": razEnable,
        "razKey": razKey,
        "razName": razName,
        "cashEnable": cashEnable,
        "code": code,
        "payPalEnable": payPalEnable,
        "payPalSandBox": payPalSandBox,
        "payPalClientId": payPalClientId,
        "payPalSecret": payPalSecret,
        "payStackEnable": payStackEnable,
        "payStackKey": payStackKey,
        "yandexKassaEnable": yandexKassaEnable,
        "yandexKassaShopId": yandexKassaShopId,
        "yandexKassaClientAppKey": yandexKassaClientAppKey,
        "yandexKassaSecretKey": yandexKassaSecretKey,
        "instamojoEnable": instamojoEnable,
        "instamojoSandBoxMode": instamojoSandBoxMode,
        "instamojoApiKey": instamojoApiKey,
        "instamojoPrivateToken": instamojoPrivateToken,
        "FlutterWaveEnable": flutterWaveEnable,
        "FlutterWaveEncryptionKey": flutterWaveEncryptionKey,
        "FlutterWavePublicKey": flutterWavePublicKey,
        "MercadoPagoEnable": mercadoPagoEnable,
        "MercadoPagoAccessToken": mercadoPagoAccessToken,
        "MercadoPagoPublicKey": mercadoPagoPublicKey,
        "payMobEnable": payMobEnable,
        "payMobApiKey": payMobApiKey,
        "payMobFrame": payMobFrame,
        "payMobIntegrationId": payMobIntegrationId,
      };
}

class Settings {
  String currency;
  String darkMode;
  String rightSymbol;
  String walletEnable;
  int symbolDigits;
  int radius;
  int shadow;
  List<String> rows;
  String mainColor;
  dynamic iconColorWhiteMode;
  dynamic iconColorDarkMode;
  int restaurantCardWidth;
  int restaurantCardHeight;
  dynamic restaurantBackgroundColor;
  int restaurantCardTextSize;
  String restaurantCardTextColor;
  dynamic restaurantTitleColor;
  String dishesTitleColor;
  dynamic dishesBackgroundColor;
  int dishesCardHeight;
  String oneInLine;
  String categoriesTitleColor;
  dynamic categoriesBackgroundColor;
  int categoryCardWidth;
  int categoryCardHeight;
  String searchBackgroundColor;
  String reviewTitleColor;
  String reviewBackgroundColor;
  String categoryCardCircle;
  int topRestaurantCardHeight;
  String bottomBarType;
  String bottomBarColor;
  String titleBarColor;
  String mapapikey;
  String typeFoods;
  String distanceUnit;
  String appLanguage;
  String copyright;
  String copyrightText;
  String about;
  String faq;
  String otp;
  String delivering;
  String curbsidePickup;
  String coupon;
  String deliveringTime;
  String deliveringDate;
  String delivery;
  String privacy;
  String terms;
  String refund;
  String refundTextName;
  String aboutTextName;
  String deliveryTextName;
  String privacyTextName;
  String termsTextName;
  String banner1CardHeight;
  String banner2CardHeight;
  String googleLoginCa;
  String facebookLoginCa;
  String defaultLat;
  String defaultLng;
  String shareAppGooglePlay;
  String shareAppAppStore;

  Settings({
    required this.currency,
    required this.darkMode,
    required this.rightSymbol,
    required this.walletEnable,
    required this.symbolDigits,
    required this.radius,
    required this.shadow,
    required this.rows,
    required this.mainColor,
    this.iconColorWhiteMode,
    this.iconColorDarkMode,
    required this.restaurantCardWidth,
    required this.restaurantCardHeight,
    this.restaurantBackgroundColor,
    required this.restaurantCardTextSize,
    required this.restaurantCardTextColor,
    this.restaurantTitleColor,
    required this.dishesTitleColor,
    this.dishesBackgroundColor,
    required this.dishesCardHeight,
    required this.oneInLine,
    required this.categoriesTitleColor,
    this.categoriesBackgroundColor,
    required this.categoryCardWidth,
    required this.categoryCardHeight,
    required this.searchBackgroundColor,
    required this.reviewTitleColor,
    required this.reviewBackgroundColor,
    required this.categoryCardCircle,
    required this.topRestaurantCardHeight,
    required this.bottomBarType,
    required this.bottomBarColor,
    required this.titleBarColor,
    required this.mapapikey,
    required this.typeFoods,
    required this.distanceUnit,
    required this.appLanguage,
    required this.copyright,
    required this.copyrightText,
    required this.about,
    required this.faq,
    required this.otp,
    required this.delivering,
    required this.curbsidePickup,
    required this.coupon,
    required this.deliveringTime,
    required this.deliveringDate,
    required this.delivery,
    required this.privacy,
    required this.terms,
    required this.refund,
    required this.refundTextName,
    required this.aboutTextName,
    required this.deliveryTextName,
    required this.privacyTextName,
    required this.termsTextName,
    required this.banner1CardHeight,
    required this.banner2CardHeight,
    required this.googleLoginCa,
    required this.facebookLoginCa,
    required this.defaultLat,
    required this.defaultLng,
    required this.shareAppGooglePlay,
    required this.shareAppAppStore,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        currency: json["currency"],
        darkMode: json["darkMode"],
        rightSymbol: json["rightSymbol"],
        walletEnable: json["walletEnable"],
        symbolDigits: json["symbolDigits"],
        radius: json["radius"],
        shadow: json["shadow"],
        rows: List<String>.from(json["rows"].map((x) => x)),
        mainColor: json["mainColor"],
        iconColorWhiteMode: json["iconColorWhiteMode"],
        iconColorDarkMode: json["iconColorDarkMode"],
        restaurantCardWidth: json["restaurantCardWidth"],
        restaurantCardHeight: json["restaurantCardHeight"],
        restaurantBackgroundColor: json["restaurantBackgroundColor"],
        restaurantCardTextSize: json["restaurantCardTextSize"],
        restaurantCardTextColor: json["restaurantCardTextColor"],
        restaurantTitleColor: json["restaurantTitleColor"],
        dishesTitleColor: json["dishesTitleColor"],
        dishesBackgroundColor: json["dishesBackgroundColor"],
        dishesCardHeight: json["dishesCardHeight"],
        oneInLine: json["oneInLine"],
        categoriesTitleColor: json["categoriesTitleColor"],
        categoriesBackgroundColor: json["categoriesBackgroundColor"],
        categoryCardWidth: json["categoryCardWidth"],
        categoryCardHeight: json["categoryCardHeight"],
        searchBackgroundColor: json["searchBackgroundColor"],
        reviewTitleColor: json["reviewTitleColor"],
        reviewBackgroundColor: json["reviewBackgroundColor"],
        categoryCardCircle: json["categoryCardCircle"],
        topRestaurantCardHeight: json["topRestaurantCardHeight"],
        bottomBarType: json["bottomBarType"],
        bottomBarColor: json["bottomBarColor"],
        titleBarColor: json["titleBarColor"],
        mapapikey: json["mapapikey"],
        typeFoods: json["typeFoods"],
        distanceUnit: json["distanceUnit"],
        appLanguage: json["appLanguage"],
        copyright: json["copyright"],
        copyrightText: json["copyright_text"],
        about: json["about"],
        faq: json["faq"],
        otp: json["otp"],
        delivering: json["delivering"],
        curbsidePickup: json["curbsidePickup"],
        coupon: json["coupon"],
        deliveringTime: json["deliveringTime"],
        deliveringDate: json["deliveringDate"],
        delivery: json["delivery"],
        privacy: json["privacy"],
        terms: json["terms"],
        refund: json["refund"],
        refundTextName: json["refund_text_name"],
        aboutTextName: json["about_text_name"],
        deliveryTextName: json["delivery_text_name"],
        privacyTextName: json["privacy_text_name"],
        termsTextName: json["terms_text_name"],
        banner1CardHeight: json["banner1CardHeight"],
        banner2CardHeight: json["banner2CardHeight"],
        googleLoginCa: json["googleLogin_ca"],
        facebookLoginCa: json["facebookLogin_ca"],
        defaultLat: json["defaultLat"],
        defaultLng: json["defaultLng"],
        shareAppGooglePlay: json["shareAppGooglePlay"],
        shareAppAppStore: json["shareAppAppStore"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "darkMode": darkMode,
        "rightSymbol": rightSymbol,
        "walletEnable": walletEnable,
        "symbolDigits": symbolDigits,
        "radius": radius,
        "shadow": shadow,
        "rows": List<dynamic>.from(rows.map((x) => x)),
        "mainColor": mainColor,
        "iconColorWhiteMode": iconColorWhiteMode,
        "iconColorDarkMode": iconColorDarkMode,
        "restaurantCardWidth": restaurantCardWidth,
        "restaurantCardHeight": restaurantCardHeight,
        "restaurantBackgroundColor": restaurantBackgroundColor,
        "restaurantCardTextSize": restaurantCardTextSize,
        "restaurantCardTextColor": restaurantCardTextColor,
        "restaurantTitleColor": restaurantTitleColor,
        "dishesTitleColor": dishesTitleColor,
        "dishesBackgroundColor": dishesBackgroundColor,
        "dishesCardHeight": dishesCardHeight,
        "oneInLine": oneInLine,
        "categoriesTitleColor": categoriesTitleColor,
        "categoriesBackgroundColor": categoriesBackgroundColor,
        "categoryCardWidth": categoryCardWidth,
        "categoryCardHeight": categoryCardHeight,
        "searchBackgroundColor": searchBackgroundColor,
        "reviewTitleColor": reviewTitleColor,
        "reviewBackgroundColor": reviewBackgroundColor,
        "categoryCardCircle": categoryCardCircle,
        "topRestaurantCardHeight": topRestaurantCardHeight,
        "bottomBarType": bottomBarType,
        "bottomBarColor": bottomBarColor,
        "titleBarColor": titleBarColor,
        "mapapikey": mapapikey,
        "typeFoods": typeFoods,
        "distanceUnit": distanceUnit,
        "appLanguage": appLanguage,
        "copyright": copyright,
        "copyright_text": copyrightText,
        "about": about,
        "faq": faq,
        "otp": otp,
        "delivering": delivering,
        "curbsidePickup": curbsidePickup,
        "coupon": coupon,
        "deliveringTime": deliveringTime,
        "deliveringDate": deliveringDate,
        "delivery": delivery,
        "privacy": privacy,
        "terms": terms,
        "refund": refund,
        "refund_text_name": refundTextName,
        "about_text_name": aboutTextName,
        "delivery_text_name": deliveryTextName,
        "privacy_text_name": privacyTextName,
        "terms_text_name": termsTextName,
        "banner1CardHeight": banner1CardHeight,
        "banner2CardHeight": banner2CardHeight,
        "googleLogin_ca": googleLoginCa,
        "facebookLogin_ca": facebookLoginCa,
        "defaultLat": defaultLat,
        "defaultLng": defaultLng,
        "shareAppGooglePlay": shareAppGooglePlay,
        "shareAppAppStore": shareAppAppStore,
      };
}
