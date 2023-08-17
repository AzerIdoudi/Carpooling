import 'package:carpooling/Pages/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
String textHolder = '';

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
        print('Signed In successfully');
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
    return (Scaffold());
  }
}
