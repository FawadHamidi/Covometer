import 'package:covometer/screens/Search_screen.dart';
import 'package:covometer/screens/graphs_screen.dart';
import 'package:covometer/screens/home_screen.dart';
import 'package:covometer/utilis/pallete.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;
  List<dynamic> _pages = [
    HomeScreen(),
    SearchScreen(),
    GraphsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        bottomNavigationBar: CurvedNavigationBar(
          color: kWhite,
          buttonBackgroundColor: kWhite,
          backgroundColor: kBackgroundColor,
          items: <Widget>[
            Icon(Icons.public, size: 30),
            Icon(Icons.travel_explore, size: 30),
            Icon(Icons.compare_arrows, size: 30),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            print(_selectedIndex);
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Row(
                  children: [
                    Icon(
                      Icons.sort,
                      size: 30,
                      color: kWhite,
                    ),
                  ],
                ),
              ),
              _pages[_selectedIndex],
            ],
          ),
        ),
      ),
    );
  }
}
