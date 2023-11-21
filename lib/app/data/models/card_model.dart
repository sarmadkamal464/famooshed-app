// To parse this JSON data, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
  String? paymentMethodId;
  String? savedCard;
  String? brand;
  String? country;

  CardModel({
    this.paymentMethodId,
    this.savedCard,
    this.brand,
    this.country,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        paymentMethodId: json["payment_method_id"],
        savedCard: json["saved_card"],
        brand: json["brand"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "payment_method_id": paymentMethodId,
        "saved_card": savedCard,
        "brand": brand,
        "country": country,
      };
}
