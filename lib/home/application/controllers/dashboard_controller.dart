import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:paytack/common_function/network/api_helper.dart';
import 'package:paytack/common_function/network/network_class.dart';
import 'package:dio/dio.dart' as dio;

class DashBoardController extends GetxController {
  String? errorMsg;
  Map<String, dynamic>? loginSuccessResponse;
  int pendingCashback = 0;
  int availableCashback = 0;
  var photoBill;

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

  selectPhoto(String filePath) {
    photoBill.value = filePath;
    update();
  }

  Future<void> uploadBill() async {
    final dio.FormData formData = new dio.FormData();
    if (photoBill.value != null)
      formData.files.add(MapEntry(
          "file",
          await dio.MultipartFile.fromFile(File(photoBill.value).path,
              filename: basename(File(photoBill.value).path))));
    _networkRepository.imageUpload(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.uploadBill,
        formData: formData,
        success: (value) {},
        error: (error) {});
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
