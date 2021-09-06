import 'package:get/get.dart';


class HistoryScreenLogic extends GetxController {
  // final state = HistoryScreenState();
  RxBool isCheckIn = true.obs;
  RxBool isBankTransferIn = false.obs;
  RxBool isRedeem = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  changePage(bool isCheck, bool isBankTransfer, bool isRedeemPage) {
    if (isCheck) {
      isCheckIn.value = isCheck;
      isBankTransferIn.value = isBankTransfer;
      isRedeem.value = isRedeemPage;
    }
    if (isBankTransfer) {
      isCheckIn.value = isCheck;
      isBankTransferIn.value = isBankTransfer;
      isRedeem.value = isRedeemPage;
    }
    if (isRedeemPage) {
      isCheckIn.value = isCheck;
      isBankTransferIn.value = isBankTransfer;
      isRedeem.value = isRedeemPage;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
