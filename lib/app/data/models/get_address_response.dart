// To parse this JSON data, do
//
//     final getAddresstResponse = getAddresstResponseFromJson(jsonString);

import 'dart:convert';

import 'address_model.dart';

GetAddresstResponse getAddresstResponseFromJson(String str) =>
    GetAddresstResponse.fromJson(json.decode(str));

String getAddresstResponseToJson(GetAddresstResponse data) =>
    json.encode(data.toJson());

class GetAddresstResponse {
  String error;
  List<Address> address;

  GetAddresstResponse({
    required this.error,
    required this.address,
  });

  factory GetAddresstResponse.fromJson(Map<String, dynamic> json) =>
      GetAddresstResponse(
        error: json["error"],
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
      };
}
