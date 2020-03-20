import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stahl_section/cold_formed_section/mainCold.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/standard_sction/mainCode.dart';
import 'package:stahl_section/translate/app_localizations.dart';
import 'package:stahl_section/user_section/mainUser.dart';
import 'package:stahl_section/welded_section/weldMain.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        //fontFamily: 'SegoeUI',
        // Define the default font family.
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(
              fontSize: 20.0, color: color.White, /*fontFamily: 'SegoeUI'*/),
          display1: TextStyle(
              color: color.black, fontSize: 20, /*fontFamily: 'SegoeUI_Bold'*/),
          display2: TextStyle(
              fontSize: 16/*, fontFamily: 'SegoeUI'*/, color: color.blackGray),
          display3: TextStyle(
              color: color.red, fontSize: 18, /*fontFamily: 'SegoeUI_Bold'*/),
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
      home: MyHomePage(title: 'SPS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: _drawer(),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('app_title'),
          style: Theme.of(context).textTheme.headline,
        ),
      ),
      body: _listCard(),
    );
  }

  _listCard() {
    double _radius = 50;
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        _card('assets/main_image/logo-01.svg',
            AppLocalizations.of(context).translate('standardSection'), _radius),
        _card('assets/main_image/icon_user.svg',
            AppLocalizations.of(context).translate('userSection'), _radius),
        _card(
            'assets/main_image/icon_cold_formed.svg',
            AppLocalizations.of(context).translate('coldFormedSection'),
            _radius + 8),
        _card('assets/main_image/filtertrans.svg',
            AppLocalizations.of(context).translate('weldedSection'), _radius),
        _card('assets/main_image/icon_saved.svg',
            AppLocalizations.of(context).translate('savedSection'), _radius),
      ],
    );
  }

  _card(String svgAssets, String text, double _radius) {
    return GestureDetector(
      onTap: () => _navigate(text),
      child: new Wrap(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: color.WhiteSelver,
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: new Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      color: color.trans,
                      width: 100,
                      height: 100,
                      child: FittedBox(
                        child: SvgPicture.asset(
                          svgAssets,
                          fit: BoxFit.fill,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      color: color.White,
                      elevation: 10,
                      child: SizedBox(
                        width: _radius * 2,
                        child: Center(
                          child: Text(
                            text,
                            style: Theme.of(context).textTheme.display3,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: new Container(
        child: new Column(children: <Widget>[
          new Container(
            width: double.infinity,
            color: color.red,
            child: SvgPicture.asset(
              'assets/main_image/logo-01.svg',
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          new ListTile(
            leading: CircleAvatar(
              backgroundColor: color.White,
              radius: 20,
              child: Icon(
                Icons.check_circle_outline,
                color: color.red,
              ),
            ),
            title: Text(
              AppLocalizations.of(context).translate('about'),
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          new Expanded(child: _listDrawer()),
        ]),
      ),
    );
  }

  _listDrawer() {
    double _radius = 20;
    List<DrawerItem> drawerItem = [
      new DrawerItem(
        AppLocalizations.of(context).translate('language'),
        [
          AppLocalizations.of(context).translate('english'),
          AppLocalizations.of(context).translate('deutsch')
        ],
        Icons.language,
      ),
      new DrawerItem(
        AppLocalizations.of(context).translate('tools'),
        [
          AppLocalizations.of(context).translate('reinforcementBar'),
          AppLocalizations.of(context).translate('bolts')
        ],
        Icons.build,
      ),
      new DrawerItem(
        AppLocalizations.of(context).translate('helpInformation'),
        [AppLocalizations.of(context).translate('IncreasingHeartsNumber')],
        Icons.info_outline,
      ),
    ];

    _buildExpandableContent(DrawerItem drawerItem) {
      List<Widget> columnContent = [];
      for (String content in drawerItem.contents)
        columnContent.add(SizedBox(
          width: double.infinity,
          height: 50,
          child: new ListTile(
            leading: SizedBox(
              width: _radius,
            ),
            title: Text(
              content,
              style: Theme.of(context).textTheme.display2,
            ),
          ),
        ));
      return columnContent;
    }

    return ListView.separated(
      itemCount: drawerItem.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, i) {
        return new ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: color.White,
            radius: _radius,
            child: Icon(
              drawerItem[i].icon,
              color: color.red,
            ),
          ),
          title: new Text(
            drawerItem[i].title,
            style: Theme.of(context).textTheme.display1,
          ),
          children: <Widget>[
            new Column(
              children: _buildExpandableContent(drawerItem[i]),
            ),
          ],
        );
      },
    );
  }

  _navigate(String text) {
    if (text == AppLocalizations.of(context).translate('standardSection')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainCode()),
      );
    } else if (text == AppLocalizations.of(context).translate('userSection')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainUser()),
      );
    } else if (text ==
        AppLocalizations.of(context).translate('coldFormedSection')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainCold()),
      );
    } else if (text ==
        AppLocalizations.of(context).translate('weldedSection')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => weldMain()),
      );
    } else if (text == AppLocalizations.of(context).translate('savedSection')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainCode()),
      );
    }
  }
}

class DrawerItem {
  final String title;
  List<String> contents = [];
  final IconData icon;

  DrawerItem(this.title, this.contents, this.icon);
}
