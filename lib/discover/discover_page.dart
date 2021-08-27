import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/mytext.dart';

class GoogleMapsClonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomGoogleMap(),
          CustomHeader(),
          DraggableScrollableSheet(
            minChildSize: .10,
            initialChildSize: .30,
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

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  Completer<GoogleMapController> _controller = Completer();

  Iterable markers = [];

  Iterable _markers = Iterable.generate(list.length, (index) {
    return Marker(
        markerId: MarkerId(list[index]['id']),
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      child: Center(
          child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(23.7985053, 90.3842538), zoom: 13),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(markers),
      )),
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
      ],
    );
  }
}
