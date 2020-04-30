import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ruler_picker/ruler_picker.dart';
import 'package:stahl_section/cold_formed_section/details.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/standard_sction/mainCode.dart';
import 'package:stahl_section/translate/app_localizations.dart';
import 'package:stahl_section/user_section/mainUser.dart';
import 'package:stahl_section/welded_section/weldMain.dart';

class mainCold extends StatefulWidget {
  @override
  _State createState() => _State();
  static TextEditingController myController = new TextEditingController();
  static String x_section = "I_section";
  static final hieghtController = TextEditingController();
  static final widthController = TextEditingController();
  static final radiusController = TextEditingController();
  static final tController = TextEditingController();
  static final h_lipController = TextEditingController();
  static final angleController = TextEditingController();
}
/* "z_with"
   "z_without"
   "u_without"
   "u_hat"
   "u_with"
   */

class _State extends State<mainCold> {
  GlobalKey imageKey;
  bool h_FocusNode;
  bool width_FocusNode;
  bool t_FocusNode;
  bool h_lip_FocusNode;
  bool angle_FocusNode;
  bool r_FocusNode;

  RulerPickerController _rulerPickerController;
  static TextEditingController _textEditingController;
  num showValue = 600;
  Rect rectFHeight,
      rectFHeight_lip = Rect.fromLTRB(0, 0, 0, 0),
      rectFWidth,
      rectFRaduis;

  static double height, width, thickness, raduis, h_lip = 0;
  static double scale_r =1;
  static double teta = pi / 2, tetaEave = 0;

  var paint = new Paint();
  var textPaint = new Paint();

  @override
  void initState() {
   // WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
    mainCold.myController.text = ('cold-formed');
    mainCold.x_section = "z_without";
    imageKey = GlobalKey();
    height = 600;
    width = 125;
    thickness = 4;
    raduis = 10;
    h_lip = 0;
    teta = pi / 2;
    mainCold.hieghtController.text = height.toString();
    mainCold.widthController.text = width.toString();
    mainCold.tController.text = thickness.toString();
    mainCold.h_lipController.text = h_lip.toString();
    mainCold.angleController.text = (teta * 180 / pi).toString();
    mainCold.radiusController.text = raduis.toString();
 /* mainCold.hieghtController.addListener(_refreshValue());
    mainCold.widthController.addListener(_refreshValue());
    mainCold.tController.addListener(_refreshValue());
    mainCold.h_lipController.addListener(_refreshValue());
    mainCold.angleController.addListener(_refreshValue());
    mainCold.radiusController.addListener(_refreshValue());
   */ _rulerPickerController = RulerPickerController(value: 600);
    _textEditingController = TextEditingController(text: '10');
    h_FocusNode = true;
    width_FocusNode = false;
    t_FocusNode = false;
    h_lip_FocusNode = false;
    angle_FocusNode = false;
    r_FocusNode = false;

    paint.strokeWidth = 2;
    paint.color = color.red;
    paint.isAntiAlias = true;
    paint.style = PaintingStyle.stroke;

    textPaint.strokeWidth = 2;
    textPaint.color = color.red;
    textPaint.isAntiAlias = true;
    textPaint.style = PaintingStyle.stroke;

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
   // _rulerPickerController.value = 600;
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
                  _header(AppLocalizations.of(context)
                      .translate('coldFormedSection')),
                  new Center(
                    child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 70,
                        color: color.gray,
                        child: _listViewHorisental()),
                  ),
                  _desqription(),
                  _rowDimention(),
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
                                width: MediaQuery.of(context).size.width,
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
            Text(
              title,
              style: Theme.of(context).textTheme.headline,
            )
          ],
        ),
      ),
    );
  }

  List<ListItem> list = [
    new ListItem(color.WhiteSelver, 'assets/cold_image/icon_cold_zr.svg'),
    new ListItem(color.gray, 'assets/cold_image/icon_cold_zwith.svg'),
    new ListItem(color.gray, 'assets/cold_image/icon_cold_u.svg'),
    new ListItem(color.gray, 'assets/cold_image/icon_cold_uwith.svg'),
    new ListItem(color.gray, 'assets/cold_image/icon_cold_hat.svg'),
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
    list[0].assetsImage = 'assets/cold_image/icon_cold_z.svg';
    list[1].assetsImage = 'assets/cold_image/icon_cold_zwith.svg';
    list[2].assetsImage = 'assets/cold_image/icon_cold_u.svg';
    list[3].assetsImage = 'assets/cold_image/icon_cold_uwith.svg';
    list[4].assetsImage = 'assets/cold_image/icon_cold_hat.svg';
    switch (selct) {
      case 0:
        mainCold.angleController.text = "90";
        mainCold.h_lipController.text = "0";
        _refreshValue();
        withLip = false;
        mainCold.x_section = "z_without";
        list[0].assetsImage = 'assets/cold_image/icon_cold_zr.svg';
        break;
      case 1:
        mainCold.angleController.text = "135";
        mainCold.h_lipController.text = (height/7).round().toString();
        _refreshValue();
        withLip = true;
        mainCold.x_section = "z_with";
        list[1].assetsImage = 'assets/cold_image/icon_cold_zwithr.svg';
        break;
      case 2:
        mainCold.angleController.text = "90";
        mainCold.h_lipController.text = "0";
        _refreshValue();
        withLip = false;
        mainCold.x_section = "u_without";
        list[2].assetsImage = 'assets/cold_image/icon_cold_ur.svg';
        break;
      case 3:
        mainCold.angleController.text = "90";
        mainCold.h_lipController.text = (height/7).round().toString();
        _refreshValue();
        withLip = true;
        mainCold.x_section = "u_with";
        list[3].assetsImage = 'assets/cold_image/icon_cold_uwithr.svg';
        break;
      case 4:
        mainCold.angleController.text = "90";
        mainCold.h_lipController.text = (height/7).round().toString();
        _refreshValue();
        withLip = true;
        mainCold.x_section = "u_hat";
        list[4].assetsImage = 'assets/cold_image/icon_cold_hatr.svg';
        break;
    }
    list[selct].color = color.WhiteSelver;
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
    if (text == AppLocalizations.of(context).translate('coldFormedSection')) {
      return;
    }
    Navigator.pop(context);
    if (text == AppLocalizations.of(context).translate('standardSection')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainCode()),
      );
      return;
    } else if (text == AppLocalizations.of(context).translate('userSection')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainUser()),
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

  _desqription() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Container(
            height: 70,
            width: double.infinity,
            color: color.WhiteSelver,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 7),
            child: TextField(
              controller: mainCold.myController,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.display2.copyWith(
                    fontSize: 20,
                    fontFamily: 'SegoeUI_Light',
                    color: color.White,
                    backgroundColor: color.gray,
                  ),
              decoration: InputDecoration(
                focusColor: color.red,
                hoverColor: color.red,
                labelText:
                    AppLocalizations.of(context).translate('desqribtion'),
                labelStyle: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(fontSize: 18, color: color.black),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            height: 70,
            alignment: Alignment.center,
            color: color.WhiteSelver,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).translate('unit'),
                  style: Theme.of(context)
                      .textTheme
                      .display2
                      .copyWith(fontSize: 20, color: color.black),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.only(left: 7, right: 7, top: 3, bottom: 3),
                  margin: EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
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
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            color: color.WhiteSelver,
            alignment: Alignment.center,
            height: 70,
            child: RaisedButton(
              child: Icon(
                Icons.description,
                color: color.red,
                size: 35,
              ),
              elevation: 2,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  details()),
                );
                // Perform some action
              },
            ),
          ),
        ),
      ],
    );
  }

  bool withLip = false;
  _rowDimention() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('height'),
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(fontSize: 18, color: color.gray),
                    ),
                    _textFiled(h_FocusNode, mainCold.hieghtController),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('width'),
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(fontSize: 18, color: color.gray),
                    ),
                    _textFiled(width_FocusNode, mainCold.widthController),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('radius'),
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(fontSize: 18, color: color.gray),
                    ),
                    _textFiled(r_FocusNode, mainCold.radiusController),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('thickness'),
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(fontSize: 18, color: color.gray),
                    ),
                    _textFiled(t_FocusNode, mainCold.tController),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(1),
          child: withLip ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('h_lip'),
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(fontSize: 18, color: color.gray),
                    ),
                    _textFiled(h_lip_FocusNode, mainCold.h_lipController),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      mainCold.x_section =='u_with'?AppLocalizations.of(context).translate('eave_angle')
                          : AppLocalizations.of(context).translate('lip_angle'),
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(fontSize: 18, color: color.gray),
                    ),
                    _textFiled(angle_FocusNode, mainCold.angleController),
                  ],
                ),
              ),
            ],
          ): Container(height: 0,),
        ),
      ],
    );
  }

  bool readOnly = true;

  _textFiled(bool focusNode, TextEditingController controller) {
    return GestureDetector(
      onDoubleTap: () => readOnly = false,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: new Border.all(
              color: color.black, width: 1.5, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 25,
        margin: EdgeInsets.only(left: 1, right: 1),
        alignment: Alignment.center,
        child: TextField(
            showCursor: false,
            readOnly: readOnly,
            controller: controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            autofocus: false,
            textInputAction: TextInputAction.done,
            style: Theme.of(context).textTheme.display2.copyWith(color: color.black,fontSize: 16),
            decoration: InputDecoration(
              filled: true,
              fillColor: focusNode ? color.red : color.White,
              hintText: "",
              contentPadding: const EdgeInsets.only(bottom: 10),
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
    );
  }

  _setFoucus(TextEditingController controller) {
    if (controller == mainCold.angleController) {
      if(mainCold.x_section == 'u_hat')return;
    }
    h_FocusNode = false;
    width_FocusNode = false;
    angle_FocusNode = false;
    t_FocusNode = false;
    h_lip_FocusNode = false;
    r_FocusNode = false;
    if (controller == mainCold.hieghtController) {
      h_FocusNode = true;
      _rulerPickerController.value =
          (double.parse(mainCold.hieghtController.text)).round();
    } else if (controller == mainCold.widthController) {
      width_FocusNode = true;
      _rulerPickerController.value =
          double.parse(mainCold.widthController.text).round();
    } else if (controller == mainCold.tController) {
      t_FocusNode = true;
      _rulerPickerController.value =
          double.parse(mainCold.tController.text).round();
    } else if (controller == mainCold.h_lipController) {
      h_lip_FocusNode = true;
      _rulerPickerController.value =
          double.parse(mainCold.h_lipController.text).round();
    } else if (controller == mainCold.angleController) {
      angle_FocusNode = true;
      _rulerPickerController.value =
          double.parse(mainCold.angleController.text).round();
    } else {
      r_FocusNode = true;
      _rulerPickerController.value =
          double.parse(mainCold.radiusController.text).round();
    }
  }

  _stacImage() {
    String SvgAssets = 'assets/code_image/ipa_txt.svg';
    switch (mainCold.x_section) {
      case "z_with":
        {
          return Stack(
            children: <Widget>[
              new Positioned.fill(
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 50),
                  color: color.White,
                  key: imageKey,
                  child: CustomPaint(
                    painter:  draw_Z_cold_angle(context, paint, textPaint),
                  ),
                ),
              ),
            ],
          );
        }
        break;
      case "z_without":
        {
          return Stack(
            children: <Widget>[
              new Positioned.fill(
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 50),
                  color: color.White,
                  key: imageKey,
                  child: CustomPaint(
                    painter:  draw_Z_cold(context, paint, textPaint),
                  ),
                ),
              ),
            ],
          );
        }
        break;
      case "u_with":
        {
          return Stack(
            children: <Widget>[
              new Positioned.fill(
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 50),
                  color: color.White,
                  key: imageKey,
                  child: CustomPaint(
                    painter:  draw_u_cold_angle(context, paint, textPaint, false),
                  ),
                ),
              ),
            ],
          );
        }
        break;
      case "u_without":
        {
          return Stack(
            children: <Widget>[
              new Positioned.fill(
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 50),
                  color: color.White,
                  key: imageKey,
                  child: CustomPaint(
                    painter:  draw_u_cold(context, paint, textPaint),
                  ),
                ),
              ),
            ],
          );
        }
        break;
      case "u_hat":
        {
          SvgAssets = 'assets/code_image/circle_txt.svg';
          return Stack(
            children: <Widget>[
              new Positioned.fill(
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 50),
                  color: color.White,
                  key: imageKey,
                  child: CustomPaint(
                    painter:  draw_u_cold_angle(context, paint, textPaint, true),
                  ),
                ),
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
          h_FocusNode
              ? mainCold.hieghtController.text = _textEditingController.text
              : width_FocusNode
                  ? mainCold.widthController.text = _textEditingController.text
                  : t_FocusNode
                      ? mainCold.tController.text = _textEditingController.text
                      : h_lip_FocusNode
                          ? mainCold.h_lipController.text =
                              _textEditingController.text
                          : angle_FocusNode
                              ? mainCold.angleController.text =
                                  _textEditingController.text
                              : mainCold.radiusController.text =
                                  _textEditingController.text;
        _refreshValue();
        });
      },
      width: MediaQuery.of(context).size.width,
    );
  }

  static _drawArc(Canvas c, Offset start, Offset end, double raduis, Paint paint, double teta) {//مع عقارب الساعة
    Rect rect;
    if (start.dx > end.dx && start.dy < end.dy) {
      rect = getRect(end, raduis, false);
      c.drawArc(rect, pi / 2, teta -  pi , false, paint);
    } else if (start.dx > end.dx && start.dy > end.dy) {
      rect = getRect(start, raduis, false);
      c.drawArc(rect, pi / 2,  pi  - teta, false, paint);
    } else if (start.dx < end.dx && start.dy >= end.dy) {
      rect = getRect(end, raduis, true);
      c.drawArc(rect, 3 * pi /2, -teta, false, paint);
    } else if (start.dx < end.dx && start.dy < end.dy) {
      rect = getRect(start, raduis, true);
      c.drawArc(rect, 3 * pi /2,  pi  - teta, false, paint);
    }
  }

  static Rect getRect(Offset p, double raduis, bool top) {
    Rect rect;
    if (top) {
      rect = new Rect.fromLTRB(p.dx - raduis, p.dy, p.dx + raduis, p.dy + 2 * raduis);
    } else {
      rect = new Rect.fromLTRB(p.dx - raduis, p.dy - 2 * raduis, p.dx + raduis, p.dy);
    }
    return rect;
  }

  static _drawArcReight(Canvas c, Offset start, Offset end, double raduis, Paint paint, double teta) {//مع عقارب الساعة
    Rect rect;
    if (start.dx > end.dx && start.dy < end.dy) {
      rect = getRect(end, raduis, false);
      c.drawArc(rect, pi / 2, teta -  pi , false, paint);
    } else if (start.dx > end.dx && start.dy > end.dy) {
      rect = getRect(start, raduis, false);
      c.drawArc(rect, pi / 2,  pi  - teta, false, paint);
    } else if (start.dx < end.dx && start.dy > end.dy) {
      rect = new Rect.fromLTRB(start.dx, start.dy - raduis, start.dx + 2 * raduis, start.dy + raduis);
      c.drawArc(rect,  pi , teta, false, paint);
    } else if (start.dx < end.dx && start.dy < end.dy) {
      rect = getRect(start, raduis, true);
      c.drawArc(rect, 3 * pi / 2,  pi  - teta, false, paint);
    }
  }

  static _drawDimention(BuildContext context,Canvas c, Offset start, Offset end, Paint paint, String s, Paint paintTedxt, double teta, bool red) {
    TextStyle textStyle = Theme.of(context).textTheme.display3.copyWith(fontSize: 14, color: color.gray);
    if (red) {
      textStyle = Theme.of(context).textTheme.display3.copyWith(fontSize: 14, color: color.red);
      paint.color = color.red;
    }
    //paintTedxt.setTedxtSize(50);
    if (start.dx == end.dx && start.dy == end.dy) {
      return;
    }
    if (start.dx == end.dx) {
      c.drawLine(Offset(start.dx + 10, start.dy), Offset(start.dx - 10, start.dy) , paint);
      c.drawLine(Offset(end.dx + 10, end.dy),Offset(end.dx - 10, end.dy), paint);
      //paintTedxt.getTedxtBounds(s, 0, s.length(), bounds);
      c.translate((end.dx + start.dx) / 2,   (end.dy + start.dy) / 2);
      c.rotate(3 * pi / 2);
      if (start.dy > end.dy) {
        //RectHeight_lip = new Rect((start.dx) - bounds.height() * 4,  abs(start.dy + end.dy) / 2 - bounds.width() + BmbDivorc.dy, (start.dx) + bounds.height() * 4,  abs(start.dy + end.dy) / 2 + bounds.width() - BmbDivorc.dy);
        _drawTextCenter(c, textStyle, s,
            0, 0 );
      } else {
        //RectHeight = new Rect((start.dx) - bounds.height() * 2,  abs(start.dy + end.dy) / 2 - bounds.width(), (start.dx) + bounds.height() * 2,  abs(start.dy + end.dy) / 2 + bounds.width());
        _drawTextCenter(c, textStyle, s,
            0, 0 );
      }
      c.rotate(-3 * pi / 2);
      c.translate( -(end.dx + start.dx) / 2,  -(end.dy + start.dy) / 2);
    } else if (start.dy == end.dy) {
      c.drawLine(Offset(start.dx, start.dy - 10), Offset(start.dx, start.dy + 10), paint);
      c.drawLine(Offset(end.dx, end.dy - 10),Offset(end.dx, end.dy + 10), paint);
      //paintTedxt.getTedxtBounds(s, 0, s.length(), bounds);
      if (start.dx > end.dx) {
        _drawTextCenter(c, textStyle, s,
            (end.dx + start.dx) / 2, start.dy);
      } else {
        _drawTextCenter(c, textStyle, s,
            (end.dx + start.dx) / 2, start.dy);
      }
      //RectWidth = new Rect((end.dx + start.dx) / 2 - bounds.width(), start.dy - bounds.height() * 2 + BmbDivorc.dy, (end.dx + start.dx) / 2 + bounds.width(), start.dy + bounds.height() * 2 - BmbDivorc.dy);
    } else {
      double sinTeta =   sin(teta -  pi / 2 );
      double cosTeta =   cos(teta -  pi / 2 );
      c.drawLine(Offset(start.dx - 5 * cosTeta, start.dy + 5 * sinTeta), Offset(start.dx + 5 * cosTeta, start.dy - 5 * sinTeta), paint);
      c.drawLine(Offset(end.dx - 5 * cosTeta, end.dy + 5 * sinTeta), Offset(end.dx + 5 * cosTeta, end.dy - 5 * sinTeta), paint);
      //paintTedxt.getTedxtBounds(s, 0, s.length(), bounds);
      c.translate((end.dx + start.dx) / 2, (end.dy + start.dy) / 2);
      c.rotate( pi - teta);
      _drawTextCenter(c, textStyle, s, 0, 0);
      c.rotate(- pi  + teta);
      c.translate(-(end.dx + start.dx) / 2, -(end.dy + start.dy) / 2);
     // RectHeight_lip = new Rect((start.dx+end.dx)/2 - bounds.width()*3,  abs(start.dy + end.dy) / 2 - bounds.width()*3, (start.dx+end.dx)/2 + bounds.width() ,  abs(start.dy + end.dy) / 2 + bounds.width()*3);
    }
    paint.color = color.gray;
    c.drawLine(Offset(start.dx, start.dy),Offset(end.dx, end.dy), paint);
  }

  static _drawArcDimention(BuildContext context, Canvas canvas, Paint paint, String raduis, Offset pS, Offset pE, double radius, double thickness,bool red) {
    Offset p1 ;
    Offset p2 ;
    //paint.setTedxtSize(50);
    if (pS.dx < pE.dx) {
      p1 = new Offset(pE.dx -  0.707 * radius, pE.dy +  0.293 * radius);
      p2 = new Offset(p1.dx + radius*2, p1.dy + 2 * radius + thickness);
    } else {
      p1 = new Offset(pS.dx -  0.707 * radius, pS.dy -  0.293 * radius);
      p2 = new Offset(p1.dx + radius*2, p1.dy - 2 * radius - thickness);
    }
    canvas.drawLine(Offset(p1.dx, p1.dy), Offset(p2.dx, p2.dy), paint);
    if(red){
      paint.color = color.red;
    }
    //Rect bounds = new Rect();
    //paint.getTedxtBounds(raduis, 0, raduis.length(), bounds);
    //RectRaduis = new Rect(p2.dx-bounds.width(), p2.dy-bounds.height()*3,p2.dx+bounds.width(), p2.dy+bounds.height()*3);
    _drawTextStart(canvas, Theme.of(context).textTheme.display1.copyWith(fontSize: 15 ,color: red? color.red:color.gray), raduis,
        p2.dx, p2.dy);
    paint.color = color.gray;
  }

  static _drawTextCenter(Canvas context, TextStyle textStyle, String text, double x, double y) {
    TextSpan span = new TextSpan(style: textStyle, text: text);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(context, new Offset(x - tp.width / 2, y - tp.height));
  }

  static _drawTextStart(Canvas context, TextStyle textStyle, String text, double x, double y) {
    TextSpan span = new TextSpan(style: textStyle, text: text);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(context, new Offset(x , y));
  }

  _editTextSelect(TextEditingController editTextSelect,TextEditingController editText){
    if(editTextSelect == editText){
      return true;
    }else {
      return false;
    }
  }

  _refreshValue() {
      height = double.parse(mainCold.hieghtController.text);
      width = double.parse(mainCold.widthController.text);
      thickness = double.parse(mainCold.tController.text);
      raduis = double.parse(mainCold.radiusController.text);
      h_lip = double.parse(mainCold.h_lipController.text);
      teta = double.parse(mainCold.angleController.text) * pi / 180;
      tetaEave = double.parse(mainCold.angleController.text) * pi / 180 - pi/2;
   }
}

class ListItem {
  String assetsImage;
  Color color;

  ListItem(this.color, this.assetsImage);
}

/*public Bitmap _draw_Z_cold(double height, double width, double raduis, double thikcnes, double heightLips, Paint paint) {
  scale_r =  min(  (widthImage - 100) / (width * 2 - thikcnes),   (heightImage - 100) / (height));
  Canvas canvas;
  String Height = String.valueOf(height);
  String HeightLips = String.valueOf(heightLips);
  String Width = String.valueOf(width);
  String Raduis = String.valueOf(raduis);
  double constant = 0;
  if (heightLips > 0) {
    constant = 1;
  }
  width *= scale_r;
  height *= scale_r;
  raduis *= scale_r;
  thikcnes *= scale_r;
  heightLips *= scale_r;
  double a = height - (2 * raduis + thikcnes);
  double b = width - (raduis + thikcnes / 2 + constant * (raduis + thikcnes / 2));
  double c = constant * (heightLips - (raduis + thikcnes / 2));
  Bitmap bmp = Bitmap.createBitmap(width * 2 - thikcnes + 175, height + 175, Bitmap.Config.ARGB_8888);
  canvas = new Canvas(bmp);
  double canvasx =   canvas.getWidth();
  double canvasy =   canvas.getHeight();
  double centerX = canvasx / 2f;
  double centerY = canvasy / 2f;
  OffsetF[] p = new OffsetF[10];
  p[0] = new OffsetF(centerX + raduis + b, centerY - height / 2 + thikcnes / 2);
  p[1] = new OffsetF(p[0].x - b, centerY - height / 2 + thikcnes / 2);
  p[2] = new OffsetF(centerX, centerY - a / 2);
  p[3] = new OffsetF(centerX, centerY + a / 2);
  p[5] = new OffsetF(centerX - raduis - b, centerY + height / 2 - thikcnes / 2);
  p[4] = new OffsetF(p[5].x + b, p[5].y);
  p[6] = new OffsetF(centerX - width + ((1 + constant) * thikcnes / 2), p[5].y - raduis);
  p[7] = new OffsetF(p[6].x, p[6].y - c);
  p[8] = new OffsetF(centerX + width - ((1 + constant) * thikcnes / 2), p[0].y + raduis);
  p[9] = new OffsetF(p[8].x, p[8].y + c);
  paint.setPathEffect(new DashPathEffect(new double[]{40, 20, 10, 20}, 0));
  drawArc(canvas, p[2], p[1], raduis, paint, 90);
  drawArc(canvas, p[3], p[4], raduis, paint, 90);
  drawArcDimention(canvas,textPadouble,Raduis,p[2],p[1],raduis,thikcnes,editTextSelect(editTextSelect,editTextRaduis));
  drawArc(canvas, p[5], p[6], raduis, paint, teta);
  drawArc(canvas, p[0], p[8], raduis, paint, teta);
  canvas.drawLine(Ofsset(p[1].x, p[1].y, p[0].x, p[0].y, paint);
      canvas.drawLine(Ofsset(p[2].x, p[2].y, p[3].x, p[3].y, paint);
  canvas.drawLine(Ofsset(p[5].x, p[5].y, p[4].x, p[4].y, paint);
      canvas.drawLine(Ofsset(p[6].x, p[6].y, p[7].x, p[7].y, paint);
  canvas.drawLine(Ofsset(p[8].x, p[8].y, p[9].x, p[9].y, paint);

      OffsetF[] pTop = new OffsetF[10];
      pTop[0] = new OffsetF(p[0].x, p[0].y - thikcnes / 2);
  pTop[1] = new OffsetF(p[1].x, p[1].y - thikcnes / 2);
  pTop[2] = new OffsetF(p[2].x - thikcnes / 2, p[2].y);
  pTop[3] = new OffsetF(p[3].x - thikcnes / 2, p[3].y);
  pTop[5] = new OffsetF(p[5].x, p[5].y - thikcnes / 2);
  pTop[4] = new OffsetF(p[4].x, p[4].y - thikcnes / 2);
  pTop[6] = new OffsetF(p[6].x + thikcnes / 2, p[6].y);
  pTop[7] = new OffsetF(p[7].x + thikcnes / 2, p[7].y);
  pTop[8] = new OffsetF(p[8].x + thikcnes / 2, p[8].y);
  pTop[9] = new OffsetF(p[9].x + thikcnes / 2, p[9].y);


  OffsetF[] pBottom = new OffsetF[10];
  pBottom[0] = new OffsetF(p[0].x, p[0].y + thikcnes / 2);
  pBottom[1] = new OffsetF(p[1].x, p[1].y + thikcnes / 2);
  pBottom[2] = new OffsetF(p[2].x + thikcnes / 2, p[2].y);
  pBottom[3] = new OffsetF(p[3].x + thikcnes / 2, p[3].y);
  pBottom[5] = new OffsetF(p[5].x, p[5].y + thikcnes / 2);
  pBottom[4] = new OffsetF(p[4].x, p[4].y + thikcnes / 2);
  pBottom[6] = new OffsetF(p[6].x - thikcnes / 2, p[6].y);
  pBottom[7] = new OffsetF(p[7].x - thikcnes / 2, p[7].y);
  pBottom[8] = new OffsetF(p[8].x - thikcnes / 2, p[8].y);
  pBottom[9] = new OffsetF(p[9].x - thikcnes / 2, p[9].y);

  if (thikcnes != 0) {
    paint.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
    drawArc(canvas, pTop[2], pTop[1], raduis + thikcnes / 2, paint, 90);
    drawArc(canvas, pTop[3], pTop[4], raduis - thikcnes / 2, paint, 90);
    if (c > 0) {
      drawArc(canvas, pTop[5], pTop[6], raduis - thikcnes / 2, paint, teta);
      drawArc(canvas, pTop[0], pTop[8], raduis + thikcnes / 2, paint, teta);
      canvas.drawLine(Ofsset(pTop[6].x, pTop[6].y, pTop[7].x, pTop[7].y, paint);
          canvas.drawLine(Ofsset(pTop[8].x, pTop[8].y, pTop[9].x, pTop[9].y, paint);

      drawArc(canvas, pBottom[5], pBottom[6], raduis + thikcnes / 2, paint, teta);
      drawArc(canvas, pBottom[0], pBottom[8], raduis - thikcnes / 2, paint, teta);
      canvas.drawLine(Ofsset(pBottom[6].x, pBottom[6].y, pBottom[7].x, pBottom[7].y, paint);
          canvas.drawLine(Ofsset(pBottom[8].x, pBottom[8].y, pBottom[9].x, pBottom[9].y, paint);

      canvas.drawLine(Ofsset(pBottom[9].x, pBottom[9].y, pTop[9].x, pTop[9].y, paint);
          canvas.drawLine(Ofsset(pBottom[7].x, pBottom[7].y, pTop[7].x, pTop[7].y, paint);
    } else {
      canvas.drawLine(Ofsset(pBottom[0].x, pBottom[0].y, pTop[0].x, pTop[0].y, paint);
          canvas.drawLine(Ofsset(pBottom[5].x, pBottom[5].y, pTop[5].x, pTop[5].y, paint);
    }

    canvas.drawLine(Ofsset(pTop[1].x, pTop[1].y, pTop[0].x, pTop[0].y, paint);
        canvas.drawLine(Ofsset(pTop[2].x, pTop[2].y, pTop[3].x, pTop[3].y, paint);
    canvas.drawLine(Ofsset(pTop[5].x, pTop[5].y, pTop[4].x, pTop[4].y, paint);

        drawArc(canvas, pBottom[2], pBottom[1], raduis - thikcnes / 2, paint, 90);
    drawArc(canvas, pBottom[3], pBottom[4], raduis + thikcnes / 2, paint, 90);
    canvas.drawLine(Ofsset(pBottom[1].x, pBottom[1].y, pBottom[0].x, pBottom[0].y, paint);
        canvas.drawLine(Ofsset(pBottom[2].x, pBottom[2].y, pBottom[3].x, pBottom[3].y, paint);
    canvas.drawLine(Ofsset(pBottom[5].x, pBottom[5].y, pBottom[4].x, pBottom[4].y, paint);

        }

        OffsetF[] pDimention = new OffsetF[2];
        pDimention[0] = new OffsetF(p[1].x - raduis - thikcnes / 2, p[1].y - 25 - thikcnes / 2);
    pDimention[1] = new OffsetF(centerX - thikcnes / 2 + width, p[1].y - 25 - thikcnes / 2);
    drawDimention(canvas, pDimention[0], pDimention[1], textPadouble, Width, textPadouble, teta, editTextSelect(editTextSelect,editTextWidth));

    pDimention[0].x = p[8].x + 15 + thikcnes / 2;
    pDimention[0].y = pTop[1].y;
    pDimention[1].x = p[8].x + 15 + thikcnes / 2;
    pDimention[1].y = pTop[1].y + heightLips;
    drawDimention(canvas, pDimention[1], pDimention[0], textPadouble, HeightLips, textPadouble, teta, editTextSelect(editTextSelect,editTextLip));
    pDimention[0].x = p[6].x - 25;
    pDimention[0].y = pTop[1].y;
    pDimention[1].x = p[6].x - 25;
    pDimention[1].y = pBottom[5].y;
    drawDimention(canvas, pDimention[0], pDimention[1], textPadouble, Height, textPadouble, teta, editTextSelect(editTextSelect,editTextHeight));
    return bmp;
  }
*/
class draw_Z_cold extends CustomPainter {


  _editTextSelect(TextEditingController editTextSelect,TextEditingController editText){
    if(editTextSelect.text == editText.text){
      return true;
    }else {
      return false;
    }
  }

  Paint paint0, textPaint;
  BuildContext context;

  draw_Z_cold(this.context,this.paint0,this.textPaint);

  @override
  void paint(Canvas canvas, Size size) {
    _State.scale_r =  min((size.width*0.8) / (_State.width * 2 - _State.thickness),   (size.height*0.8) / (_State.height));
    //Canvas canvas;
    String Height = _State.height.toString();
    String HeightLips = _State.h_lip.toString();
    String Width = _State.width.toString();
    String Raduis = _State.raduis.toString()/*.substring(0,_State.raduis.toString().length-2)*/;
    double constant = 0;
    if ( _State.h_lip > 0) {
      constant = 1;
    }
    double width = _State.width * _State.scale_r;
    double height = _State.height * _State.scale_r;
    double raduis = _State.raduis * _State.scale_r;
    double thikcnes = _State.thickness * _State.scale_r;
    double heightLips = _State.h_lip * _State.scale_r;
    double a = height - (2 * raduis + thikcnes);
    double b = width - (raduis + thikcnes / 2 + constant * (raduis + thikcnes / 2));
    double c = constant * (heightLips - (raduis + thikcnes / 2));
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double teta = pi / 2;
    double strokWidth=2;
    List<Offset> p = new List(10);
    p[0] = new Offset(centerX + raduis + b, centerY - height / 2 + thikcnes / 2);
    p[1] = new Offset(p[0].dx - b, centerY - height / 2 + thikcnes / 2);
    p[2] = new Offset(centerX, centerY - a / 2);
    p[3] = new Offset(centerX, centerY + a / 2);
    p[5] = new Offset(centerX - raduis - b, centerY + height / 2 - thikcnes / 2);
    p[4] = new Offset(p[5].dx + b, p[5].dy);
    p[6] = new Offset(centerX - width + ((1 + constant) * thikcnes / 2), p[5].dy - raduis);
    p[7] = new Offset(p[6].dx, p[6].dy - c);
    p[8] = new Offset(centerX + width - ((1 + constant) * thikcnes / 2), p[0].dy + raduis);
    p[9] = new Offset(p[8].dx, p[8].dy + c);
    paint0.strokeWidth = 0.5;
    _State._drawArc(canvas, p[2], p[1], raduis, paint0, pi / 2);
    _State._drawArc(canvas, p[3], p[4], raduis, paint0, pi / 2);
    _State._drawArcDimention(context ,canvas,textPaint,Raduis,p[2],p[1],raduis,thikcnes,_editTextSelect(_State._textEditingController ,mainCold.radiusController));
    //_State._drawArc(canvas, p[5], p[6], raduis, paint0, teta);
    //_State._drawArc(canvas, p[0], p[8], raduis, paint0, teta);
    canvas.drawLine(Offset(p[1].dx, p[1].dy), Offset(p[0].dx, p[0].dy), paint0);
    canvas.drawLine(Offset(p[2].dx, p[2].dy),Offset( p[3].dx, p[3].dy), paint0);
    canvas.drawLine(Offset(p[5].dx, p[5].dy), Offset(p[4].dx, p[4].dy), paint0);
    canvas.drawLine(Offset(p[6].dx, p[6].dy), Offset(p[7].dx, p[7].dy), paint0);
    canvas.drawLine(Offset(p[8].dx, p[8].dy), Offset(p[9].dx, p[9].dy), paint0);

    List<Offset> pTop = new List(10);
    pTop[0] = new Offset(p[0].dx, p[0].dy - thikcnes / 2);
    pTop[1] = new Offset(p[1].dx, p[1].dy - thikcnes / 2);
    pTop[2] = new Offset(p[2].dx - thikcnes / 2, p[2].dy);
    pTop[3] = new Offset(p[3].dx - thikcnes / 2, p[3].dy);
    pTop[5] = new Offset(p[5].dx, p[5].dy - thikcnes / 2);
    pTop[4] = new Offset(p[4].dx, p[4].dy - thikcnes / 2);
    pTop[6] = new Offset(p[6].dx + thikcnes / 2, p[6].dy);
    pTop[7] = new Offset(p[7].dx + thikcnes / 2, p[7].dy);
    pTop[8] = new Offset(p[8].dx + thikcnes / 2, p[8].dy);
    pTop[9] = new Offset(p[9].dx + thikcnes / 2, p[9].dy);


    List<Offset> pBottom = new List(10);
    pBottom[0] = new Offset(p[0].dx, p[0].dy + thikcnes / 2);
    pBottom[1] = new Offset(p[1].dx, p[1].dy + thikcnes / 2);
    pBottom[2] = new Offset(p[2].dx + thikcnes / 2, p[2].dy);
    pBottom[3] = new Offset(p[3].dx + thikcnes / 2, p[3].dy);
    pBottom[5] = new Offset(p[5].dx, p[5].dy + thikcnes / 2);
    pBottom[4] = new Offset(p[4].dx, p[4].dy + thikcnes / 2);
    pBottom[6] = new Offset(p[6].dx - thikcnes / 2, p[6].dy);
    pBottom[7] = new Offset(p[7].dx - thikcnes / 2, p[7].dy);
    pBottom[8] = new Offset(p[8].dx - thikcnes / 2, p[8].dy);
    pBottom[9] = new Offset(p[9].dx - thikcnes / 2, p[9].dy);

    if (thikcnes != 0) {
      paint0.strokeWidth = strokWidth;
      _State._drawArc(canvas, pTop[2], pTop[1], raduis + thikcnes / 2, paint0, pi / 2);
      _State._drawArc(canvas, pTop[3], pTop[4], raduis - thikcnes / 2, paint0, pi / 2);
      if (c > 0) {
        _State._drawArc(canvas, pTop[5], pTop[6], raduis - thikcnes / 2, paint0, teta);
        _State._drawArc(canvas, pTop[0], pTop[8], raduis + thikcnes / 2, paint0, teta);
        canvas.drawLine(Offset(pTop[6].dx, pTop[6].dy), Offset(pTop[7].dx, pTop[7].dy), paint0);
        canvas.drawLine(Offset(pTop[8].dx, pTop[8].dy), Offset(pTop[9].dx, pTop[9].dy), paint0);

        _State._drawArc(canvas, pBottom[5], pBottom[6], raduis + thikcnes / 2, paint0, teta);
        _State._drawArc(canvas, pBottom[0], pBottom[8], raduis - thikcnes / 2, paint0, teta);
        canvas.drawLine(Offset(pBottom[6].dx, pBottom[6].dy), Offset(pBottom[7].dx, pBottom[7].dy), paint0);
        canvas.drawLine(Offset(pBottom[8].dx, pBottom[8].dy), Offset(pBottom[9].dx, pBottom[9].dy), paint0);

        canvas.drawLine(Offset(pBottom[9].dx, pBottom[9].dy), Offset(pTop[9].dx, pTop[9].dy), paint0);
        canvas.drawLine(Offset(pBottom[7].dx, pBottom[7].dy), Offset(pTop[7].dx, pTop[7].dy), paint0);
      } else {
        canvas.drawLine(Offset(pBottom[0].dx, pBottom[0].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
        canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pTop[5].dx, pTop[5].dy), paint0);
      }

      canvas.drawLine(Offset(pTop[1].dx, pTop[1].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
      canvas.drawLine(Offset(pTop[2].dx, pTop[2].dy), Offset(pTop[3].dx, pTop[3].dy), paint0);
      canvas.drawLine(Offset(pTop[5].dx, pTop[5].dy), Offset(pTop[4].dx, pTop[4].dy), paint0);

      _State._drawArc(canvas, pBottom[2], pBottom[1], raduis - thikcnes / 2, paint0, pi / 2);
      _State._drawArc(canvas, pBottom[3], pBottom[4], raduis + thikcnes / 2, paint0, pi / 2);
      canvas.drawLine(Offset(pBottom[1].dx, pBottom[1].dy), Offset(pBottom[0].dx, pBottom[0].dy), paint0);
      canvas.drawLine(Offset(pBottom[2].dx, pBottom[2].dy), Offset(pBottom[3].dx, pBottom[3].dy), paint0);
      canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pBottom[4].dx, pBottom[4].dy), paint0);

    }
    int paddingDimention = min((size.width/20).round(),(size.height/20).round());
    List<Offset> pDimention = new List(2);
    pDimention[0] = new Offset(p[1].dx - raduis - thikcnes / 2, p[1].dy - paddingDimention - thikcnes / 2);
    pDimention[1] = new Offset(centerX - thikcnes / 2 + width, p[1].dy - paddingDimention - thikcnes / 2);
    _State._drawDimention(context,canvas, pDimention[0], pDimention[1], textPaint, Width, textPaint, teta, _editTextSelect(_State._textEditingController ,mainCold.widthController));
    pDimention[0] = new Offset(p[8].dx + 15 + thikcnes / 2,  pTop[1].dy);
    pDimention[1] = new Offset(p[8].dx + 15 + thikcnes / 2, pTop[1].dy + heightLips);
    // _State._drawDimention(context,canvas, pDimention[1], pDimention[0], textPaint, HeightLips, textPaint, teta, _editTextSelect(_State._textEditingController ,mainCold.h_lipController));
    pDimention[0] = new Offset (p[6].dx - paddingDimention - thikcnes/2,  pTop[1].dy);
    pDimention[1] = new Offset(p[6].dx - paddingDimention - thikcnes/2, pBottom[5].dy);
    _State._drawDimention(context,canvas, pDimention[0], pDimention[1], textPaint, Height, textPaint, teta, _editTextSelect(_State._textEditingController ,mainCold.hieghtController));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class draw_u_cold extends CustomPainter {

  _editTextSelect(TextEditingController editTextSelect,TextEditingController editText){
    if(editTextSelect.text == editText.text){
      return true;
    }else {
      return false;
    }
  }

  Paint paint0, textPaint;
  BuildContext context;

  draw_u_cold(this.context,this.paint0,this.textPaint);

  @override
  void paint(Canvas canvas, Size size) {
    _State.teta = pi / 2;
    _State.scale_r =  min((size.width*0.8) / (_State.width + _State.thickness),   (size.height*0.8) / (_State.height));
    //Canvas canvas;
    String Height = _State.height.toString();
    String HeightLips = _State.h_lip.toString();
    String Width = _State.width.toString();
    String Raduis = _State.raduis.toString()/*.substring(0,_State.raduis.toString().length-2)*/;
    double constant = 0;
    if ( _State.h_lip > 0) {
      constant = 1;
    }
    double width = _State.width * _State.scale_r;
    double height = _State.height * _State.scale_r;
    double raduis = _State.raduis * _State.scale_r;
    double thikcnes = _State.thickness * _State.scale_r;
    double heightLips = _State.h_lip * _State.scale_r;
    double a = height - (2 * raduis + thikcnes);
    double b = width - (raduis + thikcnes / 2 + constant * (raduis + thikcnes / 2));
    double c = constant * (heightLips - (raduis + thikcnes / 2));
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double teta = pi / 2;
    double strokWidth=2;
    List<Offset> p = new List(6);
    p[0] = new Offset(centerX + b / 2, centerY - height / 2 + thikcnes / 2);
    p[1] = new Offset(p[0].dx - b, centerY - height / 2 + thikcnes / 2);
    p[2] = new Offset(centerX - b / 2 - raduis, centerY - a / 2);
    p[3] = new Offset(centerX - b / 2 - raduis, centerY + a / 2);
    p[4] = new Offset(centerX - b / 2, centerY + height / 2 - thikcnes / 2);
    p[5] = new Offset(p[4].dx + b, p[4].dy);
    paint0.strokeWidth = 0.5;
    _State._drawArc(canvas, p[2], p[1], raduis, paint0, pi / 2);
    _State._drawArc(canvas, p[4], p[3], raduis, paint0, pi / 2);
    _State._drawArcDimention(context ,canvas,textPaint,Raduis,p[2],p[1],raduis,thikcnes,_editTextSelect(_State._textEditingController ,mainCold.radiusController));
    //_State._drawArc(canvas, p[5], p[6], raduis, paint0, teta);
    //_State._drawArc(canvas, p[0], p[8], raduis, paint0, teta);
    canvas.drawLine(Offset(p[1].dx, p[1].dy), Offset(p[0].dx, p[0].dy), paint0);
    canvas.drawLine(Offset(p[2].dx, p[2].dy),Offset( p[3].dx, p[3].dy), paint0);
    canvas.drawLine(Offset(p[5].dx, p[5].dy), Offset(p[4].dx, p[4].dy), paint0);

    List<Offset> pTop = new List(6);
    pTop[0] = new Offset(p[0].dx, p[0].dy - thikcnes / 2);
    pTop[1] = new Offset(p[1].dx, p[1].dy - thikcnes / 2);
    pTop[2] = new Offset(p[2].dx - thikcnes / 2, p[2].dy);
    pTop[3] = new Offset(p[3].dx - thikcnes / 2, p[3].dy);
    pTop[4] = new Offset(p[4].dx, p[4].dy + thikcnes / 2);
    pTop[5] = new Offset(p[5].dx, p[5].dy + thikcnes / 2);

    List<Offset> pBottom = new List(6);
    pBottom[0] = new Offset(p[0].dx, p[0].dy + thikcnes / 2);
    pBottom[1] = new Offset(p[1].dx, p[1].dy + thikcnes / 2);
    pBottom[2] = new Offset(p[2].dx + thikcnes / 2, p[2].dy);
    pBottom[3] = new Offset(p[3].dx + thikcnes / 2, p[3].dy);
    pBottom[4] = new Offset(p[4].dx, p[4].dy - thikcnes / 2);
    pBottom[5] = new Offset(p[5].dx, p[5].dy - thikcnes / 2);

    if (thikcnes != 0) {
      paint0.strokeWidth = strokWidth;
      _State._drawArc(canvas, pTop[2], pTop[1], raduis + thikcnes / 2, paint0, pi / 2);
      _State._drawArc(canvas, pTop[4], pTop[3], raduis + thikcnes / 2, paint0, pi / 2);
      if (c > 0) {
        _State._drawArc(canvas, pTop[5], pTop[6], raduis - thikcnes / 2, paint0, teta);
        _State._drawArc(canvas, pTop[0], pTop[8], raduis + thikcnes / 2, paint0, teta);
        canvas.drawLine(Offset(pTop[6].dx, pTop[6].dy), Offset(pTop[7].dx, pTop[7].dy), paint0);
        canvas.drawLine(Offset(pTop[8].dx, pTop[8].dy), Offset(pTop[9].dx, pTop[9].dy), paint0);

        _State._drawArc(canvas, pBottom[5], pBottom[6], raduis + thikcnes / 2, paint0, teta);
        _State._drawArc(canvas, pBottom[0], pBottom[8], raduis - thikcnes / 2, paint0, teta);
        canvas.drawLine(Offset(pBottom[6].dx, pBottom[6].dy), Offset(pBottom[7].dx, pBottom[7].dy), paint0);
        canvas.drawLine(Offset(pBottom[8].dx, pBottom[8].dy), Offset(pBottom[9].dx, pBottom[9].dy), paint0);

        canvas.drawLine(Offset(pBottom[9].dx, pBottom[9].dy), Offset(pTop[9].dx, pTop[9].dy), paint0);
        canvas.drawLine(Offset(pBottom[7].dx, pBottom[7].dy), Offset(pTop[7].dx, pTop[7].dy), paint0);
      } else {
        canvas.drawLine(Offset(pBottom[0].dx, pBottom[0].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
        canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pTop[5].dx, pTop[5].dy), paint0);
      }

      canvas.drawLine(Offset(pTop[1].dx, pTop[1].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
      canvas.drawLine(Offset(pTop[2].dx, pTop[2].dy), Offset(pTop[3].dx, pTop[3].dy), paint0);
      canvas.drawLine(Offset(pTop[5].dx, pTop[5].dy), Offset(pTop[4].dx, pTop[4].dy), paint0);

      _State._drawArc(canvas, pBottom[2], pBottom[1], raduis - thikcnes / 2, paint0, pi / 2);
      _State._drawArc(canvas, pBottom[4], pBottom[3], raduis - thikcnes / 2, paint0, pi / 2);
      canvas.drawLine(Offset(pBottom[1].dx, pBottom[1].dy), Offset(pBottom[0].dx, pBottom[0].dy), paint0);
      canvas.drawLine(Offset(pBottom[2].dx, pBottom[2].dy), Offset(pBottom[3].dx, pBottom[3].dy), paint0);
      canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pBottom[4].dx, pBottom[4].dy), paint0);

    }

    int paddingDimention = min((size.width/20).round(),(size.height/20).round());
    List<Offset> pDimention = new List(2);
    pDimention[0] = new Offset(p[1].dx - raduis - thikcnes / 2, p[1].dy - paddingDimention - thikcnes / 2);
    pDimention[1] = new Offset(p[0].dx, p[1].dy - paddingDimention - thikcnes / 2);
    _State._drawDimention(context,canvas, pDimention[0], pDimention[1], textPaint, Width, textPaint, teta, _editTextSelect(_State._textEditingController ,mainCold.widthController));
   //pDimention[0] = new Offset(p[8].dx + 15 + thikcnes / 2,  pTop[1].dy);
   //pDimention[1] = new Offset(p[8].dx + 15 + thikcnes / 2, pTop[1].dy + heightLips);
    // _State._drawDimention(context,canvas, pDimention[1], pDimention[0], textPaint, HeightLips, textPaint, teta, _editTextSelect(_State._textEditingController ,mainCold.h_lipController));
    pDimention[0] = new Offset (p[3].dx - paddingDimention - thikcnes/2,  pTop[1].dy);
    pDimention[1] = new Offset(p[3].dx - paddingDimention - thikcnes/2, pTop[5].dy);
    _State._drawDimention(context,canvas, pDimention[0], pDimention[1], textPaint, Height, textPaint, teta, _editTextSelect(_State._textEditingController ,mainCold.hieghtController));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class draw_Z_cold_angle extends CustomPainter {
  _editTextSelect(TextEditingController editTextSelect,TextEditingController editText){
    if(editTextSelect.text == editText.text){
      return true;
    }else {
      return false;
    }
  }

  Paint paint0, textPaint;
  BuildContext context;

  draw_Z_cold_angle(this.context,this.paint0,this.textPaint);

  @override
  void paint(Canvas canvas, Size size) {
    String Height = _State.height.toString();
    String HeightLips = _State.h_lip.toString();
    String Width = _State.width.toString();
    String Raduis = _State.raduis.toString()/*.substring(0,_State.raduis.toString().length-2)*/;
    double teta = _State.teta;
    double sdoubleeta = sin((teta - pi / 2));
    double cosTeta = cos((teta - pi / 2));
    double tanTeta = tan((teta - pi / 2));
    _State.scale_r =  min((size.width*0.8) / (_State.width * 2 - _State.thickness + _State.h_lip * 2 * sdoubleeta),   (size.height*0.8) / (_State.height));
//    Canvas canvas;
    double width = _State.width * _State.scale_r;
    double height = _State.height * _State.scale_r;
    double raduis = _State.raduis * _State.scale_r;
    double thikcnes = _State.thickness * _State.scale_r;
    double heightLips = _State.h_lip * _State.scale_r;
    double a = height - (2 * raduis + thikcnes);
    double b = width - (raduis + thikcnes / 2);
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double strokWidth=2;
    List<Offset> p = new List(10);
    p[0] = new Offset(centerX + raduis + b, centerY - height / 2 + thikcnes / 2);
    p[1] = new Offset(p[0].dx - b, centerY - height / 2 + thikcnes / 2);
    p[2] = new Offset(centerX, centerY - a / 2);
    p[3] = new Offset(centerX, centerY + a / 2);
    p[5] = new Offset(centerX - raduis - b, centerY + height / 2 - thikcnes / 2);
    p[4] = new Offset(p[5].dx + b, p[5].dy);
    p[6] = new Offset(p[5].dx - raduis * cosTeta, p[5].dy - raduis * (1 - sdoubleeta));
    p[7] = new Offset(p[6].dx - heightLips * sdoubleeta, p[6].dy - heightLips * cosTeta);
    p[8] = new Offset(p[0].dx + raduis * cosTeta, p[0].dy + raduis * (1 - sdoubleeta));
    p[9] = new Offset(p[8].dx + heightLips * sdoubleeta, p[8].dy + heightLips * cosTeta);
    paint0.strokeWidth = 0.5;
    _State._drawArc(canvas, p[2], p[1], raduis, paint0, pi / 2);
    _State._drawArc(canvas, p[3], p[4], raduis, paint0, pi / 2);
    _State._drawArcDimention(context ,canvas,textPaint,Raduis,p[2],p[1],raduis,thikcnes,_editTextSelect(_State._textEditingController ,mainCold.radiusController));
    _State._drawArc(canvas, p[5], p[6], raduis, paint0, teta);
    _State._drawArc(canvas, p[0], p[8], raduis, paint0, teta);
    canvas.drawLine(Offset(p[1].dx, p[1].dy), Offset(p[0].dx, p[0].dy), paint0);
    canvas.drawLine(Offset(p[2].dx, p[2].dy),Offset( p[3].dx, p[3].dy), paint0);
    canvas.drawLine(Offset(p[5].dx, p[5].dy), Offset(p[4].dx, p[4].dy), paint0);
    canvas.drawLine(Offset(p[6].dx, p[6].dy), Offset(p[7].dx, p[7].dy), paint0);
    canvas.drawLine(Offset(p[8].dx, p[8].dy), Offset(p[9].dx, p[9].dy), paint0);

    List<Offset> pTop = new List(10);
    pTop[0] = new Offset(p[0].dx, p[0].dy - thikcnes / 2);
    pTop[1] = new Offset(p[1].dx, p[1].dy - thikcnes / 2);
    pTop[2] = new Offset(p[2].dx - thikcnes / 2, p[2].dy);
    pTop[3] = new Offset(p[3].dx - thikcnes / 2, p[3].dy);
    pTop[5] = new Offset(p[5].dx, p[5].dy - thikcnes / 2);
    pTop[4] = new Offset(p[4].dx, p[4].dy - thikcnes / 2);
    pTop[6] = new Offset(p[6].dx + cosTeta * thikcnes / 2, p[6].dy - sdoubleeta * thikcnes / 2);
    pTop[7] = new Offset(p[7].dx + cosTeta * thikcnes / 2, p[7].dy - sdoubleeta * thikcnes / 2);
    pTop[8] = new Offset(p[8].dx + cosTeta * thikcnes / 2, p[8].dy - sdoubleeta * thikcnes / 2);
    pTop[9] = new Offset(p[9].dx + cosTeta * thikcnes / 2, p[9].dy - sdoubleeta * thikcnes / 2);

    List<Offset> pBottom = new List(10);
    pBottom[0] = new Offset(p[0].dx, p[0].dy + thikcnes / 2);
    pBottom[1] = new Offset(p[1].dx, p[1].dy + thikcnes / 2);
    pBottom[2] = new Offset(p[2].dx + thikcnes / 2, p[2].dy);
    pBottom[3] = new Offset(p[3].dx + thikcnes / 2, p[3].dy);
    pBottom[5] = new Offset(p[5].dx, p[5].dy + thikcnes / 2);
    pBottom[4] = new Offset(p[4].dx, p[4].dy + thikcnes / 2);
    pBottom[6] = new Offset(p[6].dx - cosTeta * thikcnes / 2, p[6].dy + sdoubleeta * thikcnes / 2);
    pBottom[7] = new Offset(p[7].dx - cosTeta * thikcnes / 2, p[7].dy + sdoubleeta * thikcnes / 2);
    pBottom[8] = new Offset(p[8].dx - cosTeta * thikcnes / 2, p[8].dy + sdoubleeta * thikcnes / 2);
    pBottom[9] = new Offset(p[9].dx - cosTeta * thikcnes / 2, p[9].dy + sdoubleeta * thikcnes / 2);

    if (thikcnes != 0) {
      paint0.strokeWidth = strokWidth;
      _State._drawArc(canvas, pTop[2], pTop[1], raduis + thikcnes / 2, paint0, pi / 2);
      _State._drawArc(canvas, pTop[3], pTop[4], raduis - thikcnes / 2, paint0, pi / 2);
      _State._drawArc(canvas, pTop[5], pTop[6], raduis - thikcnes / 2, paint0, teta);
      _State._drawArc(canvas, pTop[0], pTop[8], raduis + thikcnes / 2, paint0, teta);
      canvas.drawLine(Offset(pTop[6].dx, pTop[6].dy), Offset(pTop[7].dx, pTop[7].dy), paint0);
      canvas.drawLine(Offset(pTop[8].dx, pTop[8].dy), Offset(pTop[9].dx, pTop[9].dy), paint0);

      _State._drawArc(canvas, pBottom[5], pBottom[6], raduis + thikcnes / 2, paint0, teta);
      _State._drawArc(canvas, pBottom[0], pBottom[8], raduis - thikcnes / 2, paint0, teta);
      canvas.drawLine(Offset(pBottom[6].dx, pBottom[6].dy), Offset(pBottom[7].dx, pBottom[7].dy), paint0);
      canvas.drawLine(Offset(pBottom[8].dx, pBottom[8].dy), Offset(pBottom[9].dx, pBottom[9].dy), paint0);
      canvas.drawLine(Offset(pBottom[9].dx, pBottom[9].dy), Offset(pTop[9].dx, pTop[9].dy), paint0);
      canvas.drawLine(Offset(pBottom[7].dx, pBottom[7].dy), Offset(pTop[7].dx, pTop[7].dy), paint0);


      canvas.drawLine(Offset(pTop[1].dx, pTop[1].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
      canvas.drawLine(Offset(pTop[2].dx, pTop[2].dy), Offset(pTop[3].dx, pTop[3].dy), paint0);
      canvas.drawLine(Offset(pTop[5].dx, pTop[5].dy), Offset(pTop[4].dx, pTop[4].dy), paint0);

      _State._drawArc(canvas, pBottom[2], pBottom[1], raduis - thikcnes / 2, paint0, pi / 2);
      _State._drawArc(canvas, pBottom[3], pBottom[4], raduis + thikcnes / 2, paint0, pi / 2);
      canvas.drawLine(Offset(pBottom[1].dx, pBottom[1].dy), Offset(pBottom[0].dx, pBottom[0].dy), paint0);
      canvas.drawLine(Offset(pBottom[2].dx, pBottom[2].dy), Offset(pBottom[3].dx, pBottom[3].dy), paint0);
      canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pBottom[4].dx, pBottom[4].dy), paint0);

    }

    int paddingDimention = min((size.width/20).round(),(size.height/20).round());
    List<Offset> pDimention = new List(2);
    pDimention[0] = new Offset(p[1].dx - raduis - thikcnes / 2, p[1].dy - paddingDimention - thikcnes / 2);
    pDimention[1] = new Offset(centerX - thikcnes / 2 + width, p[1].dy - paddingDimention - thikcnes / 2);
    _State._drawDimention(context,canvas, pDimention[0], pDimention[1], textPaint, Width, textPaint, teta, _editTextSelect(_State._textEditingController ,mainCold.widthController));
    pDimention[0] = new Offset(pBottom[8].dx - paddingDimention * cosTeta,  pBottom[8].dy + paddingDimention * sdoubleeta);
    pDimention[1] = new Offset(pBottom[9].dx - paddingDimention * cosTeta,  pBottom[9].dy + paddingDimention * sdoubleeta);
    _State._drawDimention(context,canvas, pDimention[1], pDimention[0], textPaint, HeightLips, textPaint, teta, _editTextSelect(_State._textEditingController ,mainCold.h_lipController));
    pDimention[0] = new Offset (p[6].dx + width / 2,  pTop[1].dy);
    pDimention[1] = new Offset(p[6].dx + width / 2, pBottom[5].dy);
    _State._drawDimention(context,canvas, pDimention[0], pDimention[1], textPaint, Height, textPaint, pi / 2, _editTextSelect(_State._textEditingController ,mainCold.hieghtController));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class draw_u_cold_angle extends CustomPainter {

  _editTextSelect(TextEditingController editTextSelect,TextEditingController editText){
    if(editTextSelect.text == editText.text){
      return true;
    }else {
      return false;
    }
  }

  Paint paint0, textPaint;
  BuildContext context;
  bool Top = false;

  draw_u_cold_angle(this.context,this.paint0,this.textPaint,this.Top);

  @override
  void paint(Canvas canvas, Size size) {
    double teta = _State.teta = pi / 2;
    double tetaEave = _State.tetaEave;
    !Top ? _State.scale_r =  min((size.width*0.8) / (_State.width + _State.thickness),   (size.height*0.8) / (_State.height + 2 * _State.width * sin(tetaEave).abs()))
    : _State.scale_r =  min((size.width*0.8) / (_State.width + _State.thickness),   (size.height*0.8) / (_State.height + _State.h_lip * 2));
    //Canvas canvas;
    String Height = _State.height.toString();
    String HeightLips = _State.h_lip.toString();
    String Width = _State.width.toString();
    String Raduis = _State.raduis.toString()/*.substring(0,_State.raduis.toString().length-2)*/;
    double constant = 1;
    if ( _State.h_lip > 0) {
      constant = 1;
    }
    double sdoubleeta =    sin((teta - pi / 2));
    double cosTeta =    cos((teta - pi / 2));
    double sdoubleetaEave =    sin((tetaEave));
    double cosTetaEave =    cos((tetaEave));
    double tanTetaEave =    tan((tetaEave));
    double width = _State.width * _State.scale_r;
    double height = _State.height * _State.scale_r;
    double raduis = _State.raduis * _State.scale_r;
    double thikcnes = _State.thickness * _State.scale_r;
    double heightLips = _State.h_lip * _State.scale_r;
    double a = height - (raduis + thikcnes / 2 + (raduis + thikcnes / 2) * cosTetaEave);
    double b = width - 1 * (raduis + thikcnes / 2 + 0 * (raduis + thikcnes / 2));
    double c = constant * (heightLips);
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double strokWidth=2;
    List<Offset> p = new List(10);
    p[0] = new Offset(centerX + b / 2, centerY - a / 2 - (raduis) * cosTetaEave);
    p[1] = new Offset(p[0].dx - b, centerY - height / 2 + thikcnes / 2);
    p[2] = new Offset(centerX - b / 2 - raduis, centerY - a / 2);
    p[3] = new Offset(centerX - b / 2 - raduis, centerY + a / 2);
    p[4] = new Offset(centerX - b / 2, centerY + a / 2 + raduis);
    p[5] = new Offset(p[4].dx + b, p[4].dy);
    paint0.strokeWidth = 0.5;
    if (Top) {
      p[6] = new Offset(p[0].dx + raduis * cosTeta, p[0].dy - raduis * (1 - sdoubleeta));
      p[7] = new Offset(p[6].dx + heightLips * sdoubleeta, p[6].dy - heightLips * cosTeta);
      p[8] = new Offset(p[5].dx + raduis * cosTeta, p[5].dy + raduis * (1 - sdoubleeta));
      p[9] = new Offset(p[8].dx + heightLips * sdoubleeta, p[8].dy + heightLips * cosTeta);
    } else {
      p[6] = new Offset(p[0].dx + raduis * cosTeta, p[0].dy + raduis * (1 - sdoubleeta));
      p[7] = new Offset(p[6].dx + heightLips * sdoubleeta, p[6].dy + heightLips * cosTeta);
      p[8] = new Offset(p[5].dx + raduis * cosTeta, p[5].dy - raduis * (1 - sdoubleeta));
      p[9] = new Offset(p[8].dx + heightLips * sdoubleeta, p[8].dy - heightLips * cosTeta);
      p[1] = new Offset(p[2].dx + raduis * (1 - sdoubleetaEave), p[2].dy - raduis * cosTetaEave);
      p[0] = new Offset(p[1].dx + (b + raduis * sdoubleetaEave) * cosTetaEave, p[1].dy - (b + raduis * sdoubleetaEave) * sdoubleetaEave);
      p[6] = new Offset(p[0].dx +   raduis * (cosTetaEave + sdoubleetaEave), p[0].dy + raduis * cosTetaEave * (1 - tanTetaEave));
      p[7] = new Offset(p[6].dx + heightLips * sdoubleetaEave, p[6].dy + heightLips * cosTeta * cosTetaEave);
      if (tetaEave < pi/4) {
        canvas.translate(p[0].dx, p[0].dy);
        canvas.rotate(-tetaEave);
        _State._drawArc(canvas,Offset(0,0) , Offset(p[6].dx-p[0].dx,p[6].dy-p[0].dy), raduis, paint0, teta);
        canvas.rotate(tetaEave);
        canvas.translate(-p[0].dx, -p[0].dy);
      } else {
        canvas.translate(p[6].dx, p[6].dy);
        canvas.rotate(pi / 2 - tetaEave);
        _State._drawArc(canvas, Offset(p[0].dx-p[6].dx,p[0].dy-p[6].dy),  Offset(0,0) , raduis, paint0, teta);
        canvas.rotate(-pi / 2 + tetaEave);
        canvas.translate(-p[6].dx, -p[6].dy);
      }
    }
    _State._drawArcReight(canvas, p[2], p[1], raduis, paint0, pi / 2 - tetaEave);
    _State._drawArc(canvas, p[4], p[3], raduis, paint0, pi / 2);
    if (Top) {
      _State._drawArc(canvas, p[5], p[8], raduis, paint0, teta);
      _State._drawArc(canvas, p[6], p[0], raduis, paint0, teta);
      _State._drawArcDimention(context ,canvas,textPaint,Raduis,p[2],p[1],raduis,thikcnes,_editTextSelect(_State._textEditingController ,mainCold.radiusController));
    } else {
      _State._drawArc(canvas, p[8], p[5], raduis, paint0, teta);
      _State._drawArcDimention(context ,canvas,textPaint,Raduis,p[4],p[3],raduis,thikcnes,_editTextSelect(_State._textEditingController ,mainCold.radiusController));
    }
    canvas.drawLine(Offset(p[1].dx, p[1].dy), Offset(p[0].dx, p[0].dy), paint0);
    canvas.drawLine(Offset(p[2].dx, p[2].dy), Offset(p[3].dx, p[3].dy), paint0);
    canvas.drawLine(Offset(p[5].dx, p[5].dy),Offset(p[4].dx, p[4].dy), paint0);
    canvas.drawLine(Offset(p[6].dx, p[6].dy), Offset(p[7].dx, p[7].dy), paint0);
    canvas.drawLine(Offset(p[8].dx, p[8].dy), Offset(p[9].dx, p[9].dy), paint0);

    List<Offset> pTop = new List(10);
    pTop[0] = new Offset(p[0].dx - sdoubleetaEave * thikcnes / 2, p[0].dy - cosTetaEave * thikcnes / 2);
    pTop[1] = new Offset(p[1].dx - sdoubleetaEave * thikcnes / 2, p[1].dy - cosTetaEave * thikcnes / 2);
    pTop[2] = new Offset(p[2].dx - thikcnes / 2, p[2].dy);
    pTop[3] = new Offset(p[3].dx - thikcnes / 2, p[3].dy);
    pTop[4] = new Offset(p[4].dx, p[4].dy + thikcnes / 2);
    pTop[5] = new Offset(p[5].dx, p[5].dy + thikcnes / 2);

    if (Top) {
      pTop[6] = new Offset(p[6].dx - cosTeta * thikcnes / 2, p[6].dy - sdoubleeta * thikcnes / 2);
      pTop[7] = new Offset(p[7].dx - cosTeta * thikcnes / 2, p[7].dy - sdoubleeta * thikcnes / 2);
      pTop[8] = new Offset(p[8].dx - cosTeta * thikcnes / 2, p[8].dy + sdoubleeta * thikcnes / 2);
      pTop[9] = new Offset(p[9].dx - cosTeta * thikcnes / 2, p[9].dy + sdoubleeta * thikcnes / 2);
    } else {
      pTop[6] = new Offset(p[6].dx + cosTeta * thikcnes / 2 * cosTetaEave, p[6].dy - thikcnes / 2 * sdoubleetaEave);
      pTop[7] = new Offset(p[7].dx + cosTeta * thikcnes / 2 * cosTetaEave, p[7].dy - thikcnes / 2 * sdoubleetaEave);
      pTop[8] = new Offset(p[8].dx + cosTeta * thikcnes / 2, p[8].dy + sdoubleeta * thikcnes / 2);
      pTop[9] = new Offset(p[9].dx + cosTeta * thikcnes / 2, p[9].dy + sdoubleeta * thikcnes / 2);
    }
    List<Offset> pBottom = new List(10);
    pBottom[0] = new Offset(p[0].dx + sdoubleetaEave * thikcnes / 2, p[0].dy + cosTetaEave * thikcnes / 2);
    pBottom[1] = new Offset(p[1].dx + sdoubleetaEave * thikcnes / 2, p[1].dy + cosTetaEave * thikcnes / 2);
    pBottom[2] = new Offset(p[2].dx + thikcnes / 2, p[2].dy);
    pBottom[3] = new Offset(p[3].dx + thikcnes / 2, p[3].dy);
    pBottom[4] = new Offset(p[4].dx, p[4].dy - thikcnes / 2);
    pBottom[5] = new Offset(p[5].dx, p[5].dy - thikcnes / 2);
    if (Top) {
      pBottom[6] = new Offset(p[6].dx + cosTeta * thikcnes / 2, p[6].dy + sdoubleeta * thikcnes / 2);
      pBottom[7] = new Offset(p[7].dx + cosTeta * thikcnes / 2, p[7].dy + sdoubleeta * thikcnes / 2);
      pBottom[8] = new Offset(p[8].dx + cosTeta * thikcnes / 2, p[8].dy - sdoubleeta * thikcnes / 2);
      pBottom[9] = new Offset(p[9].dx + cosTeta * thikcnes / 2, p[9].dy - sdoubleeta * thikcnes / 2);
    } else {
      pBottom[6] = new Offset(p[6].dx - cosTeta * thikcnes / 2 * cosTetaEave, p[6].dy + sdoubleetaEave * thikcnes / 2);
      pBottom[7] = new Offset(p[7].dx - cosTeta * thikcnes / 2 * cosTetaEave, p[7].dy + sdoubleetaEave * thikcnes / 2);
      pBottom[8] = new Offset(p[8].dx - cosTeta * thikcnes / 2, p[8].dy - sdoubleeta * thikcnes / 2);
      pBottom[9] = new Offset(p[9].dx - cosTeta * thikcnes / 2, p[9].dy - sdoubleeta * thikcnes / 2);
    }

    if (thikcnes != 0) {
      paint0.strokeWidth = strokWidth;
      _State._drawArc(canvas, pTop[4], pTop[3], raduis + thikcnes / 2, paint0, pi / 2);
      _State._drawArcReight(canvas, pTop[2], pTop[1], (raduis + thikcnes / 2), paint0, pi / 2 - tetaEave);
      _State._drawArcReight(canvas, pBottom[2], pBottom[1], (raduis - thikcnes / 2), paint0, pi / 2 - tetaEave);
      canvas.drawLine(Offset(pTop[1].dx, pTop[1].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
      canvas.drawLine(Offset(pTop[2].dx, pTop[2].dy), Offset(pTop[3].dx, pTop[3].dy), paint0);
     canvas.drawLine(Offset(pTop[5].dx, pTop[5].dy), Offset(pTop[4].dx, pTop[4].dy), paint0);
     canvas.drawLine(Offset(pTop[6].dx, pTop[6].dy), Offset(pTop[7].dx, pTop[7].dy), paint0);
     canvas.drawLine(Offset(pTop[8].dx, pTop[8].dy), Offset(pTop[9].dx, pTop[9].dy), paint0);
     _State._drawArc(canvas, pBottom[4], pBottom[3], raduis - thikcnes / 2, paint0, pi / 2);
      if (Top) {
        _State._drawArc(canvas, pBottom[5], pBottom[8], raduis + thikcnes / 2, paint0, teta);
        _State._drawArc(canvas, pBottom[6], pBottom[0], raduis + thikcnes / 2, paint0, teta);
        _State._drawArc(canvas, pTop[5], pTop[8], raduis - thikcnes / 2, paint0, teta);
        _State._drawArc(canvas, pTop[6], pTop[0], raduis - thikcnes / 2, paint0, teta);
      } else {
        if (tetaEave < pi /4) {
          canvas.translate( pTop[0].dx, pTop[0].dy);
          canvas.rotate(-tetaEave);
          _State._drawArc(canvas, Offset(0,0) , Offset(pTop[6].dx-pTop[0].dx,pTop[6].dy-pTop[0].dy), raduis + thikcnes / 2, paint0, teta);
          canvas.rotate(tetaEave);
          canvas.translate(-pTop[0].dx,-pTop[0].dy);
          canvas.translate( pBottom[0].dx, pBottom[0].dy);
          canvas.rotate(-tetaEave);
          _State._drawArc(canvas, Offset(0,0) , Offset(pBottom[6].dx-pBottom[0].dx,pBottom[6].dy-pBottom[0].dy), raduis - thikcnes / 2, paint0, teta);
          canvas.rotate(tetaEave);
          canvas.translate(-pBottom[0].dx,-pBottom[0].dy);
         } else {
          canvas.translate(pTop[6].dx, pTop[6].dy);
          canvas.rotate(pi / 2 - tetaEave);
          _State._drawArc(canvas,  Offset(pTop[0].dx-pTop[6].dx,pTop[0].dy-pTop[6].dy),  Offset(0,0) , raduis + thikcnes / 2, paint0, teta);
          canvas.rotate(-pi / 2 + tetaEave);
          canvas.translate( -pTop[6].dx, -pTop[6].dy);
          canvas.translate(pBottom[6].dx, pBottom[6].dy);
          canvas.rotate(pi / 2 - tetaEave);
          _State._drawArc(canvas,  Offset(pBottom[0].dx-pBottom[6].dx,pBottom[0].dy-pBottom[6].dy),  Offset(0,0) , raduis - thikcnes / 2, paint0, teta);
          canvas.rotate(-pi / 2 + tetaEave);
          canvas.translate( -pBottom[6].dx, -pBottom[6].dy);
        }
        _State._drawArc(canvas, pBottom[8], pBottom[5], raduis - thikcnes / 2, paint0, teta);
        _State._drawArc(canvas, pTop[8], pTop[5], raduis + thikcnes / 2, paint0, teta);
      }
      canvas.drawLine(Offset(pBottom[1].dx, pBottom[1].dy), Offset(pBottom[0].dx, pBottom[0].dy), paint0);
          canvas.drawLine(Offset(pBottom[2].dx, pBottom[2].dy), Offset(pBottom[3].dx, pBottom[3].dy), paint0);
      canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pBottom[4].dx, pBottom[4].dy), paint0);
          canvas.drawLine(Offset(pBottom[6].dx, pBottom[6].dy), Offset(pBottom[7].dx, pBottom[7].dy), paint0);
      canvas.drawLine(Offset(pBottom[8].dx, pBottom[8].dy), Offset(pBottom[9].dx, pBottom[9].dy), paint0);
          canvas.drawLine(Offset(pBottom[7].dx, pBottom[7].dy), Offset(pTop[7].dx, pTop[7].dy), paint0);
      canvas.drawLine(Offset(pBottom[9].dx, pBottom[9].dy), Offset(pTop[9].dx, pTop[9].dy), paint0);
          }

    int paddingDimention = min((size.width/20).round(),(size.height/20).round());
    List<Offset> pDimention = new List(2);
    pDimention[0] = new Offset(p[4].dx - raduis - thikcnes / 2, p[4].dy + paddingDimention + thikcnes / 2);
    pDimention[1] = new Offset(p[5].dx, p[5].dy + paddingDimention + thikcnes / 2);
    _State._drawDimention(context ,canvas, pDimention[1], pDimention[0], textPaint, Width, textPaint, teta, _editTextSelect(_State._textEditingController ,mainCold.widthController));
    pDimention[0] = new Offset(p[3].dx - paddingDimention - thikcnes / 2, pTop[1].dy);
    pDimention[1] = new Offset(p[3].dx - paddingDimention - thikcnes / 2, pTop[5].dy);
    _State._drawDimention(context ,canvas, pDimention[0], pDimention[1], textPaint, Height, textPaint, teta, _editTextSelect(_State._textEditingController ,mainCold.hieghtController));

    if (Top) {
      pDimention[0] = new Offset(p[6].dx + (paddingDimention + thikcnes / 2) * cosTeta, p[6].dy + paddingDimention * sdoubleeta);
      pDimention[1] = new Offset(p[7].dx + (paddingDimention + thikcnes / 2) * cosTeta, p[7].dy + paddingDimention * sdoubleeta);
      _State._drawDimention(context ,canvas, pDimention[0], pDimention[1], textPaint, HeightLips, textPaint, teta, _editTextSelect(_State._textEditingController ,mainCold.h_lipController));
    } else {
      pDimention[0] = new Offset(p[8].dx + (paddingDimention + thikcnes / 2) * cosTeta, p[8].dy - paddingDimention * sdoubleeta);
      pDimention[1] = new Offset(p[9].dx + (paddingDimention + thikcnes / 2) * cosTeta, p[9].dy - paddingDimention * sdoubleeta);
      _State._drawDimention(context ,canvas, pDimention[0], pDimention[1], textPaint, HeightLips, textPaint, teta, _editTextSelect(_State._textEditingController ,mainCold.h_lipController));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
