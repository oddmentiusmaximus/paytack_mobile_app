import 'package:get/get.dart';
import 'package:paytack/permissions_screen/application/controller.dart';

class PermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PermissionsController>(() => PermissionsController());
  }
}