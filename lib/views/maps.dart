import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;
import 'package:test_app/common/colors.dart';
import 'package:test_app/common/size_config.dart';
import 'package:test_app/common/utils.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Completer<GoogleMapController> _controller = Completer();

  Location location;

  LocationData currentLocation;

  static const double CAMERA_ZOOM = 20;
  static const double CAMERA_TILT = 80;
  static const double CAMERA_BEARING = 30;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final Set<Marker> _markers = Set<Marker>();

  var sourceIcon;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    location = Location();

    location.changeSettings(accuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.04,
                    top: SizeConfig.screenHeight * 0.01,
                    bottom: SizeConfig.screenHeight * 0.01,
                    right: SizeConfig.screenWidth * 0.04),
                child: Row(children: [
                  Card(
                    elevation: 3,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:
                            Icon(Icons.arrow_back, color: Colors.blue.shade900),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.notifications_none_outlined,
                      color: Colors.blue.shade900),
                  SizedBox(
                    width: SizeConfig.screenHeight * 0.01,
                  ),
                  Icon(Icons.settings_outlined, color: Colors.blue.shade900),
                  SizedBox(
                    width: SizeConfig.screenHeight * 0.01,
                  ),
                  SizedBox(
                      height: SizeConfig.screenHeight * 0.06,
                      width: SizeConfig.screenHeight * 0.06,
                      child: Card(
                        shape: const CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        child: CircleAvatar(
                          radius: SizeConfig.screenHeight * 0.06,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: SizeConfig.screenHeight * 0.023,
                            backgroundColor: Colors.grey[300],
                            backgroundImage:
                                const AssetImage('assets/png/user.png'),
                          ),
                        ),
                      )),
                ]),
              ),
              Expanded(
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      margin: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.04,
                          bottom: SizeConfig.screenWidth * 0.04,
                          right: SizeConfig.screenWidth * 0.04),
                      child: Column(
                        children: [
                          Expanded(
                            child: GoogleMap(
                              mapType: MapType.hybrid,
                              myLocationEnabled: true,
                              markers: _markers,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated:
                                  (GoogleMapController controller) async {
                                _controller.complete(controller);

                                sourceIcon =
                                    await BitmapDescriptor.fromAssetImage(
                                        const ImageConfiguration(
                                            devicePixelRatio: 2.5),
                                        'assets/png/marker.png');

                                currentLocation = await location.getLocation();

                                updatePinOnMap();

                                enableChange();
                              },
                            ),
                          )
                        ],
                      )))
            ],
          ),
        ));
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      // tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    if (mounted) {
      setState(() {
        // updated position
        var pinPosition =
            LatLng(currentLocation.latitude, currentLocation.longitude);

        // the trick is to remove the marker (by id)
        // and add it again at the updated location
        _markers.removeWhere((m) => m.markerId.value == 'START');
        _markers.add(Marker(
            markerId: const MarkerId('START'),
            position: pinPosition, // updated position
            icon: sourceIcon));
      });
    }
  }

  enableChange() {
    location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;

      updatePinOnMap();
    });
  }
}
