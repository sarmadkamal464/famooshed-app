import 'package:famooshed/app/modules/my_reward_module/my_reward_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class MyRewardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyRewardController());
  }
}
