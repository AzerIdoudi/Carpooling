import 'dart:convert';
import 'package:carpooling/Pages/register.dart';
import 'package:flutter/material.dart';
import 'package:carpooling/Pages/login.dart';
import 'package:http/http.dart' as http;
import 'package:carpooling/Pages/pTrips.dart';

import 'carList.dart';
import 'dtrips.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

TextEditingController newName = TextEditingController();
TextEditingController newCity = TextEditingController();
String publicError = '';
TextEditingController newEmail = TextEditingController();
TextEditingController oldPasswordEmail = TextEditingController();
String emailError = '';
TextEditingController newPassword = TextEditingController();
TextEditingController confirmNewPassword = TextEditingController();
TextEditingController oldPassword = TextEditingController();
String passwordError = '';

class _profileState extends State<profile> {
  @override
  void publicSettings() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/profile/public'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'newName': newName.text,
        'newCity': newCity.text,
        'userID': userID
      }),
    );
    if (newName.text.isEmpty || newCity.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Enter valid informations'),
        backgroundColor: Colors.redAccent,
      ));
    } else {
      if (response.statusCode == 400) {
        setState(() {
          publicError = response.body;
        });
      } else {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Changes approved'),
            backgroundColor: Colors.greenAccent,
          ));
          fullName = newName;
          city = newCity;
        });
      }
    }
  }

  void changeEmail() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/profile/email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'newEmail': newEmail.text,
        'oldPasswordEmail': oldPasswordEmail.text,
        'userID': userID
      }),
    );
    if (newEmail.text.isEmpty || oldPasswordEmail.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Enter valid informations'),
        backgroundColor: Colors.redAccent,
      ));
    } else {
      if (response.statusCode == 400) {
        setState(() {
          emailError = response.body;
        });
      } else if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Changes approved'),
          backgroundColor: Colors.greenAccent,
        ));
      }
    }
  }

  void changePassword() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/profile/password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'newPassword': newPassword.text,
        'confirmNewPassword': confirmNewPassword.text,
        'oldPassword': oldPassword.text,
        'userID': userID,
      }),
    );
    if (newPassword.text.isEmpty ||
        confirmNewPassword.text.isEmpty ||
        oldPassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Enter valid informations'),
        backgroundColor: Colors.redAccent,
      ));
    }
    ;

    if (newPassword.text != confirmNewPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password doesn't match")));
    } else {
      if (response.statusCode == 400) {
        setState(() {
          passwordError = response.body;
        });
      } else if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Changes approved'),
          backgroundColor: Colors.greenAccent,
        ));
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80)),
                color: Color.fromARGB(255, 0, 140, 255),
              ),
              child: Column(children: [
                SizedBox(height: 70),
                Text(
                  'Profile',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  color: Color.fromARGB(0, 255, 255, 255),
                  elevation: 0,
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
                              ("assets/images/user.png"),
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
                                    userName,
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                        color: Colors.black),
                                  ),
                                  Container(height: 5),
                                  Text(
                                    userEmail,
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Container(height: 10),
                                  Text(userCity,
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.05,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Public Informations"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(publicError,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: const Color.fromARGB(
                                          255, 255, 0, 0))),
                              TextField(
                                controller: newName,
                                decoration: InputDecoration(
                                  hintText: 'New Full Name',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: Icon(Icons.location_on_outlined),
                                  prefixIconColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.5,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
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
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: newCity,
                                decoration: InputDecoration(
                                  hintText: 'New City',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: Icon(Icons.location_on_outlined),
                                  prefixIconColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.5,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
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
                              SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    publicSettings();
                                  },
                                  child: Text('Confirm Changes'),
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
                                  ))
                            ],
                          ),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          elevation: 0,
                          titleTextStyle:
                              TextStyle(color: Colors.cyan, fontSize: 17),
                        );
                      });
                },
                child: Row(children: [
                  Icon(
                    Icons.public,
                    size: 30,
                    color: const Color.fromARGB(255, 114, 191, 255),
                  ),
                  SizedBox(width: 30),
                  Text(
                    'Public informations settings',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ]),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.05,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Change Email"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(emailError,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: const Color.fromARGB(
                                          255, 255, 0, 0))),
                              TextField(
                                controller: newEmail,
                                decoration: InputDecoration(
                                  hintText: 'New Email',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: Icon(Icons.location_on_outlined),
                                  prefixIconColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.5,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
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
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: oldPasswordEmail,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Your Password',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: Icon(Icons.location_on_outlined),
                                  prefixIconColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.5,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
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
                              SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    changeEmail();
                                  },
                                  child: Text('Confirm Changes'),
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
                                  ))
                            ],
                          ),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          elevation: 0,
                          titleTextStyle:
                              TextStyle(color: Colors.cyan, fontSize: 17),
                        );
                      });
                },
                child: Row(children: [
                  Icon(
                    Icons.email,
                    size: 30,
                    color: const Color.fromARGB(255, 114, 191, 255),
                  ),
                  SizedBox(width: 30),
                  Text(
                    'Change Email',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ]),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.05,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Change Password"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(passwordError,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: const Color.fromARGB(
                                          255, 255, 0, 0))),
                              TextField(
                                controller: newPassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'New Password',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: Icon(Icons.location_on_outlined),
                                  prefixIconColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.5,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
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
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: confirmNewPassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: Icon(Icons.location_on_outlined),
                                  prefixIconColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.5,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
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
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: oldPassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Old Password',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: Icon(Icons.location_on_outlined),
                                  prefixIconColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.5,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
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
                              SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    changePassword();
                                  },
                                  child: Text('Confirm Changes'),
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
                                  ))
                            ],
                          ),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          elevation: 0,
                          titleTextStyle:
                              TextStyle(color: Colors.cyan, fontSize: 17),
                        );
                      });
                },
                child: Row(children: [
                  Icon(
                    Icons.password,
                    size: 30,
                    color: const Color.fromARGB(255, 114, 191, 255),
                  ),
                  SizedBox(width: 30),
                  Text(
                    'Change Password',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ]),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.05,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (status == 'Passenger') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pTrips(),
                      ),
                    );
                  }
                  if (status == 'Driver') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => dtrips(),
                      ),
                    );
                  }
                },
                child: Row(children: [
                  Icon(
                    Icons.travel_explore,
                    size: 30,
                    color: const Color.fromARGB(255, 114, 191, 255),
                  ),
                  SizedBox(width: 30),
                  Text(
                    'Trips List',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ]),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 81, 81),
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  setState(() {
                    token = '';
                    status = '';
                    userName = '';
                    userCity = '';
                    userEmail = '';
                    userID = '';
                    carlen = 0;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => login(),
                    ),
                  );
                },
                child: Row(children: [
                  Icon(
                    Icons.output_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 30),
                  Text(
                    'Disconnect',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
