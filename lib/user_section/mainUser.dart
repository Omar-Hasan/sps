import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stahl_section/cold_formed_section/mainCold.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/standard_sction/mainCode.dart';
import 'package:stahl_section/translate/app_localizations.dart';
import 'package:ruler_picker/ruler_picker.dart';
import 'package:stahl_section/user_section/details.dart';
import 'package:stahl_section/welded_section/weldMain.dart';

class mainUser extends StatefulWidget {
  @override
  _State createState() => _State();
  static String x_section = "I_section";
  static String imageDetails = 'assets/code_image/details_ipn';
  static final myController = TextEditingController();
  static final hController = TextEditingController();
  static final bController = TextEditingController();
  static final tfController = TextEditingController();
  static final twController = TextEditingController();
  static final rController = TextEditingController();
}

class _State extends State<mainUser> {
  String tw, tf, h, b, r;
  bool h_FocusNode;
  bool b_FocusNode;
  bool tw_FocusNode;
  bool tf_FocusNode;
  bool r_FocusNode;

  RulerPickerController _rulerPickerController;
  TextEditingController _textEditingController;
  num showValue = 0;


  @override
  void initState() {
    super.initState();
    mainUser.myController.text = ('User-Section');
    mainUser.hController.text = ('400');
    mainUser.bController.text = ('180');
    mainUser.tfController.text = ('13.5');
    mainUser.twController.text = ('8.6');
    mainUser.rController.text = ('21');
    mainUser.x_section = "I_section";
    _rulerPickerController = RulerPickerController(value: 0);
    _textEditingController = TextEditingController(text: '10');
    tw = 'tw';
    tf = 'tf';
    h = 'h';
    b = 'b';
    r = 'r';
    h_FocusNode = false;
    b_FocusNode = false;
    tw_FocusNode = false;
    tf_FocusNode = false;
    r_FocusNode = true;
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
                      AppLocalizations.of(context).translate(
                          'coldFormedSection'),
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
                      AppLocalizations.of(context).translate('userSectiont')),
                  new Container(
                      width: double.infinity,
                      height: 70,
                      color: color.gray,
                      child: _listViewHorisental()),
                  _desqription(),
                  _rowUserProperty(),
                  new Expanded(
                    child: new Container(
                      width: double.infinity,
                      child: Stack(
                        children: <Widget>[
                          _stacImage(),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: new Container(
                                color: color.red,
                                height: 50,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: _rulerPicker(),
                              )),
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
                style: Theme
                    .of(context)
                    .textTheme
                    .headline,
              ),
            )
          ],
        ),
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
        mainUser.x_section = "I_section";
        list[0].assetsImage = 'assets/code_image/icon_ir.svg';
        break;
      case 1:
        mainUser.x_section = "U_section";
        list[1].assetsImage = 'assets/code_image/icon_ur.svg';
        break;
      case 2:
        mainUser.x_section = "T_section";
        list[2].assetsImage = 'assets/code_image/icon_tr.svg';
        break;
      case 3:
        mainUser.x_section = "L_section";
        list[3].assetsImage = 'assets/code_image/icon_lr.svg';
        break;
      case 4:
        mainUser.x_section = "circle_section";
        list[4].assetsImage = 'assets/code_image/icon_circler.svg';
        break;
      case 5:
        mainUser.x_section = "HolwRec_section";
        list[5].assetsImage = 'assets/code_image/icon_squarr.svg';
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
                          style: Theme
                              .of(context)
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
    if (text == AppLocalizations.of(context).translate('userSection')) {
      return;
    }
    Navigator.pop(context);
    if (text == AppLocalizations.of(context).translate('standardSection')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainCode()),
      );
      return;
    }
    else if (text ==
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

  _rowUserProperty() {
    return Container(
      margin: EdgeInsets.all(7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).translate('unit'),
            style: Theme
                .of(context)
                .textTheme
                .display2
                .copyWith(fontSize: 25, color: color.gray),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 7, right: 7, top: 3, bottom: 3),
            margin: EdgeInsets.only(
              left: 7,
              right: 7,
            ),
            child: Text(
              'mm',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline,
            ),
            decoration: BoxDecoration(
              color: color.gray,
              border: Border.all(color: color.black, width: 1),
              borderRadius:
              BorderRadius.all(Radius.circular(7.0)),
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
        controller: mainUser.myController,
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
          labelText: AppLocalizations.of(context).translate('desqribtion'),
          labelStyle: Theme
              .of(context)
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
          MaterialPageRoute(builder: (context) =>  details()),
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
                fontSize: 20.0, color: color.White, fontFamily: 'SegoeUI'),
          ),
        ),
      ),
    );
  }

  _stacImage() {
    String SvgAssets = 'assets/code_image/ipa_txt.svg';
    switch (mainUser.x_section) {
      case "I_section":
        {
          SvgAssets = 'assets/code_image/ipa_txt.svg';
          mainUser.imageDetails = 'assets/code_image/details_ipe.svg';
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
                child: _textFiled(
                    h_FocusNode,
                    mainUser.hController,
                    true,
                    h,
                    0,
                    0,
                    200,
                    0),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(
                    tw_FocusNode,
                    mainUser.twController,
                    false,
                    tw,
                    100,
                    0,
                    10,
                    0),
              ),
              Align(
                alignment: Alignment.topRight,
                child: _textFiled(
                    tf_FocusNode,
                    mainUser.tfController,
                    true,
                    tf,
                    0,
                    70,
                    0,
                    70),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(
                    r_FocusNode,
                    mainUser.rController,
                    false,
                    r,
                    100,
                    0,
                    0,
                    150),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: _textFiled(
                    b_FocusNode,
                    mainUser.bController,
                    false,
                    b,
                    0,
                    0,
                    15,
                    0),
              ),
            ],
          );
        }
        break;
      case "U_section":
        {
          SvgAssets = 'assets/code_image/u_txt.svg';
          mainUser.imageDetails = 'assets/code_image/details_u.svg';
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
                child: _textFiled(
                    h_FocusNode,
                    mainUser.hController,
                    true,
                    h,
                    0,
                    0,
                    0,
                    150),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(
                    tw_FocusNode,
                    mainUser.twController,
                    false,
                    tw,
                    0,
                    30,
                    0,
                    0),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: _textFiled(
                    tf_FocusNode,
                    mainUser.tfController,
                    true,
                    tf,
                    40,
                    0,
                    130,
                    0),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(
                    r_FocusNode,
                    mainUser.rController,
                    false,
                    r,
                    0.0,
                    25,
                    0,
                    200),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: _textFiled(
                    b_FocusNode,
                    mainUser.bController,
                    false,
                    b,
                    0,
                    0,
                    0,
                    0),
              ),
            ],
          );
        }
        break;
      case "T_section":
        {
          SvgAssets = 'assets/code_image/t_txt.svg';
          mainUser.imageDetails = 'assets/code_image/details_t.svg';
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
                child: _textFiled(
                    h_FocusNode,
                    mainUser.hController,
                    true,
                    h,
                    0,
                    0,
                    50,
                    0),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(
                    tw_FocusNode,
                    mainUser.twController,
                    false,
                    tw,
                    100,
                    0,
                    50,
                    0),
              ),
              Align(
                alignment: Alignment.topRight,
                child: _textFiled(
                    tf_FocusNode,
                    mainUser.tfController,
                    true,
                    tf,
                    0,
                    50,
                    70,
                    70),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _textFiled(
                    r_FocusNode,
                    mainUser.rController,
                    false,
                    r,
                    0.0,
                    120,
                    0,
                    80),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: _textFiled(
                    b_FocusNode,
                    mainUser.bController,
                    false,
                    b,
                    0,
                    0,
                    30,
                    0),
              ),
            ],
          );
        }
        break;
      case "L_section":
        {
          SvgAssets = 'assets/code_image/l_txt.svg';
          mainUser.imageDetails = 'assets/code_image/details_luq.svg';
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
                child: _textFiled(
                    h_FocusNode,
                    mainUser.hController,
                    true,
                    h,
                    0,
                    0,
                    120,
                    0),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(
                    tw_FocusNode,
                    mainUser.twController,
                    false,
                    tw,
                    0,
                    50,
                    0,
                    30),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(
                    r_FocusNode,
                    mainUser.rController,
                    false,
                    r,
                    0,
                    40,
                    70,
                    0),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: _textFiled(
                    tf_FocusNode,
                    mainUser.tfController,
                    false,
                    tf,
                    0,
                    40,
                    40,
                    0),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _textFiled(
                    b_FocusNode,
                    mainUser.bController,
                    false,
                    b,
                    0,
                    0,
                    0,
                    60),
              ),
            ],
          );
        }
        break;
      case "circle_section":
        {
          SvgAssets = 'assets/code_image/circle_txt.svg';
          mainUser.imageDetails = 'assets/code_image/details_c.svg';
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
                alignment: Alignment.center,
                child: _textFiled(
                    tw_FocusNode,
                    mainUser.twController,
                    false,
                    tw,
                    0,
                    70,
                    00,
                    50),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _textFiled(
                    b_FocusNode,
                    mainUser.bController,
                    false,
                    b,
                    0,
                    0,
                    0,
                    60),
              ),
            ],
          );
        }
        break;
      case "HolwRec_section":
        {
          SvgAssets = 'assets/code_image/rec_txt.svg';
          mainUser.imageDetails = 'assets/code_image/details_rec.svg';
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
                child: _textFiled(
                    h_FocusNode,
                    mainUser.hController,
                    true,
                    h,
                    40,
                    0,
                    100,
                    0),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFiled(
                    tw_FocusNode,
                    mainUser.twController,
                    false,
                    tw,
                    0,
                    20,
                    30,
                    0),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: _textFiled(
                    b_FocusNode,
                    mainUser.bController,
                    false,
                    b,
                    0,
                    0,
                    5,
                    0),
              ),
            ],
          );
        }
        break;
    }
  }

  _rulerPicker() {
    return RulerPicker(
      controller: _rulerPickerController,
      backgroundColor: color.red,
      onValueChange: (value) {
        setState(() {
          _textEditingController.text = value.toString();
          h_FocusNode ? mainUser.hController.text = _textEditingController.text :
          b_FocusNode ? mainUser.bController.text = _textEditingController.text :
          tw_FocusNode ?
          mainUser.twController.text = _textEditingController.text :
          tf_FocusNode ?
          mainUser.tfController.text = _textEditingController.text :
          mainUser.rController.text = _textEditingController.text;
        });
      },
      width: MediaQuery
          .of(context)
          .size
          .width,
    );
  }

  bool readOnly = true;

  _textFiled(bool focusNode, TextEditingController controller, bool vertical,
      String text, double mLeft, double mReight, double mTop, double mBottom) {
    double angle = 0;
    if (vertical) {
      angle = -90;
    }
    return Transform.rotate(
        angle: angle * pi / 180,
        child: GestureDetector(
          onDoubleTap: () => readOnly = false,
          child: Container(
            margin: EdgeInsets.only(
                left: mLeft, right: mReight, top: mTop, bottom: mBottom),
            width: 50,
            height: 44,
            alignment: Alignment.topCenter,
            child: TextField(
                showCursor: false,
                readOnly: readOnly,
                controller: controller,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                autofocus: false,
                textInputAction: TextInputAction.done,
                style: Theme
                    .of(context)
                    .textTheme
                    .display2,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: focusNode ? color.red : color.White,
                  hintText: text,
                  contentPadding: const EdgeInsets.only(left: 7),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: color.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onTap: () {
                  setState(() {
                    readOnly = true;
                    _setFoucus(controller);
                  });
                }),
          ),
        )

    );
  }


  _setFoucus(TextEditingController controller) {
    h_FocusNode = false;
    b_FocusNode = false;
    r_FocusNode = false;
    tw_FocusNode = false;
    tf_FocusNode = false;
    if (controller == mainUser.hController) {
      h_FocusNode = true;
      _rulerPickerController.value =
          (double.parse(mainUser.hController.text)).round();
    } else if (controller == mainUser.bController) {
      b_FocusNode = true;
      _rulerPickerController.value =
          double.parse(mainUser.bController.text).round();
    } else if (controller == mainUser.twController) {
      tw_FocusNode = true;
      _rulerPickerController.value =
          double.parse(mainUser.twController.text).round();
    } else if (controller == mainUser.tfController) {
      tf_FocusNode = true;
      _rulerPickerController.value =
          double.parse(mainUser.tfController.text).round();
    } else {
      r_FocusNode = true;
      _rulerPickerController.value =
          double.parse(mainUser.rController.text).round();
    }
  }

  }

class FirstDisabledFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}

class ListItem {
  String assetsImage;
  Color color;

  ListItem(this.color, this.assetsImage);
}
