// To parse this JSON data, do
//
//     final addressResponse = addressResponseFromJson(jsonString);

import 'dart:convert';

AddressResponse addressResponseFromJson(String str) =>
    AddressResponse.fromJson(json.decode(str));

String addressResponseToJson(AddressResponse data) =>
    json.encode(data.toJson());

class AddressResponse {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? user;
  String? text;
  String? flatHouseNo;
  String? nearByLandmark;
  String? lat;
  String? lng;
  String? type;
  String? addressResponseDefault;

  AddressResponse({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.text,
    this.flatHouseNo,
    this.nearByLandmark,
    this.lat,
    this.lng,
    this.type,
    this.addressResponseDefault,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      AddressResponse(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"],
        text: json["text"],
        flatHouseNo: json["flat_house_no"],
        nearByLandmark: json["near_by_landmark"],
        lat: json["lat"],
        lng: json["lng"],
        type: json["type"],
        addressResponseDefault: json["default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user,
        "text": text,
        "lat": lat,
        "lng": lng,
        "type": type,
        "default": addressResponseDefault,
        "flat_house_no": flatHouseNo,
        "near_by_landmark": nearByLandmark,
      };
}
