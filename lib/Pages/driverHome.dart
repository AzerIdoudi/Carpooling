import 'package:carpooling/Pages/driversList.dart';
import 'package:carpooling/Pages/messages.dart';
import 'package:carpooling/Pages/profile.dart';
import 'package:carpooling/Pages/trip.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'carList.dart';
import 'myPosition.dart';

class driverHome extends StatefulWidget {
  const driverHome({super.key});

  @override
  State<driverHome> createState() => _driverHomeState();
}

class _driverHomeState extends State<driverHome> {
  int _index = 0;
  final screens = [carList(), myPosition(), messages(), profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(child: screens[_index]),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 0, 140, 255),
              borderRadius: BorderRadius.circular(50),
            ),
            child: GNav(
              selectedIndex: _index,
              onTabChange: (value) {
                setState(() {
                  _index = value;
                });
              },
              padding: EdgeInsets.all(11),
              tabMargin: EdgeInsets.all(10),
              tabBackgroundColor: Colors.white,
              activeColor: Color.fromARGB(255, 25, 152, 255),
              color: Color.fromARGB(255, 184, 223, 255),
              gap: 10,
              tabs: [
                GButton(
                  textStyle: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 25, 152, 255)),
                  icon: Icons.list_alt_outlined,
                  text: 'Car List',
                  onPressed: () {},
                ),
                GButton(
                  textStyle: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 25, 152, 255)),
                  icon: Icons.location_on_outlined,
                  text: 'My position',
                  onPressed: () {},
                ),
                GButton(
                    textStyle: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 25, 152, 255)),
                    icon: Icons.chat_bubble_outline,
                    text: 'Messages'),
                GButton(
                    textStyle: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 25, 152, 255)),
                    icon: Icons.face,
                    text: 'Profile')
              ],
            ),
          ),
        )
      ]),
    );
  }
}
