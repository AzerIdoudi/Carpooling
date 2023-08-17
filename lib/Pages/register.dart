import 'dart:convert';

import 'package:carpooling/Pages/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

TextEditingController fullName = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController city = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController confirmPassword = TextEditingController();
String textHolder = '';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  @override
  void userSignUp() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fullName': fullName.text,
        'email': email.text,
        'city': city.text,
        'password': password.text,
      }),
    );

    if (fullName.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty ||
        city.text.isEmpty) {
      setState(() {
        textHolder = 'enter valid informations';
      });
    } else if (password.text != confirmPassword.text) {
      setState(() {
        textHolder = "Password Doesn't match";
      });
    } else {
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => login(),
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
            padding: EdgeInsets.only(right: 320, top: 30, left: 20),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const login(),
                ),
              ),
              child: Container(
                child: Image.network(
                  'https://icons.veryicon.com/png/o/miscellaneous/arrows/go-back-2.png',
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 10),
              child: const Text(
                "Let's get started!",
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold),
              )),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Text('Create a new account and enjoy your trips',
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
                controller: fullName,
                decoration: InputDecoration(
                  hintText: 'Full name',
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.account_box),
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
                controller: email,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.mail),
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
            padding: const EdgeInsets.all(10),
            child: TextField(
                controller: city,
                decoration: InputDecoration(
                  hintText: 'City',
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.location_city),
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
            padding: const EdgeInsets.all(10),
            child: TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.password),
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
            padding:
                const EdgeInsets.only(top: 10, bottom: 40, left: 10, right: 10),
            child: TextField(
                controller: confirmPassword,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.password),
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
          ElevatedButton(
            onPressed: () {
              userSignUp();
            },
            child: Text(
              'SIGN UP',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(
                  right: 60, left: 60, top: 10, bottom: 10),
              backgroundColor: Color.fromARGB(255, 4, 118, 184),
              elevation: 3,
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                    children: [
                      TextSpan(
                          text: "  Sign In",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const login())),
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 14))
                    ]),
              )),
        ]),
      ),
    ));
  }
}
