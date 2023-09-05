import 'package:carpooling/Pages/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class dtrips extends StatefulWidget {
  const dtrips({super.key});

  @override
  State<dtrips> createState() => _dtripsState();
}

String selectedTripDate = "";
String selectedTripDestination = "";

class Trip {
  final String destination;
  final String driver;
  final String car;
  final String dateTime;
  final String passenger;
  final String status;

  Trip(
      {required this.destination,
      required this.driver,
      required this.car,
      required this.dateTime,
      required this.passenger,
      required this.status});

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      destination: json['destination'],
      driver: json['driver'],
      car: json['car'],
      dateTime: json['dateTime'],
      passenger: json['passenger'],
      status: json['status'],
    );
  }
}

class _dtripsState extends State<dtrips> {
  @override
  List<Trip> Trips = [];
  Future getTrips() async {
    Trips.clear();
    final url = Uri.parse('http://10.0.2.2:3000/trip/ptrip');
    final response = await http.get(url);
    final jsonData = await jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in jsonData) {
        setState(() {
          Trip trip = Trip.fromJson(item);
          Trips.add(trip);
        });
      }
    }
  }

  void deleteTrip() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/trip/deleteTrip'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'selDest': selectedTripDestination,
        'selDate': selectedTripDate
      }),
    );
  }

  void acceptTrip() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/trip/acceptTrip'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'selDest': selectedTripDestination,
        'selDate': selectedTripDate
      }),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip List'),
        shadowColor: Theme.of(context).colorScheme.shadow,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: RefreshIndicator(
          onRefresh: getTrips,
          child: ListView.builder(
            padding: EdgeInsets.only(top: 50, bottom: 85),
            itemCount: Trips.length,
            itemBuilder: (context, index) {
              if (Trips[index].driver == userEmail) {
                return Card(
                  color: Color.fromARGB(255, 158, 212, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              ("assets/images/Vector-Trip-PNG.png"),
                              height: 150,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            Container(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(height: 5),
                                  Text(
                                    Trips[index].destination,
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                  Container(height: 5),
                                  Text(
                                    Trips[index].passenger,
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(height: 5),
                                  Text(Trips[index].car),
                                  Container(height: 5),
                                  Text(
                                    Trips[index].dateTime,
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(height: 5),
                                  Text(
                                    Trips[index].status,
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      selectedTripDate = Trips[index].dateTime;
                                      selectedTripDestination =
                                          Trips[index].destination;
                                      deleteTrip();
                                      getTrips();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Trip Deleted'),
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 89, 89),
                                      ));
                                    },
                                    child: Icon(Icons.delete,
                                        color:
                                            Color.fromARGB(255, 255, 64, 64))),
                                ElevatedButton(
                                    onPressed: () {
                                      selectedTripDate = Trips[index].dateTime;
                                      selectedTripDestination =
                                          Trips[index].destination;
                                      acceptTrip();
                                      getTrips();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Trip Accepted'),
                                        backgroundColor:
                                            Color.fromARGB(255, 33, 201, 0),
                                      ));
                                    },
                                    child: Icon(Icons.done,
                                        color:
                                            Color.fromARGB(255, 33, 201, 0))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          )),
    );
  }

  void initState() {
    super.initState();
    getTrips();
  }
}
