import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/common_dialog.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/utils/permission.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/home/application/controllers/dashboard_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapsClonePage extends StatefulWidget {
  @override
  _GoogleMapsClonePageState createState() => _GoogleMapsClonePageState();
}

class _GoogleMapsClonePageState extends State<GoogleMapsClonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            CustomGoogleMap(),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: CustomHeader(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Google Map in the background
class CustomGoogleMap extends StatefulWidget {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  _CustomGoogleMapState createState() => _CustomGoogleMapState();
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

Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
    String path, int width) async {
  final Uint8List imageData = await getBytesFromAsset(path, width);
  return BitmapDescriptor.fromBytes(imageData);
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  Completer<GoogleMapController> _controller = Completer();
  Iterable markers = [];

  Iterable _markers = Iterable.generate(list.length, (index) {
    return Marker(
        markerId: MarkerId(list[index]['id']),
        // icon: //,
        position: LatLng(
          list[index]['lat'],
          list[index]['lon'],
        ),
        infoWindow: InfoWindow(title: list[index]["title"]));
  });

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      markers = _markers;
    });
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    bool permission = await PermissionHandle().checkPermissionStorage(
        context: context, permissionGroup: Permission.location);
    print("here");
    print(permission);
    if (permission == true) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      Get.find<DashBoardController>()
          .getDiscover(position.latitude, position.longitude);
      //  Get.find<DashBoardController>().getCategories();
    } else {
      Get.find<DashBoardController>().updateLoader(true);
      showCommonWithWidget(
          locationPopup: true,
          barrierDismissible: false,
          imageTrue: false,
          context: context,
          title: "Location disabled",
          message:
              'Please enable location services to find \nbest offers nearest to you',
          widget: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                CustomButton(
                    color: pPrimaryColor,
                    isEnabled: true,
                    tvSize: 16.0,
                    width: 150,
                    tvColor: Colors.white,
                    height: 45.0,
                    radius: 12.0,
                    btnTitle: "Enable location",
                    onPress: () async {
                      await openAppSettings();
                      //PermissionHandle().permission();
                    }),
                pVerticalSpace(height: 15.0),
                InkWell(
                  onTap: () {
                    Get.find<DashBoardController>().updateLoader(true);
                    Get.back();
                  },
                  child: TView(
                    title: "Not now",
                    color: pPrimaryColor,
                    size: 14.0,
                  ),
                )
              ],
            ),
          ));
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      child: GetBuilder<DashBoardController>(
        builder: (dashboardController) {
          return Container(
            child: Stack(
              children: <Widget>[
                Center(
                  child: dashboardController.loaderMap == false
                      ? SpinKitRipple(
                          color: pPrimaryColor,
                          borderWidth: 7.0,
                        )
                      : GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(
                                double.tryParse(dashboardController
                                            .listDiscover[0].latitude ??
                                        '0.0') ??
                                    0.0,
                                double.tryParse(dashboardController
                                            .listDiscover[0].longitude ??
                                        '0.0') ??
                                    0.0,
                              ),
                              zoom: 13),
                          markers: Set.from(dashboardController.markers),
                        ),

                  // ),
                ),
                DraggableScrollableSheet(
                  initialChildSize:
                      dashboardController.listNearByBusiness.isNotEmpty
                          ? 0.60
                          : 0.30,
                  // minChildSize: .10,
                  minChildSize:
                      dashboardController.listNearByBusiness.isNotEmpty
                          ? 0.60
                          : 0.30,
                  expand: true,
                  maxChildSize: 0.60,

                  // initialChildSize: .30,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: scrollController,
                      child: CustomScrollViewContent(
                        dashboardController: dashboardController,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Search text field plus the horizontally scrolling categories below the text field
class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 8),
          //adjust "40" according to the status bar size
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: <Widget>[
                pHorizontalSpace(width: 10.0),
                Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                ),
                CustomTextField(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 5, right: 15, top: 15, bottom: 15),
          hintText: "Search venues..",
          hintStyle: GoogleFonts.lato(
            color: pBottomNav,
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

/// Content of the DraggableBottomSheet's child SingleChildScrollView
class CustomScrollViewContent extends StatelessWidget {
  final DashBoardController dashboardController;

  const CustomScrollViewContent({Key? key, required this.dashboardController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.0), topLeft: Radius.circular(12.0))),
      margin: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: CustomInnerContent(
          dashboardController: dashboardController,
        ),
      ),
    );
  }
}

class CustomInnerContent extends StatelessWidget {
  final DashBoardController dashboardController;

  const CustomInnerContent({Key? key, required this.dashboardController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        pVerticalSpace(height: 8.0),
        Container(
          height: 4,
          width: 45,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
        ),
        pVerticalSpace(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TView(
              title: "Categories",
              color: pTextColor,
              weight: FontWeight.bold,
              size: 18.0,
            ),
          ),
        ),
        pVerticalSpace(height: 24.0),
        GetBuilder<DashBoardController>(builder: (dashboardController) {
          return Container(
              child: dashboardController.loaderMap == false
                  ? SpinKitRipple(
                      color: pPrimaryColor,
                      borderWidth: 7.0,
                    )
                  : dashboardController.listCategories.isEmpty
                      ? Opacity(opacity: 0.0)
                      : Container(
                          height: 136.0,
                          child: new ListView.builder(
                            padding: EdgeInsets.only(left: 16.0, right: 16.0),
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                dashboardController.listCategories.length,
                            itemBuilder: (i, con) {
                              return Card(
                                child: Column(
                                  children: [
                                    Container(
                                        height: 95.0,
                                        width: 110.0,
                                        decoration: new BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                dashboardController
                                                    .listCategories[con]
                                                    .businessName!),
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                          ),
                                        )),
                                    pVerticalSpace(height: 8.0),
                                    Expanded(
                                      child: TView(
                                        title: dashboardController
                                                .listCategories[con].category ??
                                            "",
                                        size: 14,
                                        color: pTextColor,
                                      ),
                                    ),
                                    pVerticalSpace(height: 4.0)
                                  ],
                                ),
                              );
                            },
                          )));
        }),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TView(
                title: "Nearby",
                color: pTextColors,
                size: 16.0,
                weight: FontWeight.bold,
              ),
              Spacer(),
              InkWell(
                onTap: () {},
                child: TView(
                  title: "VIEW ALL",
                  color: pProgress,
                  size: 13.0,
                  weight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        dashboardController.loader == false
            ? SpinKitRipple(
                color: pPrimaryColor,
                borderWidth: 7.0,
              )
            : dashboardController.listNearByBusiness.isEmpty
                ? Opacity(opacity: 0.0)
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      backgroundImage: dashboardController
                                                      .listNearByBusiness[0]
                                                      .logoUrl ==
                                                  null ||
                                              dashboardController
                                                  .listNearByBusiness[0]
                                                  .logoUrl!
                                                  .isEmpty ||
                                              dashboardController
                                                      .listNearByBusiness[0]
                                                      .logoUrl ==
                                                  "string"
                                          ? NetworkImage(noImage)
                                          : NetworkImage(dashboardController
                                              .listNearByBusiness[0].logoUrl!)),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, bottom: 4.0),
                                      child: TView(
                                        title: dashboardController
                                                .listNearByBusiness[0]
                                                .businessName ??
                                            "",
                                        size: 14.5,
                                        color: Colors.grey.shade800,
                                        // style: TextStyle(fontSize: 14.5),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 4.0),
                                          child: Icon(
                                            Icons.restaurant,
                                            color: Colors.grey.shade600,
                                            size: 11,
                                          ),
                                        ),
                                        ConstrainedBox(
                                          constraints:
                                              BoxConstraints(maxWidth: 70),
                                          child: Text(
                                            dashboardController
                                                    .listNearByBusiness[0]
                                                    .category ??
                                                "",
                                            style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 12.0),
                                            maxLines: 1,
                                            softWrap: true,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6.0, right: 6.0),
                                          child: Center(
                                              child: Icon(
                                            Icons.circle,
                                            color: Colors.grey.shade600,
                                            size: 5,
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0, right: 4.0),
                                          child: Icon(
                                            Icons.location_on,
                                            color: Colors.grey.shade600,
                                            size: 11,
                                          ),
                                        ),
                                        TView(
                                          title: dashboardController
                                                  .listNearByBusiness[0]
                                                  .distance!
                                                  .toStringAsFixed(2) +
                                              " Km",

                                          color: Colors.grey.shade500,
                                          size: 12.0,

                                          // style: TextStyle(
                                          //     color: Colors.grey.shade500,
                                          //     fontSize: 12.0),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, right: 4.0),
                                    child: Image.asset(
                                      flash,
                                      height: 15,
                                      width: 15,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // TView(
                                      //   title: cashback +
                                      //       " Extra Cashback",
                                      //   size: 14.0,
                                      //   color: pHomePageTextColor,
                                      // )

                                      TView(
                                        title: dashboardController
                                                .listNearByBusiness[0]
                                                .discountPercenatage ??
                                            "0" + "% Extra Cashback",
                                        // style: TextStyle(
                                        //     color: Colors.black,
                                        //     fontWeight: FontWeight.bold,
                                        //     fontSize: 16)

                                        color: Colors.black,
                                        size: 16.0,
                                        weight: FontWeight.bold,
                                      ),
                                      pVerticalSpace(height: 2.0),
                                      TView(
                                        title: "No minimum purchase",
                                        // style: TextStyle(
                                        //     color: Colors.black,
                                        //     fontWeight: FontWeight.bold,
                                        //     fontSize: 16)

                                        color: Colors.grey,
                                        size: 12.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 90.0,
                          width: 110.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              noImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
      ],
    );

    // showModalBottomSheet(
    //     context: context,
    //     builder: (context) {
    //       return Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: <Widget>[
    //           ListTile(
    //             leading: new Icon(Icons.photo),
    //             title: new Text('Photo'),
    //             onTap: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //           ListTile(
    //             leading: new Icon(Icons.music_note),
    //             title: new Text('Music'),
    //             onTap: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //           ListTile(
    //             leading: new Icon(Icons.videocam),
    //             title: new Text('Video'),
    //             onTap: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //           ListTile(
    //             leading: new Icon(Icons.share),
    //             title: new Text('Share'),
    //             onTap: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //         ],
    //       );
    //     });
  }
}
