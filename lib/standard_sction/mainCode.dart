import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stahl_section/cold_formed_section/mainCold.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/standard_sction/details.dart';
import 'package:stahl_section/translate/app_localizations.dart';
import 'package:stahl_section/user_section/mainUser.dart';
import 'package:stahl_section/welded_section/weldMain.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:stahl_section/standard_sction/ComputeDetails.dart';
import 'package:stahl_section/standard_sction/section_name.dart';
import 'dart:math';

class mainCode extends StatefulWidget {
  @override
  _State createState() => _State();
  static String x_section = "I_section";
  static final myController = TextEditingController();
  static List<String> spinner = [
    'Narrow I-beams: IPN',
    'Central width I-beam: IP',
    'Broad I-beam: ',
    'Wide flanges nozzle profiles: H',
    'Extra wide I-profiles: HL'
  ];
  static String dropdownValue = 'Narrow I-beams: IPN';
  static String imageDetails = 'assets/code_image/details_ipn';
  static List<String> arrayListName = new List();
}

class _State extends State<mainCode> {
  section_name sectionName = new section_name();
  List<String> arrayListName = new List();
  String tw, tf, h, b, r;

  var i = 0;
  var _value = 1.0;

  @override
  void initState() {
    super.initState();
    arrayListName = sectionName.IPN_section();
    mainCode.myController.text = (arrayListName[0]);
    mainCode.myController.addListener(_printLatestValue);
    mainCode.x_section = "I_section";
    mainCode.spinner = [
      'Narrow I-beams: IPN',
      'Central width I-beam: IP',
      'Broad I-beam: ',
      'Wide flanges nozzle profiles: H',
      'Extra wide I-profiles: HL'
    ];
    mainCode.dropdownValue = 'Narrow I-beams: IPN';
    tw = 'tw';
    tf = 'tf';
    h = 'h';
    b = 'b';
    r = 'r';
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    //mainCode.myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _radius = 40;
    return new Scaffold(
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
                    AppLocalizations.of(context).translate('coldFormedSection'),
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
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _header(
                    AppLocalizations.of(context).translate('standardSection')),
                new Container(
                  width: double.infinity,
                  height: 70,
                  color: color.gray,
                  child: _listViewHorisental(),
                ), //ListHorisontal
                new Container(
                  width: double.infinity,
                  color: color.WhiteSelver,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 7),
                  child: _dropDownButton(),
                ), //Spinner
                new Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: color.White,
                            radius: 25,
                            child: Icon(
                              Icons.description,
                              color: color.red,
                            ),
                          ),
                          title: TextField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(fontSize: 24),
                            controller: mainCode.myController,
                          ),
                          onTap: () => _getDetails(),
                        ),
                      ],
                    )), //name
                new Expanded(
                  child: new Container(
                    width: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        _stacImage(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: new Container(
                            width: double.infinity,
                            child: FluidSlider(
                              value: _value,
                              onChanged: (double newValue) {
                                setState(() {
                                  _value = newValue;
                                  mainCode.myController.text =
                                      arrayListName[newValue.floor() - 1];
                                });
                              },
                              labelsTextStyle:
                                  Theme.of(context).textTheme.headline,
                              min: 1.0,
                              max: double.parse(
                                  (arrayListName.length + 1).toString()),
                              end: Text(
                                (arrayListName.length + 0).toString(),
                                style: Theme.of(context).textTheme.headline,
                              ),
                            ),
                          ), //name
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  spinnerItems() {
    mainCode.dropdownValue =
        AppLocalizations.of(context).translate('spinnerI1');
    mainCode.spinner = [
      AppLocalizations.of(context).translate('spinnerI1'),
      AppLocalizations.of(context).translate('spinnerI2'),
      AppLocalizations.of(context).translate('spinnerI3'),
      AppLocalizations.of(context).translate('spinnerI4'),
      AppLocalizations.of(context).translate('spinnerI5'),
    ];
    switch (mainCode.x_section) {
      case "U_section":
        mainCode.dropdownValue =
            AppLocalizations.of(context).translate('spinnerU1');
        mainCode.spinner = [
          AppLocalizations.of(context).translate('spinnerU1'),
          AppLocalizations.of(context).translate('spinnerU2'),
        ];
        break;
      case "L_section":
        mainCode.dropdownValue =
            AppLocalizations.of(context).translate('spinnerL1');
        mainCode.spinner = [
          AppLocalizations.of(context).translate('spinnerL1'),
          AppLocalizations.of(context).translate('spinnerL2'),
        ];
        break;
      case "T_section":
        mainCode.dropdownValue =
            AppLocalizations.of(context).translate('spinnerT1');
        mainCode.spinner = [
          AppLocalizations.of(context).translate('spinnerT1'),
          AppLocalizations.of(context).translate('spinnerT2'),
        ];
        break;
      case "HolwRec_section":
        mainCode.dropdownValue =
            AppLocalizations.of(context).translate('spinnerR1');
        mainCode.spinner = [
          AppLocalizations.of(context).translate('spinnerR1'),
          AppLocalizations.of(context).translate('spinnerR2'),
          AppLocalizations.of(context).translate('spinnerR3'),
          AppLocalizations.of(context).translate('spinnerR4'),
        ];
        break;
      case "Z_section":
        mainCode.dropdownValue =
            AppLocalizations.of(context).translate('spinnerZ');
        mainCode.spinner = [AppLocalizations.of(context).translate('spinnerZ')];
        break;
      case "circle_section":
        mainCode.dropdownValue =
            AppLocalizations.of(context).translate('spinnerC');
        mainCode.spinner = [AppLocalizations.of(context).translate('spinnerC')];
        break;
    }
    return mainCode.spinner;
  }

  _textFiled(bool vertical, String text, double mLeft, double mReight,
      double mTop, double mBottom) {
    double angle = 0;
    if (vertical) {
      angle = -90;
    }
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: EdgeInsets.only(
            left: mLeft, right: mReight, top: mTop, bottom: mBottom),
        padding: const EdgeInsets.only(
          left: 7.0,
          right: 7.0,
        ),
        decoration: BoxDecoration(
          color: color.White,
          border: Border.all(color: color.gray, width: 2.0),
          borderRadius: BorderRadius.all(
              Radius.circular(7.0) //                 <--- border radius here
              ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.display1.copyWith(fontSize: 16),
        ),
      ),
    );
  }

  _stacImage() {
    i = 0;
    for (i = 0; i < mainCode.spinner.length; i++) {
      if (mainCode.dropdownValue == mainCode.spinner[i]) {
        break;
      }
    }
    i++;
    String SvgAssets = 'assets/code_image/ipn_txt.svg';
    switch (mainCode.x_section) {
      case "I_section":
        {
          switch (i) {
            case 1:
              SvgAssets = 'assets/code_image/ipn_txt.svg';
              mainCode.imageDetails = 'assets/code_image/details_ipn.svg';
              break;
            case 2:
              SvgAssets = 'assets/code_image/ipa_txt.svg';
              mainCode.imageDetails = 'assets/code_image/details_ipe.svg';
              break;
            case 3:
            case 4:
            case 5:
              SvgAssets = 'assets/code_image/h_txt.svg';
              mainCode.imageDetails = 'assets/code_image/details_h.svg';
              break;
          }
          return Stack(
            children: <Widget>[
              new Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 50),
                  child: SvgPicture.asset(
                    SvgAssets,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: _textFiled(true, h, 0, 0, 200, 0),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(false, tw, 100, 0, 10, 0),
              ),
              Align(
                alignment: Alignment.topRight,
                child: _textFiled(true, tf, 0, 70, 0, 70),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _textFiled(false, r, 0.0, 150, 0, 150),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: _textFiled(false, b, 0, 0, 35, 0),
              ),
            ],
          );
        }
        break;
      case "U_section":
        {
          switch (i) {
            case 1:
              SvgAssets = 'assets/code_image/upn_txt.svg';
              mainCode.imageDetails = 'assets/code_image/details_upn.svg';
              break;
            case 2:
              SvgAssets = 'assets/code_image/u_txt.svg';
              mainCode.imageDetails = 'assets/code_image/details_u.svg';
              break;
          }
          return Stack(
            children: <Widget>[
              new Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 50),
                  child: SvgPicture.asset(
                    SvgAssets,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _textFiled(true, h, 0, 0, 0, 150),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(false, tw, 0, 100, 10, 0),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: _textFiled(true, tf, 0, 0, 100, 0),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(false, r, 0.0, 70, 0, 250),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: _textFiled(false, b, 0, 0, 20, 0),
              ),
            ],
          );
        }
        break;
      case "T_section":
        {
          switch (i) {
            case 1:
              SvgAssets = 'assets/code_image/tpn_txt.svg';
              mainCode.imageDetails = 'assets/code_image/details_tpn.svg';
              break;
            case 2:
              SvgAssets = 'assets/code_image/t_txt.svg';
              mainCode.imageDetails = 'assets/code_image/details_t.svg';
              break;
          }
          return Stack(
            children: <Widget>[
              new Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 50),
                  child: SvgPicture.asset(
                    SvgAssets,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: _textFiled(true, h, 0, 0, 100, 0),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(false, tw, 100, 0, 10, 0),
              ),
              Align(
                alignment: Alignment.topRight,
                child: _textFiled(true, tf, 0, 80, 70, 80),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _textFiled(false, r, 0.0, 120, 0, 70),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: _textFiled(false, b, 0, 0, 50, 0),
              ),
            ],
          );
        }
        break;
      case "L_section":
        {
          switch (i) {
            case 1:
              SvgAssets = 'assets/code_image/leq_txt.svg';
              mainCode.imageDetails = 'assets/code_image/details_leq.svg';
              break;
            case 2:
              SvgAssets = 'assets/code_image/l_txt.svg';
              mainCode.imageDetails = 'assets/code_image/details_luq.svg';
              break;
          }
          return Stack(
            children: <Widget>[
              new Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 50),
                  child: SvgPicture.asset(
                    SvgAssets,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: _textFiled(true, h, 0, 0, 150, 0),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(false, tw, 0, 70, 0, 10),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(false, r, 0, 60, 70, 0),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: _textFiled(false, tf, 0, 50, 50, 0),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _textFiled(false, b, 0, 0, 0, 85),
              ),
            ],
          );
        }
        break;
      case "Z_section":
        {
          SvgAssets = 'assets/code_image/z_txt.svg';
          mainCode.imageDetails = 'assets/code_image/details_z.svg';
          return Stack(
            children: <Widget>[
              new Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 50),
                  child: SvgPicture.asset(
                    SvgAssets,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _textFiled(true, h, 0, 0, 0, 70),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(false, tw, 50, 0, 0, 50),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: _textFiled(true, tf, 50, 50, 50, 100),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(false, r, 0.0, 80, 0, 222),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _textFiled(false, b, 70, 0, 0, 80),
              ),
            ],
          );
        }
        break;
      case "circle_section":
        {
          SvgAssets = 'assets/code_image/circle_txt.svg';
          mainCode.imageDetails = 'assets/code_image/details_c.svg';
          return Stack(
            children: <Widget>[
              new Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 50),
                  child: SvgPicture.asset(
                    SvgAssets,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: _textFiled(false, tw, 100, 0, 00, 50),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _textFiled(false, b, 0, 0, 0, 80),
              ),
            ],
          );
        }
        break;
      case "HolwRec_section":
        {
          switch (i) {
            case 1:
            case 2:
              SvgAssets = 'assets/code_image/squar_txt.svg';
              mainCode.imageDetails = 'assets/code_image/details_squar.svg';
              break;
            case 3:
            case 4:
              SvgAssets = 'assets/code_image/rec_txt.svg';
              mainCode.imageDetails = 'assets/code_image/details_rec.svg';
              break;
          }
          return Stack(
            children: <Widget>[
              new Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 50),
                  child: SvgPicture.asset(
                    SvgAssets,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: _textFiled(true, h, 0, 0, 100, 0),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(false, tw, 0, 110, 30, 0),
              ),
              Align(
                alignment: Alignment.topRight,
                child: _textFiled(true, tf, 0, 70, 0, 70),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(false, r, 0, 70, 0, 150),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: _textFiled(false, b, 0, 0, 35, 0),
              ),
            ],
          );
          break;
        }
    }
  }

  _dropDownButton() {
    return DropdownButton<String>(
      value: mainCode.dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: Theme.of(context).textTheme.display2.copyWith(fontSize: 18),
      underline: Container(
        height: 2,
        color: color.gray,
      ),
      onChanged: (String data) {
        setState(() {
          mainCode.dropdownValue = data;
          i = 0;
          for (i = 0; i < mainCode.spinner.length; i++) {
            if (data == mainCode.spinner[i]) {
              break;
            }
          }
          i++;
          switch (mainCode.x_section) {
            case "I_section":
              {
                arrayListI(i);
              }
              break;
            case "U_section":
              {
                arrayListU(i);
              }
              break;
            case "T_section":
              {
                arrayListT(i);
              }
              break;
            case "L_section":
              {
                arrayListL(i);
              }
              break;
            case "Z_section":
              {
                arrayListZ(i);
              }
              break;
            case "circle_section":
              {
                arrayListC(i);
              }
              break;
            case "HolwRec_section":
              {
                arrayListR(i);
              }
              break;
          }
          mainCode.myController.text = arrayListName[0];
          _value = 1;
        });
      },
      items: mainCode.spinner.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
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
    new ListItem(color.WhiteSelver, 'assets/code_image/icon_ir.svg'),
    new ListItem(color.gray, 'assets/code_image/icon_u.svg'),
    new ListItem(color.gray, 'assets/code_image/icon_t.svg'),
    new ListItem(color.gray, 'assets/code_image/icon_z.svg'),
    new ListItem(color.gray, 'assets/code_image/icon_l.svg'),
    new ListItem(color.gray, 'assets/code_image/icon_circle.svg'),
    new ListItem(color.gray, 'assets/code_image/icon_square.svg'),
  ];

  _listViewHorisental() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (context, i) {
        return _cardList(i);
      },
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
    list[0].assetsImage = 'assets/code_image/icon_i.svg';
    list[1].assetsImage = 'assets/code_image/icon_u.svg';
    list[2].assetsImage = 'assets/code_image/icon_t.svg';
    list[3].assetsImage = 'assets/code_image/icon_z.svg';
    list[4].assetsImage = 'assets/code_image/icon_l.svg';
    list[5].assetsImage = 'assets/code_image/icon_circle.svg';
    list[6].assetsImage = 'assets/code_image/icon_square.svg';
    switch (selct) {
      case 0:
        list[0].assetsImage = 'assets/code_image/icon_ir.svg';
        mainCode.x_section = "I_section";
        spinnerItems();
        arrayListI(1);
        break;
      case 1:
        list[1].assetsImage = 'assets/code_image/icon_ur.svg';
        mainCode.x_section = "U_section";
        spinnerItems();
        arrayListU(1);
        break;
      case 2:
        list[2].assetsImage = 'assets/code_image/icon_tr.svg';
        mainCode.x_section = "T_section";
        spinnerItems();
        arrayListT(1);
        break;
      case 3:
        list[3].assetsImage = 'assets/code_image/icon_zr.svg';
        mainCode.x_section = "Z_section";
        spinnerItems();
        arrayListZ(1);
        break;
      case 4:
        list[4].assetsImage = 'assets/code_image/icon_lr.svg';
        mainCode.x_section = "L_section";
        spinnerItems();
        arrayListL(1);
        break;
      case 5:
        list[5].assetsImage = 'assets/code_image/icon_circler.svg';
        mainCode.x_section = "circle_section";
        spinnerItems();
        arrayListC(1);
        break;
      case 6:
        list[6].assetsImage = 'assets/code_image/icon_squarr.svg';
        mainCode.x_section = "HolwRec_section";
        spinnerItems();
        arrayListR(1);
        break;
    }
    list[selct].color = color.WhiteSelver;
    mainCode.myController.text = arrayListName[0];
    _value = 1;
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
    if (text == AppLocalizations.of(context).translate('standardSection')) {
      return;
    }
    Navigator.pop(context);
    if (text == AppLocalizations.of(context).translate('userSection')) {
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

  _printLatestValue() {
    ComputeDetails computeDetails =
        new ComputeDetails(mainCode.x_section, 0, 0, 0, 0, 0, 0, 0, 0);
    computeDetails.getvalue_detail(mainCode.myController.text);
    switch (mainCode.x_section) {
      case ("I_section"):
        {
          h = computeDetails.H;
          b = computeDetails.B;
          r = computeDetails.R0;
          tf = computeDetails.Tf;
          tw = computeDetails.Tw;
        }
        break;
      case ("Z_section"):
        {
          h = computeDetails.H;
          b = computeDetails.B;
          r = computeDetails.R1;
          tf = computeDetails.R2;
          tw = computeDetails.Tw;
        }
        break;
      case ("circle_section"):
        {
          b = computeDetails.B;
          tw = computeDetails.Tw;
        }
        break;
      case ("U_section"):
        {
          h = computeDetails.H;
          b = computeDetails.B;
          computeDetails.R0 == '0.0'
              ? r = computeDetails.R1
              : r = computeDetails.R0;
          tf = computeDetails.Tf;
          tw = computeDetails.Tw;
        }
        break;
      case ("T_section"):
        {
          h = computeDetails.H;
          b = computeDetails.B;
          computeDetails.R0 == '0.0'
              ? r = computeDetails.R1
              : r = computeDetails.R0;
          tf = computeDetails.Tf;
          tw = computeDetails.Tw;
        }
        break;
      case ("HolwRec_section"):
        {
          h = computeDetails.H;
          b = computeDetails.B;
          r = computeDetails.R0;
          tf = computeDetails.Ri;
          tw = computeDetails.Tf;
        }
        break;
      case ("L_section"):
        {
          h = computeDetails.H;
          b = computeDetails.B;
          r = computeDetails.R1;
          tf = computeDetails.R2;
          tw = computeDetails.T;
        }
        break;
    }
  }

  arrayListI(int i) {
    switch (i) {
      case 1:
        {
          arrayListName = sectionName.IPN_section();
        }
        break;
      case 2:
        {
          arrayListName = sectionName.IPE_section();
        }
        break;
      case 3:
        {
          arrayListName = sectionName.HE_section();
        }
        break;
      case 4:
        {
          arrayListName = sectionName.HD_section();
        }
        break;
      case 5:
        {
          arrayListName = sectionName.HL_section();
        }
        break;
    }
  }

  arrayListU(int i) {
    switch (i) {
      case 1:
        {
          arrayListName = sectionName.UPN_section();
        }
        break;
      case 2:
        {
          arrayListName = sectionName.UPE_section();
        }
        break;
    }
  }

  arrayListT(int i) {
    switch (i) {
      case 1:
        {
          arrayListName = sectionName.T_section();
        }
        break;
      case 2:
        {
          arrayListName = sectionName.Thalf_section();
        }
        break;
    }
  }

  arrayListL(int i) {
    switch (i) {
      case 1:
        {
          arrayListName = sectionName.Lequal_section();
        }
        break;
      case 2:
        {
          arrayListName = sectionName.Lunequal_section();
        }
        break;
    }
  }

  arrayListR(int i) {
    switch (i) {
      case 1:
        {
          arrayListName = sectionName.Wsquar_section();
        }
        break;
      case 2:
        {
          arrayListName = sectionName.Ksquar_section();
        }
        break;
      case 3:
        {
          arrayListName = sectionName.WRec_section();
        }
        break;
      case 4:
        {
          arrayListName = sectionName.KRec_section();
        }
        break;
    }
  }

  arrayListZ(int i) {
    arrayListName = sectionName.Z_section();
  }

  arrayListC(int i) {
    arrayListName = sectionName.circle_section();
  }

  _getDetails() {
    mainCode.arrayListName = arrayListName;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => details()),
    );
  }
}

class ListItem {
  String assetsImage;
  Color color;

  ListItem(this.color, this.assetsImage);
}
