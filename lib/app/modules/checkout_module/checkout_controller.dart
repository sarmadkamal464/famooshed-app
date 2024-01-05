import 'dart:developer';

import 'package:dio/dio.dart' as d;
import 'package:famooshed/app/common/util/loading_dialog.dart';
import 'package:famooshed/app/common/values/app_urls.dart';
import 'package:famooshed/app/data/api_helper.dart';
import 'package:famooshed/app/data/models/card_model.dart';
import 'package:famooshed/app/data/models/get_address_new_response.dart';
import 'package:famooshed/app/data/models/get_profile_response.dart';
import 'package:famooshed/app/modules/checkout_module/checkout_page.dart';
import 'package:famooshed/app/modules/dashboard_module/dashboard_controller.dart';
import 'package:famooshed/app/routes/app_pages.dart';
import 'package:famooshed/app/utils/dprint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/constants.dart';
import '../../common/storage/storage.dart';
import '../../data/models/get_cart_model.dart';
import '../../data/models/get_delivery_type_response.dart';
import '../cart_module/cart_controller.dart';
import '../order_sucess_module/order_sucess_controller.dart';
import '../payment_methods_module/payment_methods_controller.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// GetX Template Generator - fb.com/htngu.99
///

class CheckoutController extends GetxController {
  Map<String, dynamic>? paymentIntent;
  GetProfileResponse? getProfileResponse;
  @override
  void onReady() {
    // getAddress();

    getDeliveryType();

    getAddressNew();
    getProfile();
    super.onReady();
  }

  @override
  void onInit() {
    // getBasketResponse = data as GetBasketResponse;
    cartResponse = data as CartResponse;
    update();
    super.onInit();
  }

  bool isSUVSelected = true;
  bool isSedanSelected = false;
  bool isCoupeSelected = false;
  bool isTruckSelected = false;
  bool isBikeSelected = false;
  bool isOtherSelected = false;
  String selectColorId = "Black";
  String selectedVehicleName = "";
  String securityKey =
      "sk_test_51OUb2vHJpwM2a5YZzqRND2sWXkaZ7Bx5lluBlaXQFNWBWh8g6IPZoT4FtnCsNlKzWD8A7d4DGJkvGlenqdJrnxk500cdQOaoJC";
  AddressEnum? addressValue = AddressEnum.home;
  PaymentEnum? payment = PaymentEnum.card;

  int selectedRadioTile = 0;
  RxString addValue = "".obs;
  String radioItem = '';
  RxInt addId = 0.obs;
  RxString lat = "".obs;
  RxString lng = "".obs;

  bool centerTitle = true;

  CartResponse cartResponse = CartResponse();

  TextEditingController commentsController = TextEditingController();
  TextEditingController vehicleNoController = TextEditingController();
  RxBool takeOrderMySelf = RxBool(false);
  // dynamic getBasketResponse;
  final ApiHelper apiHelper = ApiHelper.to;
  dynamic data = Get.arguments;
  // final RxList<Address> _address = RxList();
  // List<Address> get address => _address;
  // set address(List<Address> address) => _address.addAll(address);

  // Address? selectedAddress;
  AddressResponse? selectedAddress;

  DateTime? selectedStartDate;
  String startTimeController = '';
  String selectedDate = '';

  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardNoController = TextEditingController();
  TextEditingController cardExpController = TextEditingController();
  TextEditingController cardCvvController = TextEditingController();
  TextEditingController cardZipController = TextEditingController();
  bool isCardSave = false;
  RxString expiryDate = ''.obs;

  final RxList<CardModel> _cards = RxList();
  List<CardModel> get cards => _cards;
  set cards(List<CardModel> address) => _cards.addAll(cards);

  CardModel selectedCard = CardModel();

  setSelectedRadioTile(int val) {
    selectedRadioTile = val;
  }

  onAddressChange() {
    // var add = address.firstWhere((element) => element.id == addId.value);
    var add = addressList.firstWhere((element) => element.id == addId.value);

    addValue.value = add.text ?? '-';
    lat.value = add.lat ?? '';
    lng.value = add.lng ?? '';
    update();
  }

  // getAddress() {
  //   apiHelper.postApiCall(AppUrl.getAddress, {}).futureValue((value) {
  //     if (value['address'] != []) {
  //       var response = GetAddresstResponse.fromJson(value);
  //       address.clear();
  //       if (response.address.isNotEmpty) {
  //         address = response.address;
  //         addValue.value = address[0].text;
  //         lat.value = address[0].lat;
  //         lng.value = address[0].lng;
  //         address.forEach((element) {
  //           if (element.addressDefault == 'true') {
  //             selectedAddress = element;
  //           } else {
  //             selectedAddress = address[0];
  //           }
  //         });
  //         dprint(addId);
  //       }
  //       // if (address.isNotEmpty) {
  //       //   address.clear();
  //       //   address = response.address;
  //       //   addValue.value = address[0].text;
  //       //   lat.value = address[0].lat;
  //       //   lng.value = address[0].lng;
  //       //   dprint(addId);
  //       // } else {
  //       // address = response.address;
  //       //
  //       // address.forEach((element) {
  //       //   if (element.addressDefault == 'true') {
  //       //     selectedAddress = element;
  //       //   } else {
  //       //     selectedAddress = address[0];
  //       //   }
  //       // });
  //       // addValue.value = address[0].text;
  //       // lat.value = address[0].lat;
  //       // lng.value = address[0].lng;
  //       // }
  //     }
  //     update();
  //   }, retryFunction: getAddress);
  // }

  RxBool nextDayCourierDelivery = RxBool(false);
  RxBool onlyFamooshed = RxBool(false);
  RxBool homeDelivery = RxBool(false);
  RxBool pickupFromMarket = RxBool(false);
  RxBool isLoading = true.obs;
  final ApiHelper _apiHelper = ApiHelper.to;
  Rx<GetDeliveryTypeResponse> deliveryOptions = Rx(GetDeliveryTypeResponse());
  RxDouble deliveryFee = RxDouble(0);

  getDeliveryType() {
    apiHelper
        .getApiCall(
      "${AppUrl.getResDeliver}?id=${cartResponse.data!.cart!.restaurantId}",
    )
        .futureValue((value) {
      if (value['error'] == '0') {
        var response = GetDeliveryTypeResponse.fromJson(value);
        if (response.error != null && response.error == '0') {
          deliveryOptions.value = response;
          if (response.homeDeli != null && response.homeDeli == 1) {
            deliveryFee.value = double.parse(response.homeDeliFee ?? '0');
          } else if (response.nextDay != null && response.nextDay == 1) {
            deliveryFee.value = double.parse(response.nextDayFee ?? '0');
          } else if (response.onlyfamooshed != null &&
              response.onlyfamooshed == 1) {
            deliveryFee.value = double.parse(response.onlyfamooshedFee ?? '0');
          }
        }
      }
      update();
    }, retryFunction: getDeliveryType);
  }

  checkoutOption() async {
    // GetBasketResponse response = getBasketResponse;
    // response.basketTotalWithTax =
    //     (double.parse(getBasketResponse.basketTotalWithTax) + deliveryFee.value)
    //         .toString();
    // update();
    await setDeliveryMethod();
    if (takeOrderMySelf.value == false) {
      await checkDeliveryAddress();
    } else {
      await getCartNew().then((value) {
        Get.toNamed(
          Routes.ORDER_SUMMARY,
        );
      });
    }
    // await getCartNew().then((value) {
    //   Get.toNamed(
    //     Routes.ORDER_SUMMARY,
    //   );
    // });

    // if (payment == PaymentEnum.card) {
    //   Get.toNamed(Routes.PAYMENT_METHODS, arguments: [
    //     {"cart": getBasketResponse},
    //     {"address": addValue.value},
    //     {"lat": lat.value},
    //     {'lng': lng.value}
    //   ]);
    // } else {
    //   addToCart();
    // }
  }

  // addToCart() {
  //   var body = {
  //     "total": getBasketResponse!.basketTotalWithTax,
  //     "address": addValue.value,
  //     "phone": "",
  //     "pstatus": "Waiting for client",
  //     "lat": lat.value,
  //     "lng": lng.value,
  //     "curbsidePickup": "false",
  //     "send": "1",
  //     "tax": getBasketResponse!.defaultTax,
  //     "hint": "abcd",
  //     "couponName": getBasketResponse!.order.couponName,
  //     "restaurant": getBasketResponse!.restaurantData.id,
  //     "method": "Cash on Delivery",
  //     "fee": getBasketResponse!.order.fee,
  //     "data": getBasketResponse!.orderdetails
  //   };
  //   dprint(body);
  //   apiHelper.addBasket(AppUrl.addToBasket, body).futureValue(
  //     (value) {
  //       walletSetId(orderId: getBasketResponse!.order.id);
  //     },
  //     retryFunction: addToCart,
  //   );
  // }

  addToCartNew() async {
    LoadingDialog.showLoadingDialog();

    try {
      var body = {
        "isApp": true,
        "id": "",
        "qty": 1,
      };

      d.Response response =
          await apiHelper.postApiNew(AppUrl.addToCart, {}, body);

      if (response.statusCode == 200) {
        LoadingDialog.closeLoadingDialog();
        dprint(response.data);
        // walletSetId(orderId: getBasketResponse!.order.id);
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  setDeliveryMethod() async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var body = {
        "onlyFamoo": onlyFamooshed.value,
        "onlyHome": (onlyFamooshed.value == false &&
                nextDayCourierDelivery.value == false &&
                takeOrderMySelf.value == false)
            ? true
            : homeDelivery.value,
        "onlyNext": nextDayCourierDelivery.value,
        // "pickup": takeOrderMySelf.value,
        "isApp": true,
        "uid": uid.toString(),
        "arrivalDate": "${takeOrderMySelf.value == true ? selectedDate : ''}",
        "arrivalTime":
            "${takeOrderMySelf.value == true ? startTimeController : ''}",
        "comment": commentsController.text,
      };

      d.Response response =
          await apiHelper.postApiNew(AppUrl.setDeliveryMethod, {}, body);

      if (response.statusCode == 200) {
        LoadingDialog.closeLoadingDialog();
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  checkDeliveryAddress() async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var body = {
        "address_id": selectedAddress!.id,
        "isApp": true,
        "uid": uid.toString(),
      };

      d.Response response =
          await apiHelper.postApiNew(AppUrl.checkDeliveryAddress, {}, body);

      if (response.statusCode == 200) {
        LoadingDialog.closeLoadingDialog();

        if (response.data['distanceMessage'] != null &&
            response.data['distanceMessage'] == false) {
          await getCartNew().then((value) {
            Get.toNamed(
              Routes.ORDER_SUMMARY,
            );
          });
        } else if (response.data['distanceMessage'] != null &&
            response.data['distanceMessage'] == true) {
          Utils.showSnackbar(
              response.data['message'] ?? "Something went wrong!!!");
        } else {
          Utils.showSnackbar(
              response.data['message'] ?? "Something went wrong!!!");
        }
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  Future<void> getCartNew() async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var queryParams = {
        "isApp": true,
        "uid": uid.toString(),
      };

      d.Response response = await apiHelper.getApiNew(
        AppUrl.getCart,
        {},
        queryParams,
      );

      if (response.statusCode == 200) {
        dprint(response.data);
        CartResponse cartResponse = CartResponse.fromJson(response.data);

        this.cartResponse = cartResponse;

        update();
        LoadingDialog.closeLoadingDialog();
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  List<AddressResponse> addressList = [];
  Future<void> getAddressNew() async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var queryParams = {
        "isApp": true,
        "uid": uid.toString(),
      };

      d.Response response = await apiHelper.getApiNew(
        AppUrl.getAddresses,
        {},
        queryParams,
      );

      if (response.statusCode == 200) {
        addressList.clear();
        dprint(response.data);
        if (response.data['error'] == '0') {
          if (response.data['address'] != null) {
            List data = response.data['address'];
            if (data.isNotEmpty) {
              data.forEach((element) {
                addressList.add(AddressResponse.fromJson(element));
              });

              addressList.forEach((element) {
                if (element.addressResponseDefault == 'true') {
                  selectedAddress = element;
                } else {
                  selectedAddress = addressList[0];
                }
              });

              lat.value = selectedAddress!.lat ?? '';
              lng.value = selectedAddress!.lng ?? '';
            }
          }
        }
      }
      update();
      LoadingDialog.closeLoadingDialog();
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  // walletSetId({orderId}) {
  //   var body = {"walletId": "", "orderId": orderId};
  //   apiHelper.postApiCall(AppUrl.walletSetId, body).futureValue(
  //     (value) {
  //       if (value["error"] == 0) {
  //         Get.toNamed(Routes.ORDER_SUCESS);
  //       }
  //     },
  //     retryFunction: walletSetId,
  //   );
  // }

  // resetBasket() {
  //   apiHelper.postApiCall(AppUrl.resetBasket, {}).futureValue(
  //     (value) {
  //       addToCart();
  //     },
  //     retryFunction: resetBasket,
  //   );
  // }

  Future<void> saveVehicleData() async {
    LoadingDialog.showLoadingDialog();
    try {
      Response response =
          await apiHelper.postApiCall(AppUrl.getOrderDeliverData, {
        "orderInPerson": "${takeOrderMySelf.value ? "Yes" : "No"}",
        "next_day": "${nextDayCourierDelivery.value ? "Yes" : "No"}",
        "only_famo": "${onlyFamooshed.value ? "Yes" : "No"}",
        // "pikFromMarket": "${pickupFromMarket.value ? "Yes" : "No"}",
        // "vehiclename": takeOrderMySelf.value == true && pickupFromMarket.value
        //     ? ''
        //     : selectedVehicleName,
        // "vehicalColor": takeOrderMySelf.value == true && pickupFromMarket.value
        //     ? ''
        //     : selectColorId,
        // "vehicalNumber": takeOrderMySelf.value == true && pickupFromMarket.value
        //     ? ''
        //     : vehicleNoController.text,
        "pstatus": "paid",
        "send": "1",
        "comment": commentsController.text,
        "arrivalDate": selectedDate,
        "arrivalTime": startTimeController,
      });

      dprint(response.request);
      if (response.statusCode == 200) {
        if (response.body['error'] == "0") {
          LoadingDialog.closeLoadingDialog();
        }
      }
    } catch (e) {
      LoadingDialog.closeLoadingDialog();
      update();
    }
    LoadingDialog.closeLoadingDialog();
    update();
  }

  Future<void> saveCard(String paymentMethodId, String amount,
      String isSaveCard, String basketTotalWithTax) async {
    LoadingDialog.showLoadingDialog();
    try {
      var body = {
        "payment_method_id": paymentMethodId,
        "amount": amount,
        "isSaveCard": isSaveCard,
        "order_id": cartResponse.data!.cart!.id,
        "basketTotalWithTax": basketTotalWithTax
      };
      dprint(body);
      Response response =
          await apiHelper.postApiCall(AppUrl.saveCustmrCard, body);

      if (response.statusCode == 200) {
        if (response.body['success'] == true) {
          // await saveVehicleData().then((value) {
          // resetBasket();
          Get.delete<CartController>();
          Get.delete<PaymentMethodsController>();

          await walletSetId(orderId: cartResponse.data!.cart!.id).then((value) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await placeOrder();
            });
          });

          // });
        }
      }
    } catch (e) {
      LoadingDialog.closeLoadingDialog();
      update();
    }
    LoadingDialog.closeLoadingDialog();
    update();
  }

  Future<void> getCards() async {
    LoadingDialog.showLoadingDialog();
    try {
      Response response = await apiHelper.postApiCall(AppUrl.getSavedCards, {});

      if (response.statusCode == 200) {
        if (response.body['success'] == true) {
          LoadingDialog.closeLoadingDialog();
          cards.clear();
          if (response.body['payload'] != null &&
              response.body['payload'] is List &&
              response.body['payload'].isNotEmpty) {
            List cardsData = response.body['payload'];
            cardsData.forEach((element) {
              cards.add(CardModel.fromJson(element));
            });
            if (selectedCard.paymentMethodId == null ||
                selectedCard.paymentMethodId!.isEmpty) {
              selectedCard = cards[0];
            }
            update();
          }
        }
      }
    } catch (e) {
      LoadingDialog.closeLoadingDialog();
      update();
    }
    LoadingDialog.closeLoadingDialog();
    update();
  }

  Future<void> walletSetId({orderId}) async {
    var body = {"walletId": "", "orderId": orderId};
    apiHelper.postApiCall(AppUrl.walletSetId, body).futureValue(
      (value) {
        if (value["error"] == 0) {
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   Get.toNamed(Routes.ORDER_SUCESS);
          //   Get.delete<CheckoutController>();
          //   Get.delete<OrderSucessController>();
          // });
        }
      },
      retryFunction: walletSetId,
    );
  }

  placeOrder() async {
    LoadingDialog.showLoadingDialog();
    int uid = await Storage.getValue(Constants.userId);

    print(uid);
    try {
      var queryParams = {
        "isApp": true,
        "uid": uid.toString(),
      };

      d.Response response = await apiHelper.getApiNew(
        AppUrl.placeOrder,
        {},
        queryParams,
      );

      if (response.statusCode == 200) {
        LoadingDialog.closeLoadingDialog();
        Get.toNamed(Routes.ORDER_SUCESS);
        Get.delete<CheckoutController>();
        Get.delete<OrderSucessController>();
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  // resetBasket() {
  //   apiHelper.postApiCall(AppUrl.resetBasket, {}).futureValue(
  //     (value) {
  //       Get.delete<CartController>();
  //       Get.delete<PaymentMethodsController>();
  //
  //       walletSetId(orderId: getBasketResponse!.order.id);
  //
  //       // addToCart();
  //     },
  //     retryFunction: resetBasket,
  //   );
  // }
  getProfile() async {
    var userId = await Storage.getValue(Constants.userId);

    _apiHelper.postApiCall("${AppUrl.getProfile}", {"id": userId}).futureValue(
      (value) {
        try {
          getProfileResponse = GetProfileResponse.fromJson(value);
          isLoading.value = false;

          update();
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
      },
      retryFunction: getProfile,
    );
  }

  Future<void> makePayment(
    String payable,
    String email,
    String name,
  ) async {
    try {
      int amountInCents = (double.parse(payable) * 100).round();
      var customer = await createOrRetrieveCustomer(
        email,
        name,
      );
      // Step 3: Create PaymentIntent with the attached PaymentMethod
      var paymentIntent = await createPaymentIntentWithPaymentMethod(
          amountInCents.toString(), 'GBP', customer['id']);

      var gpay = PaymentSheetGooglePay(
          merchantCountryCode: "GB",
          currencyCode: "GBP",
          testEnv: true,
          label: 'famooshed Pay',
          amount: '100');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            billingDetails: const BillingDetails(
                name: 'John',
                email: 'john@gmail.com',
                phone: '+920000000',
                address: Address(
                    city: 'Bordon',
                    country: 'UK',
                    line1: '25 Essex Cl',
                    line2: 'GU35 OTZ',
                    postalCode: '4567',
                    state: 'state')),
            paymentIntentClientSecret:
                paymentIntent!['client_secret'], //Gotten from payment intent
            style: ThemeMode.light,
            merchantDisplayName: 'Famooshed',
            googlePay: gpay,
            applePay: const PaymentSheetApplePay(
              buttonType: PlatformButtonType.buy,
              merchantCountryCode: '+92',
            ),
            // customerEphemeralKeySecret: paymentIntent?['ephemeralKey'],
            customerId: customer['id'],
          ))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      print(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        DashboardController dashboardController =
            Get.find<DashboardController>();
        print("Payment Successfully");
        Get.delete<CartController>();
        dashboardController.count.value.toString() == "0";
        Get.delete<CheckoutController>();
        Get.toNamed(Routes.ORDER_SUCESS);
        Get.delete<OrderSucessController>();
        placeOrder();
      });
    } catch (e) {
      print('$e');
    }
  }

  Future<Map<String, dynamic>> createOrRetrieveCustomer(
    String email,
    String name,
  ) async {
    try {
      // Check if the customer already exists
      var existingCustomers = await listCustomers(email);
      if (existingCustomers.isNotEmpty) {
        return existingCustomers.first;
      }

      // If the customer doesn't exist, create a new one
      return await createCustomer(email, name);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<List<Map<String, dynamic>>> listCustomers(String email) async {
    try {
      var response = await http.get(
        Uri.parse('https://api.stripe.com/v1/customers'),
        headers: {
          'Authorization': 'Bearer $securityKey',
        },
      );

      var customers = json.decode(response.body)['data'];
      var filteredCustomers =
          customers.where((customer) => customer['email'] == email).toList();
      return filteredCustomers.cast<Map<String, dynamic>>();
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<String> attachCardToCustomer(
      String customerId, String cardTokenOrPaymentMethodId) async {
    try {
      Map<String, dynamic> body = {
        'customer': customerId,
        'source': cardTokenOrPaymentMethodId,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_methods/attach'),
        headers: {
          'Authorization': 'Bearer $securityKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      var paymentMethodId = json.decode(response.body)['id'];
      return paymentMethodId;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntentWithPaymentMethod(
      String amount, String currency, String customer) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'customer': customer,
        'description': 'User Do its Payment',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $securityKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      var paymentIntent = json.decode(response.body) as Map<String, dynamic>;
      return paymentIntent;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<Map<String, dynamic>> createCustomer(String email, String name) async {
    try {
      Map<String, dynamic> body = {
        'email': email,
        'name': name,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/customers'),
        headers: {
          'Authorization': 'Bearer $securityKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      return json.decode(response.body.toString());
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
