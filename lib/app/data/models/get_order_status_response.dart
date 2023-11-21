// To parse this JSON data, do
//
//     final getOrdersStatusResponse = getOrdersStatusResponseFromJson(jsonString);

import 'dart:convert';

GetOrdersStatusResponse getOrdersStatusResponseFromJson(String str) =>
    GetOrdersStatusResponse.fromJson(json.decode(str));

String getOrdersStatusResponseToJson(GetOrdersStatusResponse data) =>
    json.encode(data.toJson());

class GetOrdersStatusResponse {
  String error;
  List<OrderData> data;

  GetOrdersStatusResponse({
    required this.error,
    required this.data,
  });

  factory GetOrdersStatusResponse.fromJson(Map<String, dynamic> json) =>
      GetOrdersStatusResponse(
        error: json["error"],
        data: List<OrderData>.from(
            json["data"].map((x) => OrderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OrderData {
  int orderid;
  dynamic date;
  int status;
  String statusName;
  String drivername;
  String vehicle;
  String phone;
  dynamic imageid;
  String profilepic;
  double destLat;
  double destLng;
  double shopLat;
  double shopLng;
  String driverId;
  String? deliveryMethod;
  String? arrivalDate;
  String? arrivalTime;
  dynamic comment;

  OrderData({
    required this.orderid,
    required this.date,
    required this.status,
    required this.statusName,
    required this.drivername,
    required this.vehicle,
    required this.phone,
    required this.imageid,
    required this.profilepic,
    required this.destLat,
    required this.destLng,
    required this.shopLat,
    required this.shopLng,
    required this.driverId,
    required this.deliveryMethod,
    required this.arrivalDate,
    required this.arrivalTime,
    required this.comment,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        orderid: json["orderid"],
        date: json["date"] ?? '',
        status: json["status"],
        statusName: json["statusName"],
        drivername: json["drivername"],
        vehicle: json["vehicle"] ?? '',
        phone: json["phone"],
        imageid: json["imageid"],
        profilepic: json["profilepic"],
        destLat: double.parse(
            json["destLat"] != null && json["destLat"].toString().isNotEmpty
                ? json["destLat"]
                : "0"),
        destLng: double.parse(
            json["destLng"] != null && json["destLng"].toString().isNotEmpty
                ? json["destLng"]
                : "0"),
        shopLat: double.parse(
            json["shopLat"] != null && json["shopLat"].toString().isNotEmpty
                ? json["shopLat"]
                : "0"),
        shopLng: double.parse(
            json["shopLng"] != null && json["shopLng"].toString().isNotEmpty
                ? json["shopLng"]
                : "0"),
        driverId: json["driverId"].toString(),
        deliveryMethod: json["delivery_method"],
        arrivalDate: json["arrivalDate"],
        arrivalTime: json["arrivalTime"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "orderid": orderid,
        "date": date.toIso8601String(),
        "status": status,
        "statusName": statusName,
        "drivername": drivername,
        "vehicle": vehicle,
        "phone": phone,
        "imageid": imageid,
        "profilepic": profilepic,
        "destLat": destLat,
        "destLng": destLng,
        "shopLat": shopLat,
        "shopLng": shopLng,
        "driverId": driverId,
        "delivery_method": deliveryMethod,
        "arrivalDate": arrivalDate,
        "arrivalTime": arrivalTime,
        "comment": comment,
      };
}
// To parse this JSON data, do
//
//     final reOrderModel = reOrderModelFromJson(jsonString);

ReOrderModel reOrderModelFromJson(String str) =>
    ReOrderModel.fromJson(json.decode(str));

String reOrderModelToJson(ReOrderModel data) => json.encode(data.toJson());

class ReOrderModel {
  int? orderid;
  DateTime? date;
  String? tax;
  String? fee;
  int? perkm;
  int? percent;
  int? status;
  String? statusName;
  String? total;
  String? restaurant;
  List<ReOrdersdetail>? ordersdetails;
  List<Ordertime>? ordertimes;
  String? curbsidePickup;
  dynamic arrived;
  String? destLat;
  String? destLng;
  String? shopLat;
  String? shopLng;
  int? driver;

  ReOrderModel({
    this.orderid,
    this.date,
    this.tax,
    this.fee,
    this.perkm,
    this.percent,
    this.status,
    this.statusName,
    this.total,
    this.restaurant,
    this.ordersdetails,
    this.ordertimes,
    this.curbsidePickup,
    this.arrived,
    this.destLat,
    this.destLng,
    this.shopLat,
    this.shopLng,
    this.driver,
  });

  factory ReOrderModel.fromJson(Map<String, dynamic> json) => ReOrderModel(
        orderid: json["orderid"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        tax: json["tax"],
        fee: json["fee"],
        perkm: json["perkm"],
        percent: json["percent"],
        status: json["status"],
        statusName: json["statusName"],
        total: json["total"],
        restaurant: json["restaurant"].toString(),
        ordersdetails: json["ordersdetails"] == null
            ? []
            : List<ReOrdersdetail>.from(
                json["ordersdetails"]!.map((x) => ReOrdersdetail.fromJson(x))),
        ordertimes: json["ordertimes"] == null
            ? []
            : List<Ordertime>.from(
                json["ordertimes"]!.map((x) => Ordertime.fromJson(x))),
        curbsidePickup: json["curbsidePickup"],
        arrived: json["arrived"],
        destLat: json["destLat"],
        destLng: json["destLng"],
        shopLat: json["shopLat"],
        shopLng: json["shopLng"],
        driver: json["driver"],
      );

  Map<String, dynamic> toJson() => {
        "orderid": orderid,
        "date": date?.toIso8601String(),
        "tax": tax,
        "fee": fee,
        "perkm": perkm,
        "percent": percent,
        "status": status,
        "statusName": statusName,
        "total": total,
        "restaurant": restaurant,
        "ordersdetails": ordersdetails == null
            ? []
            : List<dynamic>.from(ordersdetails!.map((x) => x.toJson())),
        "ordertimes": ordertimes == null
            ? []
            : List<dynamic>.from(ordertimes!.map((x) => x.toJson())),
        "curbsidePickup": curbsidePickup,
        "arrived": arrived,
        "destLat": destLat,
        "destLng": destLng,
        "shopLat": shopLat,
        "shopLng": shopLng,
        "driver": driver,
      };
}

class ReOrdersdetail {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? order;
  String? food;
  int? count;
  String? foodprice;
  String? extras;
  int? extrascount;
  String? extrasprice;
  int? foodid;
  int? extrasid;
  String? image;

  ReOrdersdetail({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.food,
    this.count,
    this.foodprice,
    this.extras,
    this.extrascount,
    this.extrasprice,
    this.foodid,
    this.extrasid,
    this.image,
  });

  factory ReOrdersdetail.fromJson(Map<String, dynamic> json) => ReOrdersdetail(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
      };
}

class Ordertime {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? orderId;
  int? status;
  int? driver;
  String? comment;

  Ordertime({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.orderId,
    this.status,
    this.driver,
    this.comment,
  });

  factory Ordertime.fromJson(Map<String, dynamic> json) => Ordertime(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        orderId: json["order_id"],
        status: json["status"],
        driver: json["driver"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "order_id": orderId,
        "status": status,
        "driver": driver,
        "comment": comment,
      };
}
