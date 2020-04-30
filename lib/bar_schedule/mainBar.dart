import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ruler_picker/ruler_picker.dart';
import 'package:stahl_section/bar_schedule/barCalculater.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/translate/app_localizations.dart';
import 'dart:math';

class mainBar extends StatefulWidget {
  @override
  _mainBarState createState() => _mainBarState();
}

class _mainBarState extends State<mainBar> {
  static String totalLenght = "Total length : ";
  static Rect rect_lenght,
      rect_Hlenght,
      rect_Hlenght2,
      rect_Vlenght_reight,
      rect_Vlenght_left,
      rect_Dlenght,
      rect_DlenghtReight,
      rect_radus,
      rect_lip;
  static double length = 1000,
      Hlenght = 250,
      Hlenght2 = 150,
      Vlenght_reight = 100,
      Vlenght_left = 150,
      Dlenght_left = 300,
      Dlenght_reight = 300,
      radius = 2500,
      lip,
      selectRulerValue;
  static int diameter = 12;
  static bool lenghtb = true,
      Hlenghtb = false,
      Hlenght2b = false,
      Vlenght_reightb = false,
      Vlenght_leftb = false,
      Dlenghtb_left = false,
      Dlenghtb_reight = false,
      radusb = false,
      lipb = false,
      isHlenght2 = false;
  String symbol = "01";

  Paint paintBar, paint_dim, paintText_symbol, paintText;
  GlobalKey imageKey;

  @override
  void initState() {
    length = 1000;
    diameter = 12;
    imageKey = GlobalKey();
    _rulerPickerController = RulerPickerController(value: 600);
    _textEditingController = TextEditingController(text: '600');

    rect_lenght = rect_Hlenght = rect_Hlenght2 = rect_Vlenght_reight =
        rect_Vlenght_left = rect_Dlenght = rect_DlenghtReight =
            rect_radus = rect_lip = new Rect.fromLTRB(0, 0, 0, 0);
    paintBar = new Paint();
    paintBar.strokeWidth = double.parse('$diameter');
    paintBar.color = color.gray;
    paintBar.isAntiAlias = (true);
    paintBar.style = PaintingStyle.stroke;

    paint_dim = new Paint();
    paint_dim.strokeWidth = 2;
    paint_dim.color = color.red;
    paint_dim.isAntiAlias = (true);
    paint_dim.style = PaintingStyle.stroke;
    //paint_dim.setPathEffect(new DashPathEffect(new float[]{40, 20, 10, 20}, 0));

    paintText_symbol = new Paint();
    paintText_symbol.strokeWidth = 3;
    paintText_symbol.color = color.red;
    paintText_symbol.isAntiAlias = (true);
    paintText_symbol.style = PaintingStyle.stroke;
    //    paintText_symbol.(50);
    //  paintText_symbol.setTypeface(typefaceBold);

    paintText = new Paint();
    paintText.strokeWidth = 3;
    paintText.color = color.gray;
    paintText.isAntiAlias = (true);
    paintText.style = PaintingStyle.stroke;
//    paintText.setTextSize(30);
    //  paintText.setTypeface(typeface);
  }

  @override
  Widget build(BuildContext context) {
    totalLenght = AppLocalizations.of(context).translate('totalLength');
    return Scaffold(
      body: Container(
        color: color.black,
        child: Padding(
          padding: EdgeInsets.only(top: 25),
          child: Container(
            color: color.White,
            child: Column(
              children: <Widget>[
                _header(AppLocalizations.of(context).translate('barSchdule')),
                _table(),
                _raisedButton(),
                Container(
                  color: color.gray,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Text(
                      AppLocalizations.of(context)
                          .translate('barBendingScudule'),
                      style: Theme.of(context).textTheme.headline.copyWith(
                            color: color.White,
                            fontWeight: FontWeight.bold,
                          )),
                ),
                _rowBF(),
                Expanded(
                  child: new Container(
                    width: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        _newDraw(),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: new Container(
                              color: color.gray,
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
      ),
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
            Text(
              title,
              style: Theme.of(context).textTheme.headline,
            )
          ],
        ),
      ),
    );
  }

  _table() {
    return Container(
      width: double.infinity,
      color: color.gray,
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(3),
              color: color.White,
              width: double.infinity,
              margin: EdgeInsets.only(right: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate('size'),
                      style: Theme.of(context).textTheme.headline.copyWith(
                          color: color.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  _dropDownButton(),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              color: color.White,
              width: double.infinity,
              margin: EdgeInsets.only(right: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate('area'),
                      style: Theme.of(context).textTheme.headline.copyWith(
                          color: color.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(_roundToString(_area),
                        style: Theme.of(context).textTheme.headline.copyWith(
                            color: color.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              color: color.White,
              width: double.infinity,
              margin: EdgeInsets.only(right: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate('weight'),
                      style: Theme.of(context).textTheme.headline.copyWith(
                          color: color.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(_roundToString(_weight),
                        style: Theme.of(context).textTheme.headline.copyWith(
                            color: color.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _rowBF() {
    back() {
      switch (n_hook) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
          {
            if (n_type == 1) {
              n_hook = (n_hook -= 1);
              switch (n_hook) {
                case 0:
                  {
                    n_type = 2;
                  }
                  break;
                case 1:
                  {
                    n_type = 4;
                  }
                  break;
                case 2:
                  {
                    n_type = 8;
                  }
                  break;
                case 3:
                  {
                    n_type = 4;
                  }
                  break;
                case 4:
                  {
                    n_type = 6;
                  }
                  break;
              }
            } else {
              n_type -= 1;
            }
          }
          break;
      }
      if (n_hook == 2 && n_type == 2) {
        Hlenght = 600;
        length = 250;
      } else {
        Hlenght = 250;
        length = 600;
      }
    }

    forward() {
      switch (n_hook) {
        case 0:
          {
            if (n_type == 2) {
              n_hook = (1);
              n_type = 1;
            } else {
              n_type += 1;
            }
          }
          break;
        case 1:
          {
            if (n_type == 4) {
              n_hook = (2);
              n_type = 1;
            } else {
              n_type += 1;
            }
          }
          break;
        case 2:
          {
            if (n_type == 8) {
              n_hook = (3);
              n_type = 1;
            } else {
              n_type += 1;
            }
          }
          break;
        case 3:
          {
            if (n_type == 4) {
              n_hook = (4);
              n_type = 1;
            } else {
              n_type += 1;
            }
          }
          break;
        case 4:
          {
            if (n_type == 6) {
              n_hook = (4);
              n_type = 1;
            } else {
              n_type += 1;
            }
          }
          break;
      }
      if (n_hook == 2 && n_type == 2) {
        Hlenght = 600;
        length = 250;
      } else if (n_hook == 4 && n_type == 4) {
        Dlenght_reight = Dlenght_left;
        Vlenght_left = 2 * Vlenght_reight;
        Hlenght2 = Hlenght;
      } else {
        Hlenght = 250;
        length = 600;
        Hlenght2 = 150;
        Vlenght_reight = 100;
        Vlenght_left = 150;
        Dlenght_left = Dlenght_reight = 250;
      }
    }

    return Container(
      width: double.infinity,
      color: color.White,
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(3),
              color: color.White,
              width: double.infinity,
              margin: EdgeInsets.only(right: 4),
              child: RaisedButton(
                child: Icon(
                  Icons.arrow_back,
                  color: color.black,
                  size: 35,
                ),
                elevation: 2,
                onPressed: () {
                  setState(() {
                    back();
                  });
                },
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              color: color.White,
              width: double.infinity,
              margin: EdgeInsets.only(right: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate('n_hooks'),
                      style: Theme.of(context).textTheme.headline.copyWith(
                          color: color.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                  _dropDownHook(),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              color: color.White,
              width: double.infinity,
              margin: EdgeInsets.only(right: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate('n_type'),
                      style: Theme.of(context).textTheme.headline.copyWith(
                          color: color.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text('$n_type',
                        style: Theme.of(context).textTheme.headline.copyWith(
                            color: color.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(3),
              color: color.White,
              width: double.infinity,
              margin: EdgeInsets.only(right: 4),
              child: RaisedButton(
                child: Icon(
                  Icons.arrow_forward,
                  color: color.black,
                  size: 35,
                ),
                elevation: 2,
                onPressed: () {
                  setState(() {
                    forward();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _raisedButton() {
    const double radius = 15;
    return RaisedButton(
      onPressed: () {
           Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => barCalculater()),
        );
      },
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[color.White, color.WhiteSelver],
          ),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 17, right: 17),
          constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
          // min sizes for Material buttons
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context).translate('more'),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0, color: color.red, fontFamily: 'SegoeUI'),
          ),
        ),
      ),
    );
  }

  int n_hook = 0, n_type = 1;
  double _area = 113, _weight = 0.888;

  _dropDownButton() {
    getArea_WeightOfBar(String Diameter) {
      diameter = int.parse(Diameter);
      _area = pi * pow(diameter, 2) / 4;
      _weight = _area * 7852 / 1000000;
    }

    List<String> spinner = [
      6.toString(),
      8.toString(),
      10.toString(),
      12.toString(),
      14.toString(),
      16.toString(),
      20.toString(),
      22.toString(),
      25.toString(),
      28.toString(),
      32.toString(),
      40.toString(),
    ];
    return Container(
      alignment: Alignment.center,
      height: 36,
      margin: EdgeInsets.only(right: 1, top: 3),
      //decoration: _decoration(5, 2, color.White),
      width: double.infinity,
      //color: color.WhiteSelver,
      child: DropdownButton<String>(
        value: "$diameter",
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 10,
        style: Theme.of(context)
            .textTheme
            .headline
            .copyWith(fontSize: 20, color: color.red),
        underline: Container(
          height: 2,
          color: color.WhiteSelver,
        ),
        onChanged: (String data) {
          setState(() {
            getArea_WeightOfBar(data);
          });
        },
        items: spinner.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  _dropDownHook() {
    List<String> spinner = [
      0.toString(),
      1.toString(),
      2.toString(),
      3.toString(),
      4.toString(),
    ];
    return Container(
      alignment: Alignment.center,
      height: 40,
      margin: EdgeInsets.only(right: 1, top: 3),
      //decoration: _decoration(5, 2, color.White),
      width: double.infinity,
      //color: color.WhiteSelver,
      child: DropdownButton<String>(
        value: "$n_hook",
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 10,
        style: Theme.of(context).textTheme.headline.copyWith(
            fontSize: 20, color: color.red, fontWeight: FontWeight.bold),
        underline: Container(
          height: 2,
          color: color.WhiteSelver,
        ),
        onChanged: (String data) {
          setState(() {
            n_hook = int.parse(data);
          });
        },
        items: spinner.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  static String _format2(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  static String _format3(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 3);
  }

  static String _format5(double n) {
    n += 0.0000001;
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 5);
  }

  static String _format1(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  static String _roundToString(double x) {
    String X;
    if (x < 1) {
      X = _format3(x);
    } else if (x < 10) {
      X = _format2(x);
    } else if (x < 100) {
      X = _format1(x);
    } else if (x < 1000) {
      X = x.round().toString();
    } else if (x < 100000) {
      x = x / 10;
      X = (x.round() * 10).toString();
    } else if (x < 1000000) {
      x = x / 100;
      X = (x.round() * 100).toString();
    } else {
      x = x / 1000;
      X = (x.round() * 1000).toString();
    }
    if (x == 0) {
      X = "__";
    }
    return X;
  }

  RulerPickerController _rulerPickerController;
  static TextEditingController _textEditingController;
  num showValue = 600;

  _rulerPicker() {
    return RulerPicker(
      controller: _rulerPickerController,
      backgroundColor: color.gray,
      onValueChange: (value) {
        setState(() {
          _textEditingController.text = value.toString();
          lenghtb
              ? length = double.parse(_textEditingController.text)
              : Hlenghtb
                  ? Hlenght = double.parse(_textEditingController.text)
                  : Vlenght_leftb
                      ? Vlenght_left = double.parse(_textEditingController.text)
                      : Vlenght_reightb
                          ? Vlenght_reight =
                              double.parse(_textEditingController.text)
                          : Dlenghtb_left
                              ? Dlenght_left =
                                  double.parse(_textEditingController.text)
                              : Dlenghtb_reight
                                  ? Dlenght_reight =
                                      double.parse(_textEditingController.text)
                                  : Hlenght2 =
                                      double.parse(_textEditingController.text);
        });
      },
      width: MediaQuery.of(context).size.width,
    );
  }

  static _decoration(double radius, double width, Color Mcolor) {
    return BoxDecoration(
      color: Mcolor,
      border: Border.all(color: color.black, width: width),
      borderRadius: BorderRadius.all(
          Radius.circular(radius) //                 <--- border radius here
          ),
    );
  }

  static _drawTotal_length(Canvas c, Offset p, String text, Paint paintText) {
    TextStyle textStyle = new TextStyle(
        fontSize: 22,
        color: paintText.color,
        fontWeight: FontWeight.bold,
        /*fontFamily: 'SegoeUI'*/);
    TextSpan span = new TextSpan(style: textStyle, text: text);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(c, new Offset(p.dx - tp.width / 2, p.dy - tp.height));
  }

  static _drawSymbol(Canvas c, Offset p_symbol, double R_circle, String text,
      Paint paint, Paint paintSymbol) {
    c.drawCircle(p_symbol, R_circle, paint);
    TextStyle textStyle = new TextStyle(
        fontSize: 30,
        color: paintSymbol.color,
        fontWeight: FontWeight.bold,
        /*fontFamily: 'SegoeUI'*/);
    TextSpan span = new TextSpan(style: textStyle, text: text);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(
        c, new Offset(p_symbol.dx - tp.width / 2, p_symbol.dy - tp.height / 2));
  }

  static _drawDimention(Canvas c, double teta, double Xstart, double Ystart,
      double Xend, double Yend, Paint paint, String s, Paint paintText) {
    //rect_lenght = rect_Hlenght = rect_Vlenght_reight = rect_Vlenght_left = rect_Dlenght = rect_radus = rect_lip = new Rect.fromLTRB();
    TextStyle textStyle = new TextStyle(
        fontSize: 16, color: paintText.color, fontWeight: FontWeight.normal);
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
            new Offset(0 - tp.width / 2,0/*start.dx - tp.width / 2,
                (start.dy + end.dy).abs() / 2 + tp.height + ca*/));
        rect_Vlenght_reight = new Rect.fromLTRB(
            (start.dx),
            (start.dy + end.dy).abs() / 2 - tp.width / 2 - ca,
            start.dx + tp.height + 1 * ca,
            (start.dy + end.dy).abs() / 2 + tp.width / 2 + ca);
      } else {
        tp.paint(
            c,
            new Offset(
                0- tp.width / 2, 0.0 - tp.height));
        rect_Vlenght_left = new Rect.fromLTRB(
            start.dx - (tp.height + 1 * ca),
            (start.dy + end.dy).abs() / 2 - tp.width / 2 - ca,
            start.dx,
            (start.dy + end.dy).abs() / 2 + tp.width / 2 + ca);
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
        rect_lenght = new Rect.fromLTRB(
            (end.dx + start.dx) / 2 - tp.width / 2 - ca,
            start.dy,
            (end.dx + start.dx) / 2 + tp.width / 2 + ca,
            start.dy + tp.height + ca * 2);
      } else {
        tp.paint(c,
            new Offset((end.dx + start.dx) / 2 - tp.width / 2, start.dy - ca - tp.height));
        if (!isHlenght2) {
          rect_Hlenght2 = new Rect.fromLTRB(0, 0, 0, 0);
          rect_Hlenght = new Rect.fromLTRB(
              (end.dx + start.dx) / 2 - tp.width / 2 - ca,
              start.dy - tp.height - 2 * ca,
              (end.dx + start.dx) / 2 + tp.width / 2 + ca,
              start.dy);
        } else
          rect_Hlenght2 = new Rect.fromLTRB(
              (end.dx + start.dx) / 2 - tp.width / 2 - ca,
              start.dy - tp.height - 2 * ca,
              (end.dx + start.dx) / 2 + tp.width / 2 + ca,
              start.dy);
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
      if (start.dx > end.dx)
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
            (end.dy + start.dy) / 2);
      if (Dlenghtb_left && start.dx > end.dx) {
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
      /*rect_Dlenght = new Rect.fromLTRB((end.dx + start.dx) / 2 - (bounds.width / 2 + ca) * sinTeta, (end.dy + start.dy) / 2 - (2 * ca + bounds.height) * sinTeta, (end.dx + start.dx) / 2 + (bounds.width / 2 + ca) * sinTeta, (end.dy + start.dy) / 2 + (bounds.height) * sinTeta);
       */
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
  }

  _newDraw() {
    bool _PointinRect(Offset p, Rect rectF) {
      if (p.dx >= rectF.left &&
          p.dx < rectF.right &&
          p.dy < rectF.bottom &&
          p.dy > rectF.top) {
        return true;
      }
      return false;
    }

    handleTouch(TapDownDetails dragUpdateDetails) {
      final RenderBox renderBoxRed = imageKey.currentContext.findRenderObject();
      double currentX = dragUpdateDetails.localPosition.dx;
      double currentY = dragUpdateDetails.localPosition.dy;
      if (_PointinRect(new Offset(currentX, currentY), rect_lenght))
        _setTrue("lenght");
      else if (_PointinRect(
          new Offset(currentX, currentY), rect_Vlenght_reight))
        _setTrue("Vlength_reight");
      else if (_PointinRect(new Offset(currentX, currentY), rect_Vlenght_left))
        _setTrue("Vlength_left");
      else if (_PointinRect(new Offset(currentX, currentY), rect_Hlenght))
        _setTrue("Hlength");
      else if (_PointinRect(new Offset(currentX, currentY), rect_Hlenght2))
        _setTrue("Hlength2");
      else if (_PointinRect(new Offset(currentX, currentY), rect_DlenghtReight))
        _setTrue("Dlength_reight");
      else if (_PointinRect(new Offset(currentX, currentY), rect_Dlenght))
        _setTrue("Dlenght");
    }

    if (n_hook == 0 && n_type == 1) {
      //imageBack.setEnabled(false);
    } else {
      //imageBack.setEnabled(true);
    }
    if (n_hook == 4 && n_type == 5) {
      //imageForward.setEnabled(false);
    } else {
      //imageForward.setEnabled(true);
    }
    symbol = '$n_hook' + '$n_type';
    return Stack(
      children: <Widget>[
        new Positioned.fill(
          child: GestureDetector(
            onTapDown: (dragUpdateDetails) {
              setState(() {
                handleTouch(dragUpdateDetails);
              });
            },
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 50),
              color: color.White,
              key: imageKey,
              child: symbol == '01' ? CustomPaint(
                painter: drawBar_01(
                          paintBar, paint_dim, paintText_symbol, paintText),
                    )
                  : symbol == '02' ? CustomPaint(
                painter: drawBar_02(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '11' ? CustomPaint(
                painter: drawBar_11(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '12' ? CustomPaint(
                painter: drawBar_12(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '13' ? CustomPaint(
                painter: drawBar_13(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '14' ? CustomPaint(
                painter: drawBar_14(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '21' ? CustomPaint(
                painter: drawBar_21(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '22' ? CustomPaint(
                painter: drawBar_22(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '23' ? CustomPaint(
                painter: drawBar_23(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '24' ? CustomPaint(
                painter: drawBar_24(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '25' ? CustomPaint(
                painter: drawBar_25(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '26' ? CustomPaint(
                painter: drawBar_26(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '27' ? CustomPaint(
                painter: drawBar_27(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '28' ? CustomPaint(
                painter: drawBar_28(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '31' ? CustomPaint(
                painter: drawBar_31(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '32' ? CustomPaint(
                painter: drawBar_32(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '33' ? CustomPaint(
                painter: drawBar_33(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '34' ? CustomPaint(
                painter: drawBar_34(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '41' ? CustomPaint(
                painter: drawBar_41(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '42' ? CustomPaint(
                painter: drawBar_42(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '43' ? CustomPaint(
                painter: drawBar_43(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '44' ? CustomPaint(
                painter: drawBar_44(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : symbol == '45' ? CustomPaint(
                painter: drawBar_45(
                    paintBar, paint_dim, paintText_symbol, paintText),
              )
                  : Container(),
            ),
          ),
        ),
      ],
    );
    /*    break;
     case "21":
        //bmp = drawBar_21(length, Vlenght_reight, Vlenght_left, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "22":
        //bmp = drawBar_22(length, Vlenght_reight, Vlenght_left, Hlenght, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "23":
        //bmp = drawBar_23(length, Vlenght_reight, Vlenght_left, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "24":
        //bmp = drawBar_24(length, Vlenght_reight, Vlenght_left, Dlenght_reight, Dlenght_left, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "25":
        //bmp = drawBar_25(length, Hlenght, Vlenght_reight, Dlenght_reight, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "26":
        //bmp = drawBar_26(Dlenght_reight, Hlenght, Vlenght_reight, Vlenght_left, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "27":
        //bmp = drawBar_27(Dlenght_reight, Hlenght, Vlenght_reight, Vlenght_left, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "28":
        //bmp = drawBar_28(length, Vlenght_left, Hlenght, Dlenght_left, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "31":
        //bmp = drawBar_31(length, Vlenght_reight, Vlenght_left, Hlenght, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "32":
        //bmp = drawBar_32(length, Hlenght, Vlenght_reight, Vlenght_left, Dlenght_reight, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "33":
        //bmp = drawBar_33(length, Hlenght, Vlenght_reight, Vlenght_left, Dlenght_reight, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "34":
        //bmp = drawBar_34(length, Vlenght_reight, Vlenght_left, Hlenght, Dlenght_reight, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "41":
        //bmp = drawBar_41(length, Vlenght_reight, Vlenght_left, Hlenght, Hlenght2, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "42":
        //bmp = drawBar_42(length, Vlenght_reight, Vlenght_left, Hlenght, Hlenght2, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "43":
        //bmp = drawBar_43(length, Vlenght_reight, Vlenght_left, Dlenght_reight, Dlenght_left, Hlenght, Hlenght2, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "44":
        if (Vlenght_left <= Vlenght_reight) {
          // Toast.makeText(getApplicationContext(), "error input", Toast.LENGTH_SHORT).show();
          return;
        }
        //bmp = drawBar_44(length, Vlenght_reight, Vlenght_left, Hlenght, Hlenght2, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
      case "45":
        // bmp = drawBar_45(length, Hlenght, Vlenght_reight, Vlenght_left, Dlenght_reight, (int) diameter, paintBar, paint_dim, paintText_symbol, paintText);
        break;
    }*/
  }

  _setTrue(String s) {
    lenghtb = false;
    Hlenghtb = false;
    Hlenght2b = false;
    Vlenght_reightb = false;
    Vlenght_leftb = false;
    Dlenghtb_left = false;
    Dlenghtb_reight = false;
    radusb = false;
    lipb = false;
    if ("lenght" == (s)) {
      lenghtb = true;
      _rulerPickerController.value = (length);
    } else if ("Hlength" == (s)) {
      Hlenghtb = true;
      _rulerPickerController.value = (Hlenght);
    } else if ("Hlength2" == (s)) {
      Hlenght2b = true;
      _rulerPickerController.value = (Hlenght2);
    } else if ("Vlength_reight" == (s)) {
      Vlenght_reightb = true;
      _rulerPickerController.value = (Vlenght_reight);
    } else if ("Vlength_left" == (s)) {
      Vlenght_leftb = true;
      _rulerPickerController.value = (Vlenght_left);
    } else if ("Dlenght" == (s)) {
      Dlenghtb_left = true;
      _rulerPickerController.value = (Dlenght_left);
    } else if ("Dlength_reight" == (s)) {
      Dlenghtb_reight = true;
      _rulerPickerController.value = (Dlenght_reight);
    } else if ("Radius" == (s)) {
      radusb = true;
      _rulerPickerController.value = (radius);
    } else if ("lip" == (s)) {
      lipb = true;
      _rulerPickerController.value = (lip);
    }
  }

  static _drawArc(Canvas c, Offset start, Offset end, double raduis, Paint paint,
      double teta) {
    //مع عقارب الساعة
    Rect rectF;
    if (start.dx > end.dx && start.dy < end.dy) {
      rectF = _getRectF(end, raduis, false);
      c.drawArc(rectF, pi / 2, -teta, false, paint);
    } else if (start.dx > end.dx && start.dy > end.dy) {
      rectF = _getRectF(start, raduis, false);
      c.drawArc(rectF, pi / 2, pi - teta, false, paint);
    } else if (start.dx < end.dx && start.dy >= end.dy) {
      rectF = _getRectF(end, raduis, true);
      c.drawArc(rectF, 3 * pi / 2, -teta, false, paint);
    } else if (start.dx < end.dx && start.dy < end.dy) {
      rectF = _getRectF(start, raduis, true);
      c.drawArc(rectF, 3 * pi / 2, pi - teta, false, paint);
    } else if (start.dx == end.dx && start.dy < end.dy) {
      rectF = _getRectF(start, raduis, true);
      c.drawArc(rectF, 3 * pi / 2, pi, false, paint);
    }
  }

  static Rect _getRectF(Offset p, double raduis, bool top) {
    Rect rectF;
    if (top) {
      rectF = new Rect.fromLTRB(
          p.dx - raduis, p.dy, p.dx + raduis, p.dy + 2 * raduis);
    } else {
      rectF = new Rect.fromLTRB(
          p.dx - raduis, p.dy - 2 * raduis, p.dx + raduis, p.dy);
    }
    return rectF;
  }

  static _getRadius(double Diameter) {
    double r = Diameter *  2.0;
    return r;
  }
}

class drawBar_01 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_01(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border = min(centerX / 5, centerY / 5);
    double R_circle = 25;
    double scale = ((width - 4 * L_border) / length);
    String sLength = _mainBarState._roundToString(length);
    length *= scale;
    Diameter *= scale;
    paintBar.strokeWidth = Diameter + 0.0;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(
        canvas, p_symbol, R_circle, "01", paintText, paintText_symbol);

    List<Offset> pBar = new List(2);
    pBar[0] = new Offset(centerX - length / 2.0, centerY);
    pBar[1] = new Offset(centerX + length / 2.0, centerY);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy),
        Offset(pBar[0].dx, pBar[0].dy), paintBar);

    _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[0].dy + d_dim,
        pBar[1].dx, pBar[1].dy + d_dim, paint_dim, sLength, paintText);

    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border);
    _mainBarState._drawTotal_length(canvas, p_length,
        _mainBarState.totalLenght + " " + sLength, paintText_symbol);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_02 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;


  drawBar_02(this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);


  getTeta(double length, double Vlength) {
    double alfa = 0;
    for (alfa = 1; alfa < 179; alfa += 0.1) {
      if ((Vlength * sin(alfa * pi / 180) * 2 <= length * (1 - cos(alfa * pi / 180))))
        return alfa;
    }
    return alfa;


  }

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double vLength = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    int constant = 0;
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double teta = (getTeta(length, vLength) * pi / 180.0);//alfa / 2
    double Radius = length / (2 * sin(teta));
    double scale = min((width - 6 * L_border) / length, (height - 2 * L_border) / (2 * vLength));
    String sLength = _mainBarState._roundToString(length);
    String sTotalLength = _mainBarState._roundToString(Radius * teta * 2);
    String sVLength = _mainBarState._roundToString(vLength);
    String sRadius = _mainBarState._roundToString(Radius);
    length *= scale;
    vLength *= scale;
    Radius *= scale;
    Diameter *= scale;
    paintBar.strokeWidth = (Diameter);
    Diameter *= scale;
    int d_dim = (12 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "02", paintText, paintText_symbol);

    Offset pBar0 = new Offset(centerX, centerY - vLength / 2 - L_border);
    for (double i = 0; i < (teta-0.001); i += 0.001) {
      double xL1 = pBar0.dx - Radius * sin(i);
      double xR1 = pBar0.dx + Radius * sin(i);
      double yL1 = pBar0.dy + Radius * (1 - cos(i));
      double yR1 = pBar0.dy + Radius * (1 - cos(i));
      double xL2 = pBar0.dx - Radius * sin(i + 0.001);
      double xR2 = pBar0.dx + Radius * sin(i + 0.001);
      double yL2 = pBar0.dy + Radius * (1 - cos(i+0.001));
      double yR2 = pBar0.dy + Radius * (1 - cos(i+0.001));
      canvas.drawLine(Offset(xL1, yL1),Offset(xL2, yL2), paintBar);
      canvas.drawLine(Offset(xR1, yR1),Offset(xR2, yR2), paintBar);
    }
    List<Offset> pBar = new List(2);
    pBar[0] = new Offset(centerX - length / 2, pBar0.dy + vLength);
    pBar[1] = new Offset(centerX + length / 2, pBar[0].dy);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[0].dy + d_dim, pBar[1].dx, pBar[1].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[1].dx + d_dim, pBar[1].dy, pBar[1].dx + d_dim, pBar0.dy, paint_dim, sVLength, paintText);

    TextStyle textStyle = new TextStyle(
        fontSize: 20, color: paintText.color, fontWeight: FontWeight.normal);
    TextSpan span = new TextSpan(style: textStyle, text: "R = " + sRadius);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();


    Offset pRadius = new Offset(pBar0.dx - Radius * sin(teta / 2), pBar0.dy + Radius * (1 - cos(teta / 2)));
    double lengthDim = length / 6;
    canvas.drawLine(Offset(pRadius.dx, pRadius.dy), Offset(pRadius.dx - lengthDim * sin(teta / 2), pRadius.dy - lengthDim * cos(teta / 2)), paint_dim);
    canvas.drawLine(Offset(pRadius.dx, pRadius.dy), Offset(pRadius.dx - lengthDim / 3 * sin(teta / 2 + 0.785), pRadius.dy - lengthDim / 3 * cos(teta / 2 + 0.785)), paint_dim);
    canvas.drawLine(Offset(pRadius.dx, pRadius.dy), Offset(pRadius.dx - lengthDim / 3 * sin(teta / 2 - 0.785), pRadius.dy - lengthDim / 3 * cos(teta / 2 - 0.785)), paint_dim);
    canvas.translate( pRadius.dx - (lengthDim + tp.height) * sin(teta / 2), pRadius.dy - (lengthDim + tp.height) * cos(teta / 2));
    canvas.rotate(-teta / (pi / (pi/2)));
    tp.paint(canvas, Offset(0 /*- lengthDim * sin(teta / 2)*/, 0 /*- lengthDim * cos(teta / 2)*/));
    canvas.rotate(teta / (pi / (pi/2)));
    canvas.translate(-(pRadius.dx - (lengthDim + tp.height)* sin(teta / 2)), -(pRadius.dy - (lengthDim + tp.height)* cos(teta / 2)));
    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + sTotalLength, paintText_symbol);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_11 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_11(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double vLenght = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double scale = min((width - 8 * L_border) / length, (height - 4 * L_border) / vLenght);
    double raduis = Diameter * 2;
    String sLength = _mainBarState._roundToString(length);
    String sVLength = _mainBarState._roundToString(vLenght);
    String STotalLenght = _mainBarState._roundToString(length + vLenght + (1.57 - 2) * raduis);
    length *= scale;
    vLenght *= scale;
    Diameter *= scale;
    raduis *= scale;
    paintBar.strokeWidth = Diameter;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "11", paintText, paintText_symbol);

    List<Offset> pBar = new List(4);
    pBar[0] = new Offset(centerX - length / 2, centerY + vLenght / 2);
    pBar[1] = new Offset(centerX + length / 2 - raduis, centerY + vLenght / 2);
    pBar[2] = new Offset(centerX + length / 2, centerY + vLenght / 2 - raduis);
    pBar[3] = new Offset(centerX + length / 2, centerY - vLenght / 2);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    _mainBarState._drawArc(canvas, pBar[2], pBar[1], raduis, paintBar, pi/2);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[0].dy + d_dim, pBar[2].dx, pBar[1].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[2].dx + d_dim, pBar[0].dy, pBar[2].dx + d_dim, pBar[3].dy, paint_dim, sVLength, paintText);

    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_12 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_12(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double vLenght = _mainBarState.Vlenght_reight;
    double HLenght = _mainBarState.Hlenght;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double scale = min((width - 8 * L_border) / length, (height - 4 * L_border) / vLenght / 2);
    String sLength = _mainBarState._roundToString(length);
    String sVLength = _mainBarState._roundToString(vLenght);
    String sHLength = _mainBarState._roundToString(HLenght);
    String STotalLenght = _mainBarState._roundToString(length + vLenght + 0.57 * HLenght);
    length *= scale;
    vLenght *= scale;
    Diameter *= scale;
    HLenght *= scale;
    paintBar.strokeWidth = Diameter;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "12", paintText, paintText_symbol);

    List<Offset> pBar = new List(4);
    pBar[0] = new Offset(centerX - length / 2, centerY + vLenght / 2);
    pBar[1] = new Offset(centerX + length / 2 - vLenght / 2, centerY + vLenght / 2);
    pBar[2] = new Offset(centerX + length / 2 - vLenght / 2, centerY - vLenght / 2);
    pBar[3] = new Offset(pBar[2].dx - HLenght / 2, centerY - vLenght / 2);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    _mainBarState._drawArc(canvas, pBar[2], pBar[1], vLenght / 2, paintBar,  pi /2);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[0].dy + d_dim, pBar[1].dx + vLenght / 2, pBar[1].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[2].dx + vLenght / 2, pBar[2].dy - d_dim, pBar[3].dx, pBar[3].dy - d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[2].dx + vLenght / 2 + d_dim, pBar[0].dy, pBar[2].dx + vLenght / 2 + d_dim, pBar[3].dy, paint_dim, sVLength, paintText);
    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_13 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_13(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  getAlfa(double Dlength, double Vlength, double raduis) {
    int alfa = 0;
    for (alfa = 0; alfa < 180; alfa++) {
      if ((Vlength - raduis * cos(alfa * pi / 180)) <= Dlength * sin(alfa * pi / 180))
        return alfa;
    }
    return alfa;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double vLenght = _mainBarState.Vlenght_reight;
    double DLenght = _mainBarState.Dlenght_left;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double raduis = Diameter * 2;
    double alfa = getAlfa(DLenght, vLenght, raduis) * pi / 180 ;
    double sinAlfa = sin(alfa);
    double cosAlfa = cos(alfa);
    double scale = min((width - 8 * L_border) / length, (height - 4 * L_border) / vLenght / 2);
    String sLength = _mainBarState._roundToString(length);
    String sVLength = _mainBarState._roundToString(vLenght);
    String sDLength = _mainBarState._roundToString(DLenght);
    String STotalLenght = _mainBarState._roundToString(length + DLenght + alfa * raduis);
    length *= scale;
    vLenght *= scale;
    Diameter *= scale;
    DLenght *= scale;
    raduis *= scale;
    paintBar.strokeWidth = Diameter;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "13", paintText, paintText_symbol);

    List<Offset> pBar = new List(4);
    pBar[0] = new Offset(centerX - length / 2, centerY + vLenght / 2);
    pBar[1] = new Offset(centerX + length / 2, centerY + vLenght / 2);
    pBar[2] = new Offset(centerX + length / 2 + raduis * sinAlfa, centerY + vLenght / 2 - raduis * (1 + cosAlfa));
    pBar[3] = new Offset(pBar[2].dx - DLenght * cosAlfa, centerY - vLenght / 2);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    _mainBarState._drawArc(canvas, pBar[2], pBar[1], raduis, paintBar, pi - alfa - 0.001);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[0].dy + d_dim, pBar[1].dx, pBar[1].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas, alfa, pBar[2].dx + d_dim * sinAlfa, pBar[2].dy - d_dim * cosAlfa, pBar[3].dx + d_dim * sinAlfa, pBar[3].dy - d_dim * cosAlfa, paint_dim, sDLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[2].dx + raduis / 2 + d_dim, pBar[0].dy, pBar[2].dx + raduis / 2 + d_dim, pBar[3].dy, paint_dim, sVLength, paintText);
    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_14 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_14(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double vLenght = _mainBarState.Vlenght_left;
    double DLenght = _mainBarState.Dlenght_left;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double alfa = acos(vLenght / DLenght);
    double sinAlfa = sin(alfa);
    double cosAlfa = cos(alfa);
    double scale = min((width - 8 * L_border) / (length + DLenght * sinAlfa), (height - 4 * L_border) / vLenght / 2);
    String sLength = _mainBarState._roundToString(length);
    String sVLength = _mainBarState._roundToString(vLenght);
    String sDLength = _mainBarState._roundToString(DLenght);
    String STotalLenght = _mainBarState._roundToString(length + DLenght);
    length *= scale;
    vLenght *= scale;
    Diameter *= scale;
    DLenght *= scale;
    paintBar.strokeWidth = Diameter;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "14", paintText, paintText_symbol);

    List<Offset> pBar = new List(3);
    pBar[0] = new Offset(centerX - (length + DLenght * sinAlfa) / 2, centerY - vLenght / 2);
    pBar[1] = new Offset(pBar[0].dx + DLenght * sinAlfa, pBar[0].dy + DLenght * cosAlfa);
    pBar[2] = new Offset(pBar[1].dx + length, pBar[1].dy);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[2].dx, pBar[2].dy), paintBar);
    _mainBarState._drawDimention(canvas, 0, pBar[1].dx, pBar[1].dy + d_dim, pBar[2].dx, pBar[2].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas,  pi /2 - alfa, pBar[0].dx + d_dim * cosAlfa, pBar[0].dy - d_dim * sinAlfa, pBar[1].dx + d_dim * cosAlfa, pBar[1].dy - d_dim * sinAlfa, paint_dim, sDLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx - d_dim, pBar[0].dy, pBar[0].dx - d_dim, pBar[1].dy, paint_dim, sVLength, paintText);
    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_21 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_21(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double scale = min((width - 8 * L_border) / length, (height - 4 * L_border) / max(vLenght_reight, vLenght_left) / 2);
    double raduis = Diameter * 2;
    String sLength = _mainBarState._roundToString(length);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String STotalLenght = _mainBarState._roundToString(length + vLenght_reight + vLenght_left + (1.57 - 2) * 2 * raduis);
    length *= scale;
    vLenght_reight *= scale;
    vLenght_left *= scale;
    Diameter *= scale;
    raduis *= scale;
    paintBar.strokeWidth = Diameter;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "21", paintText, paintText_symbol);

    List<Offset> pBar = new List(6);
    pBar[0] = new Offset(centerX - length / 2, centerY - vLenght_left / 2);
    pBar[1] = new Offset(centerX - length / 2, centerY + vLenght_left / 2 - raduis);
    pBar[2] = new Offset(centerX - length / 2 + raduis, centerY + vLenght_left / 2);
    pBar[3] = new Offset(centerX + length / 2 - raduis, centerY + vLenght_left / 2);
    pBar[4] = new Offset(centerX + length / 2, centerY + vLenght_left / 2 - raduis);
    pBar[5] = new Offset(centerX + length / 2, centerY + vLenght_left / 2 - vLenght_reight);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    canvas.drawLine(Offset(pBar[4].dx, pBar[4].dy), Offset(pBar[5].dx, pBar[5].dy), paintBar);
        _mainBarState._drawArc(canvas, pBar[2], pBar[1], raduis, paintBar,  pi /2);
    _mainBarState._drawArc(canvas, pBar[4], pBar[3], raduis, paintBar,  pi /2);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx - d_dim, pBar[0].dy, pBar[1].dx - d_dim, pBar[2].dy, paint_dim, sVLength_left, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[2].dy + d_dim, pBar[4].dx, pBar[3].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[4].dx + d_dim, pBar[3].dy, pBar[5].dx + d_dim, pBar[5].dy, paint_dim, sVLength_reight, paintText);

    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_22 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_22(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double lenght = _mainBarState.length;
    double HLength = _mainBarState.Hlenght;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double scale = min((width - 8 * L_border) / HLength, (height - 4 * L_border) / max(vLenght_reight, vLenght_left) / 2);
    double raduis = Diameter * 2;
    String sLength = _mainBarState._roundToString(lenght);
    String sHLength = _mainBarState._roundToString(HLength);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String STotalLenght = _mainBarState._roundToString(HLength + vLenght_left + lenght + (1.57 - 2) * raduis + (pi / 2 - 1) * vLenght_reight);
    lenght *= scale;
    HLength *= scale;
    vLenght_reight *= scale;
    vLenght_left *= scale;
    Diameter *= scale;
    raduis *= scale;
    paintBar.strokeWidth = Diameter;

    int d_dim = (15 + Diameter).round();
    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "22", paintText, paintText_symbol);

    List<Offset> pBar = new List(7);
    pBar[0] = new Offset(centerX - HLength / 2, centerY + vLenght_left / 2);
    pBar[1] = new Offset(centerX - HLength / 2, centerY - vLenght_left / 2 + raduis);
    pBar[2] = new Offset(centerX - HLength / 2 + raduis, centerY - vLenght_left / 2);
    pBar[3] = new Offset(centerX + HLength / 2 - vLenght_reight / 2, centerY - vLenght_left / 2);
    pBar[4] = new Offset(centerX + HLength / 2 - vLenght_reight / 2, centerY - vLenght_left / 2 + vLenght_reight);
    pBar[5] = new Offset(pBar[4].dx - lenght, centerY - vLenght_left / 2 + vLenght_reight);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    canvas.drawLine(Offset(pBar[4].dx, pBar[4].dy), Offset(pBar[5].dx, pBar[5].dy), paintBar);
    _mainBarState._drawArc(canvas, pBar[1], pBar[2], raduis, paintBar,  pi /2);
    _mainBarState._drawArc(canvas, pBar[3], pBar[4], vLenght_reight / 2, paintBar,  pi /2);
    _mainBarState._drawDimention(canvas, 0, pBar[1].dx - d_dim, pBar[2].dy, pBar[0].dx - d_dim, pBar[0].dy, paint_dim, sVLength_left, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[3].dx + vLenght_reight / 2, pBar[3].dy - d_dim, pBar[0].dx, pBar[2].dy - d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[4].dx + d_dim + vLenght_reight / 2, pBar[5].dy, pBar[4].dx + d_dim + vLenght_reight / 2, pBar[3].dy, paint_dim, sVLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[5].dx, pBar[5].dy + d_dim, pBar[4].dx + vLenght_reight / 2, pBar[4].dy + d_dim, paint_dim, sLength, paintText);

    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_23 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_23(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double HLength = _mainBarState.Hlenght;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double scale = min((width - 8 * L_border) / length, (height - 4 * L_border) / (vLenght_reight + vLenght_left) / 2);
    double raduis = Diameter * 2;
    String sLength = _mainBarState._roundToString(length);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String STotalLenght = _mainBarState._roundToString(length + vLenght_reight + vLenght_left + (1.57 - 2) * 2 * raduis);
    length *= scale;
    vLenght_reight *= scale;
    vLenght_left *= scale;
    Diameter *= scale;
    raduis *= scale;
    paintBar.strokeWidth = Diameter;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "23", paintText, paintText_symbol);

    List<Offset> pBar = new List(6);
    pBar[0] = new Offset(centerX - length / 2, centerY - vLenght_left / 2);
    pBar[1] = new Offset(centerX - length / 2, centerY + vLenght_left / 2 - raduis);
    pBar[2] = new Offset(centerX - length / 2 + raduis, centerY + vLenght_left / 2);
    pBar[3] = new Offset(centerX + length / 2 - raduis, centerY + vLenght_left / 2);
    pBar[4] = new Offset(centerX + length / 2, centerY + vLenght_left / 2 + raduis);
    pBar[5] = new Offset(centerX + length / 2, centerY + vLenght_left / 2 + vLenght_reight);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    canvas.drawLine(Offset(pBar[4].dx, pBar[4].dy), Offset(pBar[5].dx, pBar[5].dy), paintBar);
        _mainBarState._drawArc(canvas, pBar[2], pBar[1], raduis, paintBar,  pi /2);
    _mainBarState._drawArc(canvas, pBar[3], pBar[4], raduis, paintBar,  pi /2);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx - d_dim, pBar[0].dy, pBar[1].dx - d_dim, pBar[2].dy, paint_dim, sVLength_left, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[0].dy - d_dim, pBar[4].dx, pBar[0].dy - d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[4].dx + d_dim, pBar[5].dy, pBar[4].dx + d_dim, pBar[3].dy, paint_dim, sVLength_reight, paintText);

    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_24 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_24(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double DLenght_left = _mainBarState.Dlenght_left;
    double DLenght_reight = _mainBarState.Dlenght_reight;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double alfa_left = (acos(vLenght_left / DLenght_left));
    double sinAlfa_left = sin(alfa_left);
    double cosAlfa_left = cos(alfa_left);
    double alfa_reight = (acos(vLenght_reight / DLenght_reight));
    double sinAlfa_reight = sin(alfa_reight);
    double cosAlfa_reight = cos(alfa_reight);
    double scale = min((width - 8 * L_border) / (length + DLenght_left * sinAlfa_left + DLenght_reight * sinAlfa_reight), (height - 4 * L_border) / max(vLenght_left, vLenght_reight) / 2);
    String sLength = _mainBarState._roundToString(length);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sDLength_reight = _mainBarState._roundToString(DLenght_reight);
    String sDLength_left = _mainBarState._roundToString(DLenght_left);
    String STotalLenght = _mainBarState._roundToString(length + DLenght_left + DLenght_reight);
    length *= scale;
    vLenght_left *= scale;
    Diameter *= scale;
    DLenght_left *= scale;
    vLenght_reight *= scale;
    DLenght_reight *= scale;
    paintBar.strokeWidth = Diameter;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "24", paintText, paintText_symbol);

    List<Offset> pBar = new List(4);
    pBar[0] = new Offset(centerX - (length + DLenght_left * sinAlfa_left) / 2, centerY - vLenght_left / 2);
    pBar[1] = new Offset(pBar[0].dx + DLenght_left * sinAlfa_left, pBar[0].dy + DLenght_left * cosAlfa_left);
    pBar[2] = new Offset(pBar[1].dx + length, pBar[1].dy);
    pBar[3] = new Offset(pBar[2].dx + DLenght_reight * sinAlfa_reight, pBar[1].dy - DLenght_reight * cosAlfa_reight);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[2].dx, pBar[2].dy), paintBar);
    canvas.drawLine(Offset(pBar[3].dx, pBar[3].dy), Offset(pBar[2].dx, pBar[2].dy), paintBar);
    _mainBarState._drawDimention(canvas, 0, pBar[1].dx, pBar[1].dy + d_dim, pBar[2].dx, pBar[2].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas,  pi /2 - alfa_left, pBar[1].dx + d_dim * cosAlfa_left, pBar[1].dy - d_dim * sinAlfa_left, pBar[0].dx + d_dim * cosAlfa_left, pBar[0].dy - d_dim * sinAlfa_left, paint_dim, sDLength_left, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx - d_dim, pBar[0].dy, pBar[0].dx - d_dim, pBar[1].dy, paint_dim, sVLength_left, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[3].dx + d_dim, pBar[2].dy, pBar[3].dx + d_dim, pBar[3].dy, paint_dim, sVLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 3*pi/2 + alfa_reight, pBar[2].dx - d_dim * cosAlfa_reight, pBar[2].dy - d_dim * sinAlfa_reight, pBar[3].dx - d_dim * cosAlfa_reight, pBar[3].dy - d_dim * sinAlfa_reight, paint_dim, sDLength_reight, paintText);
    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_25 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_25(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double HLenght = _mainBarState.Hlenght;
    double DLenght_reight = _mainBarState.Dlenght_reight;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double alfa_reight = (acos(vLenght_reight / DLenght_reight) );
    double sinAlfa_reight = sin(alfa_reight);
    double cosAlfa_reight = cos(alfa_reight);
    double scale = min((width - 8 * L_border) / (length + DLenght_reight * sinAlfa_reight + HLenght), (height - 4 * L_border) / vLenght_reight / 2);
    String sLength = _mainBarState._roundToString(length);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sDLength_reight = _mainBarState._roundToString(DLenght_reight);
    String sHLength = _mainBarState._roundToString(HLenght);
    String STotalLenght = _mainBarState._roundToString(length + HLenght + DLenght_reight);
    length *= scale;
    Diameter *= scale;
    HLenght *= scale;
    vLenght_reight *= scale;
    DLenght_reight *= scale;
    paintBar.strokeWidth = Diameter;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "25", paintText, paintText_symbol);

    List<Offset> pBar = new List(4);
    pBar[0] = new Offset(centerX - (length + DLenght_reight * sinAlfa_reight + HLenght) / 2, centerY + vLenght_reight / 2);
    pBar[1] = new Offset(pBar[0].dx + length, pBar[0].dy);
    pBar[2] = new Offset(pBar[1].dx + DLenght_reight * sinAlfa_reight, pBar[1].dy - DLenght_reight * cosAlfa_reight);
    pBar[3] = new Offset(pBar[2].dx + HLenght, pBar[2].dy);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[2].dx, pBar[2].dy), paintBar);
    canvas.drawLine(Offset(pBar[3].dx, pBar[3].dy), Offset(pBar[2].dx, pBar[2].dy), paintBar);
        _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[0].dy + d_dim, pBar[1].dx, pBar[1].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[3].dx, pBar[3].dy - d_dim, pBar[2].dx, pBar[2].dy - d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[3].dx + d_dim, pBar[1].dy, pBar[3].dx + d_dim, pBar[3].dy, paint_dim, sVLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 3*pi/2 + alfa_reight, pBar[1].dx - d_dim * cosAlfa_reight, pBar[1].dy - d_dim * sinAlfa_reight, pBar[2].dx - d_dim * cosAlfa_reight, pBar[2].dy - d_dim * sinAlfa_reight, paint_dim, sDLength_reight, paintText);
    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_26 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_26(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double HLenght = _mainBarState.Hlenght;
    double DLenght_reight = _mainBarState.Dlenght_reight;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double radius = _mainBarState._getRadius(Diameter);
    double alfa_reight = (acos(vLenght_left / DLenght_reight));
    double sinAlfa_reight = sin(alfa_reight);
    double cosAlfa_reight = cos(alfa_reight);
    double scale = min((width - 8 * L_border) / (DLenght_reight * sinAlfa_reight + HLenght), (height - 4 * L_border) / max(vLenght_left, vLenght_reight) / 2);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String sDLength_reight = _mainBarState._roundToString(DLenght_reight);
    String sHLength = _mainBarState._roundToString(HLenght);
    String STotalLenght = _mainBarState._roundToString(DLenght_reight + HLenght + vLenght_reight + (2 - 1.57) * radius);
    Diameter *= scale;
    radius *= scale;
    HLenght *= scale;
    vLenght_reight *= scale;
    vLenght_left *= scale;
    DLenght_reight *= scale;
    paintBar.strokeWidth = Diameter;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "26", paintText, paintText_symbol);

    List<Offset> pBar = new List(5);
    pBar[0] = new Offset(centerX - (DLenght_reight * sinAlfa_reight + HLenght) / 2, centerY + max(vLenght_left, vLenght_reight) / 2);
    pBar[1] = new Offset(pBar[0].dx + DLenght_reight * sinAlfa_reight, pBar[0].dy - DLenght_reight * cosAlfa_reight);
    pBar[2] = new Offset(pBar[1].dx + HLenght - radius, pBar[1].dy);
    pBar[3] = new Offset(pBar[2].dx + radius, pBar[2].dy + radius);
    pBar[4] = new Offset(pBar[3].dx, pBar[2].dy + vLenght_reight);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[2].dx, pBar[2].dy), paintBar);
    canvas.drawLine(Offset(pBar[3].dx, pBar[3].dy), Offset(pBar[4].dx, pBar[4].dy), paintBar);
        _mainBarState._drawArc(canvas, pBar[2], pBar[3], radius, paintBar,  pi /2);
    _mainBarState._drawDimention(canvas, 3 * pi / 2 + alfa_reight, pBar[0].dx - d_dim * cosAlfa_reight, pBar[0].dy - d_dim * sinAlfa_reight, pBar[1].dx - d_dim * cosAlfa_reight, pBar[1].dy - d_dim * sinAlfa_reight, paint_dim, sDLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[3].dx, pBar[2].dy - d_dim, pBar[1].dx, pBar[1].dy - d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[4].dx + d_dim, pBar[4].dy, pBar[3].dx + d_dim, pBar[2].dy, paint_dim, sVLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx - d_dim, pBar[1].dy, pBar[0].dx - d_dim, pBar[0].dy, paint_dim, sVLength_left, paintText);
    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_27 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_27(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double HLenght = _mainBarState.Hlenght;
    double DLenght_reight = _mainBarState.Dlenght_reight;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double radius = _mainBarState._getRadius(Diameter);
    double alfa_reight = (acos(vLenght_left / DLenght_reight) );
    double sinAlfa_reight = sin(alfa_reight);
    double cosAlfa_reight = cos(alfa_reight);
    double scale = min((width - 8 * L_border) / (DLenght_reight * sinAlfa_reight + HLenght), (height - 4 * L_border) / max(vLenght_left, vLenght_reight) / 2);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String sDLength_reight = _mainBarState._roundToString(DLenght_reight);
    String sHLength = _mainBarState._roundToString(HLenght);
    String STotalLenght = _mainBarState._roundToString(DLenght_reight + HLenght + vLenght_reight + (2 - 1.57) * radius);
    Diameter *= scale;
    radius *= scale;
    HLenght *= scale;
    vLenght_reight *= scale;
    vLenght_left *= scale;
    DLenght_reight *= scale;
    paintBar.strokeWidth = Diameter;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "27", paintText, paintText_symbol);

    List<Offset> pBar = new List(5);
    pBar[0] = new Offset(centerX - (DLenght_reight * sinAlfa_reight + HLenght) / 2, centerY + max(vLenght_left, vLenght_reight) / 2);
    pBar[1] = new Offset(pBar[0].dx + DLenght_reight * sinAlfa_reight, pBar[0].dy - DLenght_reight * cosAlfa_reight);
    pBar[2] = new Offset(pBar[1].dx + HLenght - radius, pBar[1].dy);
    pBar[3] = new Offset(pBar[2].dx + radius, pBar[2].dy - radius);
    pBar[4] = new Offset(pBar[3].dx, pBar[2].dy - vLenght_reight);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[2].dx, pBar[2].dy), paintBar);
    canvas.drawLine(Offset(pBar[3].dx, pBar[3].dy), Offset(pBar[4].dx, pBar[4].dy), paintBar);
        _mainBarState._drawArc(canvas, pBar[3], pBar[2], radius, paintBar,  pi /2);
    _mainBarState._drawDimention(canvas, 3 * pi / 2 + alfa_reight, pBar[0].dx - d_dim * cosAlfa_reight, pBar[0].dy - d_dim * sinAlfa_reight, pBar[1].dx - d_dim * cosAlfa_reight, pBar[1].dy - d_dim * sinAlfa_reight, paint_dim, sDLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[3].dx, pBar[2].dy - d_dim, pBar[1].dx, pBar[1].dy - d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[3].dx + d_dim, pBar[2].dy, pBar[3].dx + d_dim, pBar[4].dy, paint_dim, sVLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx - d_dim, pBar[1].dy, pBar[0].dx - d_dim, pBar[0].dy, paint_dim, sVLength_left, paintText);
    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_28 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_28(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  getAlfa(double Dlength, double Vlength, double raduis) {
    int alfa = 0;
    for (alfa = 0; alfa < 180; alfa++) {
      if ((Vlength - raduis * cos(alfa * pi / 180)) <= Dlength * sin(alfa * pi / 180))
        return alfa;
    }
    return alfa;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double Hlength = _mainBarState.Hlenght;
    double DLenght_left = _mainBarState.Dlenght_left;
    double vLenght_left = _mainBarState.Vlenght_left;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double raduis = _mainBarState._getRadius(Diameter);
    double alfa = getAlfa(DLenght_left, vLenght_left, raduis) * pi / 180;
    double sinAlfa = sin(alfa);
    double cosAlfa = cos(alfa);
    double scale = min((width - 8 * L_border) / max(length, DLenght_left * sinAlfa + Hlength), (height - 4 * L_border) / vLenght_left / 2);
    String sLength = _mainBarState._roundToString(length);
    String sVLength = _mainBarState._roundToString(vLenght_left);
    String sDLength = _mainBarState._roundToString(DLenght_left);
    String sHLength = _mainBarState._roundToString(Hlength);
    String STotalLenght = _mainBarState._roundToString(length + DLenght_left + Hlength + alfa * raduis);
    length *= scale;
    vLenght_left *= scale;
    Hlength *= scale;
    Diameter *= scale;
    DLenght_left *= scale;
    raduis *= scale;
    paintBar.strokeWidth = Diameter;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "28", paintText, paintText_symbol);

    List<Offset> pBar = new List(5);
    pBar[0] = new Offset(centerX - max(length, DLenght_left * sinAlfa + Hlength) / 2, centerY + vLenght_left / 2);
    pBar[1] = new Offset(pBar[0].dx + length, pBar[0].dy);
    pBar[2] = new Offset(pBar[1].dx + raduis * sinAlfa, pBar[1].dy - raduis * (1 + cosAlfa));
    pBar[3] = new Offset(pBar[2].dx - DLenght_left * cosAlfa, centerY - vLenght_left / 2);
    pBar[4] = new Offset(pBar[3].dx - Hlength, pBar[3].dy);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    canvas.drawLine(Offset(pBar[4].dx, pBar[4].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    _mainBarState._drawArc(canvas, pBar[2], pBar[1], raduis, paintBar, pi - alfa - 0.0001);
    _mainBarState._drawDimention(canvas, 0, pBar[3].dx, pBar[3].dy - d_dim, pBar[4].dx, pBar[4].dy - d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[0].dy + d_dim, pBar[1].dx, pBar[1].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas, alfa, pBar[2].dx + d_dim * sinAlfa, pBar[2].dy - d_dim * cosAlfa, pBar[3].dx + d_dim * sinAlfa, pBar[3].dy - d_dim * cosAlfa, paint_dim, sDLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx - d_dim, pBar[4].dy, pBar[0].dx - d_dim, pBar[0].dy, paint_dim, sVLength, paintText);
    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_31 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_31(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double lenght = _mainBarState.length;
    double HLength = _mainBarState.Hlenght;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double scale = min((width - 8 * L_border) / max(lenght, HLength), (height - 4 * L_border) / (vLenght_reight + vLenght_left) / 2);
    double raduis = _mainBarState._getRadius(Diameter);
    String sLength = _mainBarState._roundToString(lenght);
    String sHLength = _mainBarState._roundToString(HLength);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String STotalLenght = _mainBarState._roundToString(HLength + vLenght_left + lenght + (1.57 - 2) * raduis * 3 + vLenght_reight);
    lenght *= scale;
    HLength *= scale;
    vLenght_reight *= scale;
    vLenght_left *= scale;
    Diameter *= scale;
    raduis *= scale;
    paintBar.strokeWidth = Diameter;

    int d_dim = (15 + Diameter).round();
    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "31", paintText, paintText_symbol);

    List<Offset> pBar = new List(8);
    pBar[0] = new Offset(centerX - max(lenght, HLength) / 2 + HLength, centerY - (vLenght_left + vLenght_reight) / 2);
    pBar[1] = new Offset(pBar[0].dx - HLength + raduis, pBar[0].dy);
    pBar[2] = new Offset(pBar[1].dx - raduis, pBar[1].dy + raduis);
    pBar[3] = new Offset(pBar[2].dx, pBar[0].dy + vLenght_left - raduis);
    pBar[4] = new Offset(pBar[3].dx + raduis, pBar[3].dy + raduis);
    pBar[5] = new Offset(pBar[3].dx + lenght - raduis, pBar[4].dy);
    pBar[6] = new Offset(pBar[5].dx + raduis, pBar[5].dy + raduis);
    pBar[7] = new Offset(pBar[6].dx, pBar[4].dy + vLenght_reight);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    canvas.drawLine(Offset(pBar[4].dx, pBar[4].dy), Offset(pBar[5].dx, pBar[5].dy), paintBar);
    canvas.drawLine(Offset(pBar[6].dx, pBar[6].dy), Offset(pBar[7].dx, pBar[7].dy), paintBar);
    _mainBarState._drawArc(canvas, pBar[2], pBar[1], raduis, paintBar,  pi /2);
    _mainBarState._drawArc(canvas, pBar[4], pBar[3], raduis, paintBar,  pi /2);
    _mainBarState._drawArc(canvas, pBar[5], pBar[6], raduis, paintBar,  pi /2);
    _mainBarState._drawDimention(canvas, 0, pBar[2].dx - d_dim, pBar[0].dy, pBar[2].dx - d_dim, pBar[4].dy, paint_dim, sVLength_left, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[0].dy - d_dim, pBar[2].dx, pBar[1].dy - d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[6].dx + d_dim, pBar[7].dy, pBar[6].dx + d_dim, pBar[5].dy, paint_dim, sVLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[3].dx, pBar[5].dy + d_dim, pBar[6].dx, pBar[5].dy + d_dim, paint_dim, sLength, paintText);

    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_32 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_32(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double HLenght = _mainBarState.Hlenght;
    double DLenght_reight = _mainBarState.Dlenght_reight;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double radius = _mainBarState._getRadius(Diameter);
    double alfa_reight = (acos(vLenght_left / DLenght_reight));
    double sinAlfa_reight = sin(alfa_reight);
    double cosAlfa_reight = cos(alfa_reight);
    double scale = min((width - 8 * L_border) / (length + DLenght_reight * sinAlfa_reight + HLenght), (height - 4 * L_border) / max(vLenght_reight, vLenght_reight) / 2);
    String sLength = _mainBarState._roundToString(length);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sDLength_reight = _mainBarState._roundToString(DLenght_reight);
    String sHLength = _mainBarState._roundToString(HLenght);
    String STotalLenght = _mainBarState._roundToString(length + HLenght + DLenght_reight + vLenght_reight - (1.57 - 2) * radius);
    length *= scale;
    Diameter *= scale;
    HLenght *= scale;
    vLenght_reight *= scale;
    vLenght_left *= scale;
    DLenght_reight *= scale;
    radius*= scale;
    paintBar.strokeWidth = Diameter;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "32", paintText, paintText_symbol);

    List<Offset> pBar = new List(6);
    pBar[0] = new Offset(centerX - (length + DLenght_reight * sinAlfa_reight + HLenght) / 2, centerY + max(vLenght_reight, vLenght_left) / 2);
    pBar[1] = new Offset(pBar[0].dx + length, pBar[0].dy);
    pBar[2] = new Offset(pBar[1].dx + DLenght_reight * sinAlfa_reight, pBar[1].dy - DLenght_reight * cosAlfa_reight);
    pBar[3] = new Offset(pBar[2].dx + HLenght - radius, pBar[2].dy);
    pBar[4] = new Offset(pBar[3].dx + radius, pBar[3].dy + radius);
    pBar[5] = new Offset(pBar[3].dx + radius, pBar[3].dy + vLenght_reight);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[2].dx, pBar[2].dy), paintBar);
    canvas.drawLine(Offset(pBar[3].dx, pBar[3].dy), Offset(pBar[2].dx, pBar[2].dy), paintBar);
    canvas.drawLine(Offset(pBar[4].dx, pBar[4].dy), Offset(pBar[5].dx, pBar[5].dy), paintBar);
    _mainBarState._drawArc(canvas, pBar[3], pBar[4], radius, paintBar,  pi /2);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[0].dy + d_dim, pBar[1].dx, pBar[1].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[4].dx, pBar[3].dy - d_dim, pBar[2].dx, pBar[2].dy - d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[5].dx + d_dim, pBar[5].dy, pBar[4].dx + d_dim, pBar[3].dy, paint_dim, sVLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx - d_dim, pBar[2].dy, pBar[0].dx - d_dim, pBar[0].dy, paint_dim, sVLength_left, paintText);
    _mainBarState._drawDimention(canvas, 3 * pi / 2 + alfa_reight, pBar[1].dx - d_dim * cosAlfa_reight, pBar[1].dy - d_dim * sinAlfa_reight, pBar[2].dx - d_dim * cosAlfa_reight, pBar[2].dy - d_dim * sinAlfa_reight, paint_dim, sDLength_reight, paintText);
    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_33 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_33(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double HLenght = _mainBarState.Hlenght;
    double DLenght_reight = _mainBarState.Dlenght_reight;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double radius = _mainBarState._getRadius(Diameter);
    double alfa_reight =  (acos(vLenght_left / DLenght_reight));
    double sinAlfa_reight = sin(alfa_reight);
    double cosAlfa_reight = cos(alfa_reight);
    double scale = min((width - 8 * L_border) / (length + DLenght_reight * sinAlfa_reight + HLenght), (height - 4 * L_border) / (vLenght_reight + vLenght_reight) / 2);
    String sLength = _mainBarState._roundToString(length);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sDLength_reight = _mainBarState._roundToString(DLenght_reight);
    String sHLength = _mainBarState._roundToString(HLenght);
    String STotalLenght = _mainBarState._roundToString(length + HLenght + DLenght_reight + vLenght_reight - (1.57 - 2) * radius);
    length *= scale;
    Diameter *= scale;
    HLenght *= scale;
    vLenght_reight *= scale;
    vLenght_left *= scale;
    DLenght_reight *= scale;
    radius*= scale;
    paintBar.strokeWidth = Diameter;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "33", paintText, paintText_symbol);

    List<Offset> pBar = new List(6);
    pBar[0] = new Offset(centerX - (length + DLenght_reight * sinAlfa_reight + HLenght) / 2, centerY + (vLenght_reight + vLenght_left) / 2);
    pBar[1] = new Offset(pBar[0].dx + length, pBar[0].dy);
    pBar[2] = new Offset(pBar[1].dx + DLenght_reight * sinAlfa_reight, pBar[1].dy - DLenght_reight * cosAlfa_reight);
    pBar[3] = new Offset(pBar[2].dx + HLenght - radius, pBar[2].dy);
    pBar[4] = new Offset(pBar[3].dx + radius, pBar[3].dy - radius);
    pBar[5] = new Offset(pBar[3].dx + radius, pBar[3].dy - vLenght_reight);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[2].dx, pBar[2].dy), paintBar);
    canvas.drawLine(Offset(pBar[3].dx, pBar[3].dy), Offset(pBar[2].dx, pBar[2].dy), paintBar);
    canvas.drawLine(Offset(pBar[4].dx, pBar[4].dy), Offset(pBar[5].dx, pBar[5].dy), paintBar);
    _mainBarState._drawArc(canvas, pBar[4], pBar[3], radius, paintBar,  pi /2);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[0].dy + d_dim, pBar[1].dx, pBar[1].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[4].dx, pBar[3].dy - d_dim, pBar[2].dx, pBar[2].dy - d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[5].dx + d_dim, pBar[3].dy, pBar[4].dx + d_dim, pBar[5].dy, paint_dim, sVLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx - d_dim, pBar[2].dy, pBar[0].dx - d_dim, pBar[0].dy, paint_dim, sVLength_left, paintText);
    _mainBarState._drawDimention(canvas, 3 * pi / 2 + alfa_reight, pBar[1].dx - d_dim * cosAlfa_reight, pBar[1].dy - d_dim * sinAlfa_reight, pBar[2].dx - d_dim * cosAlfa_reight, pBar[2].dy - d_dim * sinAlfa_reight, paint_dim, sDLength_reight, paintText);
    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_34 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_34(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double lenght = _mainBarState.length;
    double HLength = _mainBarState.Hlenght;
    double Dlength_reight = _mainBarState.Dlenght_reight;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double alfa_reight =  (acos(vLenght_reight / Dlength_reight));
    double sinAlfa_reight = sin(alfa_reight);
    double cosAlfa_reight = cos(alfa_reight);
    double scale = min((width - 8 * L_border) / (lenght + Dlength_reight * sinAlfa_reight), (height - 4 * L_border) / max(vLenght_reight, vLenght_left) / 2);
    double raduis = _mainBarState._getRadius(Diameter);
    String sLength = _mainBarState._roundToString(lenght);
    String sDLength = _mainBarState._roundToString(Dlength_reight);
    String sHLength = _mainBarState._roundToString(HLength);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String STotalLenght = _mainBarState._roundToString(HLength + vLenght_left + lenght + (1.57 - 2) * raduis * 2 + Dlength_reight);
    lenght *= scale;
    HLength *= scale;
    Dlength_reight *= scale;
    vLenght_reight *= scale;
    vLenght_left *= scale;
    Diameter *= scale;
    raduis *= scale;
    paintBar.strokeWidth = Diameter;

    int d_dim = (15 + Diameter).round();
    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "34", paintText, paintText_symbol);

    List<Offset> pBar = new List(7);
    pBar[0] = new Offset(centerX - (lenght + Dlength_reight * sinAlfa_reight) / 2 + HLength, centerY - max(vLenght_left, vLenght_reight) / 2);
    pBar[1] = new Offset(pBar[0].dx - HLength + raduis, pBar[0].dy);
    pBar[2] = new Offset(pBar[1].dx - raduis, pBar[1].dy + raduis);
    pBar[3] = new Offset(pBar[2].dx, pBar[0].dy + vLenght_left - raduis);
    pBar[4] = new Offset(pBar[3].dx + raduis, pBar[3].dy + raduis);
    pBar[5] = new Offset(pBar[3].dx + lenght, pBar[4].dy);
    pBar[6] = new Offset(pBar[5].dx + Dlength_reight * sinAlfa_reight, pBar[5].dy - Dlength_reight * cosAlfa_reight);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    canvas.drawLine(Offset(pBar[4].dx, pBar[4].dy), Offset(pBar[5].dx, pBar[5].dy), paintBar);
    canvas.drawLine(Offset(pBar[6].dx, pBar[6].dy), Offset(pBar[5].dx, pBar[5].dy), paintBar);
    _mainBarState._drawArc(canvas, pBar[2], pBar[1], raduis, paintBar,  pi /2);
    _mainBarState._drawArc(canvas, pBar[4], pBar[3], raduis, paintBar,  pi /2);
    _mainBarState._drawDimention(canvas, 0, pBar[2].dx - d_dim, pBar[0].dy, pBar[2].dx - d_dim, pBar[4].dy, paint_dim, sVLength_left, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[0].dy - d_dim, pBar[2].dx, pBar[1].dy - d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[6].dx + d_dim, pBar[5].dy, pBar[6].dx + d_dim, pBar[6].dy, paint_dim, sVLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[3].dx, pBar[5].dy + d_dim, pBar[5].dx, pBar[5].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas, 3 * pi / 2 + alfa_reight, pBar[5].dx - d_dim * cosAlfa_reight, pBar[5].dy - d_dim * sinAlfa_reight, pBar[6].dx - d_dim * cosAlfa_reight, pBar[6].dy - d_dim * sinAlfa_reight, paint_dim, sDLength, paintText);

    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_41 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_41(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double lenght = _mainBarState.length;
    double HLength = _mainBarState.Hlenght;
    double HLength2 = _mainBarState.Hlenght2;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double scale = min((width - 8 * L_border) / (lenght), (height - 4 * L_border) / max(vLenght_reight, vLenght_left) / 2);
    double raduis = _mainBarState._getRadius(Diameter);
    String sLength = _mainBarState._roundToString(lenght);
    String sHLength2 = _mainBarState._roundToString(HLength2);
    String sHLength = _mainBarState._roundToString(HLength);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String STotalLenght = _mainBarState._roundToString(HLength + HLength2 + vLenght_left + lenght + vLenght_reight + (1.57 - 2) * raduis * 4);
    lenght *= scale;
    HLength *= scale;
    HLength2 *= scale;
    vLenght_reight *= scale;
    vLenght_left *= scale;
    Diameter *= scale;
    raduis *= scale;
    paintBar.strokeWidth = Diameter;

    int d_dim = (15 + Diameter).round();
    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "41", paintText, paintText_symbol);

    List<Offset> pBar = new List(10);
    pBar[0] = new Offset(centerX - max(lenght, HLength) / 2 + HLength, centerY - max(vLenght_left, vLenght_reight) / 2);
    pBar[1] = new Offset(pBar[0].dx - HLength + raduis, pBar[0].dy);
    pBar[2] = new Offset(pBar[1].dx - raduis, pBar[1].dy + raduis);
    pBar[3] = new Offset(pBar[2].dx, pBar[0].dy + vLenght_left - raduis);
    pBar[4] = new Offset(pBar[3].dx + raduis, pBar[3].dy + raduis);
    pBar[5] = new Offset(pBar[3].dx + lenght - raduis, pBar[4].dy);
    pBar[6] = new Offset(pBar[5].dx + raduis, pBar[5].dy - raduis);
    pBar[7] = new Offset(pBar[6].dx, pBar[6].dy - vLenght_reight + raduis);
    pBar[8] = new Offset(pBar[7].dx - raduis, pBar[7].dy - raduis);
    pBar[9] = new Offset(pBar[8].dx - HLength2 + raduis, pBar[8].dy);

    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    canvas.drawLine(Offset(pBar[4].dx, pBar[4].dy), Offset(pBar[5].dx, pBar[5].dy), paintBar);
    canvas.drawLine(Offset(pBar[6].dx, pBar[6].dy), Offset(pBar[7].dx, pBar[7].dy), paintBar);
    canvas.drawLine(Offset(pBar[8].dx, pBar[8].dy), Offset(pBar[9].dx, pBar[9].dy), paintBar);
    _mainBarState._drawArc(canvas, pBar[2], pBar[1], raduis, paintBar,  pi /2);
    _mainBarState._drawArc(canvas, pBar[4], pBar[3], raduis, paintBar,  pi /2);
    _mainBarState._drawArc(canvas, pBar[6], pBar[5], raduis, paintBar,  pi /2);
    _mainBarState._drawArc(canvas, pBar[8], pBar[7], raduis, paintBar,  pi /2);
    _mainBarState._drawDimention(canvas, 0, pBar[2].dx - d_dim, pBar[0].dy, pBar[2].dx - d_dim, pBar[4].dy, paint_dim, sVLength_left, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[0].dy - d_dim, pBar[2].dx, pBar[1].dy - d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[6].dx + d_dim, pBar[5].dy, pBar[6].dx + d_dim, pBar[8].dy, paint_dim, sVLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[3].dx, pBar[5].dy + d_dim, pBar[6].dx, pBar[5].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState.isHlenght2 = true;
    _mainBarState._drawDimention(canvas, 0, pBar[6].dx, pBar[8].dy - d_dim, pBar[9].dx, pBar[8].dy - d_dim, paint_dim, sHLength2, paintText);
    _mainBarState.isHlenght2  = false;

    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_42 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_42(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double lenght = _mainBarState.length;
    double HLength = _mainBarState.Hlenght;
    double HLength2 = _mainBarState.Hlenght2;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double scale = min((width - 8 * L_border) / (lenght + HLength + HLength2), (height - 4 * L_border) / max(vLenght_reight, vLenght_left) / 2);
    double raduis = _mainBarState._getRadius(Diameter);
    String sLength = _mainBarState._roundToString(lenght);
    String sHLength2 = _mainBarState._roundToString(HLength2);
    String sHLength = _mainBarState._roundToString(HLength);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String STotalLenght = _mainBarState._roundToString(HLength + HLength2 + vLenght_left + lenght + vLenght_reight + (1.57 - 2) * raduis * 4);
    lenght *= scale;
    HLength *= scale;
    HLength2 *= scale;
    vLenght_reight *= scale;
    vLenght_left *= scale;
    Diameter *= scale;
    raduis *= scale;
    paintBar.strokeWidth = Diameter;

    int d_dim = (15 + Diameter).round();
    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "42", paintText, paintText_symbol);

    List<Offset> pBar = new List(10);
    pBar[0] = new Offset(centerX - (lenght + HLength + HLength2) / 2, centerY - vLenght_left / 2);
    pBar[1] = new Offset(pBar[0].dx + HLength - raduis, pBar[0].dy);
    pBar[2] = new Offset(pBar[1].dx + raduis, pBar[1].dy + raduis);
    pBar[3] = new Offset(pBar[2].dx, pBar[0].dy + vLenght_left - raduis);
    pBar[4] = new Offset(pBar[3].dx + raduis, pBar[3].dy + raduis);
    pBar[5] = new Offset(pBar[3].dx + lenght - raduis, pBar[4].dy);
    pBar[6] = new Offset(pBar[5].dx + raduis, pBar[5].dy - raduis);
    pBar[7] = new Offset(pBar[6].dx, pBar[6].dy - vLenght_reight + raduis);
    pBar[8] = new Offset(pBar[7].dx + raduis, pBar[7].dy - raduis);
    pBar[9] = new Offset(pBar[8].dx + HLength2 - raduis, pBar[8].dy);

    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    canvas.drawLine(Offset(pBar[4].dx, pBar[4].dy), Offset(pBar[5].dx, pBar[5].dy), paintBar);
    canvas.drawLine(Offset(pBar[6].dx, pBar[6].dy), Offset(pBar[7].dx, pBar[7].dy), paintBar);
    canvas.drawLine(Offset(pBar[8].dx, pBar[8].dy), Offset(pBar[9].dx, pBar[9].dy), paintBar);
        _mainBarState._drawArc(canvas, pBar[1], pBar[2], raduis, paintBar,  pi /2);
    _mainBarState._drawArc(canvas, pBar[4], pBar[3], raduis, paintBar,  pi /2);
    _mainBarState._drawArc(canvas, pBar[6], pBar[5], raduis, paintBar,  pi /2);
    _mainBarState._drawArc(canvas, pBar[7], pBar[8], raduis, paintBar,  pi /2);
    _mainBarState._drawDimention(canvas, 0, pBar[2].dx - d_dim, pBar[0].dy, pBar[2].dx - d_dim, pBar[4].dy, paint_dim, sVLength_left, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[2].dx, pBar[0].dy - d_dim, pBar[0].dx, pBar[1].dy - d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[6].dx + d_dim, pBar[5].dy, pBar[6].dx + d_dim, pBar[8].dy, paint_dim, sVLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[3].dx, pBar[5].dy + d_dim, pBar[6].dx, pBar[5].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState.isHlenght2 = true;
    _mainBarState._drawDimention(canvas, 0, pBar[9].dx, pBar[8].dy - d_dim, pBar[6].dx, pBar[8].dy - d_dim, paint_dim, sHLength2, paintText);
    _mainBarState.isHlenght2 = false;

    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_43 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_43(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double lenght = _mainBarState.length;
    double HLength = _mainBarState.Hlenght;
    double HLength2 = _mainBarState.Hlenght2;
    double DLenght_reight = _mainBarState.Dlenght_reight;
    double DLenght_left= _mainBarState.Dlenght_left;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double alfa_left = acos(vLenght_left / DLenght_left);
    double sinAlfa_left = sin(alfa_left);
    double cosAlfa_left = cos(alfa_left);
    double alfa_reight =  acos(vLenght_reight / DLenght_reight);
    double sinAlfa_reight = sin(alfa_reight);
    double cosAlfa_reight = cos(alfa_reight);
    double scale = min((width - 8 * L_border) / (lenght + HLength + HLength2 + DLenght_left * sinAlfa_left + DLenght_reight * sinAlfa_reight), (height - 4 * L_border) / max(vLenght_reight, vLenght_left) / 2);
    String sLength = _mainBarState._roundToString(lenght);
    String sHLength2 = _mainBarState._roundToString(HLength2);
    String sHLength = _mainBarState._roundToString(HLength);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String sDLength_reight = _mainBarState._roundToString(DLenght_reight);
    String sDLength_left = _mainBarState._roundToString(DLenght_left);
    String STotalLenght = _mainBarState._roundToString(HLength + HLength2 + DLenght_left + lenght + DLenght_reight);
    lenght *= scale;
    HLength *= scale;
    HLength2 *= scale;
    vLenght_reight *= scale;
    vLenght_left *= scale;
    DLenght_reight *= scale;
    DLenght_left *= scale;
    Diameter *= scale;
    paintBar.strokeWidth = Diameter;

    int d_dim = (15 + Diameter).round();
    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "43", paintText, paintText_symbol);

    List<Offset> pBar = new List(6);
    pBar[0] = new Offset(centerX - (lenght + HLength + HLength2 + DLenght_left * sinAlfa_left + DLenght_reight * sinAlfa_reight) / 2, centerY - max(vLenght_left, vLenght_reight) / 2);
    pBar[1] = new Offset(pBar[0].dx + HLength, pBar[0].dy);
    pBar[2] = new Offset(pBar[1].dx + DLenght_left * sinAlfa_left, pBar[1].dy + vLenght_left);
    pBar[3] = new Offset(pBar[2].dx + lenght, pBar[2].dy);
    pBar[4] = new Offset(pBar[3].dx + DLenght_reight * sinAlfa_reight, pBar[3].dy - vLenght_reight);
    pBar[5] = new Offset(pBar[4].dx + HLength2, pBar[4].dy);

    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[1].dx, pBar[1].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    canvas.drawLine(Offset(pBar[4].dx, pBar[4].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    canvas.drawLine(Offset(pBar[4].dx, pBar[4].dy), Offset(pBar[5].dx, pBar[5].dy), paintBar);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx - d_dim, pBar[0].dy, pBar[0].dx - d_dim, pBar[2].dy, paint_dim, sVLength_left, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[1].dx, pBar[0].dy - d_dim, pBar[0].dx, pBar[1].dy - d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[5].dx + d_dim, pBar[2].dy, pBar[5].dx + d_dim, pBar[5].dy, paint_dim, sVLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[2].dx, pBar[2].dy + d_dim, pBar[3].dx, pBar[2].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas,  pi /2 - alfa_left, pBar[2].dx + d_dim * cosAlfa_left, pBar[2].dy - d_dim * sinAlfa_left, pBar[1].dx + d_dim * cosAlfa_left, pBar[1].dy - d_dim * sinAlfa_left, paint_dim, sDLength_left, paintText);
    _mainBarState._drawDimention(canvas, 3*pi/2 + alfa_reight, pBar[3].dx - d_dim * cosAlfa_reight, pBar[3].dy - d_dim * sinAlfa_reight, pBar[4].dx - d_dim * cosAlfa_reight, pBar[4].dy - d_dim * sinAlfa_reight, paint_dim, sDLength_reight, paintText);
    _mainBarState.isHlenght2 = true;
    _mainBarState._drawDimention(canvas, 0, pBar[5].dx, pBar[4].dy - d_dim, pBar[4].dx, pBar[4].dy - d_dim, paint_dim, sHLength2, paintText);
    _mainBarState.isHlenght2 = false;

    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_44 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_44(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double lenght = _mainBarState.length;
    double HLength = _mainBarState.Hlenght;
    double HLength2 = _mainBarState.Hlenght2;
     double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double DLenght_left = sqrt(pow((vLenght_left - vLenght_reight), 2) + pow(HLength, 2));
    double DLenght_reight = sqrt(pow((vLenght_left - vLenght_reight), 2) + pow(HLength2, 2));
    double alfa_left =  acos((vLenght_left - vLenght_reight) / DLenght_left);
    double sinAlfa_left = sin(alfa_left);
        double cosAlfa_left = cos(alfa_left);
        double alfa_reight =  acos((vLenght_left - vLenght_reight) / DLenght_reight);
    double sinAlfa_reight = sin(alfa_reight);
    double cosAlfa_reight = cos(alfa_reight);
    double scale = min((width - 8 * L_border) / (lenght + HLength + HLength2), (height - 4 * L_border) / vLenght_left / 2);
    String sLength = _mainBarState._roundToString(lenght);
    String sHLength2 = _mainBarState._roundToString(HLength2);
    String sHLength = _mainBarState._roundToString(HLength);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String sDLength_reight = _mainBarState._roundToString(DLenght_reight);
    String sDLength_left = _mainBarState._roundToString(DLenght_left);
    String STotalLenght = _mainBarState._roundToString(vLenght_reight * 2 + DLenght_left + lenght + DLenght_reight);
    lenght *= scale;
    HLength *= scale;
    HLength2 *= scale;
    vLenght_reight *= scale;
    vLenght_left *= scale;
    DLenght_reight *= scale;
    DLenght_left *= scale;
    Diameter *= scale;
    paintBar.strokeWidth = Diameter;

    int d_dim = (15 + Diameter).round();
    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "44", paintText, paintText_symbol);

    List<Offset> pBar = new List(6);
    pBar[0] = new Offset(centerX - (lenght + HLength + HLength2) / 2, centerY - vLenght_left / 2);
    pBar[1] = new Offset(pBar[0].dx, pBar[0].dy + vLenght_reight);
    pBar[2] = new Offset(pBar[1].dx + DLenght_left * sinAlfa_left, pBar[1].dy + (vLenght_left - vLenght_reight));
    pBar[3] = new Offset(pBar[2].dx + lenght, pBar[2].dy);
    pBar[4] = new Offset(pBar[3].dx + DLenght_reight * sinAlfa_reight, pBar[1].dy);
    pBar[5] = new Offset(pBar[4].dx, pBar[4].dy - vLenght_reight);

    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[1].dx, pBar[1].dy), paintBar);
    canvas.drawLine(Offset(pBar[2].dx, pBar[2].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    canvas.drawLine(Offset(pBar[4].dx, pBar[4].dy), Offset(pBar[3].dx, pBar[3].dy), paintBar);
    canvas.drawLine(Offset(pBar[4].dx, pBar[4].dy), Offset(pBar[5].dx, pBar[5].dy), paintBar);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx - d_dim, pBar[0].dy, pBar[0].dx - d_dim, pBar[2].dy, paint_dim, sVLength_left, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[2].dx, pBar[2].dy + d_dim, pBar[0].dx, pBar[2].dy + d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[5].dx + d_dim, pBar[4].dy, pBar[5].dx + d_dim, pBar[5].dy, paint_dim, sVLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[2].dx, pBar[2].dy + d_dim, pBar[3].dx, pBar[2].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas,  pi /2 - alfa_left, pBar[2].dx + d_dim * cosAlfa_left, pBar[2].dy - d_dim * sinAlfa_left, pBar[1].dx + d_dim * cosAlfa_left, pBar[1].dy - d_dim * sinAlfa_left, paint_dim, sDLength_left, paintText);
    _mainBarState._drawDimention(canvas, 3*pi /2 + alfa_reight, pBar[3].dx - d_dim * cosAlfa_reight, pBar[3].dy - d_dim * sinAlfa_reight, pBar[4].dx - d_dim * cosAlfa_reight, pBar[4].dy - d_dim * sinAlfa_reight, paint_dim, sDLength_reight, paintText);
    _mainBarState.isHlenght2 = true;
    _mainBarState._drawDimention(canvas, 0, pBar[5].dx, pBar[2].dy + d_dim, pBar[3].dx, pBar[2].dy + d_dim, paint_dim, sHLength2, paintText);
    _mainBarState.isHlenght2 = false;
    _mainBarState.rect_DlenghtReight = _mainBarState.rect_Dlenght = new Rect.fromLTRB(0, 0, 0, 0);
    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class drawBar_45 extends CustomPainter {
  Paint paintBar, paint_dim, paintText_symbol, paintText;

  drawBar_45(
      this.paintBar, this.paint_dim, this.paintText_symbol, this.paintText);

  @override
  void paint(Canvas canvas, Size size) {
    double length = _mainBarState.length;
    double HLenght = _mainBarState.Hlenght;
    double HLength2 = _mainBarState.Hlenght2;
    double DLenght_reight = _mainBarState.Dlenght_reight;
    double vLenght_left = _mainBarState.Vlenght_left;
    double vLenght_reight = _mainBarState.Vlenght_reight;
    double Diameter = double.parse(_mainBarState.diameter.toString());
    double height = size.height, width = size.width;
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double L_border =min(centerX/5,centerY/5);
    double R_circle = 25;
    double radius = _mainBarState._getRadius(Diameter);
    double alfa_reight =  acos(vLenght_reight / DLenght_reight);
    double sinAlfa_reight = sin(alfa_reight);
        double cosAlfa_reight = cos(alfa_reight);
        double scale = min((width - 8 * L_border) / (length + DLenght_reight * sinAlfa_reight + HLenght), (height - 4 * L_border) / max(vLenght_reight, vLenght_left) / 2);
    String sLength = _mainBarState._roundToString(length);
    String sVLength_reight = _mainBarState._roundToString(vLenght_reight);
    String sVLength_left = _mainBarState._roundToString(vLenght_left);
    String sDLength_reight = _mainBarState._roundToString(DLenght_reight);
    String sHLength = _mainBarState._roundToString(HLenght);
    String STotalLenght = _mainBarState._roundToString(length + HLenght + DLenght_reight + vLenght_left * 2 + 2 * radius * (1.57 - 2));
    length *= scale;
    Diameter *= scale;
    HLenght *= scale;
    vLenght_reight *= scale;
    vLenght_left *= scale;
    DLenght_reight *= scale;
    radius *= scale;
    paintBar.strokeWidth = Diameter;
    int d_dim = (15 + Diameter).round();

    Offset p_symbol = new Offset(L_border + R_circle, L_border + R_circle);
    _mainBarState._drawSymbol(canvas, p_symbol, R_circle, "45", paintText, paintText_symbol);

    List<Offset> pBar = new List(8);
    pBar[0] = new Offset(centerX - (length + DLenght_reight * sinAlfa_reight + HLenght) / 2, centerY - max(vLenght_reight, vLenght_reight) / 2);
    pBar[1] = new Offset(pBar[0].dx, pBar[0].dy + vLenght_left - radius);
    pBar[2] = new Offset(pBar[1].dx + radius, pBar[1].dy + radius);
    pBar[3] = new Offset(pBar[1].dx + length - radius, pBar[2].dy);
    pBar[4] = new Offset(pBar[3].dx + DLenght_reight * sinAlfa_reight, pBar[3].dy - DLenght_reight * cosAlfa_reight);
    pBar[5] = new Offset(pBar[4].dx + HLenght - radius, pBar[4].dy);
    pBar[6] = new Offset(pBar[5].dx + radius, pBar[5].dy + radius);
    pBar[7] = new Offset(pBar[5].dx + radius, pBar[6].dy + vLenght_left - radius);
    canvas.drawLine(Offset(pBar[1].dx, pBar[1].dy), Offset(pBar[0].dx, pBar[0].dy), paintBar);
    canvas.drawLine(Offset(pBar[3].dx, pBar[3].dy), Offset(pBar[2].dx, pBar[2].dy), paintBar);
    canvas.drawLine(Offset(pBar[3].dx, pBar[3].dy), Offset(pBar[4].dx, pBar[4].dy), paintBar);
    canvas.drawLine(Offset(pBar[5].dx, pBar[5].dy), Offset(pBar[4].dx, pBar[4].dy), paintBar);
    canvas.drawLine(Offset(pBar[6].dx, pBar[6].dy), Offset(pBar[7].dx, pBar[7].dy), paintBar);
    _mainBarState._drawArc(canvas, pBar[2], pBar[1], radius, paintBar,  pi /2);
    _mainBarState._drawArc(canvas, pBar[5], pBar[6], radius, paintBar,  pi /2);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx, pBar[2].dy + d_dim, pBar[3].dx, pBar[2].dy + d_dim, paint_dim, sLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[6].dx, pBar[4].dy - d_dim, pBar[4].dx, pBar[4].dy - d_dim, paint_dim, sHLength, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[4].dx + d_dim, pBar[3].dy, pBar[4].dx + d_dim, pBar[4].dy, paint_dim, sVLength_reight, paintText);
    _mainBarState._drawDimention(canvas, 0, pBar[0].dx - d_dim, pBar[0].dy, pBar[0].dx - d_dim, pBar[2].dy, paint_dim, sVLength_left, paintText);
    _mainBarState._drawDimention(canvas, 3 * pi / 2 + alfa_reight, pBar[3].dx - d_dim * cosAlfa_reight, pBar[3].dy - d_dim * sinAlfa_reight, pBar[4].dx - d_dim * cosAlfa_reight, pBar[4].dy - d_dim * sinAlfa_reight, paint_dim, sDLength_reight, paintText);
    Offset p_length = new Offset(centerX, centerY + height / 2 - L_border * scale);
    _mainBarState._drawTotal_length(canvas, p_length, _mainBarState.totalLenght + " " + STotalLenght, paintText_symbol);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
