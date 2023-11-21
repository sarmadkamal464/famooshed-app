import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/data/models/notification_response.dart';
import 'package:famooshed/app/modules/widgets/no_item_found.dart';
import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:famooshed/app/modules/notification_module/notification_controller.dart';
import 'package:jiffy/jiffy.dart';

import '../../common/util/exports.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      // appBar: AppBar(title: const Text('Notification Page')),
      body: GetBuilder(
        builder: (NotificationController notificationController) {
          return notificationController.allNotification.isEmpty
              ? const NoItemFound()
              : ListView.separated(
                  itemCount: notificationController.allNotification.length,
                  itemBuilder: (context, index) {
                    var data = notificationController.allNotification[index];
                    return notificationItem(data);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      endIndent: 20.0,
                      indent: 20,
                      thickness: 1.5,
                    );
                  },
                );
        },
      ),
    );
  }

  Widget notificationItem(Notifications notification, {bool? seen = true}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Image.network(
                      Constants.imgUrl + notification.image,
                      height: 60,
                      width: 60,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 220,
                        child: Text(
                          notification.text.capitalize!,
                          style: beVietnamProaBold.copyWith(
                              fontSize: 18, color: AppColors.appTheme),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Jiffy.parse(notification.date)
                                .format(pattern: 'dd MMM, h:mm a'),
                            style: urbanistSemiBold.copyWith(
                                color: AppColors.doveGray, fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                height: 6,
                                width: 6,
                                color: AppColors.doveGray,
                              ),
                            ),
                          ),
                          Text('10 items',
                              style: urbanistSemiBold.copyWith(
                                  color: AppColors.doveGray, fontSize: 14)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              seen!
                  ? const SizedBox()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        height: 6,
                        width: 6,
                        color: AppColors.orderSucess,
                      ),
                    )
            ],
          ),
        ]),
      ),
    );
  }
}
