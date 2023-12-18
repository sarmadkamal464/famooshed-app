import 'package:famooshed/app/common/util/initializer.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

import 'app/common/util/firebase_messeging_helper/firebase_helper.dart';
import 'app/modules/widgets/base_widget.dart';
import 'app/theme/size_config.dart';

Future<void> main() async {
  Initializer.init(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    await FirebaseMessages().getFCMToken();

    await initMixPanel();

    // FCM in app Terminated State
    // RemoteMessage? initialMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();
    //
    // if (initialMessage != null) {
    //   FirebaseMessages.notificationOperation(message: initialMessage.data);
    //   // _firebaseMessagingBackgroundHandler(initialMessage);
    //   print(initialMessage.data);
    // }
    // Stripe.publishableKey =
    //     "pk_test_51IJi9OKuIF9Xn1SPpxaex4cmWtVeQNf4Ui3jponde3329EmiQLVwKO1Ag3tdpO6nlDxBjzFdhvlDLAvfaJxlngGC00CXr3HRUG";
    Stripe.publishableKey =
        "pk_test_51OMVstJ2x5Ph6J2TvIfsGwTQdKWwMs07ea6aIECqRyBpvbyOKzOufomp5FX0xqwh2njC4e92jmzAvIC14GybvpJd00gkCLL0ge";
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
    Stripe.urlScheme = 'flutterstripe';
    await Stripe.instance.applySettings();
    runApp(const MyApp());
  });
}

Mixpanel? mixpanel;

initMixPanel() async {
  mixpanel = await Mixpanel.init("de11101552dc09b4c2e9ae47d29a1088",
      trackAutomaticEvents: true);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.appThemeLight, // navigation bar color
      statusBarColor: AppColors.appThemeLight,
      // Status bar brightness (optional)
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness:
          Brightness.light, // For iOS (dark icons)/ status bar color
    ));
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      builder: (_, __) => GetMaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        defaultTransition: Transition.fadeIn,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        initialBinding: InitialBindings(),
        builder: (_, child) => BaseWidget(
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
