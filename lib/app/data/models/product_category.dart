// To parse this JSON data, do
//
//     final productCategory = productCategoryFromJson(jsonString);

import 'dart:convert';

ProductCategory productCategoryFromJson(String str) =>
    ProductCategory.fromJson(json.decode(str));

String productCategoryToJson(ProductCategory data) =>
    json.encode(data.toJson());

class ProductCategory {
  int? id;
  String? name;
  String? desc;
  int? visible;
  int? parent;
  int? featuredCat;
  String? image;
  String? parentName;
  int? itemsCount;

  ProductCategory({
    this.id,
    this.name,
    this.desc,
    this.visible,
    this.parent,
    this.featuredCat,
    this.image,
    this.parentName,
    this.itemsCount,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["id"],
        name: json["name"],
        desc: json["desc"],
        visible: json["visible"],
        parent: json["parent"],
        featuredCat: json["featured_cat"],
        image: json["image"],
        parentName: json["parentName"],
        itemsCount: json["itemsCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
        "visible": visible,
        "parent": parent,
        "featured_cat": featuredCat,
        "image": image,
        "parentName": parentName,
        "itemsCount": itemsCount,
      };
}
