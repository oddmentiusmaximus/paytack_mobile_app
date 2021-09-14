import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CashoutScreenLogic extends GetxController {
  TextEditingController? amtController;
  RxBool amtError = false.obs;
  RxBool transferAlert = false.obs;
  RxBool showList = false.obs;
  RxInt isSelectedRadio = 0.obs;

  ///BankDetailsPage
  TextEditingController? ibanController;

  ///
  List dummy = [
    {'1', '2', '3 '},
    {'2', '5', '3'}
  ];

  onChange(value){
    isSelectedRadio.value = value;
    transferAlert.value = true;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    amtController = TextEditingController();
    ibanController = TextEditingController();
  }
}
