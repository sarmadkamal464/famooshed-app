import 'package:get/get.dart';

import 'document_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class DocumentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => DocumentController(),
    );
  }
}
