import 'package:famooshed/app/utils/dprint.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class VerifyController extends GetxController {
  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
  @override
  void onClose() {
    dprint('Verify Controller Closed');
    super.onClose();
  }
}
