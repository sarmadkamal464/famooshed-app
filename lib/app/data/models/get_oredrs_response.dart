// // To parse this JSON data, do
// //
// //     final getOrdersResponse = getOrdersResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// GetOrdersResponse getOrdersResponseFromJson(String str) =>
//     GetOrdersResponse.fromJson(json.decode(str));
//
// String getOrdersResponseToJson(GetOrdersResponse data) =>
//     json.encode(data.toJson());
//
// class GetOrdersResponse {
//   String error;
//   String currency;
//   List<OrderDetail> data;
//
//   GetOrdersResponse({
//     required this.error,
//     required this.currency,
//     required this.data,
//   });
//
//   factory GetOrdersResponse.fromJson(Map<String, dynamic> json) =>
//       GetOrdersResponse(
//         error: json["error"],
//         currency: json["currency"],
//         data: List<OrderDetail>.from(
//             json["data"].map((x) => OrderDetail.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "error": error,
//         "currency": currency,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }
//
// class OrderDetail {
//   int orderid;
//   DateTime date;
//   String tax;
//   String fee;
//   int perkm;
//   int percent;
//   int status;
//   String statusName;
//   String total;
//   String restaurant;
//   List<Ordersdetail> ordersdetails;
//   String name;
//   String image;
//   List<Ordertime> ordertimes;
//   String curbsidePickup;
//   dynamic arrived;
//   String destLat;
//   String destLng;
//   String shopLat;
//   String shopLng;
//   int driver;
//
//   OrderDetail({
//     required this.orderid,
//     required this.date,
//     required this.tax,
//     required this.fee,
//     required this.perkm,
//     required this.percent,
//     required this.status,
//     required this.statusName,
//     required this.total,
//     required this.restaurant,
//     required this.ordersdetails,
//     required this.name,
//     required this.image,
//     required this.ordertimes,
//     required this.curbsidePickup,
//     this.arrived,
//     required this.destLat,
//     required this.destLng,
//     required this.shopLat,
//     required this.shopLng,
//     required this.driver,
//   });
//
//   factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
//         orderid: json["orderid"],
//         date: DateTime.parse(json["date"]),
//         tax: json["tax"],
//         fee: json["fee"],
//         perkm: json["perkm"],
//         percent: json["percent"],
//         status: json["status"],
//         statusName: json["statusName"],
//         total: json["total"],
//         restaurant: json["restaurant"],
//         ordersdetails: List<Ordersdetail>.from(
//             json["ordersdetails"].map((x) => Ordersdetail.fromJson(x))),
//         name: json["name"],
//         image: json["image"],
//         ordertimes: List<Ordertime>.from(
//             json["ordertimes"].map((x) => Ordertime.fromJson(x))),
//         curbsidePickup: json["curbsidePickup"],
//         arrived: json["arrived"] ?? '',
//         destLat: json["destLat"],
//         destLng: json["destLng"],
//         shopLat: json["shopLat"],
//         shopLng: json["shopLng"],
//         driver: json["driver"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "orderid": orderid,
//         "date": date.toIso8601String(),
//         "tax": tax,
//         "fee": fee,
//         "perkm": perkm,
//         "percent": percent,
//         "status": status,
//         "statusName": statusName,
//         "total": total,
//         "restaurant": restaurant,
//         "ordersdetails":
//             List<dynamic>.from(ordersdetails.map((x) => x.toJson())),
//         "name": name,
//         "image": image,
//         "ordertimes": List<dynamic>.from(ordertimes.map((x) => x.toJson())),
//         "curbsidePickup": curbsidePickup,
//         "arrived": arrived,
//         "destLat": destLat,
//         "destLng": destLng,
//         "shopLat": shopLat,
//         "shopLng": shopLng,
//         "driver": driver,
//       };
// }
//
// class Ordersdetail {
//   int id;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int order;
//   String food;
//   int count;
//   String foodprice;
//   String extras;
//   int extrascount;
//   String extrasprice;
//   int foodid;
//   int extrasid;
//   String image;
//
//   Ordersdetail({
//     required this.id,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.order,
//     required this.food,
//     required this.count,
//     required this.foodprice,
//     required this.extras,
//     required this.extrascount,
//     required this.extrasprice,
//     required this.foodid,
//     required this.extrasid,
//     required this.image,
//   });
//
//   factory Ordersdetail.fromJson(Map<String, dynamic> json) => Ordersdetail(
//         id: json["id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         order: json["order"],
//         food: json["food"],
//         count: json["count"],
//         foodprice: json["foodprice"],
//         extras: json["extras"],
//         extrascount: json["extrascount"],
//         extrasprice: json["extrasprice"],
//         foodid: json["foodid"],
//         extrasid: json["extrasid"],
//         image: json["image"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "order": order,
//         "food": food,
//         "count": count,
//         "foodprice": foodprice,
//         "extras": extras,
//         "extrascount": extrascount,
//         "extrasprice": extrasprice,
//         "foodid": foodid,
//         "extrasid": extrasid,
//         "image": image,
//       };
// }
//
// class Ordertime {
//   int id;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int orderId;
//   int status;
//   int driver;
//   String comment;
//
//   Ordertime({
//     required this.id,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.orderId,
//     required this.status,
//     required this.driver,
//     required this.comment,
//   });
//
//   factory Ordertime.fromJson(Map<String, dynamic> json) => Ordertime(
//         id: json["id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         orderId: json["order_id"],
//         status: json["status"],
//         driver: json["driver"],
//         comment: json["comment"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "order_id": orderId,
//         "status": status,
//         "driver": driver,
//         "comment": comment,
//       };
// }

// To parse this JSON data, do
//
//     final getOrdersResponse = getOrdersResponseFromJson(jsonString);

// import 'dart:convert';
//
// GetOrdersResponse getOrdersResponseFromJson(String str) =>
//     GetOrdersResponse.fromJson(json.decode(str));
//
// String getOrdersResponseToJson(GetOrdersResponse data) =>
//     json.encode(data.toJson());
//
// class GetOrdersResponse {
//   String? error;
//   String? currency;
//   List<OrderDetail>? data;
//
//   GetOrdersResponse({
//     this.error,
//     this.currency,
//     this.data,
//   });
//
//   factory GetOrdersResponse.fromJson(Map<String, dynamic> json) =>
//       GetOrdersResponse(
//         error: json["error"],
//         currency: json["currency"],
//         data: json["data"] == null
//             ? []
//             : List<OrderDetail>.from(
//                 json["data"]!.map((x) => OrderDetail.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "error": error,
//         "currency": currency,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }
//
// class OrderDetail {
//   int? orderid;
//   DateTime? date;
//   String? tax;
//   String? fee;
//   int? perkm;
//   int? percent;
//   int? status;
//   String? statusName;
//   String? total;
//   String? restaurant;
//   List<Ordersdetail>? ordersdetails;
//   List<Ordertime>? ordertimes;
//   String? curbsidePickup;
//   String? arrived;
//   String? destLat;
//   String? destLng;
//   String? shopLat;
//   String? shopLng;
//   int? driver;
//   String? name;
//   String? image;
//
//   OrderDetail({
//     this.orderid,
//     this.date,
//     this.tax,
//     this.fee,
//     this.perkm,
//     this.percent,
//     this.status,
//     this.statusName,
//     this.total,
//     this.restaurant,
//     this.ordersdetails,
//     this.ordertimes,
//     this.curbsidePickup,
//     this.arrived,
//     this.destLat,
//     this.destLng,
//     this.shopLat,
//     this.shopLng,
//     this.driver,
//     this.name,
//     this.image,
//   });
//
//   factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
//         orderid: json["orderid"],
//         date: json["date"] == null ? null : DateTime.parse(json["date"]),
//         tax: json["tax"],
//         fee: json["fee"],
//         perkm: json["perkm"],
//         percent: json["percent"],
//         status: json["status"],
//         statusName: json["statusName"],
//         total: json["total"],
//         restaurant: json["restaurant"],
//         ordersdetails: json["ordersdetails"] == null
//             ? []
//             : List<Ordersdetail>.from(
//                 json["ordersdetails"]!.map((x) => Ordersdetail.fromJson(x))),
//         ordertimes: json["ordertimes"] == null
//             ? []
//             : List<Ordertime>.from(
//                 json["ordertimes"]!.map((x) => Ordertime.fromJson(x))),
//         curbsidePickup: json["curbsidePickup"],
//         arrived: json["arrived"],
//         destLat: json["destLat"],
//         destLng: json["destLng"],
//         shopLat: json["shopLat"],
//         shopLng: json["shopLng"],
//         driver: json["driver"],
//         name: json["name"],
//         image: json["image"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "orderid": orderid,
//         "date": date?.toIso8601String(),
//         "tax": tax,
//         "fee": fee,
//         "perkm": perkm,
//         "percent": percent,
//         "status": status,
//         "statusName": statusName,
//         "total": total,
//         "restaurant": restaurant,
//         "ordersdetails": ordersdetails == null
//             ? []
//             : List<dynamic>.from(ordersdetails!.map((x) => x.toJson())),
//         "ordertimes": ordertimes == null
//             ? []
//             : List<dynamic>.from(ordertimes!.map((x) => x.toJson())),
//         "curbsidePickup": curbsidePickup,
//         "arrived": arrived,
//         "destLat": destLat,
//         "destLng": destLng,
//         "shopLat": shopLat,
//         "shopLng": shopLng,
//         "driver": driver,
//         "name": name,
//         "image": image,
//       };
// }

// To parse this JSON data, do
//
//     final getOrdersResponse = getOrdersResponseFromJson(jsonString);

import 'dart:convert';

GetOrdersResponse getOrdersResponseFromJson(String str) =>
    GetOrdersResponse.fromJson(json.decode(str));

String getOrdersResponseToJson(GetOrdersResponse data) =>
    json.encode(data.toJson());

class GetOrdersResponse {
  String? error;
  String? currency;
  List<Order>? data;

  GetOrdersResponse({
    this.error,
    this.currency,
    this.data,
  });

  factory GetOrdersResponse.fromJson(Map<String, dynamic> json) =>
      GetOrdersResponse(
        error: json["error"],
        currency: json["currency"],
        data: json["data"] == null
            ? []
            : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "currency": currency,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Order {
  int? orderid;
  dynamic date;
  String? tax;
  String? fee;
  int? perkm;
  int? percent;
  int? status;
  String? statusName;
  String? total;
  String? restaurant;
  List<Ordersdetail>? ordersdetails;
  String? name;
  String? image;
  List<Ordertime>? ordertimes;
  dynamic curbsidePickup;
  dynamic arrived;
  String? destLat;
  String? destLng;
  String? shopLat;
  String? shopLng;
  int? driver;

  Order({
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
    this.name,
    this.image,
    this.ordertimes,
    this.curbsidePickup,
    this.arrived,
    this.destLat,
    this.destLng,
    this.shopLat,
    this.shopLng,
    this.driver,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderid: json["orderid"],
        date: json["date"],
        tax: json["tax"],
        fee: json["fee"],
        perkm: json["perkm"],
        percent: json["percent"],
        status: json["status"],
        statusName: json["statusName"],
        total: json["total"],
        restaurant: json["restaurant"],
        ordersdetails: json["ordersdetails"] == null
            ? []
            : List<Ordersdetail>.from(
                json["ordersdetails"]!.map((x) => Ordersdetail.fromJson(x))),
        name: json["name"],
        image: json["image"],
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
        "date": date,
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
        "name": name,
        "image": image,
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

class Ordersdetail {
  int? id;
  dynamic createdAt;
  dynamic updatedAt;
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

  Ordersdetail({
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

  factory Ordersdetail.fromJson(Map<String, dynamic> json) => Ordersdetail(
        id: json["id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
        "created_at": createdAt,
        "updated_at": updatedAt,
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

// class Ordersdetail {
//   int? id;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? order;
//   String? food;
//   int? count;
//   String? foodprice;
//   String? extras;
//   int? extrascount;
//   String? extrasprice;
//   int? foodid;
//   int? extrasid;
//   String? image;
//
//   Ordersdetail({
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//     this.order,
//     this.food,
//     this.count,
//     this.foodprice,
//     this.extras,
//     this.extrascount,
//     this.extrasprice,
//     this.foodid,
//     this.extrasid,
//     this.image,
//   });
//
//   factory Ordersdetail.fromJson(Map<String, dynamic> json) => Ordersdetail(
//         id: json["id"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         order: json["order"],
//         food: json["food"],
//         count: json["count"],
//         foodprice: json["foodprice"],
//         extras: json["extras"],
//         extrascount: json["extrascount"],
//         extrasprice: json["extrasprice"],
//         foodid: json["foodid"],
//         extrasid: json["extrasid"],
//         image: json["image"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "order": order,
//         "food": food,
//         "count": count,
//         "foodprice": foodprice,
//         "extras": extras,
//         "extrascount": extrascount,
//         "extrasprice": extrasprice,
//         "foodid": foodid,
//         "extrasid": extrasid,
//         "image": image,
//       };
// }
//
// class Ordertime {
//   int? id;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? orderId;
//   int? status;
//   int? driver;
//   String? comment;
//
//   Ordertime({
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//     this.orderId,
//     this.status,
//     this.driver,
//     this.comment,
//   });
//
//   factory Ordertime.fromJson(Map<String, dynamic> json) => Ordertime(
//         id: json["id"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         orderId: json["order_id"],
//         status: json["status"],
//         driver: json["driver"],
//         comment: json["comment"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "order_id": orderId,
//         "status": status,
//         "driver": driver,
//         "comment": comment,
//       };
// }
