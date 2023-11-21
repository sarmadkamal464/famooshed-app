import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessages extends Object {
  late Map<String, dynamic> pendingNotification;
  late FirebaseMessaging _firebaseMessaging;
  String _fcmToken = "";

  String get fcmToken => _fcmToken;

  // static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  factory FirebaseMessages() {
    return _singleton;
  }

  static final FirebaseMessages _singleton = FirebaseMessages._internal();

  FirebaseMessages._internal() {
    print("======== Firebase Messaging instance created ========");
    _firebaseMessaging = FirebaseMessaging.instance;
    if (Platform.isIOS) {
      iOSPermission();
    }
    // firebaseCloudMessagingListeners();
    //
    // initializeLocalNotification();
  }

  Future<String?> getFCMToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null && token.isNotEmpty) {
        print("========= FCM Token :: $token =======");
        _fcmToken = token;
      }

      String? iosToken = await _firebaseMessaging.getAPNSToken();
      if (iosToken != null && iosToken.isNotEmpty) {
        print("========= APNS Token :: $iosToken =======");
      }
    } catch (e) {
      print("Error :: ${e.toString()}");
      return null;
    }
  }

  // void firebaseCloudMessagingListeners() {
  //   if (Platform.isIOS) {
  //     iOSPermission();
  //   }
  //   FirebaseMessaging.onMessage.listen((event) {
  //     Future.delayed(
  //         const Duration(seconds: 1),
  //         () => displayNotificationView(
  //             payload: event.data, remoteNotification: event.notification!));
  //   });
  //
  //   FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //     FirebaseMessages.notificationOperation(message: event.data);
  //   });
  // }
  //
  // void initializeLocalNotification() {
  //   _notificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.requestPermission();
  //
  //   _notificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //         alert: true,
  //         badge: true,
  //         sound: true,
  //       );
  //   final DarwinInitializationSettings initializationSettingsIOS =
  //       DarwinInitializationSettings(
  //           onDidReceiveLocalNotification: (
  //     int id,
  //     String? title,
  //     String? body,
  //     String? payload,
  //   ) async {});
  //
  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(
  //     android: const AndroidInitializationSettings("@mipmap/launcher_icon"),
  //     iOS: initializationSettingsIOS,
  //   );
  //
  //   _notificationsPlugin.initialize(
  //     initializationSettings,
  //     onDidReceiveNotificationResponse: (NotificationResponse response) async {
  //       notificationOperation(message: jsonDecode(response.payload!));
  //     },
  //   );
  // }
  //
  void iOSPermission() {
    _firebaseMessaging.requestPermission(alert: true, badge: true, sound: true);
  }
  //
  // static Future<void> displayNotificationView(
  //     {required Map<String, dynamic> payload,
  //     required RemoteNotification remoteNotification}) async {
  //   String title = remoteNotification.title!;
  //   String body = remoteNotification.body!;
  //
  //   try {
  //     final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  //
  //     const NotificationDetails notificationDetails = NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           "famooshed_user_app", "famooshed_user_app_channel",
  //           importance: Importance.max,
  //           // priority: Priority.high,
  //         ),
  //         iOS: DarwinNotificationDetails());
  //
  //     await _notificationsPlugin.show(
  //       id,
  //       title,
  //       body,
  //       notificationDetails,
  //       payload: jsonEncode(payload),
  //     );
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  // }
  //
  // static void notificationOperation({required Map<String, dynamic> message}) {
  //   // if (message['status'] == "chat") {
  //   //   Map userObject = json.decode(message['userObject']);
  //   //   print(userObject.toString());
  //   //   ChatUser userChat = ChatUser(
  //   //     id: int.parse(userObject['id'] ?? 0),
  //   //     name: userObject['name'].toString(),
  //   //     image: userObject['image'].toString(),
  //   //   );
  //   //   // SchedulerBinding.instance.addPostFrameCallback((_) {
  //   //
  //   //   String? token = Storage.getValue(Constants.token);
  //   //   String? uID = Storage.getValue(Constants.uID);
  //   //   print(token);
  //   //   if (token != null && token.isNotEmpty) {
  //   //     if (uID != null) {
  //   //       FirebaseFirestore.instance
  //   //           .collection(USER_COLLECTION)
  //   //           .doc(uID)
  //   //           .update({
  //   //         'deviceToken': FirebaseMessages().fcmToken,
  //   //         'chattingWith': ''
  //   //       });
  //   //     }
  //   //     Get.toNamed(Routes.CHAT_MESSAGE_SCREEN, arguments: userChat);
  //   //   } else {
  //   //     Get.toNamed(Routes.SIGN_IN);
  //   //   }
  //   //   // Get.toNamed(Routes.CHAT_MESSAGE_SCREEN, arguments: userChat);
  //   //   // Navigator.of(navigator!.context).push(MaterialPageRoute(
  //   //   //     builder: (navigator!.context) => MessageView(peerUser: userChat)));
  //   //   // });
  //   // }
  //   Get.toNamed(Routes.NOTIFICATION);
  // }
}
