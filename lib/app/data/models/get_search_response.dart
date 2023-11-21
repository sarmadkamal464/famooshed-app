// To parse this JSON data, do
//
//     final getSearchResponse = getSearchResponseFromJson(jsonString);

import 'dart:convert';

GetSearchResponse getSearchResponseFromJson(String str) =>
    GetSearchResponse.fromJson(json.decode(str));

String getSearchResponseToJson(GetSearchResponse data) =>
    json.encode(data.toJson());

class GetSearchResponse {
  String error;
  List<Food> foods;
  dynamic search;
  String defaultTax;
  String currency;

  GetSearchResponse({
    required this.error,
    required this.foods,
    required this.search,
    required this.defaultTax,
    required this.currency,
  });

  factory GetSearchResponse.fromJson(Map<String, dynamic> json) =>
      GetSearchResponse(
        error: json["error"],
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
        search: json["search"],
        defaultTax: json["default_tax"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "search": search,
        "default_tax": defaultTax,
        "currency": currency,
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
  int weight;
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
  List<Merchantstripe> merchantstripe;
  List<dynamic> nutritionsdata;
  List<dynamic> extrasdata;
  List<dynamic> foodsreviews;
  List<dynamic> variants;
  List<Rproduct> rproducts;

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
        merchantstripe: List<Merchantstripe>.from(
            json["merchantstripe"].map((x) => Merchantstripe.fromJson(x))),
        nutritionsdata:
            List<dynamic>.from(json["nutritionsdata"].map((x) => x)),
        extrasdata: List<dynamic>.from(json["extrasdata"].map((x) => x)),
        foodsreviews: List<dynamic>.from(json["foodsreviews"].map((x) => x)),
        variants: List<dynamic>.from(json["variants"].map((x) => x)),
        rproducts: List<Rproduct>.from(
            json["rproducts"].map((x) => Rproduct.fromJson(x))),
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
        "merchantstripe":
            List<dynamic>.from(merchantstripe.map((x) => x.toJson())),
        "nutritionsdata": List<dynamic>.from(nutritionsdata.map((x) => x)),
        "extrasdata": List<dynamic>.from(extrasdata.map((x) => x)),
        "foodsreviews": List<dynamic>.from(foodsreviews.map((x) => x)),
        "variants": List<dynamic>.from(variants.map((x) => x)),
        "rproducts": List<dynamic>.from(rproducts.map((x) => x.toJson())),
      };
}

class Merchantstripe {
  dynamic stripeId;

  Merchantstripe({
    this.stripeId,
  });

  factory Merchantstripe.fromJson(Map<String, dynamic> json) => Merchantstripe(
        stripeId: json["stripe_id"],
      );

  Map<String, dynamic> toJson() => {
        "stripe_id": stripeId,
      };
}

class Rproduct {
  int rp;

  Rproduct({
    required this.rp,
  });

  factory Rproduct.fromJson(Map<String, dynamic> json) => Rproduct(
        rp: json["rp"],
      );

  Map<String, dynamic> toJson() => {
        "rp": rp,
      };
}
