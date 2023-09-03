import 'dart:ffi';

import 'package:carpooling/Pages/homePage.dart';
import 'package:carpooling/Pages/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'createCar.dart';
import 'driverHome.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
String textHolder = '';
String token = '';
String status = '';
String userName = '';
String userCity = '';
String userEmail = '';
String userID = '';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  void userSignIn() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email.text,
        'password': password.text,
      }),
    );

    if (email.text.isEmpty || password.text.isEmpty) {
      setState(() {
        textHolder = 'enter valid informations';
      });
    } else {
      if (response.statusCode == 200) {
        setState(() {
          final data = json.decode(response.body);
          token = data["token"];
          userEmail = data["email"];
          status = data["userStatus"];
          userName = data["userName"];
          userCity = data["userCity"];
          userID = data["userID"];
        });
        if (token != '') {
          if (status == '') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => createCar(),
              ),
            );
          } else if (status == 'Passenger') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => homePage(),
              ),
            );
          } else {
            if (status == 'Passenger') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => homePage(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => driverHome(),
                ),
              );
            }
          }
        }
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
            padding: EdgeInsets.only(top: 30),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3.7,
            child: Image.asset('assets/images/login.png'),
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 30),
              child: const Text(
                'Welcome Back!',
                style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold),
              )),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Text('Log into your existing account',
                style: TextStyle(
                  fontSize: 15,
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
                controller: email,
                decoration: InputDecoration(
                  hintText: 'Email adress',
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.account_circle),
                  prefixIconColor: const Color.fromARGB(255, 105, 190, 240),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.5,
                        color: const Color.fromARGB(255, 182, 182, 182)),
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
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.password_sharp),
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
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 30, bottom: 15),
            child: Text('Forgot password?'),
          ),
          ElevatedButton(
            onPressed: () {
              userSignIn();
            },
            child: Text(
              'SIGN IN',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(
                  right: 60, left: 60, top: 10, bottom: 10),
              backgroundColor: Color.fromARGB(255, 4, 118, 184),
              elevation: 3,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Use instead',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  child: Image.asset(
                    'assets/images/google.png',
                    width: 30,
                    height: 30,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                      top: 2,
                      bottom: 2,
                      right: 50,
                      left: 50,
                    ),
                    backgroundColor: Color.fromARGB(255, 231, 53, 53),
                    elevation: 3,
                  )),
              ElevatedButton(
                  onPressed: () {},
                  child: Image.asset(
                    'assets/images/facebook.png',
                    width: 30,
                    height: 30,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                      top: 2,
                      bottom: 2,
                      right: 50,
                      left: 50,
                    ),
                    backgroundColor: Color.fromARGB(255, 35, 120, 224),
                    elevation: 3,
                  ))
            ],
          ),
          Container(
              padding: EdgeInsets.all(20),
              child: RichText(
                text: TextSpan(
                    text: "Don't have an account yet?",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                    children: [
                      TextSpan(
                          text: "  Sign Up",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const register())),
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 14))
                    ]),
              ))
        ]),
      ),
    ));
  }
}
