import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/common_dialog.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/network/api_helper.dart';
import 'package:paytack/common_function/network/network_class.dart';
import 'package:paytack/common_function/utils/loading_class.dart';
import 'package:paytack/common_function/widget/button.dart';

class DetailPageController extends GetxController {
  DetailPageController(this._networkRepository);

  final NetworkProvider _networkRepository;

  bool loyaltyStatus = false;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getLoyaltyProgramStatus(String businessId) async {

    Map<String, dynamic> params = {"BusinessId": businessId};
    _networkRepository.postMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.loyaltyProgramJoined+"?BusinessId=$businessId",
       // parameter: params,
        success: (success) {
          print(success.toString());
          if (success.toString().isNotEmpty) {
            loyaltyStatus = success;
          }
          update();
        },
        error: (error) {});
  }

  Future<void> joinLoyaltyProgram(String businessId, bool val,BuildContext context) async {
    Loading.show(context: context);
   /* Map<String, dynamic> params = {
      "BusinessId": businessId,
      "isJoinProgram": val
    };*/

    _networkRepository.postMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.manageLoyaltyProgram+"?isJoinProgram=$val&BusinessId=$businessId",
        //parameter: params,
        success: (success) {
          String message='';
          if(val==true){
            message="Thank you for joining program";
          }else{
            message="Successfully unsubscribed program";
          }
          print(success.toString());
          if (success.toString().isNotEmpty) {
            showCommonWithWidget(
              barrierDismissible: false,
              context: context,
              title: "",
              image: success_tick,
              message: message,
              imageTrue: true,
              widget: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomButton(
                    color: pPrimaryColor,
                    isEnabled: true,
                    tvSize: 16.0,
                    width: 100,
                    tvColor: Colors.white,
                    height: 45.0,
                    radius: 12.0,
                    btnTitle: "Ok",
                    onPress: () async {
                      Get.back();
                      Get.back();
                      await getLoyaltyProgramStatus(businessId);
                    }),
              ),
            );
          }
          update();
        },
        error: (error) {
          showCommonWithWidget(
            barrierDismissible: false,
            context: context,
            title: "",
            image: success_tick,
            message: "Error while joining program",
            imageTrue: true,
            widget: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                  color: pPrimaryColor,
                  isEnabled: true,
                  tvSize: 16.0,
                  width: 100,
                  tvColor: Colors.white,
                  height: 45.0,
                  radius: 12.0,
                  btnTitle: "Ok",
                  onPress: () {
                    Get.back();
                    Get.back();
                  }),
            ),
          );

        });
  }
}
