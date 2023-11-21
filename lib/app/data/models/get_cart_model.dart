// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

CartResponse cartResponseFromJson(String str) =>
    CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  bool? status;
  String? message;
  int? statusCode;
  Data? data;

  CartResponse({
    this.status,
    this.message,
    this.statusCode,
    this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        status: json["status"],
        message: json["message"],
        statusCode: json["statusCode"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "statusCode": statusCode,
        "data": data?.toJson(),
      };
}

class Data {
  Cart? cart;
  List<dynamic>? shippingOptions;
  dynamic subTotalPrice;
  String? deliveryFee;
  int? discountPrice;
  String? total;
  String? tax;
  int? cartCount;
  String? payable;

  Data({
    this.cart,
    this.shippingOptions,
    this.subTotalPrice,
    this.deliveryFee,
    this.discountPrice,
    this.total,
    this.tax,
    this.cartCount,
    this.payable,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
        shippingOptions: json["shippingOptions"] == null
            ? []
            : List<dynamic>.from(json["shippingOptions"]!.map((x) => x)),
        subTotalPrice: (json["subTotalPrice"] ?? '0'),
        deliveryFee: json["deliveryFee"],
        discountPrice: json["discountPrice"],
        total: json["total"],
        tax: json["tax"],
        cartCount: json["cartCount"],
        payable: json["payable"],
      );

  Map<String, dynamic> toJson() => {
        "cart": cart?.toJson(),
        "shippingOptions": shippingOptions == null
            ? []
            : List<dynamic>.from(shippingOptions!.map((x) => x)),
        "subTotalPrice": subTotalPrice,
        "deliveryFee": deliveryFee,
        "discountPrice": discountPrice,
        "total": total,
        "tax": tax,
        "cartCount": cartCount,
        "payable": payable,
      };
}

class Cart {
  int? id;
  int? userId;
  int? restaurantId;
  dynamic discountCodeId;
  String? discountType;
  String? discountValue;
  String? discountCode;
  String? subTotal;
  dynamic deliveryId;
  String? deliveryMethod;
  String? deliveryPrice;
  String? discountAmount;
  String? payableAmount;
  String? restaurantName;
  String? restaurantProfile;
  List<Product>? products;
  String? restaurantAddress;
  String? arrivalDate;
  String? arrivalTime;
  String? comment;

  Cart({
    this.id,
    this.userId,
    this.restaurantId,
    this.discountCodeId,
    this.discountType,
    this.discountValue,
    this.discountCode,
    this.subTotal,
    this.deliveryId,
    this.deliveryMethod,
    this.deliveryPrice,
    this.discountAmount,
    this.payableAmount,
    this.restaurantName,
    this.restaurantProfile,
    this.products,
    this.restaurantAddress,
    this.arrivalDate,
    this.arrivalTime,
    this.comment,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        userId: json["user_id"],
        restaurantId: json["restaurant_id"],
        discountCodeId: json["discount_code_id"] ?? '',
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        discountCode: json["discount_code"],
        subTotal: json["sub_total"],
        deliveryId: json["delivery_id"] ?? '',
        deliveryMethod: json["delivery_method"],
        deliveryPrice: json["delivery_price"],
        discountAmount: json["discount_amount"],
        payableAmount: json["payable_amount"],
        restaurantName: json["restaurant_name"],
        restaurantProfile: json["restaurant_profile"],
        restaurantAddress: json["restaurants_address"],
        arrivalDate: json["arrivalDate"],
        arrivalTime: json["arrivalTime"],
        comment: json["comment"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "restaurant_id": restaurantId,
        "discount_code_id": discountCodeId,
        "discount_type": discountType,
        "discount_value": discountValue,
        "discount_code": discountCode,
        "sub_total": subTotal,
        "delivery_id": deliveryId,
        "delivery_method": deliveryMethod,
        "delivery_price": deliveryPrice,
        "discount_amount": discountAmount,
        "payable_amount": payableAmount,
        "restaurant_name": restaurantName,
        "restaurant_profile": restaurantProfile,
        "restaurants_address": restaurantAddress,
        "arrivalDate": arrivalDate,
        "arrivalTime": arrivalTime,
        "comment": comment,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  int? id;
  int? cartId;
  int? productId;
  String? productName;
  int? quantity;
  String? unitPrice;
  String? discountprice;
  String? totalPrice;
  String? extras;
  int? extrasCount;
  String? extrasAmount;
  int? extrasId;
  String? image;
  dynamic updatedAt;

  Product({
    this.id,
    this.cartId,
    this.productId,
    this.productName,
    this.quantity,
    this.unitPrice,
    this.discountprice,
    this.totalPrice,
    this.extras,
    this.extrasCount,
    this.extrasAmount,
    this.extrasId,
    this.image,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        cartId: json["cart_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        unitPrice: json["unit_price"],
        discountprice: json["discountprice"],
        totalPrice: json["total_price"],
        extras: json["extras"],
        extrasCount: json["extras_count"],
        extrasAmount: json["extras_amount"],
        extrasId: json["extras_id"],
        image: json["image"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "product_id": productId,
        "product_name": productName,
        "quantity": quantity,
        "unit_price": unitPrice,
        "discountprice": discountprice,
        "total_price": totalPrice,
        "extras": extras,
        "extras_count": extrasCount,
        "extras_amount": extrasAmount,
        "extras_id": extrasId,
        "image": image,
        "updated_at": updatedAt,
      };
}
