// To parse this JSON data, do
//
//     final getSecondStepResponse = getSecondStepResponseFromJson(jsonString);

import 'dart:convert';

GetSecondStepResponse getSecondStepResponseFromJson(String str) =>
    GetSecondStepResponse.fromJson(json.decode(str));

String getSecondStepResponseToJson(GetSecondStepResponse data) =>
    json.encode(data.toJson());

class GetSecondStepResponse {
  String error;
  List<BannerData> banner1;
  List<BannerData> banner2;

  GetSecondStepResponse({
    required this.error,
    required this.banner1,
    required this.banner2,
  });

  factory GetSecondStepResponse.fromJson(Map<String, dynamic> json) =>
      GetSecondStepResponse(
        error: json["error"],
        banner1: List<BannerData>.from(
            json["banner1"].map((x) => BannerData.fromJson(x))),
        banner2: List<BannerData>.from(
            json["banner2"].map((x) => BannerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "banner1": List<dynamic>.from(banner1.map((x) => x.toJson())),
        "banner2": List<dynamic>.from(banner2.map((x) => x.toJson())),
      };
}

class BannerData {
  int id;
  String type;
  String details;
  String position;
  String image;

  BannerData({
    required this.id,
    required this.type,
    required this.details,
    required this.position,
    required this.image,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        id: json["id"],
        type: json["type"],
        details: json["details"],
        position: json["position"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "details": details,
        "position": position,
        "image": image,
      };
}
