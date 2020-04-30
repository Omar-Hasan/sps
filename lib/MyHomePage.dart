import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stahl_section/bar_schedule/barCalculater.dart';
import 'package:stahl_section/bar_schedule/mainBar.dart';
import 'package:stahl_section/cold_formed_section/mainCold.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/standard_sction/mainCode.dart';
import 'package:stahl_section/translate/app_localizations.dart';
import 'package:stahl_section/user_section/mainUser.dart';
import 'package:stahl_section/welcom_screen.dart';
import 'package:stahl_section/welded_section/weldMain.dart';

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
  List<CardItem> cardItem = new List();

  bool showCode = true; //SharedPreferencesTest.getShowCode();
  bool showCold = true;
  bool showWeld = true;
  bool showSaved = true;
  bool showUser = true;
  bool showbolts = false;
  bool showBar = false;
  bool showBarCalc = false;
  bool showFoundation = false;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cardItem.clear();
    cardItem.add(CardItem('assets/main_image/icon_code.svg',
        AppLocalizations.of(context).translate('standardSection'), showCode));
    cardItem.add(CardItem('assets/main_image/icon_user.svg',
        AppLocalizations.of(context).translate('userSection'), showUser));
    cardItem.add(CardItem('assets/main_image/icon_cold.svg',
        AppLocalizations.of(context).translate('coldFormedSection'), showCold));
    cardItem.add(CardItem('assets/main_image/icon_weld.svg',
        AppLocalizations.of(context).translate('weldedSection'), showWeld));
    cardItem.add(CardItem('assets/main_image/icon_save.svg',
        AppLocalizations.of(context).translate('savedSection'), showSaved));
    cardItem.add(CardItem('assets/main_image/icon_bar.svg',
        AppLocalizations.of(context).translate('reinforcementBar'), showBar));
    cardItem.add(CardItem('assets/main_image/icon_bolt.svg',
        AppLocalizations.of(context).translate('bolts'), showbolts));
    cardItem.add(CardItem('assets/main_image/icon_bar.svg',
        AppLocalizations.of(context).translate('barsCalculator'), showBarCalc));
    cardItem.add(CardItem('assets/foundation_image/foundation.svg',
        AppLocalizations.of(context).translate('foundation'), showFoundation));

    return new Scaffold(
      drawer: _drawer(),
      appBar: AppBar(
          title: Container(
        padding: const EdgeInsets.all(1.0),
        child: Text(
          AppLocalizations.of(context).translate('app_title'),
          style: Theme.of(context).textTheme.headline,
        ),
      )
          /*Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/main_image/logo-01.svg',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.all(8.0), child: Text(AppLocalizations.of(context).translate('app_title'),
              style: Theme.of(context).textTheme.headline,
            ),)
          ],
        ),*/
          ),
      body: _listCard(),
    );
  }

  _listCard() {
    double _radius = 50;
    List<CardItem> cardShow = new List();
    for (CardItem card in cardItem) {
      card.show ? cardShow.add(card) : {};
    }
    return GridView.builder(
      itemCount: cardShow.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0),
      itemBuilder: (BuildContext context, int index) {
        return _card(
            cardShow[index].icon, cardShow[index].description, _radius + 4);
      },
    );
    /*return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        _card('assets/main_image/logo-01.svg',
            AppLocalizations.of(context).translate('standardSection'), _radius),
        _card('assets/main_image/icon_user.svg',
            AppLocalizations.of(context).translate('userSection'), _radius),
        _card(
            'assets/main_image/icon_coldr.svg',
            AppLocalizations.of(context).translate('coldFormedSection'),
            _radius + 8),
        _card('assets/main_image/filtertrans.svg',
            AppLocalizations.of(context).translate('weldedSection'), _radius),
        _card('assets/main_image/icon_saved.svg',
            AppLocalizations.of(context).translate('savedSection'), _radius),
      ],
    );*/
  }

  _card(String svgAssets, String text, double _radius) {
    return GestureDetector(
      onTap: () => _navigate(text),
      child: new Stack(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: color.WhiteSelver,
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(1.0),
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
          Align(
              alignment: Alignment.topRight,
              child: Container(
                  margin: EdgeInsets.all(6),
                  child: CircleAvatar(
                    backgroundColor: color.White,
                    //color: color.red,
                    radius: 15,
                    child: _raisedButtonIcon(
                        Icon(Icons.delete_forever, color: color.red), text),
                  ))),
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
          new GestureDetector(
            child: ListTile(
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
            onTap: () => Navigator.pushNamed(context, "about"),
          ),
          new Expanded(child: _listDrawer()),
        ]),
      ),
    );
  }

  _listDrawer() {
    double _radius = 10;
    List<DrawerItem> drawerItem = [
      new DrawerItem(
          AppLocalizations.of(context).translate('language'),
          [
            CardItem(
                '', AppLocalizations.of(context).translate('english'), false),
            CardItem(
                '', AppLocalizations.of(context).translate('deutsch'), false),
          ],
          Icons.language,
          false),
      new DrawerItem(
          AppLocalizations.of(context).translate('steelSection'),
          [
            CardItem(
                'assets/main_image/icon_coder.svg',
                AppLocalizations.of(context).translate('standardSection'),
                showCode),
            CardItem(
                'assets/main_image/icon_userr.svg',
                AppLocalizations.of(context).translate('userSectiont'),
                showUser),
            CardItem(
                'assets/main_image/icon_coldr.svg',
                AppLocalizations.of(context).translate('coldFormedSection'),
                showCold),
            CardItem(
                'assets/main_image/icon_weldr.svg',
                AppLocalizations.of(context).translate('weldedSection'),
                showWeld),
            CardItem(
                'assets/main_image/icon_saver.svg',
                AppLocalizations.of(context).translate('savedSection'),
                showSaved),
          ],
          Icons.build,
          true),
      new DrawerItem(
          AppLocalizations.of(context).translate('concrete'),
          [
            CardItem(
                'assets/main_image/icon_barr.svg',
                AppLocalizations.of(context).translate('reinforcementBar'),
                showBar),
            CardItem(
                'assets/main_image/icon_barr.svg',
                AppLocalizations.of(context).translate('barsCalculator'),
                showBarCalc),
            CardItem(
                'assets/foundation_image/foundation.svg',
                AppLocalizations.of(context).translate('foundation'),
                showFoundation),
            CardItem('assets/main_image/icon_boltr.svg',
                AppLocalizations.of(context).translate('bolts'), showbolts),
          ],
          Icons.settings,
          true),
      new DrawerItem(
          AppLocalizations.of(context).translate('helpInformation'),
          [
            CardItem(
                '',
                AppLocalizations.of(context)
                    .translate('IncreasingHeartsNumber'),
                false),
          ],
          Icons.info_outline,
          false),
    ];

    _buildExpandableContent(DrawerItem drawerItem) {
      List<Widget> columnContent = [];
      for (CardItem content in drawerItem.contents)
        columnContent.add(Row(
          children: <Widget>[
            Flexible(
              flex: 4,
              child: GestureDetector(
                onTap: () {
                  _navigate(content.description);
                },
                child: Container(
                  // padding: EdgeInsets.only(bottom:5),
                  alignment: Alignment.centerRight,
                  width: double.infinity,
                  height: 50,
                  child: new ListTile(
                    leading: CircleAvatar(
                      backgroundColor: color.White,
                      radius: _radius * 2,
                      child: SvgPicture.asset(
                        content.icon,
                        //color: color.red,
                      ),
                    ),
                    title: Text(
                      content.description,
                      style: Theme.of(context).textTheme.display2,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: drawerItem.flex ? 1 : 0,
              fit: FlexFit.tight,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    content.show
                        ? _hide(content.description)
                        : _show(content.description);
                  });
                },
                child: drawerItem.flex
                    ? Icon(
                        Icons.star,
                        color: content.show ? color.red : color.gray,
                      )
                    : Container(),
              ),
            ),
          ],
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
      Navigator.pushNamed(context, "code");
    } else if (text == AppLocalizations.of(context).translate('userSection')) {
      Navigator.pushNamed(context, "user");
    } else if (text ==
        AppLocalizations.of(context).translate('coldFormedSection')) {
      Navigator.pushNamed(context, "cold");
    } else if (text ==
        AppLocalizations.of(context).translate('weldedSection')) {
      Navigator.pushNamed(context, "weld");
    } else if (text == AppLocalizations.of(context).translate('savedSection')) {
      Navigator.pushNamed(context, "save");
    } else if (text ==
        AppLocalizations.of(context).translate('reinforcementBar')) {
      Navigator.pushNamed(context, "bar");
    } else if (text ==
        AppLocalizations.of(context).translate('barsCalculator')) {
      Navigator.pushNamed(context, "barCalc");
    }else if (text ==
        AppLocalizations.of(context).translate('foundation')) {
      Navigator.pushNamed(context, "foundation");
    }
  }

  _hide(String text) {
    if (text == AppLocalizations.of(context).translate('standardSection')) {
      showCode = false;
      //SharedPreferencesTest.setShowCode(false);
    } else if (text == AppLocalizations.of(context).translate('userSectiont') ||
        text == AppLocalizations.of(context).translate('userSection')) {
      showUser = false;
    } else if (text ==
        AppLocalizations.of(context).translate('coldFormedSection')) {
      showCold = false;
    } else if (text ==
        AppLocalizations.of(context).translate('weldedSection')) {
      showWeld = false;
    } else if (text == AppLocalizations.of(context).translate('savedSection')) {
      showSaved = false;
    } else if (text ==
        AppLocalizations.of(context).translate('reinforcementBar')) {
      showBar = false;
    } else if (text ==
        AppLocalizations.of(context).translate('barsCalculator')) {
      showBarCalc = false;
    } else if (text == AppLocalizations.of(context).translate('bolts')) {
      showbolts = false;
    }else if (text == AppLocalizations.of(context).translate('foundation')) {
      showFoundation = false;
    }
    /*for(int i = 0; i<cardItem.length; i++){
      if (text == cardItem[i].description) {
        cardItem[i].show = false;
      }
    }
*/
  }

  _show(String text) {
    if (text == AppLocalizations.of(context).translate('standardSection')) {
      showCode = true;
    } else if (text == AppLocalizations.of(context).translate('userSectiont')) {
      showUser = true;
    } else if (text ==
        AppLocalizations.of(context).translate('coldFormedSection')) {
      showCold = true;
    } else if (text ==
        AppLocalizations.of(context).translate('weldedSection')) {
      showWeld = true;
    } else if (text == AppLocalizations.of(context).translate('savedSection')) {
      showSaved = true;
    } else if (text ==
        AppLocalizations.of(context).translate('reinforcementBar')) {
      showBar = true;
    } else if (text ==
        AppLocalizations.of(context).translate('barsCalculator')) {
      showBarCalc = true;
    } else if (text == AppLocalizations.of(context).translate('foundation')) {
      showFoundation = true;
    } else if (text == AppLocalizations.of(context).translate('bolts')) {
      showbolts = true;
    }
  }

  _afterLayout(Duration timeStamp) {
    cardItem.add(CardItem('assets/main_image/logo-01.svg',
        AppLocalizations.of(context).translate('standardSection'), showCode));
    cardItem.add(CardItem('assets/main_image/icon_user.svg',
        AppLocalizations.of(context).translate('userSection'), showUser));
    cardItem.add(CardItem('assets/main_image/icon_coldr.svg',
        AppLocalizations.of(context).translate('coldFormedSection'), showCold));
    cardItem.add(CardItem('assets/main_image/filtertrans.svg',
        AppLocalizations.of(context).translate('weldedSection'), showWeld));
    cardItem.add(CardItem('assets/main_image/icon_saved.svg',
        AppLocalizations.of(context).translate('savedSection'), showSaved));
  }

  _raisedButtonIcon(Widget icon, String text) {
    const double radius = 15;
    return RaisedButton(
      onPressed: () {
        setState(() {
          _hide(text);
        });
      },
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[color.White, color.White],
          ),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Container(
          //margin: EdgeInsets.all(7),
          padding: EdgeInsets.only(left: 1, right: 1),
          constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
          // min sizes for Material buttons
          alignment: Alignment.center,
          child: icon,
        ),
      ),
    );
  }
}

class DrawerItem {
  final String title;
  List<CardItem> contents;
  final IconData icon;
  bool flex = true;

  DrawerItem(this.title, this.contents, this.icon, this.flex);
}

class CardItem {
  String icon, description;
  bool show = true, flex = true;

  CardItem(this.icon, this.description, this.show);
}
/*
class SharedPreferencesTest {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _kLanguageCode = "en";
  static final String _kShowCode = 'true';
  static final String _kShowCold = 'true';
  static final String _kShowWeld = 'true';
  static final String _kShowSave = 'true';
  static final String _kShowUser = 'true';
  static final String _kShowBar  = 'false';
  static final String _kShowBolt = 'false';

  /// ------------------------------------------------------------
  /// Method that returns the user decision to allow notifications
  /// ------------------------------------------------------------
  static Future<String> getLanguageCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kLanguageCode) ?? 'en';
  }
  static getShowCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kShowCode) ?? true;
  }
  /// ----------------------------------------------------------
  /// Method that saves the user decision to allow notifications
  /// ----------------------------------------------------------
  static Future<bool> setLanguageCode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kLanguageCode, value);
  }
  static Future<bool> setShowCode(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_kShowCode, value);
  }

}
*/
