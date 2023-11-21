// To parse this JSON data, do
//
//     final favoritesModel = favoritesModelFromJson(jsonString);

import 'dart:convert';

FavoritesModel favoritesModelFromJson(String str) =>
    FavoritesModel.fromJson(json.decode(str));

String favoritesModelToJson(FavoritesModel data) => json.encode(data.toJson());

class FavoritesModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? user;
  Restaurant? restaurant;

  FavoritesModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.restaurant,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) => FavoritesModel(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"],
        restaurant: json["restaurant"] == null
            ? null
            : Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user,
        "restaurant": restaurant?.toJson(),
      };
}

class Restaurant {
  int? id;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? businessName;
  String? businessAddress;
  String? bcity;
  String? bzipcode;
  String? country;
  String? businesstype;
  dynamic cuisineName;
  String? numOfLocation;
  String? delivertype;
  int? published;
  int? delivered;
  String? phone;
  String? mobilephone;
  String? address;
  String? lat;
  String? lng;
  int? imageid;
  int? logoId;
  String? desc;
  String? fee;
  int? merchantCommission;
  int? percent;
  String? bestSeller;
  String? facebook;
  String? instagram;
  dynamic twitter;
  dynamic accountnumber;
  dynamic holderName;
  dynamic bankcode;
  String? bRoutingNumber;
  String? bankType;
  String? cardName;
  String? cardNumber;
  String? cardCvc;
  String? cardMm;
  String? cardYy;
  dynamic stripeId;
  String? openTimeMonday;
  String? closeTimeMonday;
  String? openTimeTuesday;
  String? closeTimeTuesday;
  String? openTimeWednesday;
  String? closeTimeWednesday;
  String? openTimeThursday;
  String? closeTimeThursday;
  String? openTimeFriday;
  String? closeTimeFriday;
  String? openTimeSaturday;
  String? closeTimeSaturday;
  String? openTimeSunday;
  String? closeTimeSunday;
  int? area;
  dynamic cardId;
  dynamic bankId;
  String? minAmount;
  int? perkm;
  dynamic crn;
  int? onlyfamooshed;
  String? image;

  Restaurant({
    this.id,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.businessName,
    this.businessAddress,
    this.bcity,
    this.bzipcode,
    this.country,
    this.businesstype,
    this.cuisineName,
    this.numOfLocation,
    this.delivertype,
    this.published,
    this.delivered,
    this.phone,
    this.mobilephone,
    this.address,
    this.lat,
    this.lng,
    this.imageid,
    this.logoId,
    this.desc,
    this.fee,
    this.merchantCommission,
    this.percent,
    this.bestSeller,
    this.facebook,
    this.instagram,
    this.twitter,
    this.accountnumber,
    this.holderName,
    this.bankcode,
    this.bRoutingNumber,
    this.bankType,
    this.cardName,
    this.cardNumber,
    this.cardCvc,
    this.cardMm,
    this.cardYy,
    this.stripeId,
    this.openTimeMonday,
    this.closeTimeMonday,
    this.openTimeTuesday,
    this.closeTimeTuesday,
    this.openTimeWednesday,
    this.closeTimeWednesday,
    this.openTimeThursday,
    this.closeTimeThursday,
    this.openTimeFriday,
    this.closeTimeFriday,
    this.openTimeSaturday,
    this.closeTimeSaturday,
    this.openTimeSunday,
    this.closeTimeSunday,
    this.area,
    this.cardId,
    this.bankId,
    this.minAmount,
    this.perkm,
    this.crn,
    this.onlyfamooshed,
    this.image,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        businessName: json["business_name"],
        businessAddress: json["business_address"],
        bcity: json["bcity"],
        bzipcode: json["bzipcode"],
        country: json["country"],
        businesstype: json["businesstype"],
        cuisineName: json["cuisine_name"],
        numOfLocation: json["num_of_location"],
        delivertype: json["delivertype"],
        published: json["published"],
        delivered: json["delivered"],
        phone: json["phone"],
        mobilephone: json["mobilephone"],
        address: json["address"],
        lat: json["lat"],
        lng: json["lng"],
        imageid: json["imageid"],
        logoId: json["logoId"],
        desc: json["desc"],
        fee: json["fee"],
        merchantCommission: json["merchant_commission"],
        percent: json["percent"],
        bestSeller: json["best_seller"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        twitter: json["twitter"],
        accountnumber: json["accountnumber"],
        holderName: json["holder_name"],
        bankcode: json["bankcode"],
        bRoutingNumber: json["b_routing_number"],
        bankType: json["bank_type"],
        cardName: json["card_name"],
        cardNumber: json["card_number"],
        cardCvc: json["card_cvc"],
        cardMm: json["card_mm"],
        cardYy: json["card_yy"],
        stripeId: json["stripe_id"],
        openTimeMonday: json["openTimeMonday"],
        closeTimeMonday: json["closeTimeMonday"],
        openTimeTuesday: json["openTimeTuesday"],
        closeTimeTuesday: json["closeTimeTuesday"],
        openTimeWednesday: json["openTimeWednesday"],
        closeTimeWednesday: json["closeTimeWednesday"],
        openTimeThursday: json["openTimeThursday"],
        closeTimeThursday: json["closeTimeThursday"],
        openTimeFriday: json["openTimeFriday"],
        closeTimeFriday: json["closeTimeFriday"],
        openTimeSaturday: json["openTimeSaturday"],
        closeTimeSaturday: json["closeTimeSaturday"],
        openTimeSunday: json["openTimeSunday"],
        closeTimeSunday: json["closeTimeSunday"],
        area: json["area"],
        cardId: json["card_id"],
        bankId: json["bank_id"],
        minAmount: json["minAmount"],
        perkm: json["perkm"],
        crn: json["crn"],
        onlyfamooshed: json["onlyfamooshed"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "business_name": businessName,
        "business_address": businessAddress,
        "bcity": bcity,
        "bzipcode": bzipcode,
        "country": country,
        "businesstype": businesstype,
        "cuisine_name": cuisineName,
        "num_of_location": numOfLocation,
        "delivertype": delivertype,
        "published": published,
        "delivered": delivered,
        "phone": phone,
        "mobilephone": mobilephone,
        "address": address,
        "lat": lat,
        "lng": lng,
        "imageid": imageid,
        "logoId": logoId,
        "desc": desc,
        "fee": fee,
        "merchant_commission": merchantCommission,
        "percent": percent,
        "best_seller": bestSeller,
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "accountnumber": accountnumber,
        "holder_name": holderName,
        "bankcode": bankcode,
        "b_routing_number": bRoutingNumber,
        "bank_type": bankType,
        "card_name": cardName,
        "card_number": cardNumber,
        "card_cvc": cardCvc,
        "card_mm": cardMm,
        "card_yy": cardYy,
        "stripe_id": stripeId,
        "openTimeMonday": openTimeMonday,
        "closeTimeMonday": closeTimeMonday,
        "openTimeTuesday": openTimeTuesday,
        "closeTimeTuesday": closeTimeTuesday,
        "openTimeWednesday": openTimeWednesday,
        "closeTimeWednesday": closeTimeWednesday,
        "openTimeThursday": openTimeThursday,
        "closeTimeThursday": closeTimeThursday,
        "openTimeFriday": openTimeFriday,
        "closeTimeFriday": closeTimeFriday,
        "openTimeSaturday": openTimeSaturday,
        "closeTimeSaturday": closeTimeSaturday,
        "openTimeSunday": openTimeSunday,
        "closeTimeSunday": closeTimeSunday,
        "area": area,
        "card_id": cardId,
        "bank_id": bankId,
        "minAmount": minAmount,
        "perkm": perkm,
        "crn": crn,
        "onlyfamooshed": onlyfamooshed,
        "image": image,
      };
}
