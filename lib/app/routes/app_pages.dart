import 'package:famooshed/app/modules/about_us_module/about_bindings.dart';
import 'package:famooshed/app/modules/about_us_module/about_page.dart';
import 'package:famooshed/app/modules/checkout_module/order_summary_page.dart';
import 'package:famooshed/app/modules/checkout_module/payment_page.dart';
import 'package:famooshed/app/modules/checkout_module/select_address_page.dart';
import 'package:famooshed/app/modules/checkout_module/vehicle_info_page.dart';
import 'package:famooshed/app/modules/document_module/document_bindings.dart';
import 'package:famooshed/app/modules/document_module/document_page.dart';
import 'package:famooshed/app/modules/favorite_module/favorite_page.dart';
import 'package:get/get.dart';

import '../../app/modules/add_new_location_module/add_new_location_bindings.dart';
import '../../app/modules/add_new_location_module/add_new_location_page.dart';
import '../../app/modules/cart_module/cart_bindings.dart';
import '../../app/modules/cart_module/cart_page.dart';
import '../../app/modules/checkout_module/checkout_bindings.dart';
import '../../app/modules/checkout_module/checkout_page.dart';
import '../../app/modules/dashboard_module/dashboard_bindings.dart';
import '../../app/modules/dashboard_module/dashboard_page.dart';
import '../../app/modules/edit_profile_module/edit_profile_bindings.dart';
import '../../app/modules/edit_profile_module/edit_profile_page.dart';
import '../../app/modules/feedbacks_module/feedbacks_bindings.dart';
import '../../app/modules/feedbacks_module/feedbacks_page.dart';
import '../../app/modules/filter_module/filter_bindings.dart';
import '../../app/modules/filter_module/filter_page.dart';
import '../../app/modules/find_by_category_module/find_by_category_bindings.dart';
import '../../app/modules/find_by_category_module/find_by_category_page.dart';
import '../../app/modules/help_and_support_module/help_and_support_bindings.dart';
import '../../app/modules/help_and_support_module/help_and_support_page.dart';
import '../../app/modules/home_location_module/home_location_bindings.dart';
import '../../app/modules/home_location_module/home_location_page.dart';
import '../../app/modules/home_module/home_bindings.dart';
import '../../app/modules/home_module/home_page.dart';
import '../../app/modules/location_module/location_bindings.dart';
import '../../app/modules/location_module/location_page.dart';
import '../../app/modules/merchants_module/merchants_bindings.dart';
import '../../app/modules/merchants_module/merchants_page.dart';
import '../../app/modules/my_profile_module/my_profile_bindings.dart';
import '../../app/modules/my_profile_module/my_profile_page.dart';
import '../../app/modules/my_reward_module/my_reward_bindings.dart';
import '../../app/modules/my_reward_module/my_reward_page.dart';
import '../../app/modules/notification_module/notification_bindings.dart';
import '../../app/modules/notification_module/notification_page.dart';
import '../../app/modules/onboard_module/onboard_bindings.dart';
import '../../app/modules/onboard_module/onboard_page.dart';
import '../../app/modules/order_details_module/order_details_bindings.dart';
import '../../app/modules/order_details_module/order_details_page.dart';
import '../../app/modules/order_sucess_module/order_sucess_bindings.dart';
import '../../app/modules/order_sucess_module/order_sucess_page.dart';
import '../../app/modules/order_track_module/order_track_bindings.dart';
import '../../app/modules/order_track_module/order_track_page.dart';
import '../../app/modules/orders_module/orders_bindings.dart';
import '../../app/modules/orders_module/orders_page.dart';
import '../../app/modules/otp_module/otp_bindings.dart';
import '../../app/modules/otp_module/otp_page.dart';
import '../../app/modules/payment_methods_module/payment_methods_bindings.dart';
import '../../app/modules/payment_methods_module/payment_methods_page.dart';
import '../../app/modules/promotions_module/promotions_bindings.dart';
import '../../app/modules/promotions_module/promotions_page.dart';
import '../../app/modules/review_module/review_bindings.dart';
import '../../app/modules/review_module/review_page.dart';
import '../../app/modules/search_module/search_bindings.dart';
import '../../app/modules/search_module/search_page.dart';
import '../../app/modules/settings_module/settings_bindings.dart';
import '../../app/modules/settings_module/settings_page.dart';
import '../../app/modules/share_address_module/share_address_bindings.dart';
import '../../app/modules/share_address_module/share_address_page.dart';
import '../../app/modules/sign_in_module/sign_in_bindings.dart';
import '../../app/modules/sign_in_module/sign_in_page.dart';
import '../../app/modules/sign_up_module/sign_up_bindings.dart';
import '../../app/modules/sign_up_module/sign_up_page.dart';
import '../../app/modules/signle_item_module/signle_item_bindings.dart';
import '../../app/modules/signle_item_module/signle_item_page.dart';
import '../../app/modules/splash_module/splash_bindings.dart';
import '../../app/modules/splash_module/splash_page.dart';
import '../../app/modules/verify_module/verify_bindings.dart';
import '../../app/modules/verify_module/verify_page.dart';
import '../../app/modules/view_all_module/view_all_bindings.dart';
import '../../app/modules/view_all_module/view_all_page.dart';
import '../modules/dashboard_module/map_page.dart';
import '../modules/favorite_module/favorite_bindings.dart';

part 'app_routes.dart';

abstract class AppPages {
  const AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.ONBOARD,
      page: () => const OnboardPage(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: Routes.SIGN_IN,
      page: () => SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.SIGN_UP,
      page: () => const SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.VERIFY,
      page: () => const VerifyPage(),
      binding: VerifyBinding(),
    ),
    GetPage(
      name: Routes.LOCATION,
      page: () => const LocationPage(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: Routes.OTP,
      page: () => const OtpPage(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: Routes.SHARE_ADDRESS,
      page: () => const ShareAddressPage(),
      binding: ShareAddressBinding(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.MAP,
      page: () => MapPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.CHECKOUT,
      page: () => const CheckoutPage(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: Routes.ADD_NEW_LOCATION,
      page: () => AddNewLocationPage(),
      binding: AddNewLocationBinding(),
    ),
    GetPage(
      name: Routes.HOME_LOCATION,
      page: () => const HomeLocationPage(),
      binding: HomeLocationBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT_METHODS,
      page: () => PaymentMethodsPage(),
      binding: PaymentMethodsBinding(),
    ),
    GetPage(
      name: Routes.ORDER_SUCESS,
      page: () => const OrderSucessPage(),
      binding: OrderSucessBinding(),
    ),
    GetPage(
      name: Routes.MERCHANTS,
      page: () => const MerchantsPage(),
      binding: MerchantsBinding(),
    ),
    GetPage(
      name: Routes.ORDERS,
      page: () => OrdersPage(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: Routes.MY_PROFILE,
      page: () => const MyProfilePage(),
      binding: MyProfileBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => const NotificationPage(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.SIGNLE_ITEM,
      page: () => const SignleItemPage(),
      binding: SignleItemBinding(),
    ),
    GetPage(
      name: Routes.REVIEW,
      page: () => const ReviewPage(),
      binding: ReviewBinding(),
    ),
    GetPage(
      name: Routes.FILTER,
      page: () => FilterPage(),
      binding: FilterBinding(),
    ),
    GetPage(
      name: Routes.FIND_BY_CATEGORY,
      page: () => const FindByCategoryPage(),
      binding: FindByCategoryBinding(),
    ),
    GetPage(
      name: Routes.ORDER_DETAILS,
      page: () => const OrderDetailsPage(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: Routes.ORDER_TRACK,
      page: () => OrderTrackPage(),
      binding: OrderTrackBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE,
      page: () => const EditProfilePage(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: Routes.VIEW_ALL,
      page: () => const ViewAllPage(),
      binding: ViewAllBinding(),
    ),
    GetPage(
      name: Routes.HELP_AND_SUPPORT,
      page: () => HelpAndSupportPage(true),
      binding: HelpAndSupportBinding(),
    ),
    GetPage(
      name: Routes.PROMOTIONS,
      page: () => PromotionsPage(),
      binding: PromotionsBinding(),
    ),
    GetPage(
      name: Routes.FEEDBACKS,
      page: () => FeedbacksPage(),
      binding: FeedbacksBinding(),
    ),
    GetPage(
      name: Routes.MY_REWARD,
      page: () => MyRewardPage(),
      binding: MyRewardBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsPage(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.FAVORITES,
      page: () => FavoritePage(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: Routes.PRIVACY_POLICY,
      page: () => DocumentPage(),
      binding: DocumentBinding(),
    ),
    GetPage(
      name: Routes.TNC,
      page: () => DocumentPage(),
      binding: DocumentBinding(),
    ),
    GetPage(
      name: Routes.REFUND_POLICY,
      page: () => DocumentPage(),
      binding: DocumentBinding(),
    ),
    GetPage(
      name: Routes.ABOUT_US,
      page: () => AboutUsPage(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: Routes.VEHICLE_INFO,
      page: () => VehicleInfoPage(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: Routes.SELECT_ADDRESS,
      page: () => SelectAddressPage(),
      // binding: CheckoutBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT_PAGE,
      page: () => PaymentPage(),
      // binding: CheckoutBinding(),
    ),
    GetPage(
      name: Routes.ORDER_SUMMARY,
      page: () => OrderSummaryPage(),
      // binding: CheckoutBinding(),
    ),
  ];
}
