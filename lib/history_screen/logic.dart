import 'package:get/get.dart';


class HistoryScreenLogic extends GetxController {
  // final state = HistoryScreenState();
  bool isCheckIn = true;
  bool isBankTransferIn = false;
  bool isRedeem = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  changePage(bool isCheck, bool isBankTransfer, bool isRedeemPage) {
    if (isCheck) {
      isCheckIn = isCheck;
      isBankTransferIn = isBankTransfer;
      isRedeem = isRedeemPage;
    }
    if (isBankTransfer) {
      isCheckIn = isCheck;
      isBankTransferIn = isBankTransfer;
      isRedeem = isRedeemPage;
    }
    if (isRedeemPage) {
      isCheckIn = isCheck;
      isBankTransferIn = isBankTransfer;
      isRedeem = isRedeemPage;
    }
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
