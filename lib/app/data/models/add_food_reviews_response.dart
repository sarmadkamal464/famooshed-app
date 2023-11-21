// To parse this JSON data, do
//
//     final addFoodReviewsResponse = addFoodReviewsResponseFromJson(jsonString);

import 'dart:convert';

AddFoodReviewsResponse addFoodReviewsResponseFromJson(String str) =>
    AddFoodReviewsResponse.fromJson(json.decode(str));

String addFoodReviewsResponseToJson(AddFoodReviewsResponse data) =>
    json.encode(data.toJson());

class AddFoodReviewsResponse {
  String error;
  DateTime date;
  List<Review> reviews;

  AddFoodReviewsResponse({
    required this.error,
    required this.date,
    required this.reviews,
  });

  factory AddFoodReviewsResponse.fromJson(Map<String, dynamic> json) =>
      AddFoodReviewsResponse(
        error: json["error"],
        date: DateTime.parse(json["date"]),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "date": date.toIso8601String(),
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
      };
}

class Review {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String desc;
  int user;
  dynamic rate;
  int food;
  String image;
  String userName;

  Review({
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

  factory Review.fromJson(Map<String, dynamic> json) => Review(
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
