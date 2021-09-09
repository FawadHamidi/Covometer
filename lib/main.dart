import 'package:covometer/providers/api_provider.dart';
import 'package:covometer/screens/landing_Screen.dart';
import 'package:covometer/utilis/my_theme.dart';
import 'package:covometer/utilis/pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ApiProvider>(create: (context) => ApiProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covometer',
        theme: ThemeData(
          textTheme: TextTheme(
            headline1: GoogleFonts.rubik(
              textStyle: TextStyle(
                  color: kWhite, fontWeight: FontWeight.bold, fontSize: 22),
            ),
            headline2: GoogleFonts.rubik(
              textStyle: TextStyle(
                  color: kWhite, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            headline3: GoogleFonts.rubik(
              textStyle: TextStyle(
                  color: kWhite, fontWeight: FontWeight.bold, fontSize: 26),
            ),
            headline4: GoogleFonts.rubik(
              textStyle: TextStyle(color: kWhite, fontSize: 18),
            ),
            headline5: GoogleFonts.rubik(
              textStyle: TextStyle(
                  color: kWhite, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            headline6: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ),
        home: LandingScreen(),
      ),
    );
  }
}
