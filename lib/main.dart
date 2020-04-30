import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stahl_section/about.dart';
import 'package:stahl_section/bar_schedule/barCalculater.dart';
import 'package:stahl_section/bar_schedule/mainBar.dart';
import 'package:stahl_section/cold_formed_section/mainCold.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/standard_sction/mainCode.dart';
import 'package:stahl_section/translate/app_localizations.dart';
import 'package:stahl_section/user_section/mainUser.dart';
import 'package:stahl_section/welcom_screen.dart';
import 'package:stahl_section/welded_section/weldMain.dart';

import 'foundations/main.dart';
//import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      supportedLocales: [
        Locale('en', 'US'),
        Locale('du', 'DU'),
      ],
      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // THIS CLASS WILL BE ADDED LATER
        // A class which loads the translations from JSON files0
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      title: 'SPS',
      theme: ThemeData(
        // Define the default brightness and colors.
        primarySwatch: Colors.red,
        brightness: Brightness.light,
        primaryColor: color.red,
        accentColor: color.White,
        indicatorColor: color.gray,
        cursorColor: color.gray,
        fontFamily: 'SegoeUI_Light',
        // Define the default font family.
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(
              fontSize: 20.0,
              color: color.White,
              fontWeight: FontWeight.bold /*fontFamily: 'SegoeUI'*/),
          display1: TextStyle(
              color: color.black,
              fontSize: 20,
              fontWeight: FontWeight.bold /*fontFamily: 'SegoeUI_Bold'*/),
          display2: TextStyle(
              fontSize: 16 /*, fontFamily: 'SegoeUI'*/, color: color.blackGray),
          display3: TextStyle(
              color: color.red,
              fontSize: 18,
              fontWeight: FontWeight.bold /*fontFamily: 'SegoeUI_Bold'*/),
        ),
      ),
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      home: welcome(),
      routes: {
        "code": (context) => mainCode(),
        "cold": (context) => mainCold(),
        "user": (context) => mainUser(),
        "weld": (context) => weldMain(),
        "save": (context) => mainCode(),
        "bar": (context) => mainBar(),
        "barCalc": (context) => barCalculater(),
        "about": (context) => about(),
        "foundation": (context) => mainFoundation(),
      },
    );
  }
}
