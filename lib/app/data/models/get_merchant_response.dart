// To parse this JSON data, do
//
//     final getMerchantResponse = getMerchantResponseFromJson(jsonString);

import 'dart:convert';

GetMerchantResponse getMerchantResponseFromJson(String str) =>
    GetMerchantResponse.fromJson(json.decode(str));

String getMerchantResponseToJson(GetMerchantResponse data) =>
    json.encode(data.toJson());

class GetMerchantResponse {
  String error;
  Restaurant restaurant;
  List<Restaurantsoffer> restaurantsoffers;
  List<Category> categories;
  List<Food> foods;
  String defaultTax;
  String currency;
  List<Sreview> restaurantsreviews;

  GetMerchantResponse({
    required this.error,
    required this.restaurant,
    required this.restaurantsoffers,
    required this.categories,
    required this.foods,
    required this.defaultTax,
    required this.currency,
    required this.restaurantsreviews,
  });

  factory GetMerchantResponse.fromJson(Map<String, dynamic> json) =>
      GetMerchantResponse(
        error: json["error"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
        restaurantsoffers: List<Restaurantsoffer>.from(
            json["restaurantsoffers"].map((x) => Restaurantsoffer.fromJson(x))),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
        defaultTax: json["default_tax"],
        currency: json["currency"],
        restaurantsreviews: List<Sreview>.from(
            json["restaurantsreviews"].map((x) => Sreview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "restaurant": restaurant.toJson(),
        "restaurantsoffers":
            List<dynamic>.from(restaurantsoffers.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "default_tax": defaultTax,
        "currency": currency,
        "restaurantsreviews":
            List<dynamic>.from(restaurantsreviews.map((x) => x.toJson())),
      };
}

class Food {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  int imageid;
  String price;
  String discountprice;
  String desc;
  int restaurant;
  int category;
  String ingredients;
  String unit;
  int packageCount;
  String weight;
  int canDelivery;
  int stars;
  int published;
  int extras;
  int nutritions;
  dynamic images;
  String image;
  String restaurantName;
  String restaurantPhone;
  String restaurantMobilePhone;
  String fee;
  int percent;
  int merchantCommission;
  List<dynamic> merchantstripe;
  List<dynamic> nutritionsdata;
  List<dynamic> extrasdata;
  List<Sreview> foodsreviews;
  List<dynamic> variants;
  List<dynamic> rproducts;
  int? itemStock;

  Food({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.imageid,
    required this.price,
    required this.discountprice,
    required this.desc,
    required this.restaurant,
    required this.category,
    required this.ingredients,
    required this.unit,
    required this.packageCount,
    required this.weight,
    required this.canDelivery,
    required this.stars,
    required this.published,
    required this.extras,
    required this.nutritions,
    this.images,
    required this.image,
    required this.restaurantName,
    required this.restaurantPhone,
    required this.restaurantMobilePhone,
    required this.fee,
    required this.percent,
    required this.merchantCommission,
    required this.merchantstripe,
    required this.nutritionsdata,
    required this.extrasdata,
    required this.foodsreviews,
    required this.variants,
    required this.rproducts,
    required this.itemStock,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        imageid: json["imageid"],
        price: json["price"],
        discountprice: json["discountprice"],
        desc: json["desc"],
        restaurant: json["restaurant"],
        category: json["category"],
        ingredients: json["ingredients"],
        unit: json["unit"],
        packageCount: json["packageCount"],
        weight: json["weight"],
        canDelivery: json["canDelivery"],
        stars: json["stars"],
        published: json["published"],
        extras: json["extras"],
        nutritions: json["nutritions"],
        images: json["images"],
        image: json["image"],
        restaurantName: json["restaurantName"],
        restaurantPhone: json["restaurantPhone"],
        restaurantMobilePhone: json["restaurantMobilePhone"],
        fee: json["fee"],
        percent: json["percent"],
        merchantCommission: json["merchant_commission"],
        itemStock: json["invenotory_stock"] ?? 0,
        merchantstripe:
            List<dynamic>.from(json["merchantstripe"].map((x) => x)),
        nutritionsdata:
            List<dynamic>.from(json["nutritionsdata"].map((x) => x)),
        extrasdata: List<dynamic>.from(json["extrasdata"].map((x) => x)),
        foodsreviews: List<Sreview>.from(
            json["foodsreviews"].map((x) => Sreview.fromJson(x))),
        variants: List<dynamic>.from(json["variants"].map((x) => x)),
        rproducts: List<dynamic>.from(json["rproducts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "imageid": imageid,
        "price": price,
        "discountprice": discountprice,
        "desc": desc,
        "restaurant": restaurant,
        "category": category,
        "ingredients": ingredients,
        "unit": unit,
        "packageCount": packageCount,
        "weight": weight,
        "canDelivery": canDelivery,
        "stars": stars,
        "published": published,
        "extras": extras,
        "nutritions": nutritions,
        "images": images,
        "image": image,
        "restaurantName": restaurantName,
        "restaurantPhone": restaurantPhone,
        "restaurantMobilePhone": restaurantMobilePhone,
        "fee": fee,
        "percent": percent,
        "merchant_commission": merchantCommission,
        "invenotory_stock": itemStock,
        "merchantstripe": List<dynamic>.from(merchantstripe.map((x) => x)),
        "nutritionsdata": List<dynamic>.from(nutritionsdata.map((x) => x)),
        "extrasdata": List<dynamic>.from(extrasdata.map((x) => x)),
        "foodsreviews": List<dynamic>.from(foodsreviews.map((x) => x.toJson())),
        "variants": List<dynamic>.from(variants.map((x) => x)),
        "rproducts": List<dynamic>.from(rproducts.map((x) => x)),
      };
}

class Sreview {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String desc;
  int user;
  String rate;
  int? food;
  String image;
  String? userName;
  int? restaurant;
  dynamic name;

  Sreview({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.desc,
    required this.user,
    required this.rate,
    this.food,
    required this.image,
    this.userName,
    this.restaurant,
    this.name,
  });

  factory Sreview.fromJson(Map<String, dynamic> json) => Sreview(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        desc: json["desc"],
        user: json["user"],
        rate: json["rate"],
        food: json["food"],
        image: json["image"],
        userName: json["userName"],
        restaurant: json["restaurant"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "desc": desc,
        "user": user,
        "rate": rate,
        "food": food,
        "image": image,
        "userName": userName,
        "restaurant": restaurant,
        "name": name,
      };
}

class Restaurant {
  int id;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String businessName;
  String businessAddress;
  String bcity;
  String bzipcode;
  String country;
  String businesstype;
  dynamic cuisineName;
  String numOfLocation;
  String delivertype;
  int published;
  int delivered;
  String phone;
  String mobilephone;
  String address;
  String lat;
  String lng;
  int imageid;
  int logoId;
  String desc;
  String fee;
  int merchantCommission;
  int percent;
  String bestSeller;
  String facebook;
  String instagram;
  dynamic twitter;
  dynamic accountnumber;
  dynamic holderName;
  dynamic bankcode;
  String bRoutingNumber;
  String bankType;
  String cardName;
  String cardNumber;
  String cardCvc;
  String cardMm;
  String cardYy;
  dynamic stripeId;
  String openTimeMonday;
  String closeTimeMonday;
  String openTimeTuesday;
  String closeTimeTuesday;
  String openTimeWednesday;
  String closeTimeWednesday;
  String openTimeThursday;
  String closeTimeThursday;
  String openTimeFriday;
  String closeTimeFriday;
  String openTimeSaturday;
  String closeTimeSaturday;
  String openTimeSunday;
  String closeTimeSunday;
  int area;
  dynamic cardId;
  dynamic bankId;
  String minAmount;
  int perkm;
  dynamic crn;
  int onlyfamooshed;
  int isFeatured;
  String image;

  Restaurant({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.businessName,
    required this.businessAddress,
    required this.bcity,
    required this.bzipcode,
    required this.country,
    required this.businesstype,
    this.cuisineName,
    required this.numOfLocation,
    required this.delivertype,
    required this.published,
    required this.delivered,
    required this.phone,
    required this.mobilephone,
    required this.address,
    required this.lat,
    required this.lng,
    required this.imageid,
    required this.logoId,
    required this.desc,
    required this.fee,
    required this.merchantCommission,
    required this.percent,
    required this.bestSeller,
    required this.facebook,
    required this.instagram,
    required this.twitter,
    required this.accountnumber,
    required this.holderName,
    this.bankcode,
    required this.bRoutingNumber,
    required this.bankType,
    required this.cardName,
    required this.cardNumber,
    required this.cardCvc,
    required this.cardMm,
    required this.cardYy,
    required this.stripeId,
    required this.openTimeMonday,
    required this.closeTimeMonday,
    required this.openTimeTuesday,
    required this.closeTimeTuesday,
    required this.openTimeWednesday,
    required this.closeTimeWednesday,
    required this.openTimeThursday,
    required this.closeTimeThursday,
    required this.openTimeFriday,
    required this.closeTimeFriday,
    required this.openTimeSaturday,
    required this.closeTimeSaturday,
    required this.openTimeSunday,
    required this.closeTimeSunday,
    required this.area,
    this.cardId,
    required this.bankId,
    required this.minAmount,
    required this.perkm,
    this.crn,
    required this.onlyfamooshed,
    required this.image,
    required this.isFeatured,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        businessName: json["business_name"],
        businessAddress: json["business_address"],
        bcity: json["bcity"],
        bzipcode: json["bzipcode"],
        country: json["country"],
        businesstype: json["businesstype"],
        cuisineName: json["cuisine_name"],
        numOfLocation: json["num_of_location"],
        delivertype: json["delivertype"],
        published: json["published"],
        delivered: json["delivered"],
        phone: json["phone"],
        mobilephone: json["mobilephone"],
        address: json["address"],
        lat: json["lat"],
        lng: json["lng"],
        imageid: json["imageid"],
        logoId: json["logoId"],
        desc: json["desc"],
        fee: json["fee"],
        merchantCommission: json["merchant_commission"],
        percent: json["percent"],
        bestSeller: json["best_seller"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        twitter: json["twitter"],
        accountnumber: json["accountnumber"],
        holderName: json["holder_name"],
        bankcode: json["bankcode"],
        bRoutingNumber: json["b_routing_number"],
        bankType: json["bank_type"],
        cardName: json["card_name"],
        cardNumber: json["card_number"],
        cardCvc: json["card_cvc"],
        cardMm: json["card_mm"],
        cardYy: json["card_yy"],
        stripeId: json["stripe_id"],
        openTimeMonday: json["openTimeMonday"],
        closeTimeMonday: json["closeTimeMonday"],
        openTimeTuesday: json["openTimeTuesday"],
        closeTimeTuesday: json["closeTimeTuesday"],
        openTimeWednesday: json["openTimeWednesday"],
        closeTimeWednesday: json["closeTimeWednesday"],
        openTimeThursday: json["openTimeThursday"],
        closeTimeThursday: json["closeTimeThursday"],
        openTimeFriday: json["openTimeFriday"],
        closeTimeFriday: json["closeTimeFriday"],
        openTimeSaturday: json["openTimeSaturday"],
        closeTimeSaturday: json["closeTimeSaturday"],
        openTimeSunday: json["openTimeSunday"],
        closeTimeSunday: json["closeTimeSunday"],
        area: json["area"],
        cardId: json["card_id"],
        bankId: json["bank_id"],
        minAmount: json["minAmount"],
        perkm: json["perkm"],
        crn: json["crn"],
        onlyfamooshed: json["onlyfamooshed"],
        image: json["image"],
        isFeatured: json["is_featured"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "business_name": businessName,
        "business_address": businessAddress,
        "bcity": bcity,
        "bzipcode": bzipcode,
        "country": country,
        "businesstype": businesstype,
        "cuisine_name": cuisineName,
        "num_of_location": numOfLocation,
        "delivertype": delivertype,
        "published": published,
        "delivered": delivered,
        "phone": phone,
        "mobilephone": mobilephone,
        "address": address,
        "lat": lat,
        "lng": lng,
        "imageid": imageid,
        "logoId": logoId,
        "desc": desc,
        "fee": fee,
        "merchant_commission": merchantCommission,
        "percent": percent,
        "best_seller": bestSeller,
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "accountnumber": accountnumber,
        "holder_name": holderName,
        "bankcode": bankcode,
        "b_routing_number": bRoutingNumber,
        "bank_type": bankType,
        "card_name": cardName,
        "card_number": cardNumber,
        "card_cvc": cardCvc,
        "card_mm": cardMm,
        "card_yy": cardYy,
        "stripe_id": stripeId,
        "openTimeMonday": openTimeMonday,
        "closeTimeMonday": closeTimeMonday,
        "openTimeTuesday": openTimeTuesday,
        "closeTimeTuesday": closeTimeTuesday,
        "openTimeWednesday": openTimeWednesday,
        "closeTimeWednesday": closeTimeWednesday,
        "openTimeThursday": openTimeThursday,
        "closeTimeThursday": closeTimeThursday,
        "openTimeFriday": openTimeFriday,
        "closeTimeFriday": closeTimeFriday,
        "openTimeSaturday": openTimeSaturday,
        "closeTimeSaturday": closeTimeSaturday,
        "openTimeSunday": openTimeSunday,
        "closeTimeSunday": closeTimeSunday,
        "area": area,
        "card_id": cardId,
        "bank_id": bankId,
        "minAmount": minAmount,
        "perkm": perkm,
        "crn": crn,
        "onlyfamooshed": onlyfamooshed,
        "image": image,
        "is_featured": isFeatured,
      };
}

class Restaurantsoffer {
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

  Restaurantsoffer({
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

  factory Restaurantsoffer.fromJson(Map<String, dynamic> json) =>
      Restaurantsoffer(
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

class Category {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  int? imageid;
  String? desc;
  int? visible;
  int? parent;
  int? featuredCat;
  String? restUserId;
  String? categoryType;
  String? image;

  Category({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.imageid,
    this.desc,
    this.visible,
    this.parent,
    this.featuredCat,
    this.restUserId,
    this.categoryType,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        imageid: json["imageid"],
        desc: json["desc"],
        visible: json["visible"],
        parent: json["parent"],
        featuredCat: json["featured_cat"],
        restUserId: json["rest_user_id"],
        categoryType: json["category_type"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "imageid": imageid,
        "desc": desc,
        "visible": visible,
        "parent": parent,
        "featured_cat": featuredCat,
        "rest_user_id": restUserId,
        "category_type": categoryType,
        "image": image,
      };
}
