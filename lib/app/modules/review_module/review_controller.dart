import 'package:famooshed/app/data/models/get_food_details_response.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class ReviewController extends GetxController {
  @override
  void onReady() {
    foodsReview = arguments;
    super.onReady();
  }

  RxBool isCenterTitle = true.obs;

  RxBool isLoading = true.obs;
  dynamic arguments = Get.arguments;

  final RxList<Foodsreview> _foodsreview = RxList();
  List<Foodsreview> get foodsReview => _foodsreview;
  set foodsReview(List<Foodsreview> foodsReview) =>
      _foodsreview.addAll(foodsReview);
}
