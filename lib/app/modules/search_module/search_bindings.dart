import 'package:famooshed/app/modules/search_module/search_controller.dart';
import 'package:get/get.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchFoodController());
  }
}
