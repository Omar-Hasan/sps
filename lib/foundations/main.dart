import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/foundations/design_foundations.dart';
import 'package:stahl_section/foundations/results.dart';
import 'package:stahl_section/translate/app_localizations.dart';

import '../popup.dart';
import '../popup_content.dart';

class mainFoundation extends StatefulWidget {
  static TextEditingController textEditingController =
  new TextEditingController();
  static String type_foundation = "isolated";
  static double pForce = 100,
      H = 50,
      Df = 100,
      A_long = 150,
      B_width = 100,
      a_long = 50,
      b_width = 30,
      fc = 180,
      qa = 3,
      gamaC = 2.5,
      gamaS = 1.5,
      Fy = 3600;

  @override
  _mainFoundationState createState() => _mainFoundationState();
}

class _mainFoundationState extends State<mainFoundation> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String type_foundation0 = "isolated";
  String type_foundation1 = "isolatedWithMoment";
  String type_foundation2 = "isolatedWithMoment";
  String type_foundation3 = "isolated";
  String type_foundation4 = "isolated";
  String type_foundation5 = "isolated";
  var paint = new Paint();
  var textPaint = new Paint();
  var BarPaint = new Paint();
  TextEditingController textEditingControllerValue =
  new TextEditingController();
  bool design = true;

  @override
  void initState() {
    super.initState();
    mainFoundation.textEditingController.text = type_foundation0;
    mainFoundation.type_foundation = type_foundation0;
    paint.strokeWidth = 2;
    paint.color = color.gray;
    paint.isAntiAlias = true;
    paint.style = PaintingStyle.stroke;

    textPaint.strokeWidth = 1;
    textPaint.color = color.red;
    textPaint.isAntiAlias = true;
    textPaint.style = PaintingStyle.fill;

    BarPaint.strokeWidth = 2;
    BarPaint.color = color.red;
    BarPaint.isAntiAlias = true;
    BarPaint.style = PaintingStyle.fill;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor:
            color.gray, //This will change the drawer background to blue.
            //other styles
          ),
          child: Container(
            width: 200,
            child: Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _row('P (Ton)', mainFoundation.pForce, _selectValuPForce),
                  _row('DF (cm)', mainFoundation.Df, _selectValuDF),
                  _row('a (cm)', mainFoundation.a_long, _selectValua),
                  _row('b (cm)', mainFoundation.b_width, _selectValub),
                  _row('A (cm)', mainFoundation.A_long, _selectValuA),
                  _row('B (cm)', mainFoundation.B_width, _selectValuB),
                  _row('H (cm)', mainFoundation.H, _selectValuH),
                ],
              ),
            ),
          ),
        ),
        appBar: _appBar(),
        body: Column(
          children: <Widget>[
            new Container(
                width: double.infinity,
                height: 70,
                color: color.gray,
                child: _listViewHorisental()),
            _desqription(),
            _button(),
            //_rowUserProperty(),
            new Expanded(
              child: new Container(
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    _stacImage(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  _appBar() {
    return AppBar(
      title: _header(AppLocalizations.of(context).translate('foundation')),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        /*SvgPicture.asset(
          'assets/code_image/save.svg',
          fit: BoxFit.contain,
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            'assets/main_image/filtertrans.svg',
            fit: BoxFit.contain,
          ),
        ),
        */
        PopupMenuButton<String>(
          onSelected: choiceAction,
          itemBuilder: (BuildContext context) {
            return Constants.choices.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(
                  choice,
                  style: Theme
                      .of(context)
                      .textTheme
                      .display1,
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.properties) {
      _scaffoldKey.currentState.openEndDrawer();
    } else if (choice == Constants.Material) {
      _showSetting();
    } else if (choice == Constants.SignOut) {
      print('SignOut');
    }
  }

  _header(String title) {
    return Container(
      height: 50,
      color: color.red,
      //padding: EdgeInsets.only(left: 7,right: 7),
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
            margin: EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: Theme
                  .of(context)
                  .textTheme
                  .headline,
            ),
          )
        ],
      ),
    );
  }

  List<ListItem> list = [
    new ListItem(color.White, 'assets/code_image/icon_ir.svg'),
    new ListItem(color.gray, 'assets/code_image/icon_u.svg'),
    new ListItem(color.gray, 'assets/code_image/icon_t.svg'),
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
      onTap: () =>
          setState(() {
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
    list[3].assetsImage = 'assets/code_image/icon_l.svg';
    list[4].assetsImage = 'assets/code_image/icon_circle.svg';
    list[5].assetsImage = 'assets/code_image/icon_square.svg';
    switch (selct) {
      case 0:
        mainFoundation.type_foundation = type_foundation0;
        list[0].assetsImage = 'assets/code_image/icon_ir.svg';
        break;
      case 1:
        mainFoundation.type_foundation = type_foundation1;
        list[1].assetsImage = 'assets/code_image/icon_ur.svg';
        break;
      case 2:
        mainFoundation.type_foundation = type_foundation2;
        list[2].assetsImage = 'assets/code_image/icon_tr.svg';
        break;
      case 3:
        mainFoundation.type_foundation = type_foundation3;
        list[3].assetsImage = 'assets/code_image/icon_lr.svg';
        break;
      case 4:
        mainFoundation.type_foundation = type_foundation4;
        list[4].assetsImage = 'assets/code_image/icon_circler.svg';
        break;
      case 5:
        mainFoundation.type_foundation = type_foundation5;
        list[5].assetsImage = 'assets/code_image/icon_squarr.svg';
        break;
    }
    list[selct].color = color.White;
  }

  _desqription() {
    return Container(
      width: double.infinity,
      color: color.WhiteSelver,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 7),
      child: TextField(
        controller: mainFoundation.textEditingController,
        textAlign: TextAlign.center,
        style: Theme
            .of(context)
            .textTheme
            .display2
            .copyWith(
            fontSize: 25, fontFamily: 'SegoeUI_Light', color: color.black),
        decoration: InputDecoration(
          focusColor: color.red,
          hoverColor: color.red,
          labelText: AppLocalizations.of(context).translate('description'),
          labelStyle: Theme
              .of(context)
              .textTheme
              .display1
              .copyWith(fontSize: 20, color: color.red),
        ),
      ),
    );
  }

  _stacImage() {
    if (mainFoundation.type_foundation == type_foundation0) {
      return Stack(
        children: <Widget>[
          new Positioned.fill(
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              color: color.White,
              child: CustomPaint(
                painter: draw_IsolatedFoundation(context, paint, textPaint),
              ),
            ),
          ),
        ],
      );
    }
  }

  _button() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Center(
            child: Switch(
              value: design,
              hoverColor: color.red,
              activeTrackColor: color.red,
              onChanged: (value) {
                setState(() {
                  design = value;
                });
              },
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Center(
            child: RaisedButton(
              textColor: color.White,
              color: color.red,
              child: design ? Text(
                AppLocalizations.of(context).translate('design'),
                style: Theme
                    .of(context)
                    .textTheme
                    .headline,
              ) : Text(
                AppLocalizations.of(context).translate('check'),
                style: Theme
                    .of(context)
                    .textTheme
                    .headline,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Results()));
                design_foundations design = new design_foundations(
                    mainFoundation.type_foundation,
                    mainFoundation.pForce,
                    mainFoundation.H,
                    mainFoundation.Df,
                    mainFoundation.A_long,
                    mainFoundation.B_width,
                    mainFoundation.a_long,
                    mainFoundation.b_width,
                    mainFoundation.fc,
                    mainFoundation.Fy,
                    mainFoundation.gamaC,
                    mainFoundation.gamaS,
                    mainFoundation.qa);
                design.design();
              },
            ),
          ),
        ),
      ],
    );
  }

  _row(String text, double value, click()) {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: color.red, width: 1),
        color: color.gray,
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 5),
              child: Text(
                text,
                style: Theme
                    .of(context)
                    .textTheme
                    .display1
                    .copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: color.White),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5),
                child: OutlineButton(
                  borderSide: BorderSide(width: 2, color: color.White),
                  child: Text(
                    '$value',
                    style: Theme
                        .of(context)
                        .textTheme
                        .display1
                        .copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: color.White),
                  ),
                  onPressed: () {
                    setState(() {
                      click();
                    });
                  },
                )),
          )
        ],
      ),
    );
  }

  editText1add(String string) {
    textEditingControllerValue.text += string;
  }

  _1clickClear() {
    textEditingControllerValue.text = "";
  }

  _1clickBack() {
    String s = textEditingControllerValue.text;
    if (s.length == 0) return;
    textEditingControllerValue.text = (s.substring(0, s.length - 1));
  }

  _1clickPoint() {
    String s = ".";
    editText1add(s);
  }

  _1click0() {
    String s = "0";
    editText1add(s);
  }

  _1click1() {
    String s = "1";
    editText1add(s);
  }

  _1click2() {
    String s = "2";
    editText1add(s);
  }

  _1click3() {
    String s = "3";
    editText1add(s);
  }

  _1click4() {
    String s = "4";
    editText1add(s);
  }

  _1click5() {
    String s = "5";
    editText1add(s);
  }

  _1click6() {
    String s = "6";
    editText1add(s);
  }

  _1click7() {
    String s = "7";
    editText1add(s);
  }

  _1click8() {
    String s = "8";
    editText1add(s);
  }

  _1click9() {
    String s = "9";
    editText1add(s);
  }

  String boolValue = '';

  _1clickOk() {
    setState(() {
      Navigator.pop(context);
      if (boolValue == 'pForce') {
        mainFoundation.pForce = double.parse(textEditingControllerValue.text);
      } else if (boolValue == 'DF') {
        mainFoundation.Df = double.parse(textEditingControllerValue.text);
      } else if (boolValue == 'A') {
        mainFoundation.A_long = double.parse(textEditingControllerValue.text);
      } else if (boolValue == 'B') {
        mainFoundation.B_width = double.parse(textEditingControllerValue.text);
      } else if (boolValue == 'a') {
        mainFoundation.a_long = double.parse(textEditingControllerValue.text);
      } else if (boolValue == 'b') {
        mainFoundation.b_width = double.parse(textEditingControllerValue.text);
      } else if (boolValue == 'H') {
        mainFoundation.H = double.parse(textEditingControllerValue.text);
      } else if (boolValue == 'ɤc') {
        mainFoundation.gamaC = double.parse(textEditingControllerValue.text);
        Navigator.pop(context);
        _showSetting();
      } else if (boolValue == 'ɤs') {
        mainFoundation.gamaS = double.parse(textEditingControllerValue.text);
        Navigator.pop(context);
        _showSetting();
      } else if (boolValue == 'fy') {
        mainFoundation.Fy = double.parse(textEditingControllerValue.text);
        Navigator.pop(context);
        _showSetting();
      } else if (boolValue == 'fc') {
        mainFoundation.fc = double.parse(textEditingControllerValue.text);
        Navigator.pop(context);
        _showSetting();
      } else if (boolValue == 'qa') {
        mainFoundation.qa = double.parse(textEditingControllerValue.text);
        Navigator.pop(context);
        _showSetting();
      }
      //  Navigator.pop(context);
    });
  }

  _raisedBottunSelver(double width, double height) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[color.Whitegray, color.Whitegray],
          ),
          borderRadius: BorderRadius.all(Radius.circular(0)),
          border: Border.all(color: color.black, width: 1),
        ),
      ),
    );
  }

  _raisedBottunred(double width, double height, String text, click()) {
    return GestureDetector(
        child: Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[color.red, color.red],
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: color.black, width: 1),
            ),
            child: Text(text,
                style: Theme
                    .of(context)
                    .textTheme
                    .headline
                    .copyWith(fontSize: 25))),
        onTap: () {
          setState(() {
            click();
          });
        });
  }

  _raisedBottun(double width, double height, String text, click()) {
    return GestureDetector(
        child: Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[color.White, color.White, color.WhiteSelver],
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: color.black, width: 1),
            ),
            child: Text(text,
                style: Theme
                    .of(context)
                    .textTheme
                    .display3
                    .copyWith(fontSize: 22))),
        onTap: () {
          setState(() {
            click();
          });
        });
  }

  _selectValue(String title) {
    double hieght = 40;
    Widget _popupBody() {
      return Container(
          width: double.infinity,
          height: double.infinity,
          color: color.red,
          //padding: EdgeInsets.all(3),
          child: Column(
            children: <Widget>[
              Container(
                height: 35,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 15),
                        child: Text(
                          title,
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1
                              .copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 5),
                          child: CloseButton()),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(1),
                  color: color.gray,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextField(
                        controller: textEditingControllerValue,
                        readOnly: true,
                        onChanged: (String s) {
                          setState(() {});
                        },
                        style: Theme
                            .of(context)
                            .textTheme
                            .display1,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: color.White,
                          contentPadding: const EdgeInsets.only(left: 7),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: color.gray, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: _raisedBottun(
                                double.infinity, hieght, '7', _1click7),
                          ),
                          Flexible(
                            flex: 1,
                            child: _raisedBottun(
                                double.infinity, hieght, '8', _1click8),
                          ),
                          Flexible(
                            flex: 1,
                            child: _raisedBottun(
                                double.infinity, hieght, '9', _1click9),
                          ),
                          Flexible(
                            flex: 1,
                            child: _raisedBottunred(
                                double.infinity, hieght, '<', _1clickBack),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: _raisedBottun(
                                double.infinity, hieght, '4', _1click4),
                          ),
                          Flexible(
                            flex: 1,
                            child: _raisedBottun(
                                double.infinity, hieght, '5', _1click5),
                          ),
                          Flexible(
                            flex: 1,
                            child: _raisedBottun(
                                double.infinity, hieght, '6', _1click6),
                          ),
                          Flexible(
                            flex: 1,
                            child: _raisedBottunred(
                                double.infinity, hieght, 'C', _1clickClear),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: _raisedBottun(
                                double.infinity, hieght, '1', _1click1),
                          ),
                          Flexible(
                            flex: 1,
                            child: _raisedBottun(
                                double.infinity, hieght, '2', _1click2),
                          ),
                          Flexible(
                            flex: 1,
                            child: _raisedBottun(
                                double.infinity, hieght, '3', _1click3),
                          ),
                          Flexible(
                            flex: 1,
                            child: _raisedBottunSelver(double.infinity, hieght),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: _raisedBottun(
                                double.infinity, hieght, '0', _1click0),
                          ),
                          Flexible(
                            flex: 1,
                            child: _raisedBottun(
                                double.infinity, hieght, '.', _1clickPoint),
                          ),
                          Flexible(
                            flex: 1,
                            child: _raisedBottunSelver(double.infinity, hieght),
                          ),
                          Flexible(
                            flex: 1,
                            child: _raisedBottunred(
                                double.infinity,
                                hieght,
                                AppLocalizations.of(context).translate('ok'),
                                _1clickOk),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ));
    }

    _showPopupCenter(context, _popupBody(), 'setting');
  }

  _selectValuPForce() {
    boolValue = 'pForce';
    textEditingControllerValue.text = mainFoundation.pForce.toString();
    _selectValue('P(Ton)');
  }

  _selectValuA() {
    boolValue = 'A';
    textEditingControllerValue.text = mainFoundation.A_long.toString();
    _selectValue('A (cm)');
  }

  _selectValua() {
    boolValue = 'a';
    textEditingControllerValue.text = mainFoundation.a_long.toString();
    _selectValue('a (cm)');
  }

  _selectValuB() {
    boolValue = 'B';
    textEditingControllerValue.text = mainFoundation.B_width.toString();
    _selectValue('B (cm)');
  }

  _selectValub() {
    boolValue = 'b';
    textEditingControllerValue.text = mainFoundation.B_width.toString();
    _selectValue('b (cm)');
  }

  _selectValuH() {
    boolValue = 'H';
    textEditingControllerValue.text = mainFoundation.H.toString();
    _selectValue('H (cm)');
  }

  _selectValuDF() {
    boolValue = 'DF';
    textEditingControllerValue.text = mainFoundation.H.toString();
    _selectValue('DF (cm)');
  }

  _selectValuGamaC() {
    boolValue = 'ɤc';
    textEditingControllerValue.text = mainFoundation.gamaC.toString();
    _selectValue('ɤc (Ton/m³)');
  }

  _selectValuGamaS() {
    boolValue = 'ɤs';
    textEditingControllerValue.text = mainFoundation.gamaS.toString();
    _selectValue('ɤs (Ton/m³)');
  }

  _selectValuFc() {
    boolValue = 'fc';
    textEditingControllerValue.text = mainFoundation.fc.toString();
    _selectValue('Fَc (Kg/cm²)');
  }

  _selectValuFy() {
    boolValue = 'fy';
    textEditingControllerValue.text = mainFoundation.Fy.toString();
    _selectValue('Fy (Kg/cm²)');
  }

  _selectValuqa() {
    boolValue = 'qa';
    textEditingControllerValue.text = mainFoundation.qa.toString();
    _selectValue('qa (Kg/cm²)');
  }


  _showSetting() {
    row(String text, double value, click()) {
      return Container(
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          border: Border.all(color: color.gray, width: 1),
          color: color.White,
        ),
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  text,
                  style: Theme
                      .of(context)
                      .textTheme
                      .display1
                      .copyWith(fontSize: 20, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 5),
                  child: OutlineButton(
                    borderSide: BorderSide(width: 2, color: color.black),
                    child: Text(
                      '$value',
                      style: Theme
                          .of(context)
                          .textTheme
                          .display1
                          .copyWith(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    onPressed: () {
                      setState(() {
                        click();
                      });
                    },
                  )),
            )
          ],
        ),
      );
    }

    Widget _popupBody() {
      return Container(
          width: double.infinity,
          height: double.infinity,
          color: color.red,
          padding: EdgeInsets.all(3),
          child: Column(
            children: <Widget>[
              Container(
                height: 35,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 15),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('material_properties'),
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1
                              .copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 5),
                          child: CloseButton()),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    color: color.gray,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          color: color.gray,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            AppLocalizations.of(context).translate('concrete'),
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline
                                .copyWith(fontSize: 18),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                row('Fَc (Kg / cm²)', mainFoundation.fc,
                                    _selectValuFc),
                                row('ɤc (Ton/m³)', mainFoundation.gamaC,
                                    _selectValuGamaC),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: color.gray,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            AppLocalizations.of(context).translate('soil'),
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline
                                .copyWith(fontSize: 18),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                row('qa (Kg / cm²)', mainFoundation.qa,
                                    _selectValuqa),
                                row('ɤs (Ton/m³)', mainFoundation.gamaS,
                                    _selectValuGamaS),
                              ],
                            ),
                          ),
                        ), //reinforcement
                        Container(
                          width: double.infinity,
                          color: color.gray,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('reinforcement'),
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline
                                .copyWith(fontSize: 18),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                row('Fy (Kg/cm²)', mainFoundation.Fy,
                                    _selectValuFy),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ));
    }

    _showPopupRight(context, _popupBody(), 'setting');
  }

  _showPopupCenter(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: 20,
        left: max(30, (MediaQuery
            .of(context)
            .size
            .width - 300) / 2),
        right: max(30, (MediaQuery
            .of(context)
            .size
            .width - 300) / 2),
        bottom: max(40, (MediaQuery
            .of(context)
            .size
            .height - 320)),
        child: PopupContent(
          content: Scaffold(
            appBar: null,
            resizeToAvoidBottomPadding: false,
            body: widget,
          ),
        ),
      ),
    );
  }

  _showPopupRight(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: 40,
        left: 70,
        right: 3,
        bottom: max(10, MediaQuery
            .of(context)
            .size
            .height - 570),
        child: PopupContent(
          content: Scaffold(
            appBar: null,
            resizeToAvoidBottomPadding: false,
            body: widget,
          ),
        ),
      ),
    );
  }

  static _drawDimention(Canvas c, double teta, double Xstart, double Ystart,
      double Xend, double Yend, Paint paint, String s, Paint paintText) {
    //rect_lenght = rect_Hlenght = rect_Vlenght_reight = rect_Vlenght_left = rect_Dlenght = rect_radus = rect_lip = new Rect.fromLTRB();
    TextStyle textStyle = new TextStyle(
        fontSize: 20, color: paintText.color, fontWeight: FontWeight.normal);
    Offset start = new Offset(Xstart, Ystart);
    Offset end = new Offset(Xend, Yend);
    if (start.dx == end.dx && start.dy == end.dy) {
      return;
    }
    int ca = 5;
    TextSpan span = new TextSpan(style: textStyle, text: s);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    if (start.dx == end.dx) {
      c.drawLine(Offset(start.dx + ca, start.dy),
          Offset(start.dx - ca, start.dy), paint);
      c.drawLine(
          Offset(end.dx + ca, end.dy), Offset(end.dx - ca, end.dy), paint);
      c.translate((end.dx + start.dx) / 2, (end.dy + start.dy) / 2);
      c.rotate(3 * pi / 2);
      if (start.dy > end.dy) {
        tp.paint(
            c,
            new Offset(0 - tp.width / 2,
                0 /*start.dx - tp.width / 2,
                (start.dy + end.dy).abs() / 2 + tp.height + ca*/
            ));
        /* rect_Vlenght_reight = new Rect.fromLTRB(
            (start.dx),
            (start.dy + end.dy).abs() / 2 - tp.width / 2 - ca,
            start.dx + tp.height + 1 * ca,
            (start.dy + end.dy).abs() / 2 + tp.width / 2 + ca);*/
      } else {
        tp.paint(c, new Offset(0 - tp.width / 2, 0.0 - tp.height));
        /*rect_Vlenght_left = new Rect.fromLTRB(
            start.dx - (tp.height + 1 * ca),
            (start.dy + end.dy).abs() / 2 - tp.width / 2 - ca,
            start.dx,
            (start.dy + end.dy).abs() / 2 + tp.width / 2 + ca);*/
      }
      c.rotate(-3 * pi / 2);
      c.translate(-(end.dx + start.dx) / 2, -(end.dy + start.dy) / 2);
    } else if (start.dy == end.dy) {
      c.drawLine(Offset(start.dx, start.dy - ca),
          Offset(start.dx, start.dy + ca), paint);
      c.drawLine(
          Offset(end.dx, end.dy - ca), Offset(end.dx, end.dy + ca), paint);
      if (start.dx < end.dx) {
        tp.paint(c,
            new Offset((end.dx + start.dx) / 2 - tp.width / 2, start.dy + ca));
        /*rect_lenght = new Rect.fromLTRB(
            (end.dx + start.dx) / 2 - tp.width / 2 - ca,
            start.dy,
            (end.dx + start.dx) / 2 + tp.width / 2 + ca,
            start.dy + tp.height + ca * 2);*/
      } else {
        tp.paint(
            c,
            new Offset((end.dx + start.dx) / 2 - tp.width / 2,
                start.dy - 0 - tp.height));
      }
    } else {
      double cosTeta = sin((teta));
      double sinTeta = cos((teta));
      c.drawLine(Offset(start.dx - ca * cosTeta, start.dy + ca * sinTeta),
          Offset(start.dx + ca * cosTeta, start.dy - ca * sinTeta), paint);
      c.drawLine(Offset(end.dx - ca * cosTeta, end.dy + ca * sinTeta),
          Offset(end.dx + ca * cosTeta, end.dy - ca * sinTeta), paint);
      c.translate((end.dx + start.dx) / 2, (end.dy + start.dy) / 2);
      c.rotate(teta);
      tp.paint(c, new Offset(0 - tp.width / 2, 0.0 - tp.height));
      c.rotate(-teta);
      c.translate(-(end.dx + start.dx) / 2, -(end.dy + start.dy) / 2);
      /*if (start.dx > end.dx)
        rect_Dlenght = new Rect.fromLTRB(
            (end.dx + start.dx) / 2 - (tp.width / 2 + ca),
            (end.dy + start.dy) / 2 - (0 * ca + tp.height),
            (end.dx + start.dx) / 2 + (tp.width / 2 + ca),
            (end.dy + start.dy) / 2);
      else
        rect_DlenghtReight = new Rect.fromLTRB(
            (end.dx + start.dx) / 2 - (tp.width / 2 + ca),
            (end.dy + start.dy) / 2 - (0 * ca + tp.height),
            (end.dx + start.dx) / 2 + (tp.width / 2 + ca),
            (end.dy + start.dy) / 2);*/
      /*if (Dlenghtb_left && start.dx > end.dx) {
        c.translate((end.dx + start.dx) / 2, (end.dy + start.dy) / 2);
        c.rotate(teta);
        rect_Dlenght = new Rect.fromLTRB(
            0 - (tp.width / 2 + ca),
            0 - (0 * ca + tp.height),
            0 + (tp.width / 2 + ca),
            0);
        c.drawRect(rect_Dlenght, paintText);
        c.rotate(-teta);
        c.translate(-(end.dx + start.dx) / 2, -(end.dy + start.dy) / 2);
      } else if (Dlenghtb_reight && start.dx < end.dx) {
        c.translate((end.dx + start.dx) / 2, (end.dy + start.dy) / 2);
        c.rotate(-2 * pi + teta);
        rect_DlenghtReight = new Rect.fromLTRB(
            0 - (tp.width / 2 + ca),
            0 - (0 * ca + tp.height),
            0 + (tp.width / 2 + ca),
            0);
        c.drawRect(rect_DlenghtReight, paintText);
        c.rotate(2 * pi - teta);
        c.translate(-(end.dx + start.dx) / 2, -(end.dy + start.dy) / 2);
      }
    }
    c.drawLine(Offset(start.dx, start.dy), Offset(end.dx, end.dy), paint);
    if (lenghtb) {
      c.drawRect(rect_lenght, paintText);
    } else if (Vlenght_reightb) {
      c.drawRect(rect_Vlenght_reight, paintText);
    } else if (Vlenght_leftb) {
      c.drawRect(rect_Vlenght_left, paintText);
    } else if (Hlenghtb) {
      c.drawRect(rect_Hlenght, paintText);
    } else if (Hlenght2b) {
      c.drawRect(rect_Hlenght2, paintText);
    } else if (Dlenghtb_left) {}
*/
    }
    c.drawLine(start, end, paint);
  }

  static _drawArrowForce(Canvas canvas, Offset point, Paint textPaint,
      double height, String textP) {
    List<Offset> pForce = new List(4);
    int ca = 10;
    pForce[0] = new Offset(point.dx, point.dy);
    pForce[1] = new Offset(pForce[0].dx - ca, pForce[0].dy - ca);
    pForce[2] = new Offset(pForce[0].dx + ca, pForce[0].dy - ca);
    pForce[3] = new Offset(pForce[1].dx + ca, pForce[1].dy - height / 2);
    canvas.drawLine(pForce[0], pForce[3], textPaint);
    Path path = new Path();
    path.moveTo(pForce[1].dx, pForce[1].dy);
    path.lineTo(pForce[0].dx, pForce[0].dy);
    path.lineTo(pForce[2].dx, pForce[2].dy);
    path.close();
    canvas.drawPath(path, textPaint);
    TextStyle textStyle = new TextStyle(
        fontSize: 20, color: textPaint.color, fontWeight: FontWeight.normal);
    TextSpan span = new TextSpan(style: textStyle, text: textP);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(pForce[3].dx + 2, pForce[3].dy));
  }
}

class Constants {
  static const String Material = 'Material';
  static const String properties = 'Values';
  static const String SignOut = 'Sign out';

  static const List<String> choices = <String>[
    Material,
    properties,
  ];
  static BuildContext context;
}

class ListItem {
  String assetsImage;
  Color color;

  ListItem(this.color, this.assetsImage);
}

class draw_IsolatedFoundation extends CustomPainter {
  Paint paint0, textPaint;
  BuildContext context;
  bool withMoment = false;

  draw_IsolatedFoundation(this.context, this.paint0, this.textPaint,
      {this.withMoment});

  @override
  void paint(Canvas canvas, Size size) {
    double P = mainFoundation.pForce; //ton
    double height = mainFoundation.H;
    double B_width = mainFoundation.B_width;
    double A_long = mainFoundation.A_long;
    double b_width = mainFoundation.b_width;
    double a_long = mainFoundation.a_long;
    double space = 50;
    double scale = min(size.width * 0.9 / (A_long + 30 + space*2),
        size.height * 0.9 / (30 + 4 * height / 2 + space + B_width));
    height *= scale;
    B_width *= scale;
    A_long *= scale;
    b_width *= scale;
    a_long *= scale;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    List<Offset> point = new List(12);
    point[0] = new Offset(centerX - A_long / 2, centerY - space / 2);
    point[1] = new Offset(point[0].dx + A_long, point[0].dy);
    point[2] = new Offset(point[1].dx, point[1].dy - height);
    point[3] = new Offset(point[2].dx - (A_long - a_long) / 2, point[2].dy);
    point[4] = new Offset(point[3].dx, point[3].dy - height / 2);
    point[5] = new Offset(point[4].dx - a_long, point[4].dy);
    point[6] = new Offset(point[5].dx, point[3].dy);
    point[7] = new Offset(point[0].dx, point[3].dy);
    point[8] = new Offset(point[0].dx, centerY + space / 2);
    point[9] = new Offset(point[1].dx, point[8].dy);
    point[10] = new Offset(point[9].dx, point[8].dy + B_width);
    point[11] = new Offset(point[8].dx, point[8].dy + B_width);

    List<Offset> pointDf = new List(5);
    pointDf[0] = new Offset(point[7].dx - 15, point[7].dy - height / 2);
    pointDf[1] = new Offset(pointDf[0].dx - space, pointDf[0].dy);
    pointDf[4] = new Offset(pointDf[0].dx, point[0].dy);
    pointDf[2] = new Offset(point[2].dx + 15, pointDf[0].dy);
    pointDf[3] = new Offset(pointDf[2].dx + space, pointDf[0].dy);


    //paint0.strokeWidth = 3;
    for (int i = 0; i < 4; i++) {
      canvas.drawLine(point[i], point[i + 1], paint0);
    }
    for (int i = 5; i < 7; i++) {
      canvas.drawLine(point[i], point[i + 1], paint0);
    }
    canvas.drawLine(point[0], point[7], paint0);
    Rect rect =
    new Rect.fromLTRB(point[8].dx, point[8].dy, point[9].dx, point[10].dy);
    canvas.drawRect(rect, paint0);
    Offset centerColumn = new Offset(centerX, point[8].dy + B_width / 2);
    rect = new Rect.fromLTRB(
        centerColumn.dx - a_long / 2,
        centerColumn.dy - b_width / 2,
        centerColumn.dx + a_long / 2,
        centerColumn.dy + b_width / 2);
    canvas.drawRect(rect, textPaint);

    canvas.drawLine(pointDf[0], pointDf[1], paint0);
    canvas.drawLine(pointDf[2], pointDf[3], paint0);
    int hatch = 5;
    for (int i = 0; i < space / hatch; i++) {
      canvas.drawLine(
          Offset(pointDf[1].dx + hatch * (i), pointDf[1].dy + hatch),
          Offset(pointDf[1].dx + hatch * (i + 1), pointDf[1].dy), paint0);
    }
    for (int i = 0; i < space / hatch; i++) {
      canvas.drawLine(
          Offset(pointDf[2].dx + hatch * (i), pointDf[2].dy + hatch),
          Offset(pointDf[2].dx + hatch * (i + 1), pointDf[2].dy), paint0);
    }

    String A = 'A';
    String B = 'B';
    String a = 'a';
    String b = 'b';
    String H = 'H';
    String Df = 'DF';
    _mainFoundationState._drawDimention(
        canvas,
        pi / 2,
        pointDf[0].dx,
        pointDf[0].dy,
        pointDf[4].dx,
        pointDf[4].dy,
        textPaint,
        Df,
        textPaint);
    String textP = 'P = $P Ton';
    textPaint.strokeWidth = 1;
    double tCoverRieght = 5 * scale;
    double diameterReiBar = 1.4 * scale * 2;
    int numbreBar = (A_long / (20 * scale)).round();
    double d_barLips =
        (A_long - numbreBar * diameterReiBar - 2 * tCoverRieght) /
            (numbreBar - 1);
    rect = new Rect.fromLTRB(
        point[7].dx + tCoverRieght,
        point[7].dy + tCoverRieght,
        point[2].dx - tCoverRieght,
        point[0].dy - tCoverRieght);
    textPaint.style = PaintingStyle.stroke;
    canvas.drawRect(rect, textPaint);
    textPaint.style = PaintingStyle.fill;

    Offset pR = new Offset(point[0].dx + tCoverRieght + diameterReiBar / 2,
        point[0].dy - tCoverRieght - diameterReiBar / 2);
    for (int i = 0; i < numbreBar; i++) {
      canvas.drawCircle(pR, diameterReiBar / 2, textPaint);
      pR = new Offset(pR.dx + d_barLips + diameterReiBar, pR.dy);
    }

    int paddingDimention =
    min((size.width / 20).round(), (size.height / 20).round());
    paddingDimention = 10;
    _mainFoundationState._drawDimention(
        canvas,
        pi / 2,
        point[1].dx + paddingDimention,
        point[1].dy,
        point[2].dx + paddingDimention,
        point[2].dy,
        textPaint,
        H,
        textPaint);
    _mainFoundationState._drawDimention(
        canvas,
        pi / 2,
        point[9].dx,
        point[9].dy - paddingDimention,
        point[8].dx,
        point[8].dy - paddingDimention,
        textPaint,
        A,
        textPaint);
    _mainFoundationState._drawDimention(
        canvas,
        pi / 2,
        point[8].dx - paddingDimention,
        point[8].dy,
        point[11].dx - paddingDimention,
        point[11].dy,
        textPaint,
        B,
        textPaint);
    /*_mainFoundationState._drawDimention(canvas, pi/2, point[9].dx, point[9].dy-paddingDimention,point[8].dx, point[8].dy-paddingDimention, paint0, A, paint0);
    _mainFoundationState._drawDimention(canvas, pi/2, point[8].dx - paddingDimention, point[8].dy ,point[11].dx - paddingDimention, point[11].dy, paint0, B, paint0);
    */
    _mainFoundationState._drawDimention(
        canvas,
        pi / 2,
        centerColumn.dx + a_long / 2,
        centerColumn.dy - b_width / 2 - paddingDimention,
        centerColumn.dx - a_long / 2,
        centerColumn.dy - b_width / 2 - paddingDimention,
        paint0,
        a,
        paint0);
    _mainFoundationState._drawDimention(
        canvas,
        pi / 2,
        centerColumn.dx - a_long / 2 - paddingDimention,
        centerColumn.dy - b_width / 2,
        centerColumn.dx - a_long / 2 - paddingDimention,
        centerColumn.dy + b_width / 2,
        paint0,
        b,
        paint0);
    Offset pForce = new Offset(centerX, point[4].dy);
    _mainFoundationState._drawArrowForce(
        canvas, pForce, textPaint, height, textP);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
