// To parse this JSON data, do
//
//     final getSignUpResponse = getSignUpResponseFromJson(jsonString);

import 'dart:convert';

GetSignUpResponse getSignUpResponseFromJson(String str) =>
    GetSignUpResponse.fromJson(json.decode(str));

String getSignUpResponseToJson(GetSignUpResponse data) =>
    json.encode(data.toJson());

class GetSignUpResponse {
  String? error;
  User? user;
  String? accessToken;

  GetSignUpResponse({
    this.error,
    this.user,
    this.accessToken,
  });

  factory GetSignUpResponse.fromJson(Map<String, dynamic> json) =>
      GetSignUpResponse(
        error: json["error"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "user": user?.toJson(),
        "access_token": accessToken,
      };
}

class User {
  String? email;
  String? typeReg;
  String? name;
  String? password;
  int? role;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? avatar;

  User({
    this.email,
    this.typeReg,
    this.name,
    this.password,
    this.role,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        typeReg: json["typeReg"],
        name: json["name"],
        password: json["password"],
        role: json["role"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "typeReg": typeReg,
        "name": name,
        "password": password,
        "role": role,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "avatar": avatar,
      };
}
