import 'package:carpooling/Pages/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
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
            padding: const EdgeInsets.all(10),
            child: TextField(
                decoration: InputDecoration(
              hintText: 'Email adress',
              hintStyle:
                  TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
              prefixIcon: Icon(Icons.account_circle),
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
              // Respond to button press
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
                  child: Image.network(
                    'https://www.seekpng.com/png/full/201-2014535_google-icon-logo-black-and-white-french-flag.png',
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
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png',
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
                    backgroundColor: Color.fromARGB(255, 89, 162, 250),
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
