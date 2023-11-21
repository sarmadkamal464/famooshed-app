// To parse this JSON data, do
//
//     final getDeliveryTypeResponse = getDeliveryTypeResponseFromJson(jsonString);

import 'dart:convert';

GetDeliveryTypeResponse getDeliveryTypeResponseFromJson(String str) =>
    GetDeliveryTypeResponse.fromJson(json.decode(str));

String getDeliveryTypeResponseToJson(GetDeliveryTypeResponse data) =>
    json.encode(data.toJson());

class GetDeliveryTypeResponse {
  String? error;
  int? homeDeli;
  int? nextDay;
  int? pickUp;
  int? onlyfamooshed;
  int? onlyfamooshedPercent;
  int? homeDeliPercent;
  int? onlyfamooshedPerKm;
  int? homeDeliPerkm;
  String? homeDeliFee;
  String? nextDayFee;
  String? onlyfamooshedFee;

  GetDeliveryTypeResponse({
    this.error,
    this.homeDeli,
    this.nextDay,
    this.pickUp,
    this.onlyfamooshed,
    this.onlyfamooshedPercent,
    this.homeDeliPercent,
    this.onlyfamooshedPerKm,
    this.homeDeliPerkm,
    this.homeDeliFee,
    this.nextDayFee,
    this.onlyfamooshedFee,
  });

  factory GetDeliveryTypeResponse.fromJson(Map<String, dynamic> json) =>
      GetDeliveryTypeResponse(
        error: json["error"],
        homeDeli: json["home_deli"],
        nextDay: json["next_day"],
        pickUp: json["pick_up"],
        onlyfamooshed: json["onlyfamooshed"],
        onlyfamooshedPercent: json["onlyfamooshed_percent"],
        homeDeliPercent: json["home_deli_percent"],
        onlyfamooshedPerKm: json["onlyfamooshed_PerKm"],
        homeDeliPerkm: json["home_deli_perkm"],
        homeDeliFee: json["home_deli_fee"],
        nextDayFee: json["next_day_fee"],
        onlyfamooshedFee: json["onlyfamooshed_fee"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "home_deli": homeDeli,
        "next_day": nextDay,
        "pick_up": pickUp,
        "onlyfamooshed": onlyfamooshed,
        "onlyfamooshed_percent": onlyfamooshedPercent,
        "home_deli_percent": homeDeliPercent,
        "onlyfamooshed_PerKm": onlyfamooshedPerKm,
        "home_deli_perkm": homeDeliPerkm,
        "home_deli_fee": homeDeliFee,
        "next_day_fee": nextDayFee,
        "onlyfamooshed_fee": onlyfamooshedFee,
      };
}
