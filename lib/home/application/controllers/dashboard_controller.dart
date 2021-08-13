import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/common_dialog.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/network/api_helper.dart';
import 'package:paytack/common_function/network/network_class.dart';
import 'package:dio/dio.dart' as dio;
import 'package:paytack/common_function/secure_storage.dart';
import 'package:paytack/common_function/utils/camera_utils.dart';
import 'package:paytack/common_function/utils/loading_class.dart';
import 'package:paytack/common_function/widget/button.dart';

class DashBoardController extends GetxController {
  String? errorMsg;
  Map<String, dynamic>? loginSuccessResponse;
  int pendingCashback = 0;
  int availableCashback = 0;

  //var photoBill;

  DashBoardController(this._networkRepository);

  final NetworkProvider _networkRepository;

  @override
  void onInit() {
    getCashBackData();
    super.onInit();
  }

  Future<void> getCashBackData() async {
    _networkRepository.getMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.getCashBack,
        success: (success) {
          print(success.toString());
          if (success.toString().isNotEmpty) {
            pendingCashback = success['pendingCashback'];
            availableCashback = success['availableCashback'];
          }
          update();
        },
        error: (error) {});
  }

  Future<dio.Response> sendForm(String url, Map<String, File> files) async {
    Map<String, dio.MultipartFile> fileMap = {};
    Map<String, dynamic> data = {};
    for (MapEntry fileEntry in files.entries) {
      File file = fileEntry.value;
      String fileName = basename(file.path);
      fileMap[fileEntry.key] = dio.MultipartFile(
          file.openRead(), await file.length(),
          filename: fileName);
    }
    data.addAll(fileMap);
    var formData = dio.FormData.fromMap(data);
    final token = await CommonStorage.readSecureStorageData("access_token");
    Dio dios = new Dio();
    return await dios.post(url,
        data: formData,
        options: Options(
            headers: {'Authorization': 'Bearer $token'},
            contentType: 'multipart/form-data'));
  }

  void uploadBill(var photoBill, BuildContext context) async {
    Loading.show(context: context);
    File _image = File(photoBill.path);
    var res1 = await sendForm(
        ApiHelpers.baseUrl + ApiHelpers.uploadBill, {'file': _image});
    if (res1.statusCode == 200) {
      Navigator.pop(context);
    } else {
      Get.back();
      showToast(msg: 'Error For Uploading');
    }
  }

  double getImageSize(String path) {
    var file = File(path);
    print(file.lengthSync());
    final bytes = file.lengthSync();
    final kb = bytes / 1024;
    final mb = kb / 1024;

    return mb;
  }
}
