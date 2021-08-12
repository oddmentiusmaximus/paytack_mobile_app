import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'dio_helper.dart';

@injectable
class NetworkProvider {
  final DioHelper _dioHelper;

  NetworkProvider(this._dioHelper);

  //POST API CALLING

  void postMethod(
      {String? baseUrl,
      Map<String, dynamic>? parameter,
      @required HttpSuccessCallback? success,
      @required HttpFailureCallback? error}) {
    _dioHelper.request(
        baseUrl: baseUrl!,
        parameter: parameter,
        method: Method.POST,
        success: success,
        error: error);
  }

  //GET API CALLING
  void  getMethod(
      {String? baseUrl,
      Map<String, dynamic>? parameter,
      @required HttpSuccessCallback? success,
      @required HttpFailureCallback? error}) {
    _dioHelper.request(
        baseUrl: baseUrl!,
        parameter: parameter,
        method: Method.GET,
        success: success,
        error: error);
  }

  //IMAGE UPLOAD
  void imageUpload(
      {@required String? baseUrl,
      @required FormData? formData,
      @required HttpSuccessCallback? success,
      @required HttpFailureCallback? error}) {
    // just like JS
    _dioHelper.request(
        baseUrl: baseUrl!,
        data: formData,
        method: Method.POST,
        success: success,
        error: error);
  }
}
