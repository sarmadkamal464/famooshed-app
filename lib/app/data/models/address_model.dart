class Address {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? user;
  String? text;
  String? flatHouseNo;
  String? nearByLandmark;
  String? lat;
  String? lng;
  String? type;
  String? addressDefault;

  Address({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.text,
    this.flatHouseNo,
    this.nearByLandmark,
    this.lat,
    this.lng,
    this.type,
    this.addressDefault,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"],
        text: json["text"],
        flatHouseNo: json["flat_house_no"],
        nearByLandmark: json["near_by_landmark"],
        lat: json["lat"],
        lng: json["lng"],
        type: json["type"],
        addressDefault: json["default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user,
        "text": text,
        "flat_house_no": flatHouseNo,
        "near_by_landmark": nearByLandmark,
        "lat": lat,
        "lng": lng,
        "type": type,
        "default": addressDefault,
      };
}
