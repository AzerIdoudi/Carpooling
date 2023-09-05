import 'package:carpooling/Pages/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'driversList.dart';

class driverCars extends StatefulWidget {
  const driverCars({super.key});

  @override
  State<driverCars> createState() => _driverCarsState();
}

int carlen = 0;

class Car {
  final String carID;
  final String mark;
  final String model;
  final String condition;
  final String owner;

  Car(
      {required this.carID,
      required this.mark,
      required this.model,
      required this.condition,
      required this.owner});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      carID: json['carID'],
      mark: json['mark'],
      model: json['model'],
      condition: json['condition'],
      owner: json['owner'],
    );
  }
}

class _driverCarsState extends State<driverCars> {
  @override
  List<Car> Cars = [];
  Future getCars() async {
    Cars.clear();
    carlen = 0;
    final url = Uri.parse('http://10.0.2.2:3000/home/carList');
    final response = await http.get(url);
    final jsonData = await jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in jsonData) {
        setState(() {
          Car car = Car.fromJson(item);
          Cars.add(car);
        });
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Text("${driveremail}'s Cars List"),
        ),
        body: RefreshIndicator(
            onRefresh: getCars,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 50, bottom: 85),
              itemCount: Cars.length,
              itemBuilder: (context, index) {
                if (Cars[index].owner == driveremail) {
                  carlen = carlen + 1;
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
                                ("assets/images/addCar.png"),
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                              Container(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(height: 5),
                                    Text(
                                      Cars[index].mark,
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Container(height: 5),
                                    Text(
                                      Cars[index].model,
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(height: 10),
                                    Text(Cars[index].condition),
                                  ],
                                ),
                              ),
                              Column(
                                children: [],
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
    getCars();
  }
}
