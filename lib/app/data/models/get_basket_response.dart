// To parse this JSON data, do
//
//     final getBasketResponse = getBasketResponseFromJson(jsonString);

import 'dart:convert';

GetBasketResponse getBasketResponseFromJson(String str) =>
    GetBasketResponse.fromJson(json.decode(str));

String getBasketResponseToJson(GetBasketResponse data) =>
    json.encode(data.toJson());

class GetBasketResponse {
  String error;
  String currency;
  dynamic defaultTax;
  Order order;
  List<Orderdetail> orderdetails;
  String shippingFee;
  dynamic discount;
  int perkm;
  int percent;
  RestaurantData restaurantData;
  String basketTotal;
  String basketTotalWithTax;
  String taxAmount;

  GetBasketResponse({
    required this.error,
    required this.currency,
    required this.defaultTax,
    required this.order,
    required this.orderdetails,
    required this.shippingFee,
    required this.discount,
    required this.perkm,
    required this.percent,
    required this.restaurantData,
    required this.basketTotal,
    required this.basketTotalWithTax,
    required this.taxAmount,
  });

  factory GetBasketResponse.fromJson(Map<String, dynamic> json) =>
      GetBasketResponse(
        error: json["error"],
        currency: json["currency"],
        defaultTax: json["default_tax"],
        order: Order.fromJson(json["order"]),
        orderdetails: List<Orderdetail>.from(
            json["orderdetails"].map((x) => Orderdetail.fromJson(x))),
        shippingFee: json["shippingFee"],
        discount: json["discount"],
        perkm: json["perkm"],
        percent: json["percent"],
        restaurantData: RestaurantData.fromJson(json["restaurantData"]),
        basketTotal: json["basketTotal"],
        basketTotalWithTax: json["basketTotalWithTax"].toString(),
        taxAmount: json["taxAmount"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "currency": currency,
        "default_tax": defaultTax,
        "order": order.toJson(),
        "orderdetails": List<dynamic>.from(orderdetails.map((x) => x.toJson())),
        "shippingFee": shippingFee,
        "discount": discount,
        "perkm": perkm,
        "percent": percent,
        "restaurantData": restaurantData.toJson(),
        "basketTotal": basketTotal,
        "basketTotalWithTax": basketTotalWithTax,
        "taxAmount": taxAmount,
      };
}

class Order {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int user;
  int driver;
  int status;
  String pstatus;
  String tax;
  String hint;
  int active;
  int restaurant;
  String method;
  String total;
  String fee;
  int send;
  String address;
  String phone;
  String lat;
  String lng;
  int percent;
  String curbsidePickup;
  dynamic arrived;
  String couponName;
  int commissionPay;
  dynamic imageProof;
  int perkm;
  int driverCommissionPay;
  String refundStatus;
  int refundAmount;

  Order({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.driver,
    required this.status,
    required this.pstatus,
    required this.tax,
    required this.hint,
    required this.active,
    required this.restaurant,
    required this.method,
    required this.total,
    required this.fee,
    required this.send,
    required this.address,
    required this.phone,
    required this.lat,
    required this.lng,
    required this.percent,
    required this.curbsidePickup,
    this.arrived,
    required this.couponName,
    required this.commissionPay,
    this.imageProof,
    required this.perkm,
    required this.driverCommissionPay,
    required this.refundStatus,
    required this.refundAmount,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: json["user"],
        driver: json["driver"],
        status: json["status"],
        pstatus: json["pstatus"],
        tax: json["tax"],
        hint: json["hint"],
        active: json["active"],
        restaurant: json["restaurant"],
        method: json["method"],
        total: json["total"],
        fee: json["fee"],
        send: json["send"],
        address: json["address"],
        phone: json["phone"],
        lat: json["lat"],
        lng: json["lng"],
        percent: json["percent"],
        curbsidePickup: json["curbsidePickup"],
        arrived: json["arrived"],
        couponName: json["couponName"],
        commissionPay: json["commission_pay"],
        imageProof: json["image_proof"],
        perkm: json["perkm"],
        driverCommissionPay: json["driver_commission_pay"],
        refundStatus: json["refund_status"],
        refundAmount: json["refund_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user,
        "driver": driver,
        "status": status,
        "pstatus": pstatus,
        "tax": tax,
        "hint": hint,
        "active": active,
        "restaurant": restaurant,
        "method": method,
        "total": total,
        "fee": fee,
        "send": send,
        "address": address,
        "phone": phone,
        "lat": lat,
        "lng": lng,
        "percent": percent,
        "curbsidePickup": curbsidePickup,
        "arrived": arrived,
        "couponName": couponName,
        "commission_pay": commissionPay,
        "image_proof": imageProof,
        "perkm": perkm,
        "driver_commission_pay": driverCommissionPay,
        "refund_status": refundStatus,
        "refund_amount": refundAmount,
      };
}

class Orderdetail {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int order;
  String food;
  int count;
  String foodprice;
  String extras;
  int extrascount;
  String extrasprice;
  int foodid;
  int extrasid;
  String image;
  int category;

  Orderdetail({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.order,
    required this.food,
    required this.count,
    required this.foodprice,
    required this.extras,
    required this.extrascount,
    required this.extrasprice,
    required this.foodid,
    required this.extrasid,
    required this.image,
    required this.category,
  });

  factory Orderdetail.fromJson(Map<String, dynamic> json) => Orderdetail(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        order: json["order"],
        food: json["food"],
        count: json["count"],
        foodprice: json["foodprice"],
        extras: json["extras"],
        extrascount: json["extrascount"],
        extrasprice: json["extrasprice"],
        foodid: json["foodid"],
        extrasid: json["extrasid"],
        image: json["image"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "order": order,
        "food": food,
        "count": count,
        "foodprice": foodprice,
        "extras": extras,
        "extrascount": extrascount,
        "extrasprice": extrasprice,
        "foodid": foodid,
        "extrasid": extrasid,
        "image": image,
        "category": category,
      };
}

class RestaurantData {
  int id;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String businessName;
  String businessAddress;
  String bcity;
  String bzipcode;
  String country;
  String businesstype;
  dynamic cuisineName;
  String numOfLocation;
  String delivertype;
  int published;
  int delivered;
  String phone;
  String mobilephone;
  String address;
  String lat;
  String lng;
  int imageid;
  int logoId;
  String desc;
  String fee;
  int merchantCommission;
  int percent;
  String bestSeller;
  String facebook;
  String instagram;
  dynamic twitter;
  dynamic accountnumber;
  dynamic holderName;
  dynamic bankcode;
  String bRoutingNumber;
  String bankType;
  String cardName;
  String cardNumber;
  String cardCvc;
  String cardMm;
  String cardYy;
  dynamic stripeId;
  String openTimeMonday;
  String closeTimeMonday;
  String openTimeTuesday;
  String closeTimeTuesday;
  String openTimeWednesday;
  String closeTimeWednesday;
  String openTimeThursday;
  String closeTimeThursday;
  String openTimeFriday;
  String closeTimeFriday;
  String openTimeSaturday;
  String closeTimeSaturday;
  String openTimeSunday;
  String closeTimeSunday;
  int area;
  dynamic cardId;
  dynamic bankId;
  String minAmount;
  int perkm;
  dynamic crn;
  int onlyfamooshed;
  String image;

  RestaurantData({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.businessName,
    required this.businessAddress,
    required this.bcity,
    required this.bzipcode,
    required this.country,
    required this.businesstype,
    this.cuisineName,
    required this.numOfLocation,
    required this.delivertype,
    required this.published,
    required this.delivered,
    required this.phone,
    required this.mobilephone,
    required this.address,
    required this.lat,
    required this.lng,
    required this.imageid,
    required this.logoId,
    required this.desc,
    required this.fee,
    required this.merchantCommission,
    required this.percent,
    required this.bestSeller,
    required this.facebook,
    required this.instagram,
    required this.twitter,
    required this.accountnumber,
    required this.holderName,
    this.bankcode,
    required this.bRoutingNumber,
    required this.bankType,
    required this.cardName,
    required this.cardNumber,
    required this.cardCvc,
    required this.cardMm,
    required this.cardYy,
    required this.stripeId,
    required this.openTimeMonday,
    required this.closeTimeMonday,
    required this.openTimeTuesday,
    required this.closeTimeTuesday,
    required this.openTimeWednesday,
    required this.closeTimeWednesday,
    required this.openTimeThursday,
    required this.closeTimeThursday,
    required this.openTimeFriday,
    required this.closeTimeFriday,
    required this.openTimeSaturday,
    required this.closeTimeSaturday,
    required this.openTimeSunday,
    required this.closeTimeSunday,
    required this.area,
    this.cardId,
    required this.bankId,
    required this.minAmount,
    required this.perkm,
    this.crn,
    required this.onlyfamooshed,
    required this.image,
  });

  factory RestaurantData.fromJson(Map<String, dynamic> json) => RestaurantData(
        id: json["id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
