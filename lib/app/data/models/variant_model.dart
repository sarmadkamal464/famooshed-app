class GetVariantResponse {
  String? variantImage;
  Variant? variant;
  String? currency;

  GetVariantResponse({this.variantImage, this.variant, this.currency});

  GetVariantResponse.fromJson(Map<String, dynamic> json) {
    variantImage = json['variant_image'];
    variant =
        json['variant'] != null ? new Variant.fromJson(json['variant']) : null;
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant_image'] = this.variantImage;
    if (this.variant != null) {
      data['variant'] = this.variant!.toJson();
    }
    data['currency'] = this.currency;
    return data;
  }
}

class Variant {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? food;
  String? name;
  int? imageid;
  String? price;
  Null? dprice;
  String? unit;
  String? weight;
  int? packageCount;

  Variant(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.food,
      this.name,
      this.imageid,
      this.price,
      this.dprice,
      this.unit,
      this.weight,
      this.packageCount});

  Variant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    food = json['food'];
    name = json['name'];
    imageid = json['imageid'];
    price = json['price'];
    dprice = json['dprice'];
    unit = json['unit'];
    weight = json['weight'];
    packageCount = json['packageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['food'] = this.food;
    data['name'] = this.name;
    data['imageid'] = this.imageid;
    data['price'] = this.price;
    data['dprice'] = this.dprice;
    data['unit'] = this.unit;
    data['weight'] = this.weight;
    data['packageCount'] = this.packageCount;
    return data;
  }
}
