class NotificationsResponse {
  String error;
  List<Notifications> notify;
  NotificationsResponse({required this.error, required this.notify});
  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    List<Notifications> m = [];
    if (json['notify'] != null) {
      var items = json['notify'];
      var t = items.map((f) => Notifications.fromJson(f)).toList();
      m = t.cast<Notifications>().toList();
    }
    return NotificationsResponse(
      error: json['error'].toString(),
      notify: m,
    );
  }
}

class Notifications {
  String id;
  String date;
  String title;
  String text;
  String image;

  Notifications(
      {required this.id,
      required this.date,
      required this.title,
      required this.text,
      required this.image});
  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'].toString(),
      date: json['updated_at'].toString(),
      title: json['title'].toString(),
      text: json['text'].toString(),
      image: json['image'].toString(),
    );
  }
}
