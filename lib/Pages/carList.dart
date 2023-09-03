import 'package:carpooling/Pages/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class carList extends StatefulWidget {
  const carList({super.key});

  @override
  State<carList> createState() => _carListState();
}

String carid = '';
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

class _carListState extends State<carList> {
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

  void deleteCar() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/carMan/deleteCar'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'carID': carid,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Car Deleted'),
        backgroundColor: Colors.greenAccent,
      ));
      getCars();
      print(carlen);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: RefreshIndicator(
            onRefresh: getCars,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 50, bottom: 85),
              itemCount: Cars.length,
              itemBuilder: (context, index) {
                if (Cars[index].owner == userEmail) {
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
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        carid = Cars[index].carID;
                                        if (carlen == 1) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'You must have at least one car'),
                                            backgroundColor: Color.fromARGB(
                                                255, 255, 89, 89),
                                          ));
                                        } else {
                                          deleteCar();
                                        }
                                      },
                                      child: Icon(Icons.delete,
                                          color: Color.fromARGB(
                                              255, 255, 75, 75))),
                                  SizedBox(
                                    height: 10,
                                  ),
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
    getCars();
  }
}
