import 'package:carpooling/Pages/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class register extends StatelessWidget {
  const register({super.key});

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const login()),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 50, left: 20),
                alignment: Alignment.topLeft,
                child: Image.network(
                  'https://icons.veryicon.com/png/o/miscellaneous/arrows/go-back-2.png',
                  width: 40,
                  height: 40,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 40),
              child: const Text(
                "Let's get started!",
                style: TextStyle(fontSize: 40),
              )),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 40),
            child: Text('Create a new account and enjoy your trips',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                )),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
                decoration: InputDecoration(
              hintText: 'Full name',
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
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Email',
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
                decoration: InputDecoration(
              hintText: 'Password',
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
                decoration: InputDecoration(
              hintText: 'Confirm Password',
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
              // Respond to button press
            },
            child: Text(
              'SIGN UP',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(
                  right: 60, left: 60, top: 10, bottom: 10),
              backgroundColor: Color.fromARGB(255, 4, 118, 184),
              elevation: 3,
            ),
          ),
          Container(
              padding: EdgeInsets.all(40),
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
