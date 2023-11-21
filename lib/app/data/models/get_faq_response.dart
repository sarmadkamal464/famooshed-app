class GetFaqResponse {
  bool? success;
  List<FaqItem>? faqData;

  GetFaqResponse({this.success, this.faqData});

  GetFaqResponse.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) {
      success = json["success"];
    }
    if (json["data"] is List) {
      faqData = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => FaqItem.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["success"] = success;
    data["data"] = faqData?.map((e) => e.toJson()).toList();
    return data;
  }
}

class FaqItem {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? question;
  String? answer;
  int? published;

  FaqItem(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.question,
      this.answer,
      this.published});

  FaqItem.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if (json["question"] is String) {
      question = json["question"];
    }
    if (json["answer"] is String) {
      answer = json["answer"];
    }
    if (json["published"] is int) {
      published = json["published"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["question"] = question;
    data["answer"] = answer;
    data["published"] = published;
    return data;
  }
}
