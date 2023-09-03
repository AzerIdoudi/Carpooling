import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'login.dart';

late bool serviceEnabled;
late PermissionStatus permissionGranted;
late double lat;
late double long;
Future<Position> getLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  Position position = await Geolocator.getCurrentPosition();
  print(position);
  return position;
}

StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream().listen((position) {
  lat = position.latitude;
  long = position.longitude;
});

class myPosition extends StatefulWidget {
  const myPosition({super.key});

  @override
  State<myPosition> createState() => myPositionState();
}

TextEditingController destination = TextEditingController();
TextEditingController driver = TextEditingController();
TextEditingController car = TextEditingController();
String textHolder = '';

class myPositionState extends State<myPosition> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static CameraPosition positionScreen = CameraPosition(
    target: LatLng(33.8869, 9.5375),
    zoom: 14.4746,
  );
  final List<Marker> _marker = <Marker>[];
  DateTime dateTime = DateTime(2001, 02, 20, 00, 00);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.25,
            child: GoogleMap(
              cameraTargetBounds: CameraTargetBounds.unbounded,
              tiltGesturesEnabled: true,
              scrollGesturesEnabled: true,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                new Factory<OneSequenceGestureRecognizer>(
                  () => new EagerGestureRecognizer(),
                ),
              ].toSet(),
              zoomGesturesEnabled: true,
              mapType: MapType.normal,
              markers: Set<Marker>.of(_marker),
              initialCameraPosition: positionScreen,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () async {
                getLocation().then((value) async {
                  print(value.latitude.toString() +
                      " " +
                      value.longitude.toString());

                  // marker added for current users location
                  _marker.add(Marker(
                    markerId: MarkerId("1"),
                    position: LatLng(value.latitude, value.longitude),
                    infoWindow: InfoWindow(
                      title: 'My Current Location',
                    ),
                  ));
                  CameraPosition cameraPosition = new CameraPosition(
                    target: LatLng(value.latitude, value.longitude),
                    zoom: 14,
                  );

                  final GoogleMapController controller =
                      await _controller.future;
                  controller.animateCamera(
                      CameraUpdate.newCameraPosition(cameraPosition));
                  setState(() {});
                });
              },
              child: Text(
                'Refresh location',
                style: TextStyle(fontSize: 30),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                  top: 2,
                  bottom: 2,
                  right: 20,
                  left: 20,
                ),
                primary: Color.fromARGB(255, 255, 165, 92),
                onPrimary: Colors.white,
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway'),
                elevation: 3,
              ))
        ]),
        padding: EdgeInsets.only(bottom: 80),
      ),
    );
  }
}
