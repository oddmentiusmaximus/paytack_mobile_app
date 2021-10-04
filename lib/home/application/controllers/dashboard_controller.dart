import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paytack/common_function/utils/permission.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';
import 'package:paytack/discover/categories_model.dart';
import 'package:paytack/home/domain/near_by_model.dart';
import 'package:permission_handler/permission_handler.dart';

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
  String? userName = "";
  String? userEmail = '';
  List<NearByModel> listNearByBusiness = [];
  List<LatLng> latLong = [];
  int pageNoSlider = 0;

  //
  Iterable markers = [];
  List<NearByModel> listDiscover = [];

  //
  void updateSlideDot(int index) {
    pageNoSlider = index;
    update();
  }

  List<CategoriesModel> listCategories = [
    CategoriesModel(
        businessName:
            "https://thumbor.thedailymeal.com/O5BS3X-3J3JKcsTKYdYd996xqsI=/870x565/https://www.thedailymeal.com/sites/default/files/slideshows/1943277/2108053/0.jpg",
        category: "Restaurant"),
    CategoriesModel(
        businessName:
            "https://cdn.pixabay.com/photo/2015/10/12/14/54/coffee-983955__480.jpg",
        category: "Coffee Shop"),
    CategoriesModel(
        businessName:
            "https://i1.wp.com/cdn.whatsuplife.in/delhi/blog/2017/08/turquoise-colltage.png",
        category: "Bar"),
    CategoriesModel(
        businessName:
            "https://img.freepik.com/free-photo/hairdresser-does-hairstyle-her-client_1157-27203.jpg?size=626&ext=jpg",
        category: "Hairdresser"),
    CategoriesModel(businessName: noImage, category: "Grocery"),
    CategoriesModel(businessName: noImage, category: "Florist"),
    CategoriesModel(businessName: noImage, category: "Books,magazines etc"),
    CategoriesModel(
        businessName: noImage, category: "Bicycles and Electric Bike"),
    CategoriesModel(businessName: noImage, category: "Betting And games"),
    CategoriesModel(businessName: noImage, category: "Florist"),
  ];

  TextEditingController? redeemController;
  bool loader = false;
  bool loaderMap = false;

  // BitmapDescriptor mapMarker;

  DashBoardController(this._networkRepository);

  final NetworkProvider _networkRepository;

  @override
  void onInit() {
    getCashBackData();
    getUserData();
    super.onInit();
  }

  updateLoader(bool val) {
    loader = val;
    update();
  }

  updateNearBy(bool val) {
    loaderMap = val;
    update();
  }

  Future<void> getUserData() async {
    _networkRepository.getMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.userDetails,
        success: (success) {
          print(success.toString());
          if (success.toString().isNotEmpty) {
            userName = success['clientName'];
            userEmail = success['email'];
          }
          update();
        },
        error: (error) {});
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
      Get.back();
      Get.back();
      showCommonWithWidget(
        barrierDismissible: false,
        context: context,
        title: "",
        image: success_tick,
        message:
            'We just need to verify your purchase so we\n can add the cashback you deserve',
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
              }),
        ),
      );
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

  Future scan(BuildContext context) async {
    bool permission = await PermissionHandle().checkPermissionStorage(
        context: context, permissionGroup: Permission.storage);
    if (permission == true) {
      try {
        var result = await BarcodeScanner.scan();
        /*if (result.rawContent.isNotEmpty) {*/
        showCommonWithWidget(
          barrierDismissible: false,
          context: context,
          title: "Enter amount to redeem",
          //  image: success_tick,
          message: '',
          imageTrue: false,
          widget: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TInput(
                    controller: redeemController,
                    hintText: "0 kr.",
                    maxLines: 1,
                    type: 'B1',
                    isEdit: false,
                    isError: false,
                    isInput: true,
                    keyboardType: TextInputType.number,
                    onChange: (val) {
                      if (val.toString() == 'null' || val.isEmpty) {}
                    }),
                pVerticalSpace(height: 15.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TView(
                    title: "Available balance $availableCashback" + " Kr.",
                    size: 14.0,
                    color: pTextColor,
                  ),
                ),
                pVerticalSpace(height: 15.0),
                CustomButton(
                    color: pPrimaryColor,
                    isEnabled: true,
                    tvSize: 16.0,
                    width: 100,
                    tvColor: Colors.white,
                    height: 45.0,
                    radius: 12.0,
                    btnTitle: "Confirm",
                    onPress: () {
                      Get.back();
                    }),
              ],
            ),
          ),
        );
        /*}*/
      } on PlatformException catch (e) {
        if (e.code == BarcodeScanner.cameraAccessDenied) {
        } else {}
      } on FormatException {} catch (e) {}
    } else {
      ///show message
    }
  }

  Future<void> getNearBy(double lat, double long) async {
    loader = false;
    _networkRepository.getMethod(
        baseUrl: ApiHelpers.baseUrl +
            ApiHelpers.getNearBy +
            "?latitude=${lat.toStringAsFixed(4)}&longitude=${long.toStringAsFixed(4)}&isRequiredAllBussiness=${false}",
        success: (success) {
          if (success.toString().isNotEmpty) {
            List<NearByModel> list = List<NearByModel>.from(
                success.map((i) => NearByModel.fromJson(i)));
            listNearByBusiness = list;
            updateLoader(true);
          }
          update();
        },
        error: (error) {
          updateLoader(true);
          //loader = false;
          //update();
          print(error);
        });
  }

  void getDiscover(double lat, double long) {
    loaderMap = false;
    _networkRepository.getMethod(
        baseUrl: ApiHelpers.baseUrl +
            ApiHelpers.getNearBy +
            "?latitude=${lat.toStringAsFixed(4)}&longitude=${long.toStringAsFixed(4)}&isRequiredAllBussiness=${true}",
        success: (success) async {
          if (success.toString().isNotEmpty) {
            List<NearByModel> list = List<NearByModel>.from(
                success.map((i) => NearByModel.fromJson(i)));
            listDiscover = list;
            BitmapDescriptor customIcons =
                await BitmapDescriptor.fromAssetImage(
                    ImageConfiguration(size: Size(20.0, 20.0)), green_dot);
            final Uint8List markerIcon = await getBytesFromAsset(green_dot, 60);
            markers = Iterable.generate(list.length, (index) {
              return Marker(
                  markerId: MarkerId(list[index].businessName ?? ''),
                  icon: BitmapDescriptor.fromBytes(markerIcon),
                  position: LatLng(
                    double.tryParse(list[index].latitude ?? '0.0') ?? 0.0,
                    double.tryParse(list[index].longitude ?? '0.0') ?? 0.0,
                  ),
                  infoWindow: InfoWindow(title: list[index].businessName));
            });
            updateNearBy(true);
          }
          update();
        },
        error: (error) {
          updateNearBy(true);
          print(error);
        });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // /api/clients/categories
  void getCategories() {
    loaderMap = false;
    _networkRepository.getMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.getCategories,
        success: (success) async {
          if (success.toString().isNotEmpty) {
            List<CategoriesModel> list = List<CategoriesModel>.from(
                success.map((i) => CategoriesModel.fromJson(i)));
            listCategories = list;
            updateNearBy(true);
          }
          update();
        },
        error: (error) {
          updateNearBy(true);
          print(error);
        });
  }
}
