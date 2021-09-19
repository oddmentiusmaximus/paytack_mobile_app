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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/common_dialog.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/utils/permission.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/home/application/controllers/dashboard_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapsClonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomGoogleMap(),
          CustomHeader(),
          DraggableScrollableSheet(
            initialChildSize: 0.30,
            // minChildSize: .10,
            minChildSize: 0.10,
            maxChildSize: 0.5,
            // initialChildSize: .30,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: CustomScrollViewContent(),
              );
            },
          ),
        ],
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
            child: Center(
              child: dashboardController.loaderMap==false?SpinKitRipple(
                color: pPrimaryColor,
                borderWidth: 7.0,
              ):GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      double.tryParse(
                              dashboardController.listDiscover[0].latitude ??
                                  '0.0') ??
                          0.0,
                      double.tryParse(
                              dashboardController.listDiscover[0].longitude ??
                                  '0.0') ??
                          0.0,
                    ),
                    zoom: 13),
                markers: Set.from(dashboardController.markers),
              ),

              // ),
            ),
          );
        },
      ),
    );
  }

  Future<Set<Marker>> generateMarkers(List<LatLng> positions) async {
    List<Marker> markers = <Marker>[];
    for (final location in positions) {
      final icon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(24, 24)), green_dot);

      final marker = Marker(
        markerId: MarkerId(location.toString()),
        position: LatLng(location.latitude, location.longitude),
        icon: icon,
      );

      markers.add(marker);
    }
    return markers.toSet();
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
                pHorizontalSpace(width: 5.0),
                Icon(
                  Icons.search,
                  color: pTextColors,
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
          contentPadding: const EdgeInsets.all(15),
          hintText: "Search Venues",
          hintStyle: TextStyle(
              color: pTextColors,
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              fontFamily: "Lato"),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

/// Content of the DraggableBottomSheet's child SingleChildScrollView
class CustomScrollViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: CustomInnerContent(),
      ),
    );
  }
}

class CustomInnerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        pVerticalSpace(height: 4.0),
        Container(
          height: 3,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
        ),
        pVerticalSpace(height: 12.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TView(
              title: "Categories",
              color: pTextColor,
              weight: FontWeight.bold,
              size: 16.0,
            ),
          ),
        ),
        SizedBox(height: 2),
        new Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 150.0,
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (i, con) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: new BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(burger_image),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                        Expanded(
                          child: TView(
                            title: "Italian",
                            size: 14,
                            color: pTextColor,
                          ),
                        ),
                        pVerticalSpace(height: 10.0)
                      ],
                    ),
                  ),
                );
              },
            )),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Nearby",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                "View all",
                style: TextStyle(color: pPrimaryColor, fontSize: 13),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            backgroundImage: NetworkImage(
                                'http://assets.stickpng.com/images/5842996fa6515b1e0ad75add.png')),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 4.0),
                            child: Text("Burger King"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 4.0),
                                child: Icon(
                                  Icons.restaurant,
                                  color: Colors.grey.shade600,
                                  size: 13,
                                ),
                              ),
                              Text(
                                "Fastfood",
                                style: TextStyle(color: Colors.grey),
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
                              Text(
                                "3 Km",
                                style: TextStyle(color: Colors.grey),
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
                                    left: 8.0, right: 4.0),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.grey.shade600,
                                  size: 13,
                                ),
                              ),
                              Text(
                                "4.5",
                                style: TextStyle(color: Colors.grey),
                              )
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
                          padding: const EdgeInsets.only(top: 4.0, right: 4.0),
                          child: Icon(
                            Icons.flash_on,
                            color: Colors.orange,
                            size: 19,
                          ),
                        ),
                        Column(
                          children: [
                            Text("5% Extra Cashback",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            Text("No minimum purchase",
                                style: TextStyle(fontSize: 14))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(burger_image),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ))
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
