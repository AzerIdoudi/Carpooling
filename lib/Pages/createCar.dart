import 'package:carpooling/Pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:carpooling/Pages/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

TextEditingController Mark = TextEditingController();
TextEditingController Model = TextEditingController();
TextEditingController Condition = TextEditingController();
String textHolder = '';

class createCar extends StatefulWidget {
  const createCar({super.key});

  @override
  State<createCar> createState() => _createCarState();
}

class _createCarState extends State<createCar> {
  @override
  void notDriver() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/carMan/notDriver'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'owner': userEmail}),
    );
    print(userEmail);
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => homePage(),
        ),
      );
      ;
    }
    ;
  }

  void createCar() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/carMan/createCar'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mark': Mark.text,
        'model': Model.text,
        'condition': Condition.text,
        'owner': userEmail
      }),
    );

    if (Mark.text.isEmpty || Model.text.isEmpty || Condition.text.isEmpty) {
      setState(() {
        textHolder = 'enter valid informations';
      });
    } else {
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => homePage(),
          ),
        );
      } else {
        String error = response.body;
        setState(() {
          textHolder = error;
        });
      }
    }
    ;
  }

  Widget build(BuildContext context) {
    return (Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(top: 80),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Image.asset('assets/images/addCar.png'),
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 40),
              child: const Text(
                "Add a car!",
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold),
              )),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Text('Create your first car!',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                )),
          ),
          Container(
            padding: EdgeInsets.only(top: 0, bottom: 5),
            child: Text(textHolder,
                style: TextStyle(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 255, 0, 0),
                )),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
                controller: Mark,
                decoration: InputDecoration(
                  hintText: 'Mark',
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.car_repair),
                  prefixIconColor: const Color.fromARGB(255, 105, 190, 240),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.5,
                        color: const Color.fromARGB(
                            255, 182, 182, 182)), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Color.fromARGB(255, 105, 190, 240),
                    ),
                  ),
                )),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
                controller: Model,
                decoration: InputDecoration(
                  hintText: 'Model',
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.car_rental_rounded),
                  prefixIconColor: const Color.fromARGB(255, 105, 190, 240),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.5,
                        color:
                            Color.fromARGB(255, 182, 182, 182)), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Color.fromARGB(255, 105, 190, 240),
                    ),
                  ),
                )),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 40),
            child: TextField(
                controller: Condition,
                decoration: InputDecoration(
                  hintText: 'Condition',
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.car_crash_sharp),
                  prefixIconColor: const Color.fromARGB(255, 105, 190, 240),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.5,
                        color: const Color.fromARGB(
                            255, 182, 182, 182)), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Color.fromARGB(255, 105, 190, 240),
                    ),
                  ),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  createCar();
                },
                child: Text(
                  'ADD CAR!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                      right: 40, left: 40, top: 15, bottom: 15),
                  backgroundColor: Color.fromARGB(255, 4, 118, 184),
                  elevation: 3,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  notDriver();
                },
                child: Text(
                  'NOT A DRIVER',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                      right: 40, left: 40, top: 15, bottom: 15),
                  backgroundColor: Color.fromARGB(255, 255, 147, 46),
                  elevation: 3,
                ),
              ),
            ],
          ),
        ]),
      ),
    ));
  }
}
