import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carpooling/Pages/carList.dart';

import 'driverCars.dart';

class driversList extends StatefulWidget {
  const driversList({super.key});

  @override
  State<driversList> createState() => _driversListState();
}

String driveremail = '';

class Driver {
  final String fullName;
  final String city;
  final String status;
  final String email;

  Driver(
      {required this.fullName,
      required this.email,
      required this.city,
      required this.status});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      fullName: json['fullName'],
      email: json['email'],
      city: json['city'],
      status: json['status'],
    );
  }
}

class _driversListState extends State<driversList> {
  @override
  List<Driver> Drivers = [];
  Future getDrivers() async {
    Drivers.clear();
    final url = Uri.parse('http://10.0.2.2:3000/home/drivers');
    final response = await http.get(url);
    final jsonData = await jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in jsonData) {
        setState(() {
          Driver driver = Driver.fromJson(item);
          Drivers.add(driver);
        });
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: RefreshIndicator(
            onRefresh: getDrivers,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 50, bottom: 85),
              itemCount: Drivers.length,
              itemBuilder: (context, index) {
                if (Drivers[index].status == 'Driver') {
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
                                ("assets/images/driver.png"),
                                height: 100,
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
                                      Drivers[index].fullName,
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Container(height: 5),
                                    Text(
                                      Drivers[index].city,
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(height: 10),
                                    Text(Drivers[index].email),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        driveremail = Drivers[index].email;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => driverCars(),
                                          ),
                                        );
                                      },
                                      child: Icon(Icons.car_rental_sharp,
                                          color: const Color.fromARGB(
                                              255, 0, 140, 255))),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: Icon(
                                        Icons.mail,
                                        color: const Color.fromARGB(
                                            255, 0, 140, 255),
                                      )),
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
            )));
  }

  void initState() {
    super.initState();
    getDrivers();
  }
}
