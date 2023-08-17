import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class trip extends StatefulWidget {
  const trip({super.key});

  @override
  State<trip> createState() => tripState();
}

class tripState extends State<trip> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.7,
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
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height / 3.44,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color.fromARGB(255, 114, 191, 255),
            ),
            margin: EdgeInsets.all(10),
            child: Column(children: [
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                    decoration: InputDecoration(
                  hintText: 'Where to?',
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.account_circle),
                  prefixIconColor: const Color.fromARGB(255, 105, 190, 240),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.5, color: Color.fromARGB(255, 255, 255, 255)),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Color.fromARGB(255, 255, 165, 92),
                    ),
                  ),
                )),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                    decoration: InputDecoration(
                  hintText: "Driver's email adress",
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.account_circle),
                  prefixIconColor: const Color.fromARGB(255, 105, 190, 240),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.5,
                        color:
                            Color.fromARGB(255, 255, 255, 255)), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Color.fromARGB(255, 255, 165, 92),
                    ),
                  ),
                )),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Request trip',
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                          right: 20,
                          left: 20,
                        ),
                        primary: Color.fromARGB(255, 17, 168, 255),
                        onPrimary: Colors.white,
                        textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'),
                        elevation: 3,
                      )),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Clear',
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                          right: 50,
                          left: 50,
                        ),
                        primary: Color.fromARGB(255, 255, 165, 92),
                        onPrimary: Colors.white,
                        textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'),
                        elevation: 3,
                      ))
                ],
              ),
            ]),
          ),
        ]),
        padding: EdgeInsets.only(bottom: 80),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
