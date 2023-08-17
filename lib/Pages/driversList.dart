import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class driversList extends StatefulWidget {
  const driversList({super.key});

  @override
  State<driversList> createState() => _driversListState();
}

class Driver {
  final String fullName;
  final String city;
  final String status;

  Driver({required this.fullName, required this.city, required this.status});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      fullName: json['fullName'],
      city: json['city'],
      status: json['status'],
    );
  }
}

List<Driver> Drivers = [];
Future refresh() async {
  Drivers.clear();
  final url = Uri.parse('http://10.0.2.2:3000/home/drivers');
  final response = await http.get(url);
  final jsonData = await jsonDecode(response.body);
  if (response.statusCode == 200) {
    for (var item in jsonData) {
      Driver driver = Driver.fromJson(item);
      Drivers.add(driver);
    }
  }
}

class _driversListState extends State<driversList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: ListView.builder(
          padding: EdgeInsets.only(top: 50, bottom: 70),
          itemCount: Drivers.length,
          itemBuilder: (context, index) {
            if (Drivers[index].status == 'Driver') {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color.fromARGB(255, 255, 144, 54),
                      Color.fromARGB(255, 255, 181, 121),
                    ],
                  ),
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: ListTile(
                    textColor: Colors.white,
                    title: Text(Drivers[index].fullName),
                    subtitle: Text(Drivers[index].city)),
              );
            }
          },
        ));
  }
}
