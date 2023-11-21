// To parse this JSON data, do
//
//     final saveAddresstResponse = saveAddresstResponseFromJson(jsonString);

import 'dart:convert';

import 'address_model.dart';

SaveAddresstResponse saveAddresstResponseFromJson(String str) =>
    SaveAddresstResponse.fromJson(json.decode(str));

String saveAddresstResponseToJson(SaveAddresstResponse data) =>
    json.encode(data.toJson());

class SaveAddresstResponse {
  String error;
  List<Address> address;

  SaveAddresstResponse({
    required this.error,
    required this.address,
  });

  factory SaveAddresstResponse.fromJson(Map<String, dynamic> json) =>
      SaveAddresstResponse(
        error: json["error"],
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
      };
}
