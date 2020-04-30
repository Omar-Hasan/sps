import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stahl_section/cold_formed_section/mainCold.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/standard_sction/mainCode.dart';
import 'package:stahl_section/translate/app_localizations.dart';
import 'package:stahl_section/user_section/mainUser.dart';
import 'dart:math';
import 'package:stahl_section/welded_section/details.dart';

class weldMain extends StatefulWidget {
  @override
  _State createState() => _State();
  static String x_section;
  static String imageDetails = 'assets/weld_image/weldi_equal.svg';
  static final myController = TextEditingController();
  static double t_plate, b_plate, hw, h, b_Top, tw, tf_Top, b_Bottom, tf_Bottom;
  static double alfa = 90;
  static int numberUpn = 6; // select channelle
  static List<String> spinner = new List();

  static double wPlateRL,
      tPlateRL,
      wPlateRL_height,
      wPlateRL_bottom,
      wPlateRL_top

      /*coverPlate Reight & Left*/;

  static double aC, ezC, IyC, IzC, WplyC;

  static void _setChannelleDetails(int number) {
    switch (number) {
      case 0:
        {
          _setDetailsUPN(50, 38, 5, 7, 3.5, 20, 7.12, 26.4, 9.12, 1.37, 3.506);
        }
        break;
      case 1:
        {
          _setDetailsUPN(65, 42, 5.5, 7.5, 4, 33, 9.03, 57.5, 14.1, 1.42, 7.45);
        }
        break;
      case 2:
        {
          _setDetailsUPN(80, 45, 6, 8, 4, 47, 11, 106, 19.4, 1.45, 15.9);
        }
        break;
      case 3:
        {
          _setDetailsUPN(100, 50, 6, 8.5, 4.5, 64, 13.5, 206, 29.3, 1.55, 24.5);
        }
        break;
      case 4:
        {
          _setDetailsUPN(120, 55, 7, 9, 4.5, 82, 17, 364, 43.2, 1.6, 36.3);
        }
        break;
      case 5:
        {
          _setDetailsUPN(140, 60, 7, 10, 5, 97, 20.4, 605, 62.7, 1.75, 51.4);
        }
        break;
      case 6:
        {
          _setDetailsUPN(
              160, 65, 7.5, 10.5, 5.5, 116, 24, 925, 85.3, 1.84, 68.8);
        }
        break;
      case 7:
        {
          _setDetailsUPN(180, 70, 8, 11, 5.5, 133, 28, 1350, 114, 1.92, 89.6);
        }
        break;
      case 8:
        {
          _setDetailsUPN(
              200, 75, 8.5, 11.5, 6, 151, 32.2, 1910, 148, 2.01, 114);
        }
        break;
      case 9:
        {
          _setDetailsUPN(
              220, 80, 9, 12.5, 6.5, 166, 37.4, 2690, 197, 2.14, 146);
        }
        break;
      case 10:
        {
          _setDetailsUPN(
              240, 85, 9.5, 13, 6.5, 185, 42.3, 3600, 248, 2.23, 179);
        }
        break;
      case 11:
        {
          _setDetailsUPN(260, 90, 10, 14, 7, 201, 48.3, 4820, 317, 2.36, 221);
        }
        break;
      case 12:
        {
          _setDetailsUPN(280, 95, 10, 15, 7.5, 216, 53.3, 6280, 399, 2.53, 266);
        }
        break;
      case 13:
        {
          _setDetailsUPN(300, 100, 10, 16, 8, 232, 58.8, 8030, 495, 2.7, 316);
        }
        break;
      case 14:
        {
          _setDetailsUPN(
              320, 100, 14, 17.5, 8.75, 247, 75.8, 10870, 597, 2.6, 413);
        }
        break;
      case 15:
        {
          _setDetailsUPN(350, 100, 14, 16, 8, 283, 77.3, 12840, 570, 2.4, 459);
        }
        break;
      case 16:
        {
          _setDetailsUPN(
              380, 102, 13.5, 16, 8, 313, 80.4, 15760, 615, 2.38, 507);
        }
        break;
      case 17:
        {
          _setDetailsUPN(400, 110, 14, 18, 9, 325, 91.5, 20350, 846, 2.65, 618);
        }
        break;
    }
  }

  static void _setDetailsUPN(
      double h,
      double b,
      double tw,
      double tf,
      double r2,
      double d,
      double a,
      double Iy,
      double Iz,
      double ez,
      double wply) {
    wPlateRL = h;
    wPlateRL_height = b - tw;
    tPlateRL = tw;
    wPlateRL_bottom = r2;
    wPlateRL_top = (h - d) / 2 - tf;
    aC = a;
    IyC = Iy;
    IzC = Iz;
    ezC = ez;
    WplyC = wply * 2;
  }
}

class _State extends State<weldMain> {
  GlobalKey imageKey;

  double heightGlobal, widthGlobal;
  double r = 1;

  var paint = new Paint();
  String spinner_value;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
    weldMain.x_section = 'weldI_equalFlange';
    weldMain.myController.text = 'Weld';
    imageKey = GlobalKey();
    heightGlobal = 400;
    widthGlobal = 400;
    weldMain.tf_Top = 12;
    weldMain.b_Top = 100;
    weldMain.tf_Bottom = 12;
    weldMain.b_Bottom = 100;
    weldMain.tw = 8;
    weldMain.hw = 100;

    paint.strokeWidth = 2;
    paint.color = color.red;
    paint.isAntiAlias = true;
    paint.style = PaintingStyle.fill;
    weldMain._setChannelleDetails(6);
    spinner_value = 'UPN 160';
    weldMain.spinner = [
      'UPN 50',
      'UPN 65',
      'UPN 80',
      'UPN 100',
      'UPN 120',
      'UPN 140',
      'UPN 160',
      'UPN 180',
      'UPN 200',
      'UPN 220',
      'UPN 240',
      'UPN 260',
      'UPN 280',
      'UPN 300',
      'UPN 320',
      'UPN 350',
      'UPN 380',
      'UPN 400',
    ];
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _radius = 40;

    return new Scaffold(
        resizeToAvoidBottomInset: false,
        endDrawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor:
                color.gray, //This will change the drawer background to blue.
            //other styles
          ),
          child: Container(
            width: 200,
            child: Drawer(
              child: ListView(
                children: <Widget>[
                  _cardDrawer(
                      'assets/main_image/icon_saved.svg',
                      AppLocalizations.of(context).translate('savedSection'),
                      _radius),
                  _cardDrawer(
                      'assets/main_image/icon_user.svg',
                      AppLocalizations.of(context).translate('userSection'),
                      _radius),
                  _cardDrawer(
                      'assets/main_image/icon_code.svg',
                      AppLocalizations.of(context).translate('standardSection'),
                      _radius),
                  _cardDrawer(
                      'assets/main_image/filtertrans.svg',
                      AppLocalizations.of(context).translate('weldedSection'),
                      _radius),
                  _cardDrawer(
                      'assets/main_image/icon_coldr.svg',
                      AppLocalizations.of(context)
                          .translate('coldFormedSection'),
                      _radius),
                ],
              ),
            ),
          ),
        ),
        appBar: null,
        body: Container(
          color: color.black,
          child: Padding(
            padding: EdgeInsets.only(top: 25),
            child: Container(
              color: color.White,
              child: Column(
                children: <Widget>[
                  _header(
                      AppLocalizations.of(context).translate('weldedSection')),
                  new Container(
                      width: double.infinity,
                      height: 70,
                      color: color.gray,
                      child: _listViewHorisental()),
                  _desqription(),
                  _rowUserProperty(),
                  new Expanded(
                    child: new Container(
                      padding: EdgeInsets.all(5),
                      key: imageKey,
                      child: Stack(
                        children: <Widget>[
                          _stacImage(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _header(String title) {
    return Container(
      height: 50,
      color: color.red,
      child: Padding(
        padding: EdgeInsets.only(left: 7, right: 7),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: color.red,
              radius: 25,
              child: SvgPicture.asset(
                'assets/main_image/logo-01.svg',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline,
              ),
            )
          ],
        ),
      ),
    );
  }

  List<ListItem> list = [
    new ListItem(color.White, 'assets/weld_image/icon_weld_ir.svg'),
    new ListItem(color.gray, 'assets/weld_image/icon_weld_iuq.svg'),
    new ListItem(color.gray, 'assets/weld_image/icon_weld_iplate.svg'),
    new ListItem(color.gray, 'assets/weld_image/icon_weld_ichannel.svg'),
    new ListItem(color.gray, 'assets/weld_image/icon_weld_box.svg'),
    new ListItem(color.gray, 'assets/weld_image/icon_weld_boxg.svg'),
  ];

  _listViewHorisental() {
    return Row(
      children: <Widget>[
        Flexible(
            flex: 1,
            child: Container(
              width: 70,
              child: Text(
                AppLocalizations.of(context).translate('selectShape'),
                style:
                    Theme.of(context).textTheme.headline.copyWith(fontSize: 18),
              ),
              padding: EdgeInsets.all(7),
            )),
        Expanded(
          flex: 5,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, i) {
              return _cardList(i);
            },
          ),
        ),
      ],
    );
  }

  _cardList(int i) {
    return GestureDetector(
      child: Container(
        width: 70,
        color: list[i].color,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: CircleAvatar(
            backgroundColor: color.White,
            radius: 60,
            child: SvgPicture.asset(
              list[i].assetsImage,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      onTap: () => setState(() {
        _tapImage(i);
      }),
    );
  }

  _tapImage(int selct) {
    for (int i = 0; i < list.length; i++) {
      list[i].color = color.gray;
    }
    list[0].assetsImage = 'assets/weld_image/icon_weld_i.svg';
    list[1].assetsImage = 'assets/weld_image/icon_weld_iuq.svg';
    list[2].assetsImage = 'assets/weld_image/icon_weld_iplate.svg';
    list[3].assetsImage = 'assets/weld_image/icon_weld_ichannel.svg';
    list[4].assetsImage = 'assets/weld_image/icon_weld_box.svg';
    list[5].assetsImage = 'assets/weld_image/icon_weld_boxg.svg';
    switch (selct) {
      case 0:
        weldMain.x_section = "weldI_equalFlange";
        list[0].assetsImage = 'assets/weld_image/icon_weld_ir.svg';
        weldMain.b_Bottom = weldMain.b_Top;
        weldMain.tf_Bottom = weldMain.tf_Top;
        weldMain.t_plate = weldMain.t_plate = 0;
        weldMain.imageDetails = 'assets/weld_image/weldi_equal.svg';
        break;
      case 1:
        weldMain.x_section = "weldI_unequalFlange";
        list[1].assetsImage = 'assets/weld_image/icon_weld_iuqr.svg';
        weldMain.b_Top += 20;
        weldMain.t_plate = weldMain.t_plate = 0;
        weldMain.imageDetails = 'assets/weld_image/weldi_unequal.svg';
        break;
      case 2:
        weldMain.x_section = "weldI_withPlate";
        list[2].assetsImage = 'assets/weld_image/icon_weld_iplater.svg';
        weldMain.t_plate = weldMain.tf_Top + 2;
        weldMain.b_plate = weldMain.b_Top + 20;
        weldMain.imageDetails = 'assets/weld_image/weldi_plate.svg';
        break;
      case 3:
        weldMain.x_section = "weldI_withChannelle";
        list[3].assetsImage = 'assets/weld_image/icon_weld_ichannelr.svg';
        weldMain.t_plate = weldMain.t_plate = 0;
        weldMain.imageDetails = 'assets/weld_image/weldi_channel.svg';
        break;
      case 4:
        weldMain.alfa = 90;
        weldMain.x_section = "weldBox_parallelFlange";
        list[4].assetsImage = 'assets/weld_image/icon_weld_boxr.svg';
        weldMain.b_Bottom = weldMain.b_Top;
        weldMain.tf_Bottom = weldMain.tf_Top;
        weldMain.t_plate = weldMain.t_plate = 0;
        weldMain.imageDetails = 'assets/weld_image/weldi_box.svg';
        break;
      case 5:
        weldMain.alfa = 80;
        weldMain.x_section = "weldBox_unParallelFlange";
        list[5].assetsImage = 'assets/weld_image/icon_weld_boxgr.svg';
        weldMain.b_Bottom = weldMain.b_Top;
        weldMain.tf_Bottom = weldMain.tf_Top;
        weldMain.t_plate = weldMain.t_plate = 0;
        break;
    }
    list[selct].color = color.White;
  }

  _cardDrawer(String svgAssets, String text, double _radius) {
    return GestureDetector(
      onTap: () => _navigate(text),
      child: new Wrap(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: color.gray,
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: new Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      color: color.trans,
                      width: 75,
                      height: 75,
                      child: FittedBox(
                        child: SvgPicture.asset(
                          svgAssets,
                          fit: BoxFit.fill,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: _radius * 2,
                      child: Center(
                        child: Text(
                          text,
                          style: Theme.of(context)
                              .textTheme
                              .display3
                              .copyWith(color: color.White),
                          textAlign: TextAlign.center,
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

  _navigate(String text) {
    Navigator.pop(context);
    if (text == AppLocalizations.of(context).translate('weldedSection')) {
      return;
    }
    Navigator.pop(context);
    if (text == AppLocalizations.of(context).translate('standardSection')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainCode()),
      );
      return;
    } else if (text ==
        AppLocalizations.of(context).translate('coldFormedSection')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainCold()),
      );
    } else if (text == AppLocalizations.of(context).translate('userSection')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainUser()),
      );
    } else if (text == AppLocalizations.of(context).translate('savedSection')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainCode()),
      );
    }
  }

  _rowUserProperty() {
    return Container(
      margin: EdgeInsets.all(7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).translate('unit'),
            style: Theme.of(context)
                .textTheme
                .display2
                .copyWith(fontSize: 25, color: color.gray),
          ),
          Container(
            padding: EdgeInsets.only(left: 7, right: 7, top: 3, bottom: 3),
            margin: EdgeInsets.only(
              left: 7,
              right: 7,
            ),
            child: Text(
              'mm',
              style: Theme.of(context).textTheme.headline,
            ),
            decoration: BoxDecoration(
              color: color.gray,
              border: Border.all(color: color.black, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: _raisedButton(),
            ),
          )
        ],
      ),
    );
  }

  _desqription() {
    return Container(
      width: double.infinity,
      color: color.WhiteSelver,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 7),
      child: TextField(
        controller: weldMain.myController,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.display2.copyWith(
            fontSize: 25, fontFamily: 'SegoeUI_Light', color: color.black),
        decoration: InputDecoration(
          focusColor: color.red,
          hoverColor: color.red,
          labelText: AppLocalizations.of(context).translate('desqribtion'),
          labelStyle: Theme.of(context)
              .textTheme
              .display1
              .copyWith(fontSize: 20, color: color.red),
        ),
      ),
    );
  }

  _raisedButton() {
    const double radius = 15;
    return RaisedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => details()),
        );
      },
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[color.red, color.red],
          ),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 17, right: 17),
          constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
          // min sizes for Material buttons
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context).translate('calculate'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: color.White, /*fontFamily: 'SegoeUI'*/
            ),
          ),
        ),
      ),
    );
  }

  _stacImage() {
    int space = 3;
    switch (weldMain.x_section) {
      case 'weldI_equalFlange':
        {
          weldMain.h = weldMain.hw + weldMain.tf_Bottom * 2;
          r = min((heightGlobal - 35) / weldMain.h,
              (widthGlobal - 35) / weldMain.b_Top);
          //weldMain.imageDetails = 'assets/code_image/details_ipe.svg';
          return Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: _container(weldMain.b_Top, weldMain.tf_Top, r, 0, 0,
                        0, weldMain.hw + weldMain.tf_Top + space),
                    onTap: () {
                      setState(() {
                        _setBool('p1');
                        _asyncInputDialog(
                            context, weldMain.b_Top, weldMain.tf_Top);
                      });
                    },
                  )),
              Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                    angle: -90 * pi / 180,
                    child: GestureDetector(
                      child:
                          _container(weldMain.hw, weldMain.tw, r, 0, 0, 0, 0),
                      onTap: () {
                        setState(() {
                          _setBool('p2');
                          _asyncInputDialog(context, weldMain.hw, weldMain.tw);
                        });
                      },
                    )),
              ),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: _container(weldMain.b_Bottom, weldMain.tf_Bottom, r,
                        0, 0, weldMain.hw + weldMain.tf_Top + space, 0),
                    onTap: () {
                      setState(() {
                        _setBool('p3');
                        _asyncInputDialog(
                            context, weldMain.b_Bottom, weldMain.tf_Bottom);
                      });
                    },
                  )),
            ],
          );
        }
        break;
      case "weldI_unequalFlange":
        {
          weldMain.h = weldMain.hw + weldMain.tf_Bottom + weldMain.tf_Top;
          r = min((heightGlobal - 35) / weldMain.h,
              (widthGlobal - 35) / max(weldMain.b_Top, weldMain.b_Bottom));
         // weldMain.imageDetails = 'assets/code_image/details_ipe.svg';
          return Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: _container(weldMain.b_Top, weldMain.tf_Top, r, 0, 0,
                        0, weldMain.hw + weldMain.tf_Top + space),
                    onTap: () {
                      setState(() {
                        _setBool('p1');
                        _asyncInputDialog(
                            context, weldMain.b_Top, weldMain.tf_Top);
                      });
                    },
                  )),
              Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                    angle: -90 * pi / 180,
                    child: GestureDetector(
                      child:
                          _container(weldMain.hw, weldMain.tw, r, 0, 0, 0, 0),
                      onTap: () {
                        setState(() {
                          _setBool('p2');
                          _asyncInputDialog(context, weldMain.hw, weldMain.tw);
                        });
                      },
                    )),
              ),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: _container(weldMain.b_Bottom, weldMain.tf_Bottom, r,
                        0, 0, weldMain.hw + weldMain.tf_Bottom + space, 0),
                    onTap: () {
                      setState(() {
                        _setBool('p3');
                        _asyncInputDialog(
                            context, weldMain.b_Bottom, weldMain.tf_Bottom);
                      });
                    },
                  )),
            ],
          );
        }
        break;
      case "weldI_withPlate":
        {
          weldMain.h = weldMain.hw +
              weldMain.tf_Bottom +
              weldMain.tf_Top +
              weldMain.t_plate;
          r = min(
              (heightGlobal -
                      50 -
                      weldMain.t_plate -
                      (weldMain.tf_Top - weldMain.tf_Bottom)) /
                  weldMain.h,
              (widthGlobal - 35) /
                  max(max(weldMain.b_Top, weldMain.b_Bottom),
                      weldMain.b_plate));
          //weldMain.imageDetails = 'assets/code_image/details_ipe.svg';
          return Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: _container(
                        weldMain.b_plate,
                        weldMain.t_plate,
                        r,
                        0,
                        0,
                        0,
                        weldMain.hw +
                            weldMain.tf_Top * 2 +
                            weldMain.t_plate +
                            space * 2),
                    onTap: () {
                      setState(() {
                        _setBool('pPlate');
                        _asyncInputDialog(
                            context, weldMain.b_plate, weldMain.t_plate);
                      });
                    },
                  )),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: _container(weldMain.b_Top, weldMain.tf_Top, r, 0, 0,
                        0, weldMain.hw + weldMain.tf_Top + space),
                    onTap: () {
                      setState(() {
                        _setBool('p1');
                        _asyncInputDialog(
                            context, weldMain.b_Top, weldMain.tf_Top);
                      });
                    },
                  )),
              Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                    angle: -90 * pi / 180,
                    child: GestureDetector(
                      child:
                          _container(weldMain.hw, weldMain.tw, r, 0, 0, 0, 0),
                      onTap: () {
                        setState(() {
                          _setBool('p2');
                          _asyncInputDialog(context, weldMain.hw, weldMain.tw);
                        });
                      },
                    )),
              ),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: _container(weldMain.b_Bottom, weldMain.tf_Bottom, r,
                        0, 0, weldMain.hw + weldMain.tf_Bottom + space, 0),
                    onTap: () {
                      setState(() {
                        _setBool('p3');
                        _asyncInputDialog(
                            context, weldMain.b_Bottom, weldMain.tf_Bottom);
                      });
                    },
                  )),
            ],
          );
        }
        break;
      case "weldI_withChannelle":
        {
          weldMain._setChannelleDetails(weldMain.numberUpn);
          weldMain.h = weldMain.hw +
              weldMain.tf_Bottom +
              weldMain.tf_Top +
              weldMain.tPlateRL;
          r = min(
              (heightGlobal -
                      70 -
                      weldMain.t_plate -
                      (weldMain.tf_Top - weldMain.tf_Bottom)) /
                  weldMain.h,
              (widthGlobal - 35) /
                  max(max(weldMain.b_Top, weldMain.b_Bottom),
                      weldMain.wPlateRL));
         // weldMain.imageDetails = 'assets/code_image/details_ipe.svg';
          return Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Container(
                      color: color.White,
                      width: weldMain.wPlateRL_top * r,
                      height: weldMain.wPlateRL_height * r,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: 0,
                          right:
                              (weldMain.wPlateRL - weldMain.wPlateRL_top) * r,
                          left: 0 * r,
                          bottom: (weldMain.hw +
                                  weldMain.tf_Top * 2 -
                                  weldMain.wPlateRL_height +
                                  space * 2) *
                              r),
                      child: CustomPaint(
                          painter: Trapezoidal(
                              paint,
                              weldMain.wPlateRL_bottom * r,
                              weldMain.wPlateRL_top * r,
                              weldMain.wPlateRL_height * r,
                              false)),
                    ),
                    onTap: () {
                      setState(() {
                        _asyncInputDialogChanell(context);
                      });
                    },
                  )),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Container(
                      color: color.White,
                      width: weldMain.wPlateRL_top * r,
                      height: weldMain.wPlateRL_height * r,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: 0,
                          left: (weldMain.wPlateRL - weldMain.wPlateRL_top) * r,
                          right: 0 * r,
                          bottom: (weldMain.hw +
                                  weldMain.tf_Top * 2 -
                                  weldMain.wPlateRL_height +
                                  space * 2) *
                              r),
                      child: CustomPaint(
                          painter: Trapezoidal(
                              paint,
                              weldMain.wPlateRL_bottom * r,
                              weldMain.wPlateRL_top * r,
                              weldMain.wPlateRL_height * r,
                              true)),
                    ),
                    onTap: () {
                      setState(() {
                        _asyncInputDialogChanell(context);
                      });
                    },
                  )),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: _container(
                        weldMain.wPlateRL,
                        weldMain.tPlateRL,
                        r,
                        0,
                        0,
                        0,
                        weldMain.hw +
                            weldMain.tf_Top * 2 +
                            weldMain.tPlateRL +
                            space * 2),
                    onTap: () {
                      setState(() {
                        _asyncInputDialogChanell(context);
                      });
                    },
                  )),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: _container(weldMain.b_Top, weldMain.tf_Top, r, 0, 0,
                        0, weldMain.hw + weldMain.tf_Top + space),
                    onTap: () {
                      setState(() {
                        _setBool('p1');
                        _asyncInputDialog(
                            context, weldMain.b_Top, weldMain.tf_Top);
                      });
                    },
                  )),
              Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                    angle: -90 * pi / 180,
                    child: GestureDetector(
                      child:
                          _container(weldMain.hw, weldMain.tw, r, 0, 0, 0, 0),
                      onTap: () {
                        setState(() {
                          _setBool('p2');
                          _asyncInputDialog(context, weldMain.hw, weldMain.tw);
                        });
                      },
                    )),
              ),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: _container(weldMain.b_Bottom, weldMain.tf_Bottom, r,
                        0, 0, weldMain.hw + weldMain.tf_Bottom + space, 0),
                    onTap: () {
                      setState(() {
                        _setBool('p3');
                        _asyncInputDialog(
                            context, weldMain.b_Bottom, weldMain.tf_Bottom);
                      });
                    },
                  )),
            ],
          );
        }
        break;
      case "weldBox_parallelFlange":
        {
          weldMain.h = weldMain.hw + weldMain.tf_Bottom * 2;
          r = min((heightGlobal - 35) / weldMain.h,
              (widthGlobal - 35) / weldMain.b_Top);
          //weldMain.imageDetails = 'assets/code_image/details_ipe.svg';
          return Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: _container(weldMain.b_Top, weldMain.tf_Top, r, 0, 0,
                        0, weldMain.hw + weldMain.tf_Top + space),
                    onTap: () {
                      setState(() {
                        _setBool('p1');
                        _asyncInputDialog(
                            context, weldMain.b_Top, weldMain.tf_Top);
                      });
                    },
                  )),
              Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                    angle: -90 * pi / 180,
                    child: GestureDetector(
                      child: _container(weldMain.hw, weldMain.tw, r, 0, 0,
                          weldMain.b_Top - weldMain.tw - space, 0),
                      onTap: () {
                        setState(() {
                          _setBool('p2');
                          _asyncInputDialog(context, weldMain.hw, weldMain.tw);
                        });
                      },
                    )),
              ),
              Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                    angle: -90 * pi / 180,
                    child: GestureDetector(
                      child: _container(weldMain.hw, weldMain.tw, r, 0, 0, 0,
                          weldMain.b_Top - weldMain.tw - space),
                      onTap: () {
                        setState(() {
                          _setBool('p2');
                          _asyncInputDialog(context, weldMain.hw, weldMain.tw);
                        });
                      },
                    )),
              ),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: _container(weldMain.b_Bottom, weldMain.tf_Bottom, r,
                        0, 0, weldMain.hw + weldMain.tf_Bottom + space, 0),
                    onTap: () {
                      setState(() {
                        _setBool('p3');
                        _asyncInputDialog(
                            context, weldMain.b_Bottom, weldMain.tf_Bottom);
                      });
                    },
                  )),
            ],
          );
        }
        break;
      case "weldBox_unParallelFlange":
        {
          weldMain.h = weldMain.hw + weldMain.tf_Bottom * 2;
          r = min((heightGlobal - 35) / weldMain.h,
              (widthGlobal - 35) / weldMain.b_Top);
         // weldMain.imageDetails = 'assets/code_image/details_ipe.svg';
          return Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: _container(weldMain.b_Top, weldMain.tf_Top, r, 0, 0,
                        0, weldMain.hw + weldMain.tf_Top + space),
                    onTap: () {
                      setState(() {
                        _setBool('p1');
                        _asyncInputDialog(
                            context, weldMain.b_Top, weldMain.tf_Top);
                      });
                    },
                  )),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Container(
                      color: color.White,
                      width: (weldMain.hw * cos(weldMain.alfa * pi / 180) +
                              weldMain.tw) *
                          r,
                      height: weldMain.hw * r,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: 0,
                          left: (weldMain.b_Top -
                                  weldMain.hw * cos(weldMain.alfa * pi / 180) -
                                  weldMain.tw -
                                  space) *
                              r,
                          right: 0 * r,
                          bottom: (0) * r),
                      child: CustomPaint(
                        painter: TrapezoidalBox(context, paint, weldMain.hw,
                            weldMain.tw, weldMain.alfa * pi / 180, true, r),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _asyncInputAngleDialog(
                            context, weldMain.hw, weldMain.tw, weldMain.alfa);
                      });
                    },
                  )),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Container(
                      color: color.White,
                      width: (weldMain.hw * cos(weldMain.alfa * pi / 180) +
                              weldMain.tw) *
                          r,
                      height: weldMain.hw * r,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: 0,
                          right: (weldMain.b_Top -
                                  weldMain.hw * cos(weldMain.alfa * pi / 180) -
                                  weldMain.tw -
                                  space) *
                              r,
                          left: 0 * r,
                          bottom: (0) * r),
                      child: CustomPaint(
                        painter: TrapezoidalBox(context, paint, weldMain.hw,
                            weldMain.tw, weldMain.alfa * pi / 180, false, r),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _asyncInputAngleDialog(
                            context, weldMain.hw, weldMain.tw, weldMain.alfa);
                      });
                    },
                  )),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: _container(weldMain.b_Bottom, weldMain.tf_Bottom, r,
                        0, 0, weldMain.hw + weldMain.tf_Bottom + space, 0),
                    onTap: () {
                      setState(() {
                        _setBool('p3');
                        _asyncInputDialog(
                            context, weldMain.b_Bottom, weldMain.tf_Bottom);
                      });
                    },
                  )),
            ],
          );
        }
        break;
    }
  }

  _container(double width, double height, double r, double mLeft,
      double mReight, double mTop, double mBottom) {
    return Container(
      color: color.red,
      width: width * r,
      height: height * r,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
          top: mTop * r,
          left: mLeft * r,
          right: mReight * r,
          bottom: mBottom * r),
      child: Text(
        (width).toString() + ' * ' + (height).toString(),
        style: Theme.of(context)
            .textTheme
            .headline
            .copyWith(fontSize: min((height - 2) * r, 20)),
      ),
    );
  }

  _asyncInputDialog(BuildContext context, double width, double t) async {
    TextEditingController wController = new TextEditingController();
    TextEditingController tController = new TextEditingController();
    wController.text = width.toString();
    tController.text = t.toString();
    _getDimentions() {
      switch (weldMain.x_section) {
        case "weldI_equalFlange":
          {
            if (p1) {
              weldMain.b_Top = double.parse(wController.text);
              weldMain.tf_Top = double.parse(tController.text);
              weldMain.b_Bottom = weldMain.b_Top;
              weldMain.tf_Bottom = weldMain.tf_Top;
            } else if (p2) {
              weldMain.hw = double.parse(wController.text);
              weldMain.tw = double.parse(tController.text);
            } else if (p3) {
              weldMain.b_Bottom = double.parse(wController.text);
              weldMain.tf_Bottom = double.parse(tController.text);
              weldMain.b_Top = weldMain.b_Bottom;
              weldMain.tf_Top = weldMain.tf_Bottom;
            }
            weldMain.imageDetails = 'assets/weld_image/weldi_equal.svg';
          }
          break;
        case "weldI_unequalFlange":
          {
            if (p1) {
              weldMain.b_Top = double.parse(wController.text);
              weldMain.tf_Top = double.parse(tController.text);
            } else if (p2) {
              weldMain.hw = double.parse(wController.text);
              weldMain.tw = double.parse(tController.text);
            } else if (p3) {
              weldMain.b_Bottom = double.parse(wController.text);
              weldMain.tf_Bottom = double.parse(tController.text);
            }
            weldMain.imageDetails = 'assets/weld_image/weldi_unequal.svg';
          }
          break;
        case "weldI_withPlate":
          {
            if (p1) {
              weldMain.b_Top = double.parse(wController.text);
              weldMain.tf_Top = double.parse(tController.text);
            } else if (p2) {
              weldMain.hw = double.parse(wController.text);
              weldMain.tw = double.parse(tController.text);
            } else if (p3) {
              weldMain.b_Bottom = double.parse(wController.text);
              weldMain.tf_Bottom = double.parse(tController.text);
            } else if (pPlate) {
              weldMain.b_plate = double.parse(wController.text);
              weldMain.t_plate = double.parse(tController.text);
            }
          }
          break;
        case "weldI_withChannelle":
          {
            if (p1) {
              weldMain.b_Top = double.parse(wController.text);
              weldMain.tf_Top = double.parse(tController.text);
            } else if (p2) {
              weldMain.hw = double.parse(wController.text);
              weldMain.tw = double.parse(tController.text);
            } else if (p3) {
              weldMain.b_Bottom = double.parse(wController.text);
              weldMain.tf_Bottom = double.parse(tController.text);
            } else if (pC) {}
          }
          break;
        case "weldBox_parallelFlange":
        case "weldBox_unParallelFlange":
          {
            if (p1) {
              weldMain.b_Top = double.parse(wController.text);
              weldMain.tf_Top = double.parse(tController.text);
              weldMain.b_Bottom = weldMain.b_Top;
            } else if (p2) {
              weldMain.hw = double.parse(wController.text);
              weldMain.tw = double.parse(tController.text);
            } else if (p3) {
              weldMain.b_Bottom = double.parse(wController.text);
              weldMain.tf_Bottom = double.parse(tController.text);
              weldMain.b_Top = weldMain.b_Bottom;
            }
            if (weldMain.tf_Bottom < weldMain.tf_Top)
              weldMain.imageDetails = 'assets/weld_image/weldi_box_top.svg';
            else if (weldMain.tf_Bottom < weldMain.tf_Top)
              weldMain.imageDetails = 'assets/weld_image/weldi_box.svg';
            else
              weldMain.imageDetails = 'assets/weld_image/weldi_box_bottom.svg';
            break;
          }
      }
    }

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context).translate('PlateDimentions'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.display3,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here
            content: Container(
              width: double.infinity,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: wController,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(fontSize: 20, color: color.black),
                      decoration: InputDecoration(
                        focusColor: color.red,
                        hoverColor: color.red,
                        labelText:
                            AppLocalizations.of(context).translate('width'),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontSize: 14, color: color.red),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: tController,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(fontSize: 20, color: color.black),
                      decoration: InputDecoration(
                        focusColor: color.red,
                        hoverColor: color.red,
                        labelText:
                            AppLocalizations.of(context).translate('thickness'),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontSize: 14, color: color.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  AppLocalizations.of(context).translate('cancle'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display1,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  AppLocalizations.of(context).translate('ok'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display1,
                ),
                onPressed: () {
                  setState(() {
                    _getDimentions();
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          );
        });
  }

  _asyncInputAngleDialog(
      BuildContext context, double width, double t, double alfa) async {
    TextEditingController wController = new TextEditingController();
    TextEditingController tController = new TextEditingController();
    TextEditingController alfaController = new TextEditingController();
    wController.text = width.toString();
    tController.text = t.toString();
    alfaController.text = alfa.toString();
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context).translate('PlateDimentions'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.display3,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here
            content: Container(
              width: double.infinity,
              height: 220,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: wController,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(fontSize: 20, color: color.black),
                      decoration: InputDecoration(
                        focusColor: color.red,
                        hoverColor: color.red,
                        labelText:
                            AppLocalizations.of(context).translate('width'),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontSize: 14, color: color.red),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: tController,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(fontSize: 20, color: color.black),
                      decoration: InputDecoration(
                        focusColor: color.red,
                        hoverColor: color.red,
                        labelText:
                            AppLocalizations.of(context).translate('thickness'),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontSize: 14, color: color.red),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: alfaController,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(fontSize: 20, color: color.black),
                      decoration: InputDecoration(
                        focusColor: color.red,
                        hoverColor: color.red,
                        labelText:
                            AppLocalizations.of(context).translate('alfa'),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontSize: 14, color: color.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  AppLocalizations.of(context).translate('cancle'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display1,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  AppLocalizations.of(context).translate('ok'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display1,
                ),
                onPressed: () {
                  setState(() {
                    weldMain.tw = double.parse(tController.text);
                    weldMain.hw = double.parse(wController.text);
                    weldMain.alfa = double.parse(alfaController.text);
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          );
        });
  }

  _asyncInputDialogChanell(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context).translate('selectUPN'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.display3,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here
            content: Container(
              width: double.infinity,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: DropdownButton<String>(
                  value: spinner_value,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 1,
                  style: Theme.of(context)
                      .textTheme
                      .display2
                      .copyWith(fontSize: 18),
                  underline: Container(
                    height: 2,
                    color: color.gray,
                  ),
                  onChanged: (String data) {
                    setState(() {
                      spinner_value = data;
                      for (int i = 0; i < weldMain.spinner.length; i++) {
                        if (weldMain.spinner[i] == data) {
                          weldMain.numberUpn = i;
                          break;
                        }
                      }
                    });
                  },
                  items: weldMain.spinner
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            actions: <Widget>[
              /*FlatButton(
                child: Text(
                  AppLocalizations.of(context).translate('cancle'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display1,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),*/
              FlatButton(
                child: Text(
                  AppLocalizations.of(context).translate('ok'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display1,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          );
        });
  }

  bool p1, p2, p3, pPlate, pC;

  _setBool(String p) {
    p1 = p2 = p3 = pPlate = pC = false;
    switch (p) {
      case 'p1':
        p1 = true;
        break;
      case 'p2':
        p2 = true;
        break;
      case 'p3':
        p3 = true;
        break;
      case 'pPlate':
        pPlate = true;
        break;
    }
  }

  _afterLayout(Duration timeStamp) {
    final RenderBox renderBoxRed = imageKey.currentContext.findRenderObject();
    heightGlobal = renderBoxRed.size.height;
    widthGlobal = renderBoxRed.size.width;
  }
}

class ListItem {
  String assetsImage;
  Color color;

  ListItem(this.color, this.assetsImage);
}

class Trapezoidal extends CustomPainter {
  Paint paintBorder;
  double Top_width;
  double bottom_width;
  double height;
  bool reight;

  Trapezoidal(this.paintBorder, this.bottom_width, this.Top_width, this.height,
      this.reight);

  @override
  void paint(Canvas c, Size size) {
    var paint = paintBorder;
    double canvasx = size.width;
    double canvasy = size.height;
    double centerX = canvasx / 2.0;
    double centerY = canvasy / 2.0;

    List<Offset> p = new List(4);
    if (reight) {
      p[0] = new Offset(centerX - Top_width / 2, centerY - height / 2);
      p[1] = new Offset(centerX + Top_width / 2, centerY - height / 2);
      p[2] = new Offset(centerX + Top_width / 2, centerY + height / 2);
      p[3] = new Offset(p[2].dx - bottom_width, centerY + height / 2);
    } else {
      p[0] = new Offset(centerX - Top_width / 2, centerY - height / 2);
      p[1] = new Offset(centerX + Top_width / 2, centerY - height / 2);
      p[3] = new Offset(centerX - Top_width / 2, centerY + height / 2);
      p[2] = new Offset(p[3].dx + bottom_width, centerY + height / 2);
    }

    /* c.drawLine(p[0], p[1], paint);
    c.drawLine(p[1], p[2], paint);
    c.drawLine(p[2], p[3], paint);
    c.drawLine(p[3], p[0], paint);
*/

    Path path = new Path();
    path.moveTo(p[0].dx, p[0].dy);
    path.lineTo(p[1].dx, p[1].dy);
    path.lineTo(p[2].dx, p[2].dy);
    path.lineTo(p[3].dx, p[3].dy);
    path.close();
    c.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class TrapezoidalBox extends CustomPainter {
  Paint paintBorder;
  double width;
  double thikcnes;
  double alfa_Rad;
  bool reight;
  double r;
  BuildContext context;

  TrapezoidalBox(this.context, this.paintBorder, this.width, this.thikcnes,
      this.alfa_Rad, this.reight, this.r);

  @override
  void paint(Canvas c, Size size) {
    String s = (this.width).toString() + " * " + (this.thikcnes).toString();
    double width = this.width * r;
    double thikcnes = this.thikcnes * r;
    double alfa_Rad = this.alfa_Rad;
    double d = width * sin(alfa_Rad);
    double C = width * cos(alfa_Rad);
    double allC = C + thikcnes;

    double canvasx = size.width;
    double canvasy = size.height;
    double centerX = canvasx / 2.0;
    double centerY = canvasy / 2.0;
    List<Offset> p = new List(4);
    if (reight) {
      p[0] = new Offset(centerX + allC / 2 - thikcnes, centerY - d / 2);
      p[1] = new Offset(centerX + allC / 2, centerY - d / 2);
      p[2] = new Offset(centerX - allC / 2 + thikcnes, centerY + d / 2);
      p[3] = new Offset(centerX - allC / 2, centerY + d / 2);
      Rect rect = new Rect.fromLTRB(centerX - allC / 2, centerY - d / 2 - C,
          centerX + allC / 2 - thikcnes + C, centerY - d / 2 + C);
      c.drawArc(rect, pi - alfa_Rad, alfa_Rad, true, paintBorder);
      // c.drawArc(rect,180 + alfa_Rad ,-alfa_Rad,false,paintBorder);
      alfa_Rad = -alfa_Rad * 180 / pi;
      _drawText(
          c,
          Theme.of(context)
              .textTheme
              .headline
              .copyWith(fontSize: min(15, thikcnes - 4)),
          (-alfa_Rad).toString(),
          centerX - allC / 2 + (C / 2),
          centerY - d / 2 + (C / 2.8));
    } else {
      p[0] = new Offset(centerX - allC / 2, centerY - d / 2);
      p[1] = new Offset(centerX - allC / 2 + thikcnes, centerY - d / 2);
      p[2] = new Offset(centerX + allC / 2, centerY + d / 2);
      p[3] = new Offset(centerX + allC / 2 - thikcnes, centerY + d / 2);
      alfa_Rad = alfa_Rad * 180 / pi;
    }
    Path path = new Path();
    path.moveTo(p[0].dx, p[0].dy);
    path.lineTo(p[1].dx, p[1].dy);
    path.lineTo(p[2].dx, p[2].dy);
    path.lineTo(p[3].dx, p[3].dy);
    path.close();
    c.drawPath(path, paintBorder);

    /* c.drawLine(p[0], p[1], paintBorder);
      c.drawLine(p[1], p[2], paintBorder);
      c.drawLine(p[2], p[3], paintBorder);
      c.drawLine(p[3], p[0], paintBorder);
*/
    if (reight) {
      // c.translate(centerX, centerY);
      c.rotate(alfa_Rad * pi / 180);
    } else {
      c.translate(centerX, centerY);
      c.rotate((180 + alfa_Rad) * pi / 180);
    }
    _drawText(
        c,
        Theme.of(context)
            .textTheme
            .headline
            .copyWith(fontSize: min(15, thikcnes - 4)),
        s,
        centerX /*- bounds.width() / 2*/,
        centerY /*+bounds.height() / 2*/);
  }

  _drawText(Canvas context, TextStyle textStyle, String text, double x, double y) {
    TextSpan span = new TextSpan(style: textStyle, text: text);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(context, new Offset(x - tp.width / 2, y - tp.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
