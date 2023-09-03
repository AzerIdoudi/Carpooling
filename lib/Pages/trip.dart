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

class trip extends StatefulWidget {
  const trip({super.key});

  @override
  State<trip> createState() => tripState();
}

TextEditingController destination = TextEditingController();
TextEditingController driver = TextEditingController();
TextEditingController car = TextEditingController();
String textHolder = '';

class tripState extends State<trip> {
  void sendRequest() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/trip/request'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'destination': destination.text,
        'driver': driver.text,
        'car': car.text,
        'dateTime':
            '${dateTime.year}/${dateTime.month}/${dateTime.day}    ${dateTime.hour} : ${dateTime.minute}',
        'token': token
      }),
    );

    if (destination.text.isEmpty || driver.text.isEmpty || car.text.isEmpty) {
      setState(() {
        textHolder = 'enter valid informations';
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(textHolder),
              content: Image.asset(
                "assets/icons/fail.gif",
                width: 200,
                height: 200,
              ),
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              elevation: 0,
              titleTextStyle: TextStyle(color: Colors.cyan, fontSize: 17),
            );
          });
    } else {
      if (response.statusCode == 200) {
        setState(() {
          textHolder = 'Request sent succesfully';
        });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Image.asset(
                  "assets/icons/done.gif",
                  width: 200,
                  height: 200,
                ),
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                elevation: 0,
                titleTextStyle: TextStyle(color: Colors.cyan, fontSize: 17),
              );
            });
      } else {
        String error = response.body;
        setState(() {
          textHolder = error;
        });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(textHolder),
                content: Image.asset(
                  "assets/icons/fail.gif",
                  width: 200,
                  height: 200,
                ),
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                elevation: 0,
                titleTextStyle: TextStyle(color: Colors.cyan, fontSize: 17),
              );
            });
      }
    }
    ;
  }

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
            height: MediaQuery.of(context).size.height / 2.1,
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
          Container(
            padding: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height / 2.15,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromARGB(255, 114, 191, 255),
            ),
            margin: EdgeInsets.all(10),
            child: Column(children: [
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: destination,
                  decoration: InputDecoration(
                    hintText: 'Where to?',
                    hintStyle: TextStyle(
                        fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                    prefixIcon: Icon(Icons.location_on_outlined),
                    prefixIconColor: Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        width: 1.5,
                        color: Color.fromARGB(255, 255, 165, 92),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                    controller: driver,
                    decoration: InputDecoration(
                      hintText: "Driver's email adress",
                      hintStyle: TextStyle(
                          fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                      prefixIcon: Icon(Icons.mail),
                      prefixIconColor: Color.fromARGB(255, 255, 255, 255),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.5,
                            color: Color.fromARGB(
                                255, 255, 255, 255)), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
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
                  controller: car,
                  decoration: InputDecoration(
                    hintText: 'CAR',
                    hintStyle: TextStyle(
                        fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                    prefixIcon: Icon(Icons.car_rental),
                    prefixIconColor: Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        width: 1.5,
                        color: Color.fromARGB(255, 255, 165, 92),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    print(value);
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    pickDateTime();
                    ;
                  },
                  child: Text(
                    '${dateTime.year}/${dateTime.month}/${dateTime.day}    ${dateTime.hour} : ${dateTime.minute}',
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                      top: 2,
                      bottom: 2,
                      right: 20,
                      left: 20,
                    ),
                    primary: Color.fromARGB(255, 0, 140, 255),
                    onPrimary: Colors.white,
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway'),
                    elevation: 0,
                  )),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        sendRequest();
                      },
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
                        primary: Color.fromARGB(255, 0, 140, 255),
                        onPrimary: Colors.white,
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'),
                        elevation: 3,
                      )),
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
                        print(dateTime.toString());
                      },
                      child: Text(
                        'Refresh location',
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
                ],
              ),
            ]),
          ),
        ]),
        padding: EdgeInsets.only(bottom: 80),
      ),
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;
    TimeOfDay? time = await pickTime();
    if (time == null) return;
    final newDateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      this.dateTime = newDateTime;
    });
  }

  Future<TimeOfDay?> pickTime() =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());
  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100));
}
