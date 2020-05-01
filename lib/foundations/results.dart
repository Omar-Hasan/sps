import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stahl_section/DXFDocument.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/foundations/main.dart';
import 'package:stahl_section/translate/app_localizations.dart';

import 'design_foundations.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
  static DXFDocument dxf = new DXFDocument(1000);
}

class _ResultsState extends State<Results> {
  static String Height = '',
      A = '',
      B = '',
      a = '',
      b = '',
      AsA1L = '',
      AsA1D = '',
      AsA2L = '',
      AsA2D = '',
      AsB1L = '',
      AsB1D = '',
      AsB2L = '',
      AsB2D = '';
  static int A1d = 12,
      A2d = 12,
      B1d = 12,
      B2d = 12,
      A1L = 250,
      A2L = 250,
      B1L = 250,
      B2L = 250,
      A1n = 250,
      A2n = 250,
      B1n = 250,
      B2n = 250;

  var paint = new Paint();
  var textPaint = new Paint();
  var BarPaint = new Paint();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    Height = design.Height;
    A = design.A;
    B = design.B;
    a = design.a_long.round().toString();
    b = design.b_width.round().toString();
    AsA1L = design.AsA1L;
    AsA1D = design.AsA1D;
    AsA2L = design.AsA2L;
    AsA2D = design.AsA2D;
    AsB1L = design.AsB1L;
    AsB1D = design.AsB1D;
    AsB2L = design.AsB2L;
    AsB2D = design.AsB2D;

    A1d = design.A1d;
    A2d = design.A2d;
    B1d = design.B1d;
    B2d = design.B2d;
    A1L = design.A1L;
    A2L = design.A2L;
    B1L = design.B1L;
    B2L = design.B2L;
    A1n = design.A1n;
    A2n = design.A2n;
    B1n = design.B1n;
    B2n = design.B2n;
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

    Results.dxf = new DXFDocument(1000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: <Widget>[
          _result(),
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  color: color.White,
                  height: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: CustomPaint(
                    painter: draw_IsolatedFoundation1(context, paint, textPaint),
                  ),
                ),
                Container(
                  color: color.White,
                  height: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: CustomPaint(
                    painter: draw_IsolatedFoundation2(context, paint, textPaint),
                  ),
                ),
                Center(
                  child: RaisedButton(
                    textColor: color.White,
                    color: color.red,
                    child: Text(
                      AppLocalizations.of(context).translate('exportToDXF'),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline,
                    ),
                    onPressed: () {
                      /*
          design.design();*/
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
     // title:
      automaticallyImplyLeading: true,
      /*actions: <Widget>[
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
      ],*/
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.properties) {} else
    if (choice == Constants.Material) {} else if (choice == Constants.SignOut) {
      print('SignOut');
    }
  }

  _result() {
    var valuColor = color.red;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(3),
          color: color.WhiteSelver,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            mainFoundation.textEditingController.text,
            style: Theme
                .of(context)
                .textTheme
                .display1
                .copyWith(color: color.black, fontSize: 22),
          ),
        ),
        Container(
            width: double.infinity,
            color: color.White,
            padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
            child: Row(
              children: <Widget>[
                Text(
                  'Column Dimension: ',
                  style: Theme
                      .of(context)
                      .textTheme
                      .display1
                      .copyWith(fontSize: 18),
                ),
                Text('$a x $b (cm)',
                    style: Theme
                        .of(context)
                        .textTheme
                        .display1
                        .copyWith(fontSize: 18, color: valuColor)),
              ],
            )),
        Container(
            width: double.infinity,
            color: color.WhiteSelver,
            padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
            child: Row(
              children: <Widget>[
                Text(
                  'Foundation Dimension: ',
                  style: Theme
                      .of(context)
                      .textTheme
                      .display1
                      .copyWith(fontSize: 18),
                ),
                Text(
                  '$A x $B x $Height (cm)',
                  style: Theme
                      .of(context)
                      .textTheme
                      .display1
                      .copyWith(fontSize: 18, color: valuColor),
                ),
              ],
            )),
        Container(
          width: double.infinity,
          color: color.White,
          padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Parrallel A: ',
                style:
                Theme
                    .of(context)
                    .textTheme
                    .display1
                    .copyWith(fontSize: 18),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 30,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'AsA1: ',
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1
                              .copyWith(fontSize: 18),
                        ),
                        Text(
                          '$AsA1D [$AsA1L cm]',
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1
                              .copyWith(fontSize: 18, color: valuColor),
                        ),

                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ), Row(
                      children: <Widget>[
                        Text(
                          'AsA2: ',
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1
                              .copyWith(fontSize: 18),
                        ),
                        Text(
                          '$AsA2D [$AsA2L cm]',
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1
                              .copyWith(fontSize: 18, color: valuColor),
                        ),

                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: color.WhiteSelver,
          padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Parrallel B: ',
                style:
                Theme
                    .of(context)
                    .textTheme
                    .display1
                    .copyWith(fontSize: 18),
                textAlign: TextAlign.left,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 30,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'AsB1: ',
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1
                              .copyWith(fontSize: 18),
                        ),
                        Text(
                          '$AsB1D [$AsB1L cm]',
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1
                              .copyWith(fontSize: 18, color: valuColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'AsB2: ',
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1
                              .copyWith(fontSize: 18),
                        ),
                        Text(
                          '$AsB2D [$AsB2L cm]',
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1
                              .copyWith(fontSize: 18, color: valuColor),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
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
  static _drawDimentionDXF(double plusH,double scale, double teta, double Xstart, double Ystart,
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
      Results.dxf.drawLine(plusH,scale,Offset(start.dx + ca, start.dy),
          Offset(start.dx - ca, start.dy), paint);
      Results.dxf.drawLine(plusH,scale,
          Offset(end.dx + ca, end.dy), Offset(end.dx - ca, end.dy), paint);
      Results.dxf.rotate(3 * pi / 2);
      if (start.dy > end.dy) {
        Results.dxf.drawText(plusH,scale, span,
            new Offset(
                start.dx + tp.height,
                (start.dy + end.dy) / 2 + tp.width/2));
      } else {
        Results.dxf.drawText(plusH,scale, span,new Offset(start.dx - tp.height,
            (start.dy + end.dy) / 2 + tp.width/2));
       }
      Results.dxf.rotate(-3 * pi / 2);
    } else if (start.dy == end.dy) {
      Results.dxf.drawLine(plusH,scale,Offset(start.dx, start.dy - ca),
          Offset(start.dx, start.dy + ca), paint);
      Results.dxf.drawLine(plusH,scale,
          Offset(end.dx, end.dy - ca), Offset(end.dx, end.dy + ca), paint);
      if (start.dx < end.dx) {
        Results.dxf.drawText(plusH,scale, span,
            new Offset((end.dx + start.dx) / 2 - tp.width / 2, start.dy + ca));
        /*rect_lenght = new Rect.fromLTRB(
            (end.dx + start.dx) / 2 - tp.width / 2 - ca,
            start.dy,
            (end.dx + start.dx) / 2 + tp.width / 2 + ca,
            start.dy + tp.height + ca * 2);*/
      } else {
        Results.dxf.drawText(plusH,scale, span,
            new Offset((end.dx + start.dx) / 2 - tp.width / 2,
                start.dy - 0 - tp.height));
      }
    } else {
      double cosTeta = sin((teta));
      double sinTeta = cos((teta));
      Results.dxf.drawLine(plusH,scale,Offset(start.dx - ca * cosTeta, start.dy + ca * sinTeta),
          Offset(start.dx + ca * cosTeta, start.dy - ca * sinTeta), paint);
      Results.dxf.drawLine(plusH,scale,Offset(end.dx - ca * cosTeta, end.dy + ca * sinTeta),
          Offset(end.dx + ca * cosTeta, end.dy - ca * sinTeta), paint);
      Results.dxf.rotate(teta);
      Results.dxf.drawText(plusH,scale, span, new Offset((end.dx + start.dx) / 2 - tp.width / 2, (end.dy + start.dy) / 2 - tp.height));
      Results.dxf.rotate(-teta);
     }
    Results.dxf.drawLine(plusH,scale, start, end, paint);
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

  static _drawTextCenter(Canvas canvas, Paint paint, String text, double x, double y) {
    TextStyle textStyle = new TextStyle(color: paint.color,fontSize: 18,fontWeight: FontWeight.bold);
    TextSpan span = new TextSpan(style: textStyle, text: text);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, new Offset(x - tp.width / 2, y-tp.height/2));
  }
  static _drawTextCenterDXF(double plusH,double scale, Paint paint, String text, double x, double y) {
    TextStyle textStyle = new TextStyle(color: paint.color,fontSize: 18,fontWeight: FontWeight.bold);
    TextSpan span = new TextSpan(style: textStyle, text: text);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    Results.dxf.drawText(plusH,scale, span, new Offset(x - tp.width / 2, y + tp.height / 2));
  }
  static _drawTextLeft(Canvas canvas, Paint paint, String text, double x, double y) {
    TextStyle textStyle = new TextStyle(color: paint.color,fontSize: 18,fontWeight: FontWeight.bold);
    TextSpan span = new TextSpan(style: textStyle, text: text);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, new Offset(x , y-tp.height));
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

class draw_IsolatedFoundation1 extends CustomPainter {
  Paint paint0, textPaint;
  BuildContext context;
  bool withMoment = false;
  String fie = 'Փ', mm2 = 'mm²', test;
  draw_IsolatedFoundation1(this.context, this.paint0, this.textPaint,
      {this.withMoment});

  @override
  void paint(Canvas canvas, Size size) {
    double height = double.parse(_ResultsState.Height);
    double A = double.parse(_ResultsState.A);
    double a = double.parse(_ResultsState.a);
    int A1d = _ResultsState.A1d;
    int B1d = _ResultsState.B1d;
    int B1n = _ResultsState.B1n;
    int B2n = _ResultsState.B2n;
    double neck = 5.0 * A1d;//cm

    double clean = 5;
    double scale = min(size.width * 0.9 / (A + 30 + clean * 2),
        size.height * 0.9 / (clean + 3 * height / 2 + neck + 60));
    height *= scale;
    A *= scale;
    a *= scale;
    neck*=scale;
    clean*=scale;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    List<Offset> point = new List(8);
    point[0] = new Offset(centerX - A / 2, centerY + (1.5 * height+neck)/2-20*scale);
    point[1] = new Offset(point[0].dx + A, point[0].dy);
    point[2] = new Offset(point[1].dx, point[1].dy - height);
    point[3] = new Offset(point[2].dx - (A - a) / 2, point[2].dy);
    point[4] = new Offset(point[3].dx, point[3].dy - neck - height/2);
    point[5] = new Offset(point[4].dx - a, point[4].dy);
    point[6] = new Offset(point[5].dx, point[3].dy);
    point[7] = new Offset(point[0].dx, point[3].dy);

    double plusH =0;
    for (int i = 0; i < 4; i++) {
      canvas.drawLine(point[i], point[i + 1], paint0);
      Results.dxf.drawLine(0,1/scale,point[i], point[i + 1], paint0);
    }
    for (int i = 5; i < 7; i++) {
      canvas.drawLine(point[i], point[i + 1], paint0);
      Results.dxf.drawLine(plusH,1/scale,point[i], point[i + 1], paint0);
    }
    canvas.drawLine(point[0], point[7], paint0);
    Results.dxf.drawLine(plusH,1/scale,point[0], point[7], paint0);

    Rect rect =
    new Rect.fromLTRB(point[0].dx-clean, point[0].dy, point[1].dx+clean, point[0].dy+clean);
    canvas.drawRect(rect, paint0);
    Results.dxf.drawRect(0,1/scale,rect, paint0);

    for (int i = 0; i < (A+2*clean) / clean; i++) {
      canvas.drawLine(Offset(point[0].dx - clean + clean * (i), point[0].dy + clean), Offset(point[0].dx - clean + clean * (i + 1), point[0].dy), paint0);
      Results.dxf.drawLine(plusH,1/scale,Offset(point[0].dx - clean + clean * (i), point[0].dy + clean), Offset(point[0].dx - clean + clean * (i + 1), point[0].dy), paint0);
    }

    //رسم التسليح
    double tCoverRieght = 5 * scale;
    double diameterReiBar = B1d * scale * 5/10;
    int numbreBar = B1n+B2n;
    double d_barLips =
        (A - numbreBar * diameterReiBar - 2 * tCoverRieght) /
            (numbreBar - 1);
    rect = new Rect.fromLTRB(
        point[7].dx + tCoverRieght,
        point[7].dy + tCoverRieght,
        point[2].dx - tCoverRieght,
        point[0].dy - tCoverRieght);
    textPaint.style = PaintingStyle.stroke;
    canvas.drawRect(rect, textPaint);
    textPaint.style = PaintingStyle.fill;
    double lip = min(30*scale,height/2);
    canvas.drawLine(Offset(rect.right,rect.bottom-lip), Offset(rect.right-diameterReiBar/2,rect.bottom-lip-diameterReiBar/2), textPaint);
    canvas.drawLine(Offset(rect.left,rect.bottom-lip), Offset(rect.left+diameterReiBar/2,rect.bottom-lip-diameterReiBar/2), textPaint);
    Results.dxf.drawLine(plusH,1/scale,Offset(rect.right,rect.bottom-lip), Offset(rect.right-diameterReiBar/2,rect.bottom-lip-diameterReiBar/2), textPaint);
    Results.dxf.drawLine(plusH,1/scale,Offset(rect.left,rect.bottom-lip), Offset(rect.left+diameterReiBar/2,rect.bottom-lip-diameterReiBar/2), textPaint);
    Results.dxf.drawRect(0,1/scale,rect, textPaint);

    List<Offset> pR = new List(numbreBar+1);
    pR[0] = new Offset(point[0].dx + tCoverRieght + diameterReiBar / 2,
        point[0].dy - tCoverRieght - diameterReiBar / 2);
    for (int i = 0; i < numbreBar; i++) {
      canvas.drawCircle(pR[i], diameterReiBar / 2, textPaint);
      Results.dxf.drawCircle(plusH,1/scale,pR[i], diameterReiBar / 2, textPaint);
     // Results.dxf.drawPoint(pR[i], diameterReiBar / 2, textPaint);
      pR[i+1] = new Offset(pR[i].dx + d_barLips + diameterReiBar, pR[i].dy);
    }
    //قضيب ربط حيطي
    canvas.drawCircle(Offset(pR[0].dx-diameterReiBar/4,pR[0].dy-height+tCoverRieght*2+3 * diameterReiBar/4), diameterReiBar / 4, textPaint);
    canvas.drawCircle(Offset(pR[numbreBar-1].dx+diameterReiBar/4,pR[numbreBar-1].dy-height+tCoverRieght*2+3 * diameterReiBar/ 4), diameterReiBar / 4, textPaint);
    Results.dxf.drawCircle(plusH,1/scale,Offset(pR[0].dx-diameterReiBar/4,pR[0].dy-height+tCoverRieght*2+3 * diameterReiBar/4), diameterReiBar / 4, textPaint);
    Results.dxf.drawCircle(plusH,1/scale,Offset(pR[numbreBar-1].dx+diameterReiBar/4,pR[numbreBar-1].dy-height+tCoverRieght*2+3 * diameterReiBar/ 4), diameterReiBar / 4, textPaint);

    double colxDis = (point[4].dx - point[5].dx-tCoverRieght)/3;
    List<Offset> colRie = new List(4);
    for (int i = 0; i < 4; i++) {
      colRie[i] = Offset(point[5].dx + colxDis*(i) + tCoverRieght/2,point[5].dy);
    }
    canvas.drawLine(colRie[0], Offset(colRie[0].dx,point[0].dy-diameterReiBar-tCoverRieght), textPaint);
    canvas.drawLine(Offset(colRie[0].dx,point[0].dy-diameterReiBar-tCoverRieght), Offset(colRie[3].dx-tCoverRieght/2,point[0].dy-diameterReiBar-tCoverRieght), textPaint);
    canvas.drawLine(colRie[1], Offset(colRie[1].dx,point[0].dy-diameterReiBar-tCoverRieght), textPaint);
    canvas.drawLine(colRie[2], Offset(colRie[2].dx,point[0].dy-diameterReiBar*2-tCoverRieght), textPaint);
    canvas.drawLine(colRie[3], Offset(colRie[3].dx,point[0].dy-diameterReiBar*2-tCoverRieght), textPaint);
    canvas.drawLine(Offset(colRie[3].dx,point[0].dy-diameterReiBar*2-tCoverRieght), Offset(colRie[0].dx+tCoverRieght/2,point[0].dy-diameterReiBar*2-tCoverRieght), textPaint);
    Results.dxf.drawLine(plusH,1/scale,colRie[0], Offset(colRie[0].dx,point[0].dy-diameterReiBar-tCoverRieght), textPaint);
    Results.dxf.drawLine(plusH,1/scale,Offset(colRie[0].dx,point[0].dy-diameterReiBar-tCoverRieght), Offset(colRie[3].dx-tCoverRieght/2,point[0].dy-diameterReiBar-tCoverRieght), textPaint);
    Results.dxf.drawLine(plusH,1/scale,colRie[1], Offset(colRie[1].dx,point[0].dy-diameterReiBar-tCoverRieght), textPaint);
    Results.dxf.drawLine(plusH,1/scale,colRie[2], Offset(colRie[2].dx,point[0].dy-diameterReiBar*2-tCoverRieght), textPaint);
    Results.dxf.drawLine(plusH,1/scale,colRie[3], Offset(colRie[3].dx,point[0].dy-diameterReiBar*2-tCoverRieght), textPaint);
    Results.dxf.drawLine(plusH,1/scale,Offset(colRie[3].dx,point[0].dy-diameterReiBar*2-tCoverRieght), Offset(colRie[0].dx+tCoverRieght/2,point[0].dy-diameterReiBar*2-tCoverRieght), textPaint);
    for (int i = 0; i < 4; i++) {
      colRie[i] = Offset(colRie[i].dx,point[3].dy - neck);
      canvas.drawLine(Offset(colRie[0].dx , colRie[0].dy+neck/5*(i+1)), Offset(colRie[3].dx , colRie[0].dy+neck/5*(i+1)), textPaint);
      Results.dxf.drawLine(plusH,1/scale,Offset(colRie[0].dx , colRie[0].dy+neck/5*(i+1)), Offset(colRie[3].dx , colRie[0].dy+neck/5*(i+1)), textPaint);
    }
    canvas.drawLine(colRie[0], Offset(colRie[0].dx + colxDis / 3 , colRie[0].dy - colxDis /3), textPaint);
    canvas.drawLine(colRie[1], Offset(colRie[1].dx + colxDis / 3 , colRie[1].dy - colxDis /3), textPaint);
    canvas.drawLine(colRie[2], Offset(colRie[2].dx - colxDis / 3 , colRie[2].dy - colxDis /3), textPaint);
    canvas.drawLine(colRie[3], Offset(colRie[3].dx - colxDis / 3 , colRie[3].dy - colxDis /3), textPaint);
    canvas.drawLine(Offset(colRie[0].dx , point[3].dy), Offset(colRie[0].dx + colxDis / 3 , point[3].dy + colxDis /3), textPaint);
    canvas.drawLine(Offset(colRie[1].dx , point[3].dy), Offset(colRie[1].dx + colxDis / 3 , point[3].dy + colxDis /3), textPaint);
    canvas.drawLine(Offset(colRie[2].dx , point[3].dy), Offset(colRie[2].dx - colxDis / 3 , point[3].dy + colxDis /3), textPaint);
    canvas.drawLine(Offset(colRie[3].dx , point[3].dy), Offset(colRie[3].dx - colxDis / 3 , point[3].dy + colxDis /3), textPaint);
    Results.dxf.drawLine(plusH,1/scale,colRie[0], Offset(colRie[0].dx + colxDis / 3 , colRie[0].dy - colxDis /3), textPaint);
    Results.dxf.drawLine(plusH,1/scale,colRie[1], Offset(colRie[1].dx + colxDis / 3 , colRie[1].dy - colxDis /3), textPaint);
    Results.dxf.drawLine(plusH,1/scale,colRie[2], Offset(colRie[2].dx - colxDis / 3 , colRie[2].dy - colxDis /3), textPaint);
    Results.dxf.drawLine(plusH,1/scale,colRie[3], Offset(colRie[3].dx - colxDis / 3 , colRie[3].dy - colxDis /3), textPaint);
    Results.dxf.drawLine(plusH,1/scale,Offset(colRie[0].dx , point[3].dy), Offset(colRie[0].dx + colxDis / 3 , point[3].dy + colxDis /3), textPaint);
    Results.dxf.drawLine(plusH,1/scale,Offset(colRie[1].dx , point[3].dy), Offset(colRie[1].dx + colxDis / 3 , point[3].dy + colxDis /3), textPaint);
    Results.dxf.drawLine(plusH,1/scale,Offset(colRie[2].dx , point[3].dy), Offset(colRie[2].dx - colxDis / 3 , point[3].dy + colxDis /3), textPaint);
    Results.dxf.drawLine(plusH,1/scale,Offset(colRie[3].dx , point[3].dy), Offset(colRie[3].dx - colxDis / 3 , point[3].dy + colxDis /3), textPaint);

    double paddingDimention = 15 * scale;
    _ResultsState._drawDimention(
        canvas,
        pi / 2,
        point[1].dx + paddingDimention,
        point[1].dy,
        point[2].dx + paddingDimention,
        point[2].dy,
        paint0,
        '${_ResultsState.Height}cm',
        paint0);
    _ResultsState._drawDimentionDXF(plusH,1/scale,
        pi / 2,
        point[1].dx + paddingDimention,
        point[1].dy,
        point[2].dx + paddingDimention,
        point[2].dy,
        paint0,
        '${_ResultsState.Height}cm',
        paint0);
    _ResultsState._drawDimention(
        canvas,
        pi / 2,
        point[6].dx - paddingDimention,
        colRie[0].dy ,
        point[6].dx - paddingDimention,
        point[6].dy,
        paint0,
        '50 $fie',
        paint0);
    _ResultsState._drawDimention(
        canvas,
        pi / 2,
        pR[numbreBar-1].dx - d_barLips/2,
        rect.bottom,
        pR[numbreBar-1].dx - d_barLips/2,
        point[0].dy ,
        paint0,
        '5cm',
        paint0);
    _ResultsState._drawDimentionDXF(plusH,1/scale,
        pi / 2,
        point[6].dx - paddingDimention,
        colRie[0].dy ,
        point[6].dx - paddingDimention,
        point[6].dy,
        paint0,
        '50 $fie',
        paint0);
    _ResultsState._drawDimentionDXF(plusH,1/scale,
        pi / 2,
        pR[numbreBar-1].dx - d_barLips/2,
        rect.bottom,
        pR[numbreBar-1].dx - d_barLips/2,
        point[0].dy ,
        paint0,
        '5cm',
        paint0);
    double dCircle = 18*scale;
    Offset pDetail = new Offset(pR[0].dx+d_barLips/2+diameterReiBar/2, rect.bottom);
    _drawDetailInCircle(canvas, scale, pDetail, dCircle,'1','2', textPaint);
    _drawDetailInCircleDXF(plusH,Results.dxf, scale, pDetail, dCircle,'1','2', textPaint);
    pDetail = new Offset(pR[(numbreBar/2).round()].dx, rect.bottom);
    _drawDetailInCircleDXF(plusH,Results.dxf, scale, pDetail, dCircle,'3','4', textPaint);
    _drawDetailInCircle(canvas, scale, pDetail, dCircle,'3','4', textPaint);
  }

  _drawDetailInCircle(Canvas canvas,double scale, Offset pDetail,double dCircle,String txt1,String txt2, Paint textPaint){
    canvas.drawLine(pDetail, Offset(pDetail.dx,pDetail.dy + 40*scale), textPaint);
    canvas.drawLine(Offset(pDetail.dx,pDetail.dy + 40*scale), Offset(pDetail.dx+dCircle*2,pDetail.dy + 40*scale), textPaint);
    textPaint.style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(pDetail.dx+dCircle/2+1,pDetail.dy + 40*scale - dCircle/2-1), dCircle/2, textPaint);
    _ResultsState._drawTextCenter(canvas, textPaint,txt1,pDetail.dx+dCircle/2+1,pDetail.dy + 40*scale - dCircle/2-1);
    _ResultsState._drawTextCenter(canvas, textPaint,'+',pDetail.dx+dCircle/2+18,pDetail.dy + 40*scale - dCircle/2-1);
    canvas.drawCircle(Offset(pDetail.dx+dCircle+4+18,pDetail.dy + 40*scale - dCircle/2-1), dCircle/2, textPaint);
    _ResultsState._drawTextCenter(canvas, textPaint,txt2,pDetail.dx+dCircle+4+18,pDetail.dy + 40*scale - dCircle/2-1);

  }
  _drawDetailInCircleDXF(double plusH,DXFDocument canvas,double scale, Offset pDetail,double dCircle,String txt1,String txt2, Paint textPaint){
    canvas.drawLine(plusH,1/scale,pDetail, Offset(pDetail.dx,pDetail.dy + 40), textPaint);
    canvas.drawLine(plusH,1/scale,Offset(pDetail.dx,pDetail.dy + 40), Offset(pDetail.dx + dCircle * 2 ,pDetail.dy + 40), textPaint);
    textPaint.style = PaintingStyle.stroke;
    canvas.drawCircle(plusH,1/scale,Offset(pDetail.dx+dCircle/2+1,pDetail.dy + 40 - dCircle/2-1), dCircle/2, textPaint);
    _ResultsState._drawTextCenterDXF(plusH,1/scale, textPaint,txt1,pDetail.dx+dCircle/2+1,pDetail.dy + 40 - dCircle/2-1);
    _ResultsState._drawTextCenterDXF(plusH,1/scale, textPaint,'+',pDetail.dx+dCircle/2+18,pDetail.dy + 40 - dCircle/2-1);
    canvas.drawCircle(plusH,1/scale,Offset(pDetail.dx+dCircle+4+18,pDetail.dy + 40 - dCircle/2-1), dCircle/2, textPaint);
    _ResultsState._drawTextCenterDXF(plusH,1/scale, textPaint,txt2,pDetail.dx+dCircle+4+18,pDetail.dy + 40 - dCircle/2-1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class draw_IsolatedFoundation2 extends CustomPainter {
  Paint paint0, textPaint;
  BuildContext context;
  bool withMoment = false;
  String fie = 'Փ', mm2 = 'mm²',test;
  draw_IsolatedFoundation2(this.context, this.paint0, this.textPaint,
      {this.withMoment});

  @override
  void paint(Canvas canvas, Size size) {
    double height = double.parse(_ResultsState.Height);
    double B = double.parse(_ResultsState.B);
    double A = double.parse(_ResultsState.A);
    double b = double.parse(_ResultsState.b);
    double a = double.parse(_ResultsState.a);
    int A_a2 = ((A-a)/2).round();
    int B_b2 = ((B-b)/2).round();

    int A1d = _ResultsState.A1d;
    int A1L = _ResultsState.A1L;
    int A1n = _ResultsState.A1n;
    int A2d = _ResultsState.A2d;
    int A2L = _ResultsState.A2L;
    int A2n = _ResultsState.A2n;
    int B1d = _ResultsState.B1d;
    int B1L = _ResultsState.B1L;
    int B1n = _ResultsState.B1n;
    int B2d = _ResultsState.B2d;
    int B2L = _ResultsState.B2L;
    int B2n = _ResultsState.B2n;

    double plusH = 250 + height;
    double clean = 5;
    double scale = min(size.width * 0.9 / (A + 30 + clean * 2),
        size.height * 0.9 / (clean *2 +B +30));
    height *= scale;
    B *= scale;
    A *= scale;
    b *= scale;
    a *= scale;
    clean*=scale;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    List<Offset> point = new List(4);
    point[0] = new Offset(centerX - A/2 , centerY - B / 2);
    point[1] = new Offset(point[0].dx +A, point[0].dy);
    point[2] = new Offset(point[1].dx, point[1].dy + B);
    point[3] = new Offset(point[0].dx, point[1].dy + B);

    List<Offset> pointDXF = new List(4);
    pointDXF[0] = new Offset(centerX - A/2 , centerY - B / 2 + plusH);
    pointDXF[1] = new Offset(point[0].dx +A, point[0].dy );
    pointDXF[2] = new Offset(point[1].dx, point[1].dy + B );
    pointDXF[3] = new Offset(point[0].dx, point[1].dy + B );

    Rect rect = new Rect.fromLTRB(point[0].dx, point[0].dy, point[1].dx, point[3].dy);
    canvas.drawRect(rect, paint0);
    Results.dxf.drawRect(plusH,1/scale,rect, paint0);
    rect = new Rect.fromLTRB(point[0].dx-clean, point[0].dy-clean, point[1].dx+clean, point[3].dy+clean);
    canvas.drawRect(rect, paint0);
    Results.dxf.drawRect(plusH,1/scale,rect, paint0);

    Offset centerColumn = new Offset(centerX, point[0].dy + B / 2);
    rect = new Rect.fromLTRB(
        centerColumn.dx - a / 2,
        centerColumn.dy - b / 2,
        centerColumn.dx + a / 2,
        centerColumn.dy + b / 2);
    canvas.drawRect(rect, paint0);
    Results.dxf.drawRect(plusH,1/scale,rect, paint0);

    _hatch(canvas,rect,plusH,1/scale);

    //رسم التسليح
    //AsA1
    double tCoverRieght = 5 * scale;

    rect = new Rect.fromLTRB(
        point[3].dx + tCoverRieght,
        point[3].dy - tCoverRieght *2- min(30*scale,height/2),
        point[2].dx - tCoverRieght,
        point[3].dy - tCoverRieght*2);
    textPaint.style = PaintingStyle.stroke;
    _drawDetailAs1(plusH,canvas, scale, rect, '${_ResultsState.AsA1D}', 'L = ${A1L}cm','1', textPaint);
    rect = new Rect.fromLTRB(
      point[2].dx - tCoverRieght*2 - min(30*scale,height/2),
      point[1].dy + tCoverRieght ,
      point[2].dx - tCoverRieght*2,
      point[3].dy - tCoverRieght,
    );
    _drawDetailBs1(plusH, canvas, scale, rect, '${_ResultsState.AsB1D}', 'L = ${B1L}cm','3', textPaint);
    tCoverRieght = 3*scale;
    rect = new Rect.fromLTRB(
        point[3].dx + tCoverRieght,
        centerY + b/2 - tCoverRieght - height - 10*scale,
        point[2].dx - tCoverRieght,
        centerY + b/2 - tCoverRieght);
    _drawDetailAs2(plusH, canvas, scale, rect, '${_ResultsState.AsA2D}', 'L = ${A2L}cm','2', textPaint);
    rect = new Rect.fromLTRB(
      centerX - tCoverRieght + a/2 - height - 10*scale ,
      point[1].dy + tCoverRieght ,
      centerX - tCoverRieght + a/2,
      point[3].dy - tCoverRieght,
    );
    _drawDetailBs2(plusH, canvas, scale, rect, '${_ResultsState.AsB2D}', 'L = ${B2L}cm','4', textPaint);
    test = Results.dxf.toDXFString();

    //اللأبعاد
    double paddingDimention = 15 * scale;
    _ResultsState._drawDimention(canvas, pi / 2, point[1].dx, point[1].dy - paddingDimention, point[0].dx, point[0].dy - paddingDimention, paint0, '${_ResultsState.A} cm', paint0);
    _ResultsState._drawDimention(canvas, pi / 2, point[0].dx - paddingDimention, point[0].dy, point[0].dx - paddingDimention, point[3].dy, paint0, '${_ResultsState.B} cm', paint0);
    _ResultsState._drawDimention(canvas, pi / 2, point[3].dx, point[3].dy + paddingDimention, point[3].dx + (A-a)/2, point[2].dy + paddingDimention, paint0, '${A_a2} cm', paint0);
    _ResultsState._drawDimention(canvas, pi / 2, point[3].dx + (A-a)/2, point[3].dy + paddingDimention, point[3].dx + (A-a)/2 + a, point[2].dy + paddingDimention, paint0, '${_ResultsState.a} cm', paint0);
    _ResultsState._drawDimention(canvas, pi / 2, point[3].dx+ (A-a)/2 + a, point[3].dy + paddingDimention, point[2].dx, point[2].dy + paddingDimention, paint0, '${A_a2} cm', paint0);
    _ResultsState._drawDimention(canvas, pi / 2, point[2].dx + paddingDimention, point[2].dy, point[1].dx + paddingDimention, point[2].dy - (B-b)/2, paint0, '${B_b2} cm', paint0);
    _ResultsState._drawDimention(canvas, pi / 2, point[2].dx + paddingDimention, point[2].dy- (B-b)/2, point[1].dx + paddingDimention, point[2].dy - (B-b)/2 - b, paint0, '${_ResultsState.b} cm', paint0);
    _ResultsState._drawDimention(canvas, pi / 2, point[2].dx + paddingDimention, point[2].dy - (B-b)/2 - b, point[1].dx + paddingDimention, point[1].dy, paint0, '${B_b2} cm', paint0);

    _ResultsState._drawDimentionDXF(plusH, 1/scale, pi / 2, point[1].dx, point[1].dy - paddingDimention, point[0].dx, point[0].dy - paddingDimention, paint0, '${_ResultsState.A} cm', paint0);
    _ResultsState._drawDimentionDXF(plusH, 1/scale, pi / 2, point[0].dx - paddingDimention, point[0].dy, point[0].dx - paddingDimention, point[3].dy, paint0, '${_ResultsState.B} cm', paint0);
    _ResultsState._drawDimentionDXF(plusH, 1/scale, pi / 2, point[3].dx, point[3].dy + paddingDimention, point[3].dx + (A-a)/2, point[2].dy + paddingDimention, paint0, '${A_a2} cm', paint0);
    _ResultsState._drawDimentionDXF(plusH, 1/scale, pi / 2, point[3].dx + (A-a)/2, point[3].dy + paddingDimention, point[3].dx + (A-a)/2 + a, point[2].dy + paddingDimention, paint0, '${_ResultsState.a} cm', paint0);
    _ResultsState._drawDimentionDXF(plusH, 1/scale, pi / 2, point[3].dx+ (A-a)/2 + a, point[3].dy + paddingDimention, point[2].dx, point[2].dy + paddingDimention, paint0, '${A_a2} cm', paint0);
    _ResultsState._drawDimentionDXF(plusH, 1/scale, pi / 2, point[2].dx + paddingDimention, point[2].dy, point[1].dx + paddingDimention, point[2].dy - (B-b)/2, paint0, '${B_b2} cm', paint0);
    _ResultsState._drawDimentionDXF(plusH, 1/scale, pi / 2, point[2].dx + paddingDimention, point[2].dy- (B-b)/2, point[1].dx + paddingDimention, point[2].dy - (B-b)/2 - b, paint0, '${_ResultsState.b} cm', paint0);
    _ResultsState._drawDimentionDXF(plusH, 1/scale, pi / 2, point[2].dx + paddingDimention, point[2].dy - (B-b)/2 - b, point[1].dx + paddingDimention, point[1].dy, paint0, '${B_b2} cm', paint0);

    test = Results.dxf.toDXFString();
  }
  _drawDetailAs1(double plusH,Canvas canvas,double scale,Rect rect, String txt1, String txt2, String txtC, Paint textPaint){
    canvas.drawLine(Offset(rect.left,rect.top), Offset(rect.left,rect.bottom), textPaint);
    canvas.drawLine(Offset(rect.left,rect.bottom), Offset(rect.right,rect.bottom), textPaint);
    canvas.drawLine(Offset(rect.right,rect.top), Offset(rect.right,rect.bottom), textPaint);
    Results.dxf.drawLine(plusH,1/scale,Offset(rect.left,rect.top), Offset(rect.left,rect.bottom), textPaint);
    Results.dxf.drawLine(plusH,1/scale,Offset(rect.left,rect.bottom), Offset(rect.right,rect.bottom), textPaint);
    Results.dxf.drawLine(plusH,1/scale,Offset(rect.right,rect.top), Offset(rect.right,rect.bottom), textPaint);
    Offset ptxt = new Offset(rect.left+2*scale, rect.bottom-2*scale);
    TextStyle textStyle = new TextStyle(color: textPaint.color,fontSize: 18,fontWeight: FontWeight.bold);
    TextSpan span = new TextSpan(style: textStyle, text: txt1);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, new Offset(ptxt.dx , ptxt.dy-tp.height));
    Results.dxf.drawText(plusH, 1/scale, span, Offset(ptxt.dx , ptxt.dy-tp.height));
    double dCircle = 18*scale;
    Offset pDetail = new Offset(ptxt.dx + 3*scale +tp.width + dCircle/2, ptxt.dy - tp.height/2);
    canvas.drawCircle(Offset(pDetail.dx,pDetail.dy), dCircle/2, textPaint);
    Results.dxf.drawCircle(plusH,1/scale,Offset(pDetail.dx,pDetail.dy), dCircle/2, textPaint);
    _ResultsState._drawTextCenter(canvas, textPaint,txtC,pDetail.dx,pDetail.dy);
    _ResultsState._drawTextCenterDXF(plusH,1/scale, textPaint,txtC,pDetail.dx,pDetail.dy);
    ptxt = new Offset(ptxt.dx + 3*scale *2 +tp.width + dCircle, rect.bottom-2*scale);
    span = new TextSpan(style: textStyle, text: txt2);
    tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, new Offset(ptxt.dx , ptxt.dy-tp.height));
    Results.dxf.drawText(plusH, 1/scale, span, new Offset(ptxt.dx , ptxt.dy-tp.height));

  }

  _drawDetailAs2(double plusH, Canvas canvas,double scale,Rect rect, String txt1, String txt2, String txtC, Paint textPaint){
    double d = 2*scale;
    canvas.drawLine(Offset(rect.left,rect.top), Offset(rect.left,rect.bottom), textPaint);
    canvas.drawLine(Offset(rect.left,rect.bottom), Offset(rect.right-d,rect.bottom), textPaint);
    canvas.drawLine(Offset(rect.right-d,rect.top), Offset(rect.right-d,rect.bottom), textPaint);
    canvas.drawLine(Offset(rect.left + d,rect.top-d), Offset(rect.left+d,rect.bottom-d), textPaint);
    canvas.drawLine(Offset(rect.left+d,rect.top-d), Offset(rect.right,rect.top-d), textPaint);
    canvas.drawLine(Offset(rect.right,rect.top-d), Offset(rect.right,rect.bottom-d), textPaint);
    Results.dxf.drawLine(plusH, 1/scale, Offset(rect.left,rect.top), Offset(rect.left,rect.bottom), textPaint);
    Results.dxf.drawLine(plusH, 1/scale, Offset(rect.left,rect.bottom), Offset(rect.right-d,rect.bottom), textPaint);
    Results.dxf.drawLine(plusH, 1/scale, Offset(rect.right-d,rect.top), Offset(rect.right-d,rect.bottom), textPaint);
    Results.dxf.drawLine(plusH, 1/scale, Offset(rect.left + d,rect.top-d), Offset(rect.left+d,rect.bottom-d), textPaint);
    Results.dxf.drawLine(plusH, 1/scale, Offset(rect.left+d,rect.top-d), Offset(rect.right,rect.top-d), textPaint);
    Results.dxf.drawLine(plusH, 1/scale, Offset(rect.right,rect.top-d), Offset(rect.right,rect.bottom-d), textPaint);
    Offset ptxt = new Offset(rect.left+2*scale, rect.bottom-2*scale);
    TextStyle textStyle = new TextStyle(color: textPaint.color,fontSize: 18,fontWeight: FontWeight.bold);
    TextSpan span = new TextSpan(style: textStyle, text: txt1);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, new Offset(ptxt.dx , ptxt.dy-tp.height));
    double dCircle = 18*scale;
    Offset pDetail = new Offset(ptxt.dx + 3*scale +tp.width + dCircle/2, ptxt.dy - tp.height/2);
    canvas.drawCircle(Offset(pDetail.dx,pDetail.dy), dCircle/2, textPaint);
    _ResultsState._drawTextCenter(canvas, textPaint,txtC,pDetail.dx,pDetail.dy);
    ptxt = new Offset(ptxt.dx , rect.bottom);
    span = new TextSpan(style: textStyle, text: txt2);
    tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, new Offset(ptxt.dx , ptxt.dy));
  }

  _drawDetailBs1(double plusH,Canvas canvas,double scale,Rect rect, String txt1, String txt2, String txtC, Paint textPaint){
    canvas.drawLine(Offset(rect.left,rect.top), Offset(rect.right,rect.top), textPaint);
    canvas.drawLine(Offset(rect.left,rect.bottom), Offset(rect.right,rect.bottom), textPaint);
    canvas.drawLine(Offset(rect.right,rect.top), Offset(rect.right,rect.bottom), textPaint);
    Results.dxf.drawLine(plusH,1/scale,Offset(rect.left,rect.top), Offset(rect.right,rect.top), textPaint);
    Results.dxf.drawLine(plusH,1/scale,Offset(rect.left,rect.bottom), Offset(rect.right,rect.bottom), textPaint);
    Results.dxf.drawLine(plusH,1/scale,Offset(rect.right,rect.top), Offset(rect.right,rect.bottom), textPaint);
    Offset ptxt = new Offset(rect.right-2*scale, rect.bottom-2*scale);
    TextStyle textStyle = new TextStyle(color: textPaint.color,fontSize: 18,fontWeight: FontWeight.bold);
    TextSpan span = new TextSpan(style: textStyle, text: txt1);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    canvas.translate(ptxt.dx- tp.height , ptxt.dy);
    canvas.rotate(-pi/2);
    tp.paint(canvas, new Offset(0 , 0));
    canvas.rotate(pi/2);
    canvas.translate(-ptxt.dx+ tp.height , -ptxt.dy);
    double dCircle = 18*scale;
    Offset pDetail = new Offset(ptxt.dx - dCircle/2, ptxt.dy - tp.width- 3*scale - dCircle/2);
    canvas.translate(pDetail.dx , pDetail.dy);
    canvas.rotate(-pi/2);
    canvas.drawCircle(Offset(0,0), dCircle/2, textPaint);
    _ResultsState._drawTextCenter(canvas, textPaint,txtC,0,0);
    canvas.rotate(pi/2);
    canvas.translate(-pDetail.dx , -pDetail.dy);
    ptxt = new Offset(pDetail.dx , pDetail.dy - dCircle/2 - 3*scale);
    span = new TextSpan(style: textStyle, text: txt2);
    tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    canvas.translate(ptxt.dx -tp.height/2 , ptxt.dy);
    canvas.rotate(-pi/2);
    tp.paint(canvas, new Offset(0,0));
    canvas.rotate(pi/2);
    canvas.translate(-ptxt.dx +tp.height/2, -ptxt.dy);
  }

  _drawDetailBs2(double plusH,Canvas canvas,double scale,Rect rect, String txt1, String txt2, String txtC, Paint textPaint){
    double d = 2*scale;
    double dCircle = 18*scale;
    canvas.drawLine(Offset(rect.left,rect.top+d), Offset(rect.right,rect.top+d), textPaint);
    canvas.drawLine(Offset(rect.left,rect.bottom), Offset(rect.right,rect.bottom), textPaint);
    canvas.drawLine(Offset(rect.right,rect.top+d), Offset(rect.right,rect.bottom), textPaint);
    canvas.drawLine(Offset(rect.left-d,rect.top), Offset(rect.right-d,rect.top), textPaint);
    canvas.drawLine(Offset(rect.left-d,rect.bottom-d), Offset(rect.right-d,rect.bottom-d), textPaint);
    canvas.drawLine(Offset(rect.left-d,rect.top), Offset(rect.left-d,rect.bottom-d), textPaint);
    Results.dxf.drawLine(plusH, 1/scale, Offset(rect.left,rect.top+d), Offset(rect.right,rect.top+d), textPaint);
    Results.dxf.drawLine(plusH, 1/scale, Offset(rect.left,rect.bottom), Offset(rect.right,rect.bottom), textPaint);
    Results.dxf.drawLine(plusH, 1/scale, Offset(rect.right,rect.top+d), Offset(rect.right,rect.bottom), textPaint);
    Results.dxf.drawLine(plusH, 1/scale, Offset(rect.left-d,rect.top), Offset(rect.right-d,rect.top), textPaint);
    Results.dxf.drawLine(plusH, 1/scale, Offset(rect.left-d,rect.bottom-d), Offset(rect.right-d,rect.bottom-d), textPaint);
    Results.dxf.drawLine(plusH, 1/scale, Offset(rect.left-d,rect.top), Offset(rect.left-d,rect.bottom-d), textPaint);
    Offset ptxt = new Offset(rect.right-2*scale, rect.top+2*scale+dCircle);
    TextStyle textStyle = new TextStyle(color: textPaint.color,fontSize: 18,fontWeight: FontWeight.bold);
    TextSpan span = new TextSpan(style: textStyle, text: txt1);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    canvas.translate(ptxt.dx- tp.height , ptxt.dy+tp.width);
    canvas.rotate(-pi/2);
    tp.paint(canvas, new Offset(0 , 0));
    canvas.rotate(pi/2);
    canvas.translate(-ptxt.dx+ tp.height , -ptxt.dy-tp.width);
    Offset pDetail = new Offset(ptxt.dx - dCircle/2, ptxt.dy - 3*scale - dCircle/2);
    canvas.translate(pDetail.dx , pDetail.dy);
    canvas.rotate(-pi/2);
    canvas.drawCircle(Offset(0,0), dCircle/2, textPaint);
    _ResultsState._drawTextCenter(canvas, textPaint,txtC,0,0);
    canvas.rotate(pi/2);
    canvas.translate(-pDetail.dx , -pDetail.dy);
    span = new TextSpan(style: textStyle, text: txt2);
    tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    ptxt = new Offset(rect.right, rect.top+2*scale+dCircle);
    canvas.translate(ptxt.dx, ptxt.dy+tp.width/2);
    canvas.rotate(-pi/2);
    tp.paint(canvas, new Offset(0,0));
    canvas.rotate(pi/2);
    canvas.translate(-ptxt.dx, -ptxt.dy-tp.width/2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _hatch(Canvas canvas,Rect rect,double plusH,double scale) {
    double b = rect.height;
    double a = rect.width;

    for (int i = 0; i < 4 ; i++) {
      canvas.drawLine(
          Offset(rect.left , rect.top + (b / 4) * (i + 1)),
          Offset(rect.left + (b / 4) * (i + 1), rect.top),
          paint0);
      Results.dxf.drawLine(plusH,scale,
          Offset(rect.left , rect.top + (b / 4) * (i + 1)),
          Offset(rect.left + (b / 4) * (i + 1), rect.top),
          paint0);
    }
    for (int i = 0; i < 4 ; i++) {
      canvas.drawLine(
          Offset(rect.right , rect.top + (b / 4) * (i + 1)),
          Offset(rect.right - (b / 4) * (i + 1), rect.top),
          paint0);
      Results.dxf.drawLine(plusH,scale,
          Offset(rect.right , rect.top + (b / 4) * (i + 1)),
          Offset(rect.right - (b / 4) * (i + 1), rect.top),
          paint0);
    }
    for (int i = 0; i < 4 ; i++) {
      canvas.drawLine(
          Offset(rect.left , rect.bottom - (b / 4) * (i + 1)),
          Offset(rect.left + (b / 4) * (i + 1), rect.bottom),
          paint0);
      Results.dxf.drawLine(plusH,scale,
          Offset(rect.left , rect.bottom - (b / 4) * (i + 1)),
          Offset(rect.left + (b / 4) * (i + 1), rect.bottom),
          paint0);
    }
    for (int i = 0; i < 4 ; i++) {
      canvas.drawLine(
          Offset(rect.right , rect.bottom - (b / 4) * (i + 1)),
          Offset(rect.right - (b / 4) * (i + 1), rect.bottom),
          paint0);
      Results.dxf.drawLine(plusH,scale,
          Offset(rect.right , rect.bottom - (b / 4) * (i + 1)),
          Offset(rect.right - (b / 4) * (i + 1), rect.bottom),
          paint0);
    }
    for (int i = 0; i < ((a-b)/(b/4)).round()-1 ; i++) {
      canvas.drawLine(
          Offset(rect.left + (b / 4) * (i + 1), rect.top),
          Offset(rect.left + (b / 4) * (i + 5), rect.bottom),
          paint0);
      Results.dxf.drawLine(plusH,scale,
          Offset(rect.left + (b / 4) * (i + 1), rect.top),
          Offset(rect.left + (b / 4) * (i + 5), rect.bottom),
          paint0);
    }
    for (int i = 0; i < ((a-b)/(b/4)).round()-1 ; i++) {
      canvas.drawLine(
          Offset(rect.right - (b / 4) * (i +1), rect.top),
          Offset(rect.right - (b / 4) * (i +5), rect.bottom),
          paint0);
      Results.dxf.drawLine(plusH,scale,
          Offset(rect.right - (b / 4) * (i +1), rect.top),
          Offset(rect.right - (b / 4) * (i +5), rect.bottom),
          paint0);
    }
  }
}
