// To parse this JSON data, do
//
//     final getProfileResponse = getProfileResponseFromJson(jsonString);

import 'dart:convert';

GetProfileResponse getProfileResponseFromJson(String str) =>
    GetProfileResponse.fromJson(json.decode(str));

String getProfileResponseToJson(GetProfileResponse data) =>
    json.encode(data.toJson());

class GetProfileResponse {
  String error;
  User user;
  dynamic itemCount;
  dynamic lastOrderDate;
  dynamic amountSpent;

  GetProfileResponse({
    required this.error,
    required this.user,
    required this.itemCount,
    required this.lastOrderDate,
    required this.amountSpent,
  });

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) =>
      GetProfileResponse(
        error: json["error"],
        user: User.fromJson(json["user"]),
        itemCount: json["itemCount"],
        lastOrderDate: json["lastOrderDate"] == "No Order"
            ? json["lastOrderDate"]
            : DateTime.parse(json["lastOrderDate"]),
        amountSpent: json["amountSpent"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "user": user.toJson(),
        "itemCount": itemCount,
        "lastOrderDate": lastOrderDate.toIso8601String(),
        "amountSpent": amountSpent,
      };
}

class User {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  dynamic isAdmin;
  String password;
  dynamic rememberToken;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic areain;
  dynamic vehicle;
  int role;
  dynamic imageid;
  dynamic address;
  dynamic phone;
  dynamic token;
  dynamic fcbToken;
  dynamic active;
  String typeReg;
  String lat;
  String lng;
  String speed;
  dynamic stripeId;
  dynamic bankId;
  dynamic driveFor;
  dynamic driverCommission;
  dynamic dateOfBirth;
  dynamic idDocs;
  dynamic addiDocs;
  dynamic city;
  dynamic zipcode;
  dynamic country;
  String avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.isAdmin,
    required this.password,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    this.areain,
    this.vehicle,
    required this.role,
    required this.imageid,
    this.address,
    this.phone,
    this.token,
    required this.fcbToken,
    this.active,
    required this.typeReg,
    required this.lat,
    required this.lng,
    required this.speed,
    this.stripeId,
    this.bankId,
    this.driveFor,
    this.driverCommission,
    this.dateOfBirth,
    this.idDocs,
    this.addiDocs,
    this.city,
    this.zipcode,
    this.country,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        isAdmin: json["is_admin"],
        password: json["password"],
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        areain: json["areain"],
        vehicle: json["vehicle"],
        role: json["role"],
        imageid: json["imageid"],
        address: json["address"] ?? "",
        phone: json["phone"] ?? "",
        token: json["_token"],
        fcbToken: json["fcbToken"],
        active: json["active"],
        typeReg: json["typeReg"],
        lat: json["lat"],
        lng: json["lng"],
        speed: json["speed"],
        stripeId: json["stripe_id"],
        bankId: json["bank_id"],
        driveFor: json["drive_for"],
        driverCommission: json["driver_commission"],
        dateOfBirth: json["date_of_birth"],
        idDocs: json["id_docs"],
        addiDocs: json["addi_docs"],
        city: json["city"],
        zipcode: json["zipcode"],
        country: json["country"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "is_admin": isAdmin,
        "password": password,
        "remember_token": rememberToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "areain": areain,
        "vehicle": vehicle,
        "role": role,
        "imageid": imageid,
        "address": address,
        "phone": phone,
        "_token": token,
        "fcbToken": fcbToken,
        "active": active,
        "typeReg": typeReg,
        "lat": lat,
        "lng": lng,
        "speed": speed,
        "stripe_id": stripeId,
        "bank_id": bankId,
        "drive_for": driveFor,
        "driver_commission": driverCommission,
        "date_of_birth": dateOfBirth,
        "id_docs": idDocs,
        "addi_docs": addiDocs,
        "city": city,
        "zipcode": zipcode,
        "country": country,
        "avatar": avatar,
      };
}
