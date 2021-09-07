import 'package:get/get.dart';

import 'logic.dart';

class CashoutScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CashoutScreenLogic());
  }
}
