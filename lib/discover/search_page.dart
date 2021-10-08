import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:get/get.dart';

import 'application/search_controller.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: Get.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: new Container(
                  //modified
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                          child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.1),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          controller: controller.searchText,
                          maxLines: 1,
                          onChanged: (val) {
                            controller.searchData(val);
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 5, right: 15, top: 15, bottom: 15),
                            hintText: "Search venues..",
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey.shade400,
                            ),
                            hintStyle: GoogleFonts.lato(
                              color: pBottomNav,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                      new Container(
                        margin: new EdgeInsets.symmetric(horizontal: 4.0),
                        child: TextButton(
                            onPressed: () {
                              controller.searchText?.clear();
                              Get.back();
                            },
                            child: TView(
                              color: pProgress,
                              size: 14,
                              title: 'Cancel',
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  return Visibility(
                    visible: controller.searchResultList.isNotEmpty &&
                        controller.searchText!.text.isNotEmpty,
                    replacement: Wrap(
                      spacing: 8.0,
                      alignment: WrapAlignment.spaceEvenly,
                      runAlignment: WrapAlignment.start,
                      children: [
                        ...controller.chipList.map(
                          (element) => GestureDetector(
                            onTap: () {
                              controller.searchText!.text = element;
                              controller
                                  .searchData(controller.searchText!.text);
                            },
                            child: Chip(
                              backgroundColor: Color(0xFFF79256),
                              label: TView(
                                color: Colors.white,
                                title: element,
                                size: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: controller.searchResultList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return listTileActivities(index);
                      },
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listTileActivities(int index) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(12.0),
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                  controller.searchResultList[index].logoUrl ?? noImage),
            ),
          ),
          title: TView(
            title: controller.searchResultList[index].businessName ?? '',
            size: 14,
            weight: FontWeight.bold,
            color: pTextColor,
            align: TextAlign.start,
          ),
          subtitle: TView(
            title: controller.searchResultList[index].address ?? '',
            size: 12,
            color: pTextColor3,
            align: TextAlign.start,
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
        )
      ],
    );
  }
}
