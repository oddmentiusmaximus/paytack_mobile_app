import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/network/api_helper.dart';
import 'package:paytack/common_function/network/network_class.dart';

class SignupController extends GetxController {
  String? errorMsg;
  Map<String, dynamic>? loginSuccessResponse;

  SignupController(this._networkRepository);

  final NetworkProvider _networkRepository;

  ///SignUp Screen
  TextEditingController? signUpName ;
  TextEditingController? signUpEmail ;
  TextEditingController? signUpReferralCode ;



  Future<void> getSignIn() async {
    Map<String, dynamic> params = {
      "email": "s@gmail.com",
      "password": "1234",
      "confirmPassword": "1234",
      "clientName": "Dipak",
      "countryCode": "+91",
      "phoneNumber": "82392929",
      "gender": "Male",
      "dateOfBirth": "2021-08-11T16:43:15.938Z",
      "anniversaryDate": "2021-08-11T16:43:15.938Z",
      "referralCode": ""
    };
    _networkRepository.postMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.register,
        parameter: params,
        success: (success) {
          print(success.toString());
        },
        error: (error) {});
  }

  Future<void> checkEmail(String email) async {
    _networkRepository.getMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.emailExist + "?email={$email}",
        success: (success) {
          print(success.toString());
        },
        error: (error) {});
  }

  ///optional Details Screen
  String birthdayDate = 'Birthday';
  String anniversaryDate = 'Anniversary';

  updateDate(bool birthdateUpdate, String _selectedDate) {
    if (birthdateUpdate == true) {
      birthdayDate = _selectedDate;
    } else {
      anniversaryDate = _selectedDate;
    }
    update();
  }
}
