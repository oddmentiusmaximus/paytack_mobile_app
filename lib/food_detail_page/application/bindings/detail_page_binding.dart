import 'package:get/get.dart';
import 'package:paytack/common_function/network/dio_helper.dart';
import 'package:paytack/common_function/network/network_class.dart';
import 'package:paytack/food_detail_page/application/controllers/detail_page_controller.dart';

class DetailPageBinding implements Bindings {
  @override
  void dependencies() {
    final apiBaseHelper = DioHelper();
    Get.lazyPut(() => NetworkProvider(apiBaseHelper));
    Get.lazyPut<DetailPageController>(() => DetailPageController(Get.find()));
    //Get.put<ProfileController>(ProfileController(Get.find()));

  }
}
