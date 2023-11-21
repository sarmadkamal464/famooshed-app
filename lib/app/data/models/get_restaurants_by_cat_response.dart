// To parse this JSON data, do
//
//     final getRestaurantByCatResponse = getRestaurantByCatResponseFromJson(jsonString);

import 'dart:convert';

GetRestaurantByCatResponse getRestaurantByCatResponseFromJson(String str) =>
    GetRestaurantByCatResponse.fromJson(json.decode(str));

String getRestaurantByCatResponseToJson(GetRestaurantByCatResponse data) =>
    json.encode(data.toJson());

class GetRestaurantByCatResponse {
  String error;
  List<Allcat> category;
  List<Allcat> allcat;
  List<RestaurantByCat> restaurantByCat;

  GetRestaurantByCatResponse({
    required this.error,
    required this.category,
    required this.allcat,
    required this.restaurantByCat,
  });

  factory GetRestaurantByCatResponse.fromJson(Map<String, dynamic> json) =>
      GetRestaurantByCatResponse(
        error: json["error"],
        category:
            List<Allcat>.from(json["category"].map((x) => Allcat.fromJson(x))),
        allcat:
            List<Allcat>.from(json["allcat"].map((x) => Allcat.fromJson(x))),
        restaurantByCat: List<RestaurantByCat>.from(
            json["restaurantByCat"].map((x) => RestaurantByCat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "allcat": List<dynamic>.from(allcat.map((x) => x.toJson())),
        "restaurantByCat":
            List<dynamic>.from(restaurantByCat.map((x) => x.toJson())),
      };
}

class Allcat {
  int id;
  String name;
  String image;

  Allcat({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Allcat.fromJson(Map<String, dynamic> json) => Allcat(
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

// class RestaurantByCat {
//   int id;
//   String name;
//   String desc;
//   String businessAddress;
//   String phone;
//   String image;
//   String favStatus;
//
//   RestaurantByCat({
//     required this.id,
//     required this.name,
//     required this.desc,
//     required this.businessAddress,
//     required this.phone,
//     required this.image,
//     required this.favStatus,
//   });
//
//   factory RestaurantByCat.fromJson(Map<String, dynamic> json) =>
//       RestaurantByCat(
//         id: json["id"],
//         name: json["name"],
//         desc: json["desc"],
//         businessAddress: json["business_address"],
//         phone: json["phone"],
//         image: json["image"],
//         favStatus: json["favStatus"] ?? 'false',
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "desc": desc,
//         "business_address": businessAddress,
//         "phone": phone,
//         "image": image,
//         "favStatus": favStatus,
//       };
// }

class RestaurantByCat {
  int? id;
  String? name;
  String? lat;
  String? lng;
  String? desc;
  String? businessAddress;
  String? phone;
  String? image;
  int? numberOfRating;
  int? rate;
  String? favStatus;

  RestaurantByCat({
    this.id,
    this.name,
    this.lat,
    this.lng,
    this.desc,
    this.businessAddress,
    this.phone,
    this.image,
    this.numberOfRating,
    this.rate,
    this.favStatus,
  });

  factory RestaurantByCat.fromJson(Map<String, dynamic> json) =>
      RestaurantByCat(
        id: json["id"],
        name: json["name"],
        lat: json["lat"],
        lng: json["lng"],
        desc: json["desc"],
        businessAddress: json["business_address"],
        phone: json["phone"],
        image: json["image"],
        numberOfRating: json["number_of_rating"],
        rate: json["rate"],
        favStatus: json["favStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lat": lat,
        "lng": lng,
        "desc": desc,
        "business_address": businessAddress,
        "phone": phone,
        "image": image,
        "number_of_rating": numberOfRating,
        "rate": rate,
        "favStatus": favStatus,
      };
}
