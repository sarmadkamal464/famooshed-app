// To parse this JSON data, do
//
//     final productCategoryModel = productCategoryModelFromJson(jsonString);

import 'dart:convert';

ProductCategoryModel productCategoryModelFromJson(String str) =>
    ProductCategoryModel.fromJson(json.decode(str));

String productCategoryModelToJson(ProductCategoryModel data) =>
    json.encode(data.toJson());

class ProductCategoryModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  int? imageid;
  String? desc;
  int? visible;
  int? parent;
  int? featuredCat;
  String? restUserId;
  String? categoryType;

  ProductCategoryModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.imageid,
    this.desc,
    this.visible,
    this.parent,
    this.featuredCat,
    this.restUserId,
    this.categoryType,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProductCategoryModel(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        imageid: json["imageid"],
        desc: json["desc"],
        visible: json["visible"],
        parent: json["parent"],
        featuredCat: json["featured_cat"],
        restUserId: json["rest_user_id"],
        categoryType: json["category_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "imageid": imageid,
        "desc": desc,
        "visible": visible,
        "parent": parent,
        "featured_cat": featuredCat,
        "rest_user_id": restUserId,
        "category_type": categoryType,
      };
}
