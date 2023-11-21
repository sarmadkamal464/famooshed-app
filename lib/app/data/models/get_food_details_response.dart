// To parse this JSON data, do
//
//     final getFoodDetailsResponse = getFoodDetailsResponseFromJson(jsonString);

import 'dart:convert';

GetFoodDetailsResponse getFoodDetailsResponseFromJson(String str) =>
    GetFoodDetailsResponse.fromJson(json.decode(str));

String getFoodDetailsResponseToJson(GetFoodDetailsResponse data) =>
    json.encode(data.toJson());

class GetFoodDetailsResponse {
  String error;
  String id;
  String image;
  List<Food> foods;
  List<SimilarFood> similarFood;
  String defaultTax;
  String currency;
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
  String restaurantName;
  String restaurantPhone;
  String restaurantMobilePhone;
  String fee;
  int percent;
  int merchantCommission;
  List<dynamic> merchantstripe;
  List<dynamic> nutritionsdata;
  List<dynamic> extrasdata;
  List<dynamic> foodsreviews;
  List<dynamic> variants;
  List<dynamic> rproducts;

  GetFoodDetailsResponse({
    required this.error,
    required this.id,
    required this.image,
    required this.foods,
    required this.similarFood,
    required this.defaultTax,
    required this.currency,
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

  factory GetFoodDetailsResponse.fromJson(Map<String, dynamic> json) =>
      GetFoodDetailsResponse(
        error: json["error"],
        id: json["id"],
        image: json["image"],
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
        similarFood: List<SimilarFood>.from(
            json["similarFood"].map((x) => SimilarFood.fromJson(x))),
        defaultTax: json["default_tax"],
        currency: json["currency"],
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
        restaurantName: json["restaurantName"],
        restaurantPhone: json["restaurantPhone"],
        restaurantMobilePhone: json["restaurantMobilePhone"],
        fee: json["fee"],
        percent: json["percent"],
        merchantCommission: json["merchant_commission"],
        merchantstripe: json["merchantstripe"] != null
            ? List<dynamic>.from(json["merchantstripe"].map((x) => x))
            : [],
        nutritionsdata: json["nutritionsdata"] != null
            ? List<dynamic>.from(json["nutritionsdata"].map((x) => x))
            : [],
        extrasdata: json["extrasdata"] != null
            ? List<dynamic>.from(json["extrasdata"].map((x) => x))
            : [],
        foodsreviews: json["foodsreviews"] != null
            ? List<dynamic>.from(json["foodsreviews"].map((x) => x))
            : [],
        variants: json["variants"] != null
            ? List<dynamic>.from(json["variants"].map((x) => x))
            : [],
        rproducts: json["rproducts"] != null
            ? List<dynamic>.from(json["rproducts"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "id": id,
        "image": image,
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "default_tax": defaultTax,
        "currency": currency,
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
        "restaurantName": restaurantName,
        "restaurantPhone": restaurantPhone,
        "restaurantMobilePhone": restaurantMobilePhone,
        "fee": fee,
        "percent": percent,
        "merchant_commission": merchantCommission,
        "merchantstripe": List<dynamic>.from(merchantstripe.map((x) => x)),
        "nutritionsdata": List<dynamic>.from(nutritionsdata.map((x) => x)),
        "extrasdata": List<dynamic>.from(extrasdata.map((x) => x)),
        "foodsreviews": List<dynamic>.from(foodsreviews.map((x) => x)),
        "variants": List<dynamic>.from(variants.map((x) => x)),
        "rproducts": List<dynamic>.from(rproducts.map((x) => x)),
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
  List<Foodsreview> foodsreviews;
  List<dynamic> variants;
  List<dynamic> rproducts;

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
        merchantstripe:
            List<dynamic>.from(json["merchantstripe"].map((x) => x)),
        nutritionsdata:
            List<dynamic>.from(json["nutritionsdata"].map((x) => x)),
        extrasdata: List<dynamic>.from(json["extrasdata"].map((x) => x)),
        foodsreviews: List<Foodsreview>.from(
            json["foodsreviews"].map((x) => Foodsreview.fromJson(x))),
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
        "merchantstripe": List<dynamic>.from(merchantstripe.map((x) => x)),
        "nutritionsdata": List<dynamic>.from(nutritionsdata.map((x) => x)),
        "extrasdata": List<dynamic>.from(extrasdata.map((x) => x)),
        "foodsreviews": List<dynamic>.from(foodsreviews.map((x) => x.toJson())),
        "variants": List<dynamic>.from(variants.map((x) => x)),
        "rproducts": List<dynamic>.from(rproducts.map((x) => x)),
      };
}

class Foodsreview {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String desc;
  int user;
  String rate;
  int food;
  String image;
  String userName;

  Foodsreview({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.desc,
    required this.user,
    required this.rate,
    required this.food,
    required this.image,
    required this.userName,
  });

  factory Foodsreview.fromJson(Map<String, dynamic> json) => Foodsreview(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        desc: json["desc"],
        user: json["user"],
        rate: json["rate"],
        food: json["food"],
        image: json["image"],
        userName: json["userName"],
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
      };
}

class SimilarFood {
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

  SimilarFood({
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
  });

  factory SimilarFood.fromJson(Map<String, dynamic> json) => SimilarFood(
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
      };
}
