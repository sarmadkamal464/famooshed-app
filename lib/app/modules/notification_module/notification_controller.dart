import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/notification_response.dart';
import 'package:famooshed/app/utils/dprint.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  @override
  void onReady() {
    getCategoryData();
    super.onReady();
  }

  @override
  void onClose() {
    dprint('Notification Controller Closed');
    super.onClose();
  }

  final ApiHelper _apiHelper = ApiHelper.to;
  final RxList<Notifications> _allNotification = RxList();
  List<Notifications> get allNotification => _allNotification;
  set allNotification(List<Notifications> allNotification) =>
      _allNotification.addAll(allNotification);

  getCategoryData() {
    _apiHelper.getApiCall(AppUrl.notify).futureValue(
      (value) {
        var response = NotificationsResponse.fromJson(value);

        if (allNotification.isNotEmpty) {
          allNotification.clear();
          allNotification = response.notify;
        } else {
          allNotification = response.notify;
        }

        update();
      },
      retryFunction: getCategoryData,
    );
  }
}
