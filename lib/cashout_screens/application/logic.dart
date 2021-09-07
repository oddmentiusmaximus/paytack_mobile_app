import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CashoutScreenLogic extends GetxController {
  TextEditingController? amtController;
  RxBool amtError = false.obs;
  RxBool transferAlert = false.obs;

  ///BankDetailsPage
  TextEditingController? ibanController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    amtController = TextEditingController();
    ibanController = TextEditingController();
  }
}
