import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/mytext.dart';

import '../logic.dart';
import '../state.dart';

class HistoryScreenPage extends StatelessWidget {
  final HistoryScreenLogic logic = Get.put(HistoryScreenLogic());
  // final HistoryScreenState state = Get
  //     .find<HistoryScreenLogic>()
  //     .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 2.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TView(
                    title: "Activities",
                    size: 24.0,
                    weight: FontWeight.bold,
                    align: TextAlign.start,
                    isMaxLines: false,
                    isOverflow: false,
                    color: pTextColor,
                  ),
                  Obx(() {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () => logic.changePage(true, false, false),
                            child: Visibility(
                              visible: logic.isCheckIn.isTrue,
                              replacement: ListTile(
                                subtitle: Divider(
                                  thickness: 5,
                                  color: Colors.transparent,
                                  endIndent: 90,
                                  height: 0,
                                ),
                                contentPadding: EdgeInsets.zero,
                                title: TView(
                                  title: "Check-ins",
                                  size: 14.0,
                                  align: TextAlign.start,
                                  isMaxLines: false,
                                  isOverflow: false,
                                  color: pDisableColor,
                                ),
                              ),
                              child: ListTile(
                                subtitle: Divider(
                                  thickness: 5,
                                  color: pPrimaryColor,
                                  endIndent: 90,
                                  height: 0,
                                ),
                                contentPadding: EdgeInsets.zero,
                                title: TView(
                                  title: "Check-ins",
                                  size: 16.0,
                                  weight: FontWeight.bold,
                                  align: TextAlign.start,
                                  isMaxLines: false,
                                  isOverflow: false,
                                  color: pTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () => logic.changePage(false, true, false),
                            child: Visibility(
                              visible: logic.isBankTransferIn.isTrue,
                              replacement: ListTile(
                                subtitle: Divider(
                                  thickness: 5,
                                  color: Colors.transparent,
                                  endIndent: 90,
                                  height: 0,
                                ),
                                contentPadding: EdgeInsets.zero,
                                title: TView(
                                  title: "Bank Transfer",
                                  size: 14.0,
                                  align: TextAlign.start,
                                  isMaxLines: false,
                                  isOverflow: false,
                                  color: pDisableColor,
                                ),
                              ),
                              child: ListTile(
                                subtitle: Divider(
                                  thickness: 5,
                                  color: pPrimaryColor,
                                  endIndent: 90,
                                  height: 0,
                                ),
                                contentPadding: EdgeInsets.zero,
                                title: TView(
                                  title: "Bank Transfer",
                                  size: 16.0,
                                  weight: FontWeight.bold,
                                  align: TextAlign.start,
                                  isMaxLines: false,
                                  isOverflow: false,
                                  color: pTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () => logic.changePage(false, false, true),
                            child: Visibility(
                              visible: logic.isRedeem.isTrue,
                              replacement: ListTile(
                                subtitle: Divider(
                                  thickness: 5,
                                  color: Colors.transparent,
                                  endIndent: 90,
                                  height: 0,
                                ),
                                contentPadding: EdgeInsets.zero,
                                title: TView(
                                  title: "Redeem",
                                  size: 14.0,
                                  weight: FontWeight.normal,
                                  align: TextAlign.start,
                                  isMaxLines: false,
                                  isOverflow: false,
                                  color: pDisableColor,
                                ),
                              ),
                              child: ListTile(
                                subtitle: Divider(
                                  thickness: 5,
                                  color: pPrimaryColor,
                                  endIndent: 90,
                                  height: 0,
                                ),
                                contentPadding: EdgeInsets.zero,
                                title: TView(
                                  title: "Redeem",
                                  size: 16.0,
                                  weight: FontWeight.bold,
                                  align: TextAlign.start,
                                  isMaxLines: false,
                                  isOverflow: false,
                                  color: pTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  })
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  width: 60,
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.centerLeft,
                  child: TView(
                    title: 'TODAY',
                    color: pTextColor3,
                    size: 11,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)), // radius of 10
                      color: pBubbleColor // green as background color
                  )),
            ),
            pVerticalSpace(height: 25.0),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: logic.isBankTransferIn.isTrue ? 3 : logic.isRedeem
                      .isTrue ? 5 : 15,
                  itemBuilder: (BuildContext context, int index) {
                    return listTileActivities();
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  final List<String> imageList = [
    "https://wallpapercave.com/wp/wp2253979.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  ];

  Widget listTileActivities() {
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
                  "https://i.etsystatic.com/23304690/r/il/77fca0/2328867732/il_fullxfull.2328867732_tunp.jpg"),
            ),
          ),
          title: TView(
            title: 'Pizza Hut',
            size: 15,
            weight: FontWeight.bold,
            color: pTextColor,
            align: TextAlign.start,
          ),
          subtitle: TView(title: '21 Sept at 20:30',
            size: 12,
            color: pTextColor3,
            align: TextAlign.start,),
          trailing: TView(
            title: '40 kr',
            size: 14,
            color: pTextColor,
          ),

        ),
        Divider(height: 1, thickness: 1,)
      ],
    );
  }
}
