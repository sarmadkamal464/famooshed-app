import 'package:famooshed/app/common/constants.dart';

abstract class AppUrl {
  static const loginEmail = "login";
  static const register = "regUser";
  static const getSecondStep = "getSecondStep";
  static const getFoodCatList = "foodCatList";
  static const getHome = "getHome";
  static const getOrders = "getOrders";
  static const reOrder = "reOrder";
  static const getRestaurants = "getRestaurant?restaurant=";
  static const addToBasket = "addToBasket";
  static const forgotPassword = "forgot";

  static const getBasket = "getBasket";
  static const notify = "notify";
  static const getRestaurantByCat = "getRestaurantByCat?restaurant=";
  static const saveAddress = "saveAddress";
  static const getAddress = "getAddress";
  static const getResDeliver = "getResDeliver";
  static const delAddress = "delAddress";
  static const getFoodDetails = "getFood?id=";
  static const addFoodReviews = "foodReviewsAdd";
  static const getProfile = "getUserProfile";
  static const uploadAvatar = "uploadAvatar";
  static const changeProfile = "changeProfile";
  static const setCountInBasket = "setCountInBasket";
  static const getSearch = "search?search=";
  static const walletSetId = "walletSetId";
  static const resetBasket = "resetBasket";
  static const checkUser = "checkEmail?email=";
  static const getOrdersStatus = "getOrdersStatus?orderId=";
  static const deleteFromBasket = "deleteFromBasket";
  static const getfaq = "getfaq";
  static const getCategories = "categoryList";
  static const getStallCategories = "loadstallCategories";
  static const getFavorites = "favoritesResGet";
  static const addFavorites = "addFavRest";
  static const deleteFavorites = "favoritesResDelete";
  static const getDocument = "getDocuments";
  static const getDriverLoc = "getDriverLocation";
  static const createTicket = "submit-ticket";
  static const getOrderDeliverData = "getOrderDeliverData";
  static const getSavedCards = "getSavedCards";
  static const saveCustmrCard = "saveCustmrCard";
  static const customerDelete = "customerDelete";
  static const fcbToken = "fcbToken";

  //New
  static const addToCart = "${Constants.baseUrlNew}add-to-cart";
  static const resetCart = "${Constants.baseUrlNew}cart-reset";
  static const getCart = "${Constants.baseUrlNew}get-cart";
  static const setDeliveryMethod = "${Constants.baseUrlNew}set-delivery-method";
  static const checkCouponCode = "${Constants.baseUrlNew}check-coupon-code";
  static const getAddresses = "${Constants.baseUrlNew}get-addresses";
  static const removeCart = "${Constants.baseUrlNew}remove-cart";
  static const placeOrder = "${Constants.baseUrlNew}place-order";
  static const repeatOrder = "${Constants.baseUrlNew}repeat-order";
  static const checkDeliveryAddress =
      "${Constants.baseUrlNew}check-delivery-address";

  static const getRestaurantsNew = "getRestaurant";
}
