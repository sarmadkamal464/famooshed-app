import 'dart:io';
import 'dart:math';

import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/common/values/app_logo.dart';
import 'package:famooshed/app/modules/dashboard_module/dashboard_controller.dart';
import 'package:famooshed/app/modules/widgets/custom_inkwell_widget.dart';
import 'package:famooshed/app/modules/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../theme/size_config.dart';
import '../../utils/common_helper.dart';

abstract class Utils {
  static void showDialog(
    String? message, {
    String title = Strings.error,
    bool success = false,
    VoidCallback? onTap,
  }) =>
      Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: () async {
          Get.back();

          onTap?.call();

          return true;
        },
        title: success ? Strings.success : title,
        content: Text(
          message ?? Strings.somethingWentWrong,
          textAlign: TextAlign.center,
          maxLines: 6,
          style: AppTextStyle.semiBoldStyle.copyWith(
            color: AppColors.mineShaft,
            fontSize: Dimens.fontSize16,
          ),
        ),
        confirm: Align(
          alignment: Alignment.centerRight,
          child: CustomInkwellWidget.text(
            onTap: () {
              Get.back();

              onTap?.call();
            },
            title: Strings.ok,
            textStyle: AppTextStyle.buttonTextStyle.copyWith(
              fontSize: Dimens.fontSize18,
            ),
          ),
        ),
      );

  static void showIconDialog(
    String title,
    String message, {
    Widget? imageWidget,
    VoidCallback? onTap,
  }) =>
      Get.dialog(
        AlertDialog(
          title:
              imageWidget ?? const Icon(Icons.done), //add your icon/image here
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyle.semiBoldStyle.copyWith(
                  color: Colors.black,
                  fontSize: Dimens.fontSize24,
                ),
              ),
              SizedBox(height: 10.w),
              Text(message,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regularStyle.copyWith(
                    color: AppColors.mineShaft,
                    fontSize: Dimens.fontSize16,
                  )),
              SizedBox(height: 20.w),
              CustomTextButton(
                title: Strings.ok,
                onPressed: () {
                  Get.back();

                  onTap?.call();
                },
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );

  static void timePicker(
    Function(String time) onSelectTime, {
    TimeOfDay? initialTime,
  }) {
    showTimePicker(
      context: Get.overlayContext!,
      initialTime: initialTime ??
          TimeOfDay.fromDateTime(
            DateTime.now(),
          ),
    ).then((v) {
      if (v != null) {
        final now = DateTime.now();
        final dateTime = DateTime(
          now.year,
          now.month,
          now.day,
          v.hour,
          v.minute,
        );

        onSelectTime(dateTime.formatedDate(dateFormat: 'hh:mm aa'));
      }
    });
  }

  static int toInt(String str) {
    int ret = 0;
    try {
      ret = int.parse(str);
    } catch (_) {}
    return ret;
  }

  static String getRandomString(
    int length, {
    bool isNumber = true,
  }) {
    final chars = isNumber ? '1234567890' : 'abcdefghijklmnopqrstuvwxyz';
    final rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(
          rnd.nextInt(
            chars.length,
          ),
        ),
      ),
    );
  }

  // static void loadingDialog() {
  //   closeDialog();

  //   Get.dialog(
  //     const Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //     name: 'loadingDialog',
  //   );
  // }

  static void loadingDialog() {
    closeDialog();

    Get.dialog(
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Image(
              image: AssetImage("assets/images/Loader.gif"),
              height: 60,
              width: 80,
            ),
          ],
        ),
      ),
    );
  }

  static void closeDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  static void closeSnackbar() {
    if (Get.isSnackbarOpen == true) {
      Get.back();
    }
  }

  static void showSnackbar(String? message) {
    closeSnackbar();

    Get.snackbar(
      "Famooshed",
      message!,
      colorText: Colors.white,
      backgroundColor: AppColors.appTheme,
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          AppLogo.appLogo,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static Future<String?> datePicker(BuildContext context,
      {DateTime? lastDate, firstDate, initalDate}) async {
    String? dateTime;
    DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(90),
                horizontal: getProportionateScreenWidth(25)),
            child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                      // onSurface: Colors.white70,
                      primary: AppColors.appTheme),
                ),
                child: child!),
          );
        },
        context: context,
        initialDate: initalDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime.now(),
        lastDate: lastDate ?? DateTime(2050));

    if (pickedDate != null) {
      final DateFormat serverFormatter = DateFormat('yyyy-MM-dd');
      dateTime = serverFormatter.format(pickedDate);
    }

    return dateTime;
  }

  static void closeKeyboard() {
    final currentFocus = Get.focusScope!;
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static void goBackToScreen(String routeName) {
    Get.until(
      (route) => route.settings.name == routeName,
    );
  }

  static Future<void> showImagePicker({
    required Function(File image) onGetImage,
  }) {
    return showModalBottomSheet<void>(
      context: Get.context!,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    getImage(source: 2).then((v) {
                      if (v != null) {
                        onGetImage(v);
                        Get.back();
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image,
                        size: 60.w,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        Strings.gallery,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBoldStyle.copyWith(
                          color: AppColors.mineShaft,
                          fontSize: Dimens.fontSize16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    getImage().then((v) {
                      if (v != null) {
                        onGetImage(v);
                        Get.back();
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera,
                        size: 60.w,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        Strings.camera,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBoldStyle.copyWith(
                          color: AppColors.mineShaft,
                          fontSize: Dimens.fontSize16,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static Future<File?> getImage({int source = 1}) async {
    File? croppedFile;
    CroppedFile? crop;
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: source == 1 ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 60,
    );

    if (pickedFile != null) {
      final image = File(pickedFile.path);

      crop = (await ImageCropper().cropImage(
        compressQuality: 50,
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
      ));
    }
    croppedFile = File(crop!.path);
    return croppedFile;
  }

  static String getLocalDate(String inputDate) {
    DateTime utcDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(inputDate, true).toLocal();
    String localString = DateFormat('dd MMM yyyy, h:mm a').format(utcDate);

    return localString;
  }

  static String calcuDistance(String lat, String lng) {
    DashboardController dashboardController = Get.find<DashboardController>();
    double myLat = dashboardController.lat.value;
    double myLong = dashboardController.lng.value;
    double returnDouble = 0;
    if (lat.isNotEmpty && lng.isNotEmpty) {
      var dis = calculateDistance(
          myLat, myLong, double.parse(lat), double.parse(lng));
      // dis = dis * 1000;
      // var mileFromMeter = dis / 1609.344;
      returnDouble = dis * 0.621371;
    }
    return returnDouble.toStringAsFixed(0);
  }

  static showDateRangePicker(context, initialSelectedRange,
      Function(Object?)? onSubmit, showActionButtons) {
    return Theme(
      data: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.appTheme,
                    fontWeight: FontWeight.w500,
                    fontSize: getProportionalFontSize(13),
                  ),
            ),
          ),
        ),
      ),
      child: SfDateRangePicker(
        onCancel: () {
          Get.back();
        },

        headerHeight: getProportionateScreenHeight(55),
        initialSelectedRange: initialSelectedRange,
        onSubmit: onSubmit,
        showActionButtons: showActionButtons,
        showNavigationArrow: true,

        minDate: DateTime(200),
        maxDate: DateTime.now(),

        selectionMode: DateRangePickerSelectionMode.range,
        startRangeSelectionColor: AppColors.appTheme,
        endRangeSelectionColor: AppColors.appTheme,

        yearCellStyle: DateRangePickerYearCellStyle(
          textStyle: Theme.of(context).textTheme.bodyMedium!,
          leadingDatesTextStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white54),
          todayCellDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.appTheme,
          ),
          todayTextStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.white),
        ),

        monthViewSettings: DateRangePickerMonthViewSettings(
          viewHeaderHeight: getProportionateScreenHeight(60),
          dayFormat: "EEE",
          viewHeaderStyle: DateRangePickerViewHeaderStyle(
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: getProportionalFontSize(12),
                // fontFamily: AppFonts.fontMedium,
                fontWeight: FontWeight.w500,
                color: AppColors.lightBlack),
          ),
          weekNumberStyle: DateRangePickerWeekNumberStyle(
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
        headerStyle: DateRangePickerHeaderStyle(
          backgroundColor: AppColors.appTheme,
          textAlign: TextAlign.start,
          textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                // fontFamily: beVietnamProaBold,
                fontSize: getProportionalFontSize(14),
              ),
        ),
        selectionShape: DateRangePickerSelectionShape.circle,

        monthCellStyle: DateRangePickerMonthCellStyle(
          disabledDatesTextStyle:
              Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.lightBlack,
                    fontSize: getProportionalFontSize(13),
                  ),
          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.black,
                fontSize: getProportionalFontSize(14),
              ),
          todayTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.appTheme,
              ),
          // cellDecoration: BoxDecoration(
          //   color: Color(0xFF10c7de),
          //   shape: BoxShape.circle,
          // ),
        ),
        navigationDirection: DateRangePickerNavigationDirection.horizontal,

        selectionTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
              fontSize: getProportionalFontSize(15),
            ),
        selectionColor: AppColors.redColor,

        rangeTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.black,
              // fontFamily: AppFonts.fontMedium,
              fontWeight: FontWeight.w500,
              fontSize: getProportionalFontSize(13),
            ),
        rangeSelectionColor: AppColors.lightGreenColor,
        extendableRangeSelectionDirection:
            ExtendableRangeSelectionDirection.both,
        // initialSelectedRange: PickerDateRange(),
        enablePastDates: true,

        todayHighlightColor: AppColors.lightGreenColor,
      ),
    );
  }
}
