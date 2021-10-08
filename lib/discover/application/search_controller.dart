import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:paytack/home/application/controllers/dashboard_controller.dart';
import 'package:paytack/home/domain/near_by_model.dart';

class SearchController extends GetxController {
  RxList chipList = [
    'Thai',
    'Sushi',
    'Pizza',
    'Tortilla',
    'Indian',
    'Italian',
    'Burger',
    'Steak',
    'Kebab',
    'Coffee'
  ].obs;
  RxList<NearByModel> searchResultList = <NearByModel>[].obs;
  List<NearByModel> nearByList = [];
  TextEditingController? searchText;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    searchText = TextEditingController();
    nearByList = Get.find<DashBoardController>().listDiscover;
  }

  Future<void> searchData(String val) async {
    try {
      isLoading.value = true;
      if (val.isEmpty) {
        searchResultList.clear();
        return;
      }
      searchResultList.value = nearByList
          .where((NearByModel entry) =>
              (entry.businessName!.toLowerCase().contains(val.toLowerCase()) ||
                  entry.businessName!.contains(val)))
          .toList();

      // skillListBu.forEach((skill) {
      //   if (skill.skill.toLowerCase().contains(val.toLowerCase())) {
      //     if (!skillListBuSearch.contains(skill.skill))
      //       skillListBuSearch.add(skill);
      //   }
      // });

      isLoading.value = false;
    } catch (e) {}
  }
}
