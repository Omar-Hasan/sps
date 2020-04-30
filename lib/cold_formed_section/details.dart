import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stahl_section/cold_formed_section/ComputeDetails.dart';
import 'package:stahl_section/cold_formed_section/mainCold.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/popup.dart';
import 'package:stahl_section/popup_content.dart';
import 'package:stahl_section/translate/app_localizations.dart';
import 'package:photo_view/photo_view.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class details extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<details> {
  List<DetailsItem> listDetails = new List();


  static double alfa, tetaEave;
  String description, x_section;
  String grad = "S-355", details = "general", Material = "Steel";
  List<String> spinnerGrad = new List();
  List<String> spinnerDetails = new List();
  List<String> spinnerMaterial = new List();

  static int c1, c2,bA_eff, b1, b2, L_flang, L_web, Ls, LsEffect,  Ycg;
  static double ex, x0, scale_r = 1, thickness, raduis, h_lip, height, width, teta_axis;

  var paint = new Paint();
  var textPaint = new Paint();
  var paintAxis = new Paint();


  @override
  void initState() {
    super.initState();
    height = double.parse(mainCold.hieghtController.text);
    h_lip = double.parse(mainCold.h_lipController.text);
    width = double.parse(mainCold.widthController.text);
    thickness = double.parse(mainCold.tController.text);
    raduis = double.parse(mainCold.radiusController.text);
    description = mainCold.myController.text;
    x_section = mainCold.x_section;
    alfa = double.parse(mainCold.angleController.text);
    tetaEave = double.parse(mainCold.angleController.text) - 90;
    _setViewDeatils();
  spinnerGrad = [
      'S-235',
      'S-275',
      'S-355',
      'S-460',
    ];

    spinnerDetails = new List(3);
    spinnerMaterial = new List(3);
    dropDownMaterial = 'Steel';
    dropDownDetails ='Full cross_section area properties';
    dropDownGrad = 'S-235';

    paint.strokeWidth = 1;
    paint.color = color.red;
    paint.isAntiAlias = true;
    paint.style = PaintingStyle.stroke;

    textPaint.strokeWidth = 1.5;
    textPaint.color = color.gray;
    textPaint.isAntiAlias = true;
    textPaint.style = PaintingStyle.stroke;

    paintAxis.strokeWidth = 0.5;
    paintAxis.color = color.gray;
    paintAxis.isAntiAlias = true;
    paintAxis.style = PaintingStyle.stroke;



  }
  _setViewDeatils() {
    ComputeDetails computeDetails = new ComputeDetails(
        Material,
        details,
        grad,
        x_section,
        height,
        width,
        h_lip,
        thickness,
        raduis,
        double.parse(alfa.toString()),
        double.parse(tetaEave.toString()));
    List<String> value = computeDetails.getvalue_detail();
    List<String> name = computeDetails.getname_detail();
    c1 = computeDetails.c1;
    c2 = computeDetails.c2;
    b1 = computeDetails.b1;
    b2 = computeDetails.b2;
    bA_eff =computeDetails.bA_eff;
    L_flang = computeDetails.L_flang;
    L_web = computeDetails.L_web;
    Ls = computeDetails.Ls;
    LsEffect = computeDetails.LsEffect;
    Ycg = computeDetails.Ycg;
    ex = double.parse((computeDetails.ex).toString());
    x0 = double.parse((computeDetails.x0).toString());
    teta_axis = double.parse((computeDetails.Teta * 180 / pi).toString());

    listDetails.clear();
    for (int i = 0; i < value.length; i++) {
      listDetails.add(DetailsItem(name[i], value[i]));
    }
    //_swichX_section();
  }

  @override
  Widget build(BuildContext context) {
    spinnerDetails[0] = (AppLocalizations.of(context).translate('Fullcross_sectionareaproperties'));
    spinnerDetails[1] = (AppLocalizations.of(context).translate('Flexuralcross_sectionareaproperties'));
    spinnerDetails[2] = (AppLocalizations.of(context).translate('Compressioncross_sectionareaproperties'));
    spinnerMaterial[0] = (AppLocalizations.of(context).translate('Steel'));
    spinnerMaterial[1] = (AppLocalizations.of(context).translate('Aluminum'));
    spinnerMaterial[2] = (AppLocalizations.of(context).translate('Copper'));

    return Scaffold(
      appBar: _appBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: color.gray,
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              Text(
                description,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: color.White, fontWeight: FontWeight.bold),
              ),
              Row(children: <Widget>[
                Flexible(
                  flex:1,
                  child:_dropDownButtonMaterial(),
                ),
                Flexible(
                  flex:1,
                  child:_dropDownButtonGrad(),
                ),
              ],),
              Row(children: <Widget>[
                Flexible(
                  flex:1,
                  child:_dropDownButtonDetails(),
                ),
               ],),
              _photo(),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: _listDetails(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String dropDownMaterial,dropDownGrad,dropDownDetails;

  _dropDownButtonMaterial() {
    List<String> spinner = spinnerMaterial;
    return Container(
      alignment: Alignment.center,
      height: 40,
      margin: EdgeInsets.only(left: 1,top: 3),
      decoration: _decoration(5, 2, color.White),
      width: double.infinity,
      //color: color.WhiteSelver,
      child: DropdownButton<String>(
        value: dropDownMaterial,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 10,
        style: Theme.of(context).textTheme.display2.copyWith(fontSize: 18),
        underline: Container(
          height: 2,
          color: color.WhiteSelver,
        ),
        onChanged: (String data) {
          dropDownMaterial = data;
          setState(() {
            int i = 0;
            for (i = 0; i < spinner.length; i++) {
              if (data == spinner[i]) {
                switch (i) {
                  case 0:
                    Material = "Steel";
                    spinnerGrad.clear();
                    spinnerGrad = [
                      'S-235',
                      'S-275',
                      'S-355',
                      'S-460',
                    ];
                    dropDownGrad = 'S-275';
                    break;
                  case 1:
                    Material = "Aluminium";
                    spinnerGrad.clear();
                    spinnerGrad = [
                      'AC-42100',
                      'AC-42200',
                      'AC-43000',
                      'AC-43300',
                      'AC-44200',
                      'AC-51300',
                    ];
                    dropDownGrad = 'AC-51300';
                    break;
                  case 2:
                    Material = "Copper";
                    spinnerGrad.clear();
                    spinnerGrad = [
                      'ASTM B1,B2,B3,B152',
                    ];
                    dropDownGrad = 'ASTM B1,B2,B3,B152';

                    break;
                }
                break;
              }
            }
            _setViewDeatils();
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
    return DropdownButton<String>(
      value: spinner[0],
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 10,
      style: Theme.of(context).textTheme.display2.copyWith(fontSize: 18),
      underline: Container(
        height: 2,
        color: color.gray,
      ),
      onChanged: (String data) {
        setState(() {
          int i = 0;
          for (i = 0; i < spinner.length; i++) {
            if (data == spinner[i]) {
              switch (i) {
                case 0:
                  Material = "Steel";
                  spinnerGrad.clear();
                  spinnerGrad = [
                    'S-235',
                    'S-275',
                    'S-355',
                    'S-460',
                  ];
                  break;
                case 1:
                  Material = "Aluminium";
                  spinnerGrad.clear();
                  spinnerGrad = [
                    'AC-42100',
                    'AC-42200',
                    'AC-43000',
                    'AC-43300',
                    'AC-44200',
                    'AC-51300',
                  ];
                  break;
                case 2:
                  Material = "Copper";
                  spinnerGrad.clear();
                  spinnerGrad = [
                    'ASTM B1,B2,B3,B152',
                  ];
                  break;
              }
              break;
            }
          }
          _setViewDeatils();
        });
      },
      items: spinner.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  _dropDownButtonDetails() {
    List<String> spinner = spinnerDetails;
    return Container(
      padding: EdgeInsets.only(left: 3),
      height: 40,
      margin: EdgeInsets.only(left: 1, right: 1),
      decoration: _decoration(5, 2, color.White),
      width: double.infinity,
      //color: color.WhiteSelver,
      child: DropdownButton<String>(
        value: dropDownDetails,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 10,
        style: Theme.of(context).textTheme.display2.copyWith(fontSize: 18),
        underline: Container(
          height: 2,
          color: color.WhiteSelver,
        ),
        onChanged: (String data) {
          dropDownDetails = data;
          if (thickness == 0) {
            /*  Fluttertoast.showToast(
              msg: AppLocalizations.of(context).translate('getThickness'),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white
          );*/
            return;
          }
          setState(() {
            int i = 0;
            for (i = 0; i < spinner.length; i++) {
              if (data == spinner[i]) {
                switch (i) {
                  case 0:
                    details = "general";
                    break;
                  case 1:
                    details = "flexural";
                    break;
                  case 2:
                    details = "compression";
                    break;
                }
                break;
              }
            }
            _setViewDeatils();
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
  _dropDownButtonGrad() {
    List<String> spinner = spinnerGrad;
    return Container(
      alignment: Alignment.center,
      height: 40,
      margin: EdgeInsets.only(right: 1,top: 3),
      decoration: _decoration(5, 2, color.White),
      width: double.infinity,
      //color: color.WhiteSelver,
      child: DropdownButton<String>(
        value: dropDownGrad,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 10,
        style: Theme.of(context).textTheme.display2.copyWith(fontSize: 18),
        underline: Container(
          height: 2,
          color: color.WhiteSelver,
        ),
        onChanged: (String data) {
          dropDownGrad = data;
          setState(() {
            grad = data;
            _setViewDeatils();
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
    return DropdownButton<String>(
      value: spinner[0],
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 10,
      style: Theme.of(context).textTheme.display2.copyWith(fontSize: 18),
      underline: Container(
        height: 2,
        color: color.gray,
      ),
      onChanged: (String data) {
         setState(() {
           grad = data;
           _setViewDeatils();
        });
      },
      items: spinner.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  _decoration(double radius, double width, Color Mcolor) {
    return BoxDecoration(
      color: Mcolor,
      border: Border.all(color: color.black, width: width),
      borderRadius: BorderRadius.all(
          Radius.circular(radius) //                 <--- border radius here
          ),
    );
  }

  _appBar() {
    return AppBar(
      title: new Text(''),
      actions: <Widget>[
        SvgPicture.asset(
          'assets/code_image/save.svg',
          fit: BoxFit.contain,
        ),
        PopupMenuButton<String>(
          onSelected: choiceAction,
          itemBuilder: (BuildContext context) {
            return Constants.choices.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(
                  choice,
                  style: Theme.of(context).textTheme.display1,
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  _photo() {
    Widget _popupBody() {
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: PhotoView.customChild(
          backgroundDecoration: BoxDecoration(
            color: color.White,
          ),
            child: _swichX_section()
          //child: SvgPicture.asset(weldMain.imageDetails),
        ),
      );
    }

    _photoView() {
      showPopupCenter(context, _popupBody(), 'title');
    }

    return GestureDetector(
      onTap: () => _photoView(),
      child: Container(
          margin: EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
          color: color.White,
          border: Border.all(color: color.black, width: 3.0),
          borderRadius: BorderRadius.all(
              Radius.circular(11.0) //                 <--- border radius here
              ),
        ),
          width: double.infinity,
          height: 175,
          child: _swichX_section()
        //child: SvgPicture.asset(weldMain.imageDetails),
      ),
    );
  }

  _listDetails() {
    List<DetailsItem> listDetailsTrue = new List();
    for (int i = 0; i < listDetails.length; i++) {
      listDetailsTrue.add(listDetails[i]);
    }
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 10),
      child: ListView.separated(
        itemCount: listDetailsTrue.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: color.Whitegray,
          thickness: 2,
        ),
        itemBuilder: (context, i) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 7),
            height: 16,
            child: Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: new Text(
                        listDetailsTrue[i].title,
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 14, fontFamily: 'SugeoUI_bold'),
                      ),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 100),
                      child: new Text(
                        listDetailsTrue[i].value,
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 14),
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  void  choiceAction(String choice) {
    if (choice == Constants.symbols) {
      Widget _popupBody() {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: color.White,
          padding: EdgeInsets.all(3),
          child: ListView(
            children: <Widget>[
              Text(
                AppLocalizations.of(context)
                    .translate('meaningOFSYMBOLEWelded'),
                style: Theme.of(context).textTheme.display2,
              ),
            ],
          ),
        );
      }

      showPopupRight(context, _popupBody(), 'title');
    } else if (choice == Constants.Subscribe) {
      print('Subscribe');
    } else if (choice == Constants.SignOut) {
      print('SignOut');
    }
  }

  showPopupCenter(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: 30,
        left: 30,
        right: 30,
        bottom: 50,
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

  showPopupRight(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: 0,
        left: 70,
        right: 0,
        bottom: 7,
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
  
  _swichX_section() {
    switch (x_section) {
      case "z_with":
        {
          switch (details) {
            case "general":
              //default:
              return CustomPaint(
                painter:  draw_Z_coldWithgeneralDetails(context, paint, textPaint, paintAxis),
              );
              break;
            case "flexural":
              return CustomPaint(
                painter:  draw_z_coldWith_tensionCompretionDetails(true, paint, textPaint, paintAxis),
              );
              break;
            case "compression":
              return CustomPaint(
                painter:  draw_z_coldWith_tensionCompretionDetails(false, paint, textPaint, paintAxis),
              );
              break;
          }
        }
        break;
      case "z_without":
        {
          switch (details) {
            case "general":
              //default:
              return CustomPaint(
                painter:  draw_Z_coldgeneralDetails(context, paint, textPaint, paintAxis),
              );
              break;
            case "flexural":
              return CustomPaint(
                painter:  draw_z_cold_tensionCompretionDetails(true, paint, textPaint, paintAxis),
              );
              break;
            case "compression":
              return CustomPaint(
                painter:  draw_z_cold_tensionCompretionDetails(false, paint, textPaint, paintAxis),
              );
              break;
          }
        }
        break;
      case "u_without":
        {
          switch (details) {
            case "general":
              //default:
              return CustomPaint(
                painter:   draw_u_cold_generalDetails(context, paint, textPaint, paintAxis),
              );
              break;
            case "flexural":
              return CustomPaint(
                painter:   draw_u_cold_FlaxeurDetails(paint, textPaint, paintAxis),
              );
              break;
            case "compression":
              return CustomPaint(
                painter:   draw_u_cold_CompretionDetails(paint, textPaint, paintAxis),
              );
              break;
          }
        }
        break;
      case "u_with":
        {
          switch (details) {
            case "general":
            //default:
              return CustomPaint(
                painter:   draw_u_coldWith_generalDetails(context, paint, textPaint, paintAxis,false),
              );
              break;
            case "flexural":
              return CustomPaint(
                painter:   draw_u_coldWith_FlaxeurDetails(paint, textPaint, paintAxis,false),
              );
              break;
            case "compression":
              return CustomPaint(
                painter:   draw_u_coldWith_CompretionDetails(paint, textPaint, paintAxis,false),
              );
              break;
          }
        }
        break;
      case "u_hat":
        {
          switch (details) {
            case "general":
            //default:
              return CustomPaint(
                painter:   draw_u_coldWith_generalDetails(context, paint, textPaint, paintAxis,true),
              );
              break;
            case "flexural":
              return CustomPaint(
                painter:   draw_u_coldWith_FlaxeurDetails(paint, textPaint, paintAxis,true),
              );
              break;
            case "compression":
              return CustomPaint(
                painter:   draw_u_coldWith_CompretionDetails(paint, textPaint, paintAxis,true),
              );
              break;
          }
        }
        break;
    }
  }

  static _drawArc(Canvas c, Offset start, Offset end, double raduis,
      Paint paint, double teta) {
    //مع عقارب الساعة
    Rect rect;
    if (start.dx > end.dx && start.dy < end.dy) {
      rect = getRect(end, raduis, false);
      c.drawArc(rect, pi / 2, teta - pi, false, paint);
    } else if (start.dx > end.dx && start.dy > end.dy) {
      rect = getRect(start, raduis, false);
      c.drawArc(rect, pi / 2, pi - teta, false, paint);
    } else if (start.dx < end.dx && start.dy >= end.dy) {
      rect = getRect(end, raduis, true);
      c.drawArc(rect, 3 * pi / 2, -teta, false, paint);
    } else if (start.dx < end.dx && start.dy < end.dy) {
      rect = getRect(start, raduis, true);
      c.drawArc(rect, 3 * pi / 2, pi - teta, false, paint);
    }
  }

  static Rect getRect(Offset p, double raduis, bool top) {
    Rect rect;
    if (top) {
      rect = new Rect.fromLTRB(
          p.dx - raduis, p.dy, p.dx + raduis, p.dy + 2 * raduis);
    } else {
      rect = new Rect.fromLTRB(
          p.dx - raduis, p.dy - 2 * raduis, p.dx + raduis, p.dy);
    }
    return rect;
  }

  static _drawArcReight(Canvas c, Offset start, Offset end, double raduis,
      Paint paint, double teta) {
    //مع عقارب الساعة
    Rect rect;
    if (start.dx > end.dx && start.dy < end.dy) {
      rect = getRect(end, raduis, false);
      c.drawArc(rect, pi / 2, teta - pi, false, paint);
    } else if (start.dx > end.dx && start.dy > end.dy) {
      rect = getRect(start, raduis, false);
      c.drawArc(rect, pi / 2, pi - teta, false, paint);
    } else if (start.dx < end.dx && start.dy > end.dy) {
      rect = new Rect.fromLTRB(start.dx, start.dy - raduis,
          start.dx + 2 * raduis, start.dy + raduis);
      c.drawArc(rect, pi, teta, false, paint);
    } else if (start.dx < end.dx && start.dy < end.dy) {
      rect = getRect(start, raduis, true);
      c.drawArc(rect, 3 * pi / 2, pi - teta, false, paint);
    }
  }

  static _drawDimention(int t ,Canvas c, Offset start, Offset end, Paint paint,
      String s, Paint paintTedxt, double teta) {
    bool red =false;
    TextStyle textStyle = textStyleD.copyWith(fontSize: min(double.parse(t.toString()),18),fontWeight: FontWeight.bold, fontStyle: FontStyle.normal,);
    if (red) {
      //textStyle = TextStyle(fontSize: 14, color: color.red);
      //paint.color = color.red;
    }
    //paintTedxt.setTedxtSize(50);
    if (start.dx == end.dx && start.dy == end.dy) {
      return;
    }
    int arrow = 5;
    if (start.dx == end.dx) {
      c.drawLine(Offset(start.dx + arrow, start.dy),
          Offset(start.dx - arrow, start.dy), paint);
      c.drawLine(
          Offset(end.dx + arrow, end.dy), Offset(end.dx - arrow, end.dy), paint);
      //paintTedxt.getTedxtBounds(s, 0, s.length(), bounds);
      c.translate((end.dx + start.dx) / 2, (end.dy + start.dy) / 2);
      c.rotate(3 * pi / 2);
      if (start.dy > end.dy) {
        //RectHeight_lip = new Rect((start.dx) - bounds.height() * 4,  abs(start.dy + end.dy) / 2 - bounds.width() + BmbDivorc.dy, (start.dx) + bounds.height() * 4,  abs(start.dy + end.dy) / 2 + bounds.width() - BmbDivorc.dy);
        _drawTextCenter(c, textStyle, s, 0, 0);
      } else {
        //RectHeight = new Rect((start.dx) - bounds.height() * 2,  abs(start.dy + end.dy) / 2 - bounds.width(), (start.dx) + bounds.height() * 2,  abs(start.dy + end.dy) / 2 + bounds.width());
        _drawTextCenter(c, textStyle, s, 0, 0);
      }
      c.rotate(-3 * pi / 2);
      c.translate(-(end.dx + start.dx) / 2, -(end.dy + start.dy) / 2);
    } else if (start.dy == end.dy) {
      c.drawLine(Offset(start.dx, start.dy - arrow),
          Offset(start.dx, start.dy + arrow), paint);
      c.drawLine(
          Offset(end.dx, end.dy - arrow), Offset(end.dx, end.dy + arrow), paint);
      //paintTedxt.getTedxtBounds(s, 0, s.length(), bounds);
      if (start.dx > end.dx) {
        _drawTextCenter(c, textStyle, s, (end.dx + start.dx) / 2, start.dy);
      } else {
        _drawTextCenter(c, textStyle, s, (end.dx + start.dx) / 2, start.dy);
      }
      //RectWidth = new Rect((end.dx + start.dx) / 2 - bounds.width(), start.dy - bounds.height() * 2 + BmbDivorc.dy, (end.dx + start.dx) / 2 + bounds.width(), start.dy + bounds.height() * 2 - BmbDivorc.dy);
    } else {
      double sinTeta = sin(teta - pi / 2);
      double cosTeta = cos(teta - pi / 2);
      c.drawLine(Offset(start.dx - 5 * cosTeta, start.dy + 5 * sinTeta),
          Offset(start.dx + 5 * cosTeta, start.dy - 5 * sinTeta), paint);
      c.drawLine(Offset(end.dx - 5 * cosTeta, end.dy + 5 * sinTeta),
          Offset(end.dx + 5 * cosTeta, end.dy - 5 * sinTeta), paint);
      //paintTedxt.getTedxtBounds(s, 0, s.length(), bounds);
      c.translate((end.dx + start.dx) / 2, (end.dy + start.dy) / 2);
      c.rotate(pi - teta);
      _drawTextCenter(c, textStyle, s, 0, 0);
      c.rotate(-pi + teta);
      c.translate(-(end.dx + start.dx) / 2, -(end.dy + start.dy) / 2);
      // RectHeight_lip = new Rect((start.dx+end.dx)/2 - bounds.width()*3,  abs(start.dy + end.dy) / 2 - bounds.width()*3, (start.dx+end.dx)/2 + bounds.width() ,  abs(start.dy + end.dy) / 2 + bounds.width()*3);
    }
    paint.color = color.gray;
    c.drawLine(Offset(start.dx, start.dy), Offset(end.dx, end.dy), paint);
  }


  static _drawArcDimention(
      Canvas canvas,
      Paint paint,
      Offset pS,
      Offset pE,
      double radius) {
    Offset p1;
    Offset p2;
    bool red = false;
    //paint.setTedxtSize(50);
    if (pS.dx < pE.dx) {
      p1 = new Offset(pE.dx - 0.707 * radius, pE.dy + 0.293 * radius);
      p2 = new Offset(p1.dx + radius * 2, p1.dy + 2 * radius + thickness);
    } else {
      p1 = new Offset(pS.dx - 0.707 * radius, pS.dy - 0.293 * radius);
      p2 = new Offset(p1.dx + radius * 2, p1.dy - 2 * radius - thickness);
    }
    canvas.drawLine(Offset(p1.dx, p1.dy), Offset(p2.dx, p2.dy), paint);
    if (red) {
      paint.color = color.red;
    }
    //Rect bounds = new Rect();
    //paint.getTedxtBounds(raduis, 0, raduis.length(), bounds);
    //RectRaduis = new Rect(p2.dx-bounds.width(), p2.dy-bounds.height()*3,p2.dx+bounds.width(), p2.dy+bounds.height()*3);
    _drawTextStart(
        canvas,
textStyleD.copyWith(fontSize: 18,fontWeight: FontWeight.bold, fontStyle: FontStyle.normal,)
    ,
        'r',
        p2.dx,
        p2.dy+9);
    paint.color = color.gray;
  }

  static _drawTextCenter(
      Canvas context, TextStyle textStyle, String text, double x, double y) {
    TextSpan span = new TextSpan(style: textStyle, text: text);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(context, new Offset(x - tp.width / 2, y - tp.height));
  }

  static _drawTextStart(
      Canvas context, TextStyle textStyle, String text, double x, double y) {
    TextSpan span = new TextSpan(style: textStyle, text: text);
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(context, new Offset(x, y - tp.height));
  }

  static _drawAxis_uCold(Canvas canvas, Paint paint, Offset p, double x0,
      double ex, double height, double width) {
    List<Offset> pointFS = new List(4);
    pointFS[0] = new Offset(p.dx, p.dy + height / 2);
    pointFS[1] = new Offset(p.dx, p.dy - height / 2);
    pointFS[2] = new Offset(p.dx - 80 * scale_r - x0, p.dy);
    pointFS[3] = new Offset(p.dx + width / 2, p.dy);
    Offset Sc = new Offset(p.dx - x0, p.dy);

    canvas.drawLine(Offset(pointFS[0].dx, pointFS[0].dy),
        Offset(pointFS[1].dx, pointFS[1].dy), paint);
    canvas.drawLine(Offset(pointFS[2].dx, pointFS[2].dy),
        Offset(pointFS[3].dx, pointFS[3].dy), paint);

    TextStyle textStyle = new TextStyle(
      color: color.gray,
      fontSize: 14,
      fontStyle: FontStyle.italic,
    );
    _drawTextStart(canvas, textStyle, "Z", pointFS[0].dx, pointFS[0].dy);
    _drawTextStart(canvas, textStyle, "Z", pointFS[1].dx, pointFS[1].dy);
    _drawTextStart(canvas, textStyle, "Y", pointFS[2].dx, pointFS[2].dy);
    _drawTextStart(canvas, textStyle, "Y", pointFS[3].dx, pointFS[3].dy);
    _drawTextStart(canvas, textStyle, "C-G", p.dx, p.dy);
    _drawTextStart(canvas, textStyle, "S-c", p.dx - x0, p.dy);
    Sc = Offset(Sc.dx, Sc.dy + height / 4);
    p = Offset(p.dx, p.dy + height / 4);
    _drawDimention(min(width/10,height/10).round(),canvas, Sc, p, paint, "x0", paint, pi/2);

    Sc = Offset(Sc.dx, Sc.dy - height / 2);
    p = Offset(p.dx, p.dy - height / 2);
    Offset px = new Offset(p.dx - ex, Sc.dy);
    _drawDimention(min(width/10,height/10).round(), canvas, px, p, paint, "eZ", paint, pi/2);
    _drawDimention(min(width/10,height/10).round(), canvas, Sc, px, paint, "m", paint, pi/2);
  }

  static TextStyle textStyle = new TextStyle(
    color: color.gray,
    fontSize: 14,
    fontStyle: FontStyle.italic,
  );
  static TextStyle textStyleD = new TextStyle(
    color: color.gray,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static _drawAxis_ZCold(Canvas canvas, Paint paint, Offset center,
      double height, double width, double teta) {
    double sinTeta = sin(teta * pi / 180);
    double cosTeta = cos(teta * pi / 180);
    double tanTeta = tan(teta * pi / 180);
    double cotanTeta = cosTeta / sinTeta;

    List<Offset> pointFS = new List(4);
    pointFS[0] = new Offset(center.dx, center.dy + height / 2);
    pointFS[1] = new Offset(center.dx, center.dy - height / 2);
    pointFS[2] = new Offset(center.dx - width / 2, center.dy);
    pointFS[3] = new Offset(center.dx + width / 2, center.dy);
    List<Offset> pointF2 = new List(4);
    pointF2[0] =
        new Offset(center.dx + width / 2, center.dy - (width / 2) * tanTeta);
    pointF2[1] =
        new Offset(center.dx - width / 2, center.dy + (width / 2) * tanTeta);
    pointF2[2] =
        new Offset(center.dx - width / 4, center.dy - (width / 4) * cotanTeta);
    pointF2[3] =
        new Offset(center.dx + width / 4, center.dy + (width / 4) * cotanTeta);
    List<Offset> pointFArc = new List(3);
    pointFArc[0] = new Offset(
        center.dx - (width / 6) * cosTeta, center.dy + (width / 6) * sinTeta);
    pointFArc[1] = new Offset(center.dx - (width / 6), center.dy);
    pointFArc[2] = new Offset(center.dx - (width / 6 + 10),
        center.dy + (width / 6 + 10) * tanTeta / 2);

    canvas.drawLine(Offset(pointFS[0].dx, pointFS[0].dy),
        Offset(pointFS[1].dx, pointFS[1].dy), paint);
    canvas.drawLine(Offset(pointFS[2].dx, pointFS[2].dy),
        Offset(pointFS[3].dx, pointFS[3].dy), paint);
    canvas.drawLine(Offset(pointF2[0].dx, pointF2[0].dy),
        Offset(pointF2[1].dx, pointF2[1].dy), paint);
    canvas.drawLine(Offset(pointF2[2].dx, pointF2[2].dy),
        Offset(pointF2[3].dx, pointF2[3].dy), paint);
//     paint.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
    //drawArc(canvas,pointFArc[0],pointFArc[1],width/12*sinTeta,paint,(int) teta);
    _drawTextStart(canvas, textStyle.copyWith(fontSize: min(width/10,height/10)), "Z", pointFS[0].dx, pointFS[0].dy);
    _drawTextStart(canvas, textStyle.copyWith(fontSize: min(width/10,height/10)), "Z", pointFS[1].dx, pointFS[1].dy);
    _drawTextStart(canvas, textStyle.copyWith(fontSize: min(width/10,height/10)), "Y", pointFS[2].dx, pointFS[2].dy+7);
    _drawTextStart(canvas, textStyle.copyWith(fontSize: min(width/10,height/10)), "Y", pointFS[3].dx, pointFS[3].dy+7);
    _drawTextStart(canvas, textStyle.copyWith(fontSize: min(width/10,height/10)), "C-G", center.dx, center.dy);
    _drawTextStart(canvas, textStyle.copyWith(fontSize: min(width/10,height/10)), "Y2", pointF2[0].dx, pointF2[0].dy);
    _drawTextStart(canvas, textStyle.copyWith(fontSize: min(width/10,height/10)), "Z2", pointF2[2].dx, pointF2[2].dy);
    _drawTextStart(canvas, textStyle.copyWith(fontSize: min(width/10,height/10)), "Ɵ", pointFArc[2].dx, pointFArc[2].dy);
    //  paint.setPathEffect(new DashPathEffect(new double[]{40, 15, 5, 15}, 0));
  }
}

class Constants {
  static const String Subscribe = 'Subscribe';
  static const String symbols = 'Symbols';
  static const String SignOut = 'Sign out';

  static const List<String> choices = <String>[
    symbols,
  ];
  static BuildContext context;
}

class DetailsItem {
  final String title;
  String value;

  DetailsItem(this.title, this.value);
}

class draw_Z_coldgeneralDetails extends CustomPainter {
  Paint paint0, textPaint0, paint0Axis;
  BuildContext context;

  draw_Z_coldgeneralDetails(this.context,this.paint0,this.textPaint0,this.paint0Axis);

  @override
  void paint(Canvas canvas, Size size) {
    _State.scale_r =  min((size.width*0.8) / (_State.width * 2 - _State.thickness),   (size.height*0.8) / (_State.height));
    //Canvas canvas;
    double constant = 0;
    if ( _State.h_lip > 0) {
      constant = 1;
    }
    double width = _State.width * _State.scale_r;
    double height = _State.height * _State.scale_r;
    double raduis = _State.raduis * _State.scale_r;
    double thikcnes = _State.thickness * _State.scale_r;
    double heightLips = _State.h_lip * _State.scale_r;
    double Ycg = _State.Ycg * _State.scale_r;
    double tetaAxis = double.parse(_State.teta_axis.toString());
    double a = height - (2 * raduis + thikcnes);
    double b = width - (raduis + thikcnes / 2 + constant * (raduis + thikcnes / 2));
    double c = constant * (heightLips - (raduis + thikcnes / 2));
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double teta = pi / 2;
    double strokWidth=2;
    List<Offset> p = new List(6);
    p[0] = new Offset(centerX + raduis + b, centerY - height / 2 + thikcnes / 2);
    p[1] = new Offset(p[0].dx - b, centerY - height / 2 + thikcnes / 2);
    p[2] = new Offset(centerX, centerY - a / 2);
    p[3] = new Offset(centerX, centerY + a / 2);
    p[5] = new Offset(centerX - raduis - b, centerY + height / 2 - thikcnes / 2);
    p[4] = new Offset(p[5].dx + b, p[5].dy);
    Offset cG = new Offset(centerX, centerY);
    _State._drawAxis_ZCold(canvas, paint0Axis, cG, height / 2, width + 20 * _State.scale_r, tetaAxis);
    // paint0.setPathEffect(new DashPathEffect(new double[]{40, 20, 10, 20}, 0));
    _State._drawArc(canvas, p[2], p[1], raduis, paint0, teta);
    _State._drawArcDimention(canvas, paint0Axis, p[2], p[1], raduis);

    /*canvas.drawLine(Offset(p[1].dx, p[1].dy, p[0].dx, p[0].dy, paint0);
        canvas.drawLine(Offset(p[2].dx, p[2].dy, p[3].dx, p[3].dy, paint0);
        canvas.drawLine(Offset(p[5].dx, p[5].dy, p[4].dx, p[4].dy, paint0);
*/
    List<Offset> pTop = new List(6);
    pTop[0] = new Offset(p[0].dx, p[0].dy - thikcnes / 2);
    pTop[1] = new Offset(p[1].dx, p[1].dy - thikcnes / 2);
    pTop[2] = new Offset(p[2].dx - thikcnes / 2, p[2].dy);
    pTop[3] = new Offset(p[3].dx - thikcnes / 2, p[3].dy);
    pTop[5] = new Offset(p[5].dx, p[5].dy - thikcnes / 2);
    pTop[4] = new Offset(p[4].dx, p[4].dy - thikcnes / 2);

    List<Offset> pBottom = new List(6);
    pBottom[0] = new Offset(p[0].dx, p[0].dy + thikcnes / 2);
    pBottom[1] = new Offset(p[1].dx, p[1].dy + thikcnes / 2);
    pBottom[2] = new Offset(p[2].dx + thikcnes / 2, p[2].dy);
    pBottom[3] = new Offset(p[3].dx + thikcnes / 2, p[3].dy);
    pBottom[5] = new Offset(p[5].dx, p[5].dy + thikcnes / 2);
    pBottom[4] = new Offset(p[4].dx, p[4].dy + thikcnes / 2);

    if (thikcnes != 0) {
      //paint0.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
      _State._drawArc(canvas, pTop[2], pTop[1], raduis + thikcnes / 2, paint0, teta);
      _State._drawArc(canvas, pTop[3], pTop[4], raduis - thikcnes / 2, paint0, teta);
      canvas.drawLine(Offset(pBottom[0].dx, pBottom[0].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
      canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pTop[5].dx, pTop[5].dy), paint0);
      canvas.drawLine(Offset(pTop[1].dx, pTop[1].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
      canvas.drawLine(Offset(pTop[2].dx, pTop[2].dy), Offset(pTop[3].dx, pTop[3].dy), paint0);
      canvas.drawLine(Offset(pTop[5].dx, pTop[5].dy), Offset(pTop[4].dx, pTop[4].dy), paint0);
      canvas.drawLine(Offset(pBottom[1].dx, pBottom[1].dy), Offset(pBottom[0].dx, pBottom[0].dy), paint0);
      canvas.drawLine(Offset(pBottom[2].dx, pBottom[2].dy), Offset(pBottom[3].dx, pBottom[3].dy), paint0);
      canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pBottom[4].dx, pBottom[4].dy), paint0);
      _State._drawArc(canvas, pBottom[2], pBottom[1], raduis - thikcnes / 2, paint0, teta);
      _State._drawArc(canvas, pBottom[3], pBottom[4], raduis + thikcnes / 2, paint0, teta);
    } else {
      _State._drawArc(canvas, p[3], p[4], raduis, paint0, teta);
      canvas.drawLine(Offset(p[1].dx, p[1].dy), Offset(p[0].dx, p[0].dy), paint0);
      canvas.drawLine(Offset(p[2].dx, p[2].dy), Offset(p[3].dx, p[3].dy), paint0);
      canvas.drawLine(Offset(p[5].dx, p[5].dy), Offset(p[4].dx, p[4].dy), paint0);
    }

    int paddingDimention = min((size.width/20).round(),(size.height/20).round());
    List<Offset> pDimention = new List(2);
    pDimention[0] = new Offset(p[1].dx - raduis - thikcnes / 2, p[1].dy - paddingDimention - thikcnes / 2);
    pDimention[1] = new Offset(centerX - thikcnes / 2 + width, p[1].dy - paddingDimention - thikcnes / 2);
    _State._drawDimention(paddingDimention, canvas, pDimention[0], pDimention[1], textPaint0, "W", textPaint0, teta);

    pDimention[0] = new Offset (p[5].dx - paddingDimention,  pTop[1].dy);
    pDimention[1] = new Offset(p[5].dx - paddingDimention , pBottom[5].dy);
    _State._drawDimention(paddingDimention, canvas, pDimention[0], pDimention[1], textPaint0, "h", textPaint0, teta);

    /**/

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
class draw_z_cold_tensionCompretionDetails extends CustomPainter {
  Paint paint0, textPaint0, paint0Axis;
  bool isFlexural;

  draw_z_cold_tensionCompretionDetails(this.isFlexural,this.paint0,this.textPaint0,this.paint0Axis);

  @override
  void paint(Canvas canvas, Size size) {
    _State.scale_r =  min((size.width*0.8) / (_State.width * 2 - _State.thickness),   (size.height*0.8) / (_State.height));
    //Canvas canvas;
    double constant = 0;
    if ( _State.h_lip > 0) {
      constant = 1;
    }
    double width = _State.width * _State.scale_r;
    double height = _State.height * _State.scale_r;
    double raduis = _State.raduis * _State.scale_r;
    double thikcnes = _State.thickness * _State.scale_r;
    double heightLips = _State.h_lip * _State.scale_r;
    double Ycg = _State.Ycg * _State.scale_r;
    double c1 = double.parse(_State.c1.toString())* _State.scale_r;
    double c2 = double.parse(_State.c2.toString())* _State.scale_r;
    double b1,b2;
    if(isFlexural){
      b1 = double.parse(_State.b1.toString())* _State.scale_r;
      b2 = double.parse(_State.b2.toString())* _State.scale_r;
    }else{
      b1 = b2 = double.parse((_State.bA_eff / 2).toString())* _State.scale_r;
    }
    double a = height - (2 * raduis + thikcnes);
    double b = width - (raduis + thikcnes / 2 + constant * (raduis + thikcnes / 2));
    double c = constant * (heightLips - (raduis + thikcnes / 2));
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double teta = pi / 2;
    double strokWidth=2;
    List<Offset> p = new List(6);
    p[0] = new Offset(centerX + raduis + b, centerY - height / 2 + thikcnes / 2);
    p[1] = new Offset(p[0].dx - b, centerY - height / 2 + thikcnes / 2);
    p[2] = new Offset(centerX, centerY - a / 2);
    p[3] = new Offset(centerX, centerY + a / 2);
    p[5] = new Offset(centerX - raduis - b, centerY + height / 2 - thikcnes / 2);
    p[4] = new Offset(p[5].dx + b, p[5].dy);

    double widthLine =  paint0.strokeWidth;
    paint0.strokeWidth = (1);
    List<Offset> pTop = new List(6);
    pTop[0] = new Offset(p[0].dx, p[0].dy - thikcnes / 2);
    pTop[1] = new Offset(p[1].dx, p[1].dy - thikcnes / 2);
    pTop[2] = new Offset(p[2].dx - thikcnes / 2, p[2].dy);
    pTop[3] = new Offset(p[3].dx - thikcnes / 2, p[3].dy);
    pTop[5] = new Offset(p[5].dx, p[5].dy - thikcnes / 2);
    pTop[4] = new Offset(p[4].dx, p[4].dy - thikcnes / 2);

    List<Offset> pBottom = new List(6);
    pBottom[0] = new Offset(p[0].dx, p[0].dy + thikcnes / 2);
    pBottom[1] = new Offset(p[1].dx, p[1].dy + thikcnes / 2);
    pBottom[2] = new Offset(p[2].dx + thikcnes / 2, p[2].dy);
    pBottom[3] = new Offset(p[3].dx + thikcnes / 2, p[3].dy);
    pBottom[5] = new Offset(p[5].dx, p[5].dy + thikcnes / 2);
    pBottom[4] = new Offset(p[4].dx, p[4].dy + thikcnes / 2);

    List<Offset> pF = new List(6);
    pF[0] = new Offset(p[0].dx - c2, p[0].dy);
    pF[1] = new Offset(p[1].dx + c1, p[1].dy);
    pF[2] = new Offset(p[2].dx, p[2].dy + b1);
    pF[3] = new Offset(p[3].dx, p[3].dy - b2);
    pF[5] = new Offset(p[5].dx + c2, p[5].dy);
    pF[4] = new Offset(p[4].dx - c1, p[4].dy);
    List<Offset> pFTop = new List(4);
    pFTop[0] = new Offset(pTop[0].dx - c2, pTop[0].dy);
    pFTop[1] = new Offset(pTop[1].dx + c1, pTop[1].dy);
    pFTop[2] = new Offset(pTop[2].dx, pTop[2].dy + b1);
    pFTop[3] = new Offset(pTop[3].dx, pTop[3].dy - b2);
    List<Offset> pFBottom = new List(4);
    pFBottom[0] = new Offset(pBottom[0].dx - c2, pBottom[0].dy);
    pFBottom[1] = new Offset(pBottom[1].dx + c1, pBottom[1].dy);
    pFBottom[2] = new Offset(pBottom[2].dx, pBottom[2].dy + b1);
    pFBottom[3] = new Offset(pBottom[3].dx, pBottom[3].dy - b2);
    if (thikcnes != 0) {
      // paint0.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
      _State._drawArc(canvas, pTop[2], pTop[1], raduis + thikcnes / 2, paint0, teta);
      _State._drawArc(canvas, pTop[3], pTop[4], raduis - thikcnes / 2, paint0, teta);
      canvas.drawLine(Offset(pBottom[0].dx, pBottom[0].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
      canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pTop[5].dx, pTop[5].dy), paint0);
      canvas.drawLine(Offset(pTop[1].dx, pTop[1].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
      canvas.drawLine(Offset(pTop[2].dx, pTop[2].dy), Offset(pTop[3].dx, pTop[3].dy), paint0);
      canvas.drawLine(Offset(pTop[5].dx, pTop[5].dy), Offset(pTop[4].dx, pTop[4].dy), paint0);
      canvas.drawLine(Offset(pBottom[1].dx, pBottom[1].dy), Offset(pBottom[0].dx, pBottom[0].dy), paint0);
      canvas.drawLine(Offset(pBottom[2].dx, pBottom[2].dy), Offset(pBottom[3].dx, pBottom[3].dy), paint0);
      canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pBottom[4].dx, pBottom[4].dy), paint0);
      _State._drawArc(canvas, pBottom[2], pBottom[1], raduis - thikcnes / 2, paint0, teta);
      _State._drawArc(canvas, pBottom[3], pBottom[4], raduis + thikcnes / 2, paint0, teta);
    }
    paint0.strokeWidth  = (thikcnes);
    canvas.drawLine(Offset(p[0].dx, p[0].dy), Offset(pF[0].dx, pF[0].dy), paint0);
    canvas.drawLine(Offset(p[1].dx, p[1].dy), Offset(pF[1].dx, pF[1].dy), paint0);
    canvas.drawLine(Offset(p[2].dx, p[2].dy), Offset(pF[2].dx, pF[2].dy), paint0);
    canvas.drawLine(Offset(p[3].dx, p[3].dy), Offset(pF[3].dx, pF[3].dy), paint0);
    if (isFlexural) {
      canvas.drawLine(Offset(p[4].dx, p[4].dy), Offset(p[5].dx, p[5].dy), paint0);
    } else {
      canvas.drawLine(Offset(p[4].dx, p[4].dy), Offset(pF[4].dx, pF[4].dy), paint0);
      canvas.drawLine(Offset(p[5].dx, p[5].dy), Offset(pF[5].dx, pF[5].dy), paint0);
    }
    _State._drawArc(canvas, p[2], p[1], raduis, paint0, teta);
    _State._drawArc(canvas, p[3], p[4], raduis, paint0, teta);
    paint0.strokeWidth = (widthLine);

    Offset cG;
    if (isFlexural) {
      cG = new Offset(centerX, p[0].dy - thikcnes / 2 + Ycg);
    } else {
      cG = new Offset(centerX, centerY);
    }
    int paddingDimention = min((size.width/20).round(),(size.height/20).round());
    canvas.drawLine(Offset(cG.dx + width, cG.dy), Offset(cG.dx - width / 2, cG.dy), paint0Axis);
    //     paint0Axis.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
    _State._drawTextStart(canvas, _State.textStyleD,"Y", cG.dx + width, cG.dy);
    Offset pSDimen = new Offset(p[0].dx + raduis + thikcnes / 2 + 10 * _State.scale_r, p[0].dy - thikcnes / 2);
    Offset pEDimen = new Offset(p[0].dx + raduis + thikcnes / 2 + 10 * _State.scale_r, cG.dy);
    _State._drawDimention(paddingDimention, canvas, pSDimen, pEDimen, paint0Axis, "Ycg", paint0Axis, pi / 2);
     pTop[1] = new Offset(pTop[1].dx,pTop[1].dy - paddingDimention);
    pFTop[1] = new Offset(pFTop[1].dx,pFTop[1].dy -  paddingDimention);
    pTop[0] = new Offset(pTop[0].dx,pTop[0].dy - paddingDimention);
    pFTop[0] = new Offset(pFTop[0].dx,pFTop[0].dy -  paddingDimention);
    _State._drawDimention(paddingDimention, canvas, pTop[1], pFTop[1], paint0Axis, "C1", paint0Axis, teta);
    _State._drawDimention(paddingDimention, canvas, pFTop[0], pTop[0], paint0Axis, "C2", paint0Axis, teta);
    pFBottom[2] = new Offset(pFBottom[2].dx + paddingDimention,pFBottom[2].dy);
    pBottom[2] = new Offset(pBottom[2].dx + paddingDimention,pBottom[2].dy);
    pFBottom[3] = new Offset(pFBottom[3].dx + paddingDimention,pFBottom[3].dy);
    pBottom[3] = new Offset(pBottom[3].dx + paddingDimention,pBottom[3].dy);
    _State._drawDimention(paddingDimention, canvas, pFBottom[2], pBottom[2], paint0Axis, "b1", paint0Axis, teta);
    _State._drawDimention(paddingDimention, canvas, pBottom[3], pFBottom[3], paint0Axis, "b2", paint0Axis, teta);
    pTop[2] = new Offset(pTop[2].dx - paddingDimention,pTop[2].dy);
    pTop[3] = new Offset(pTop[3].dx - paddingDimention,pTop[3].dy);
    pTop[4] = new Offset(pTop[4].dx ,pTop[4].dy- paddingDimention);
    pTop[5] = new Offset(pTop[5].dx ,pTop[5].dy- paddingDimention);
    _State._drawDimention(paddingDimention,canvas, pTop[2], pTop[3], textPaint0, "L-web", textPaint0, teta);
    _State._drawDimention(paddingDimention, canvas, pTop[5], pTop[4], textPaint0, "L-flang", textPaint0, 3 * pi /2);
    //paint0Axis.setPathEffect(new DashPathEffect(new double[]{40, 15, 15, 15}, 0));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class draw_Z_coldWithgeneralDetails extends CustomPainter {
  Paint paint0, textPaint0, paint0Axis;
  BuildContext context;

  draw_Z_coldWithgeneralDetails(this.context,this.paint0,this.textPaint0,this.paint0Axis);

  @override
  void paint(Canvas canvas, Size size) {
    //Canvas canvas;
    double alfa = double.parse(_State.alfa.toString()) * pi / 180;
    double cosTeta1 =  sin((alfa - pi / 2) );
    double sinTeta =  cos((alfa - pi / 2));
    double tanTetaOn2 =  tan((pi - alfa) / 2);
    if (alfa == pi / 2) {
      tanTetaOn2 = 1;
    }
    _State.scale_r =  min((size.width*0.8) / (_State.width * 2 - _State.thickness + _State.h_lip * sinTeta * 2),   (size.height*0.8) / (_State.height));
    int constant = 0;
    double width = _State.width * _State.scale_r;
    double height = _State.height * _State.scale_r;
    double raduis = _State.raduis * _State.scale_r;
    double thikcnes = _State.thickness * _State.scale_r;
    //double heightLips = _State.h_lip * _State.scale_r;
    double Ycg = _State.Ycg * _State.scale_r;
    double tetaAxis = double.parse(_State.teta_axis.toString());
    double L_steffiner = _State.h_lip * _State.scale_r;
    double a = height - (2 * raduis + thikcnes);
    double b = width - (raduis + thikcnes / 2 + constant * (raduis + thikcnes / 2));
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double teta = pi /2;
    Offset cG = new Offset(centerX, centerY);

    _State._drawAxis_ZCold(canvas, paint0Axis, cG, height / 2, width + 20 * _State.scale_r, tetaAxis);
    //paint0.setPathEffect(new DashPathEffect(new double[]{40, 20, 10, 20}, 0));

    List<Offset> p = new List(10);
    p[0] = new Offset(centerX + raduis + b, centerY - height / 2 + thikcnes / 2);
    p[1] = new Offset(p[0].dx - b, centerY - height / 2 + thikcnes / 2);
    p[2] = new Offset(centerX, centerY - a / 2);
    p[3] = new Offset(centerX, centerY + a / 2);
    p[5] = new Offset(centerX - raduis - b, centerY + height / 2 - thikcnes / 2);
    p[4] = new Offset(p[5].dx + b, p[5].dy);
    p[6] = new Offset(p[5].dx - raduis * sinTeta, p[5].dy - raduis * (1 - cosTeta1));
    p[7] = new Offset(p[6].dx - L_steffiner * cosTeta1, p[6].dy - L_steffiner * sinTeta);
    p[8] = new Offset(p[0].dx + raduis * sinTeta, p[0].dy + raduis * (1 - cosTeta1));
    p[9] = new Offset(p[8].dx + L_steffiner * cosTeta1, p[8].dy + L_steffiner * sinTeta);
    //paint0.setPathEffect(new DashPathEffect(new double[]{40, 20, 10, 20}, 0));
    _State._drawArc(canvas, p[2], p[1], raduis, paint0, teta);
    _State._drawArcDimention(canvas, paint0Axis, p[2], p[1], raduis);

    List<Offset> pTop = new List(10);
    pTop[0] = new Offset(p[0].dx, p[0].dy - thikcnes / 2);
    pTop[1] = new Offset(p[1].dx, p[1].dy - thikcnes / 2);
    pTop[2] = new Offset(p[2].dx - thikcnes / 2, p[2].dy);
    pTop[3] = new Offset(p[3].dx - thikcnes / 2, p[3].dy);
    pTop[5] = new Offset(p[5].dx, p[5].dy - thikcnes / 2);
    pTop[4] = new Offset(p[4].dx, p[4].dy - thikcnes / 2);
    pTop[6] = new Offset(p[6].dx + sinTeta * thikcnes / 2, p[6].dy - cosTeta1 * thikcnes / 2);
    pTop[7] = new Offset(p[7].dx + sinTeta * thikcnes / 2, p[7].dy - cosTeta1 * thikcnes / 2);
    pTop[8] = new Offset(p[8].dx + sinTeta * thikcnes / 2, p[8].dy - cosTeta1 * thikcnes / 2);
    pTop[9] = new Offset(p[9].dx + sinTeta * thikcnes / 2, p[9].dy - cosTeta1 * thikcnes / 2);

    List<Offset> pBottom = new List(10);
    pBottom[0] = new Offset(p[0].dx, p[0].dy + thikcnes / 2);
    pBottom[1] = new Offset(p[1].dx, p[1].dy + thikcnes / 2);
    pBottom[2] = new Offset(p[2].dx + thikcnes / 2, p[2].dy);
    pBottom[3] = new Offset(p[3].dx + thikcnes / 2, p[3].dy);
    pBottom[5] = new Offset(p[5].dx, p[5].dy + thikcnes / 2);
    pBottom[4] = new Offset(p[4].dx, p[4].dy + thikcnes / 2);
    pBottom[6] = new Offset(p[6].dx - sinTeta * thikcnes / 2, p[6].dy + cosTeta1 * thikcnes / 2);
    pBottom[7] = new Offset(p[7].dx - sinTeta * thikcnes / 2, p[7].dy + cosTeta1 * thikcnes / 2);
    pBottom[8] = new Offset(p[8].dx - sinTeta * thikcnes / 2, p[8].dy + cosTeta1 * thikcnes / 2);
    pBottom[9] = new Offset(p[9].dx - sinTeta * thikcnes / 2, p[9].dy + cosTeta1 * thikcnes / 2);

    if (thikcnes != 0) {
      //paint0.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
      _State._drawArc(canvas, pTop[2], pTop[1], raduis + thikcnes / 2, paint0, pi / 2);
      _State._drawArc(canvas, pTop[3], pTop[4], raduis - thikcnes / 2, paint0, pi / 2);
      _State._drawArc(canvas, pTop[5], pTop[6], raduis - thikcnes / 2, paint0, alfa);
      _State._drawArc(canvas, pTop[0], pTop[8], raduis + thikcnes / 2, paint0, alfa);
      canvas.drawLine(Offset(pTop[6].dx, pTop[6].dy), Offset(pTop[7].dx, pTop[7].dy), paint0);
      canvas.drawLine(Offset(pTop[8].dx, pTop[8].dy), Offset(pTop[9].dx, pTop[9].dy), paint0);

      _State._drawArc(canvas, pBottom[5], pBottom[6], raduis + thikcnes / 2, paint0, alfa);
      _State._drawArc(canvas, pBottom[0], pBottom[8], raduis - thikcnes / 2, paint0, alfa);
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
    } else {
      _State._drawArc(canvas, p[3], p[4], raduis, paint0, alfa);
      _State._drawArc(canvas, p[5], p[6], raduis, paint0, alfa);
      _State._drawArc(canvas, p[0], p[8], raduis, paint0, alfa);
      canvas.drawLine(Offset(p[1].dx, p[1].dy), Offset(p[0].dx, p[0].dy), paint0);
      canvas.drawLine(Offset(p[2].dx, p[2].dy), Offset(p[3].dx, p[3].dy), paint0);
      canvas.drawLine(Offset(p[5].dx, p[5].dy), Offset(p[4].dx, p[4].dy), paint0);
      canvas.drawLine(Offset(p[6].dx, p[6].dy), Offset(p[7].dx, p[7].dy), paint0);
      canvas.drawLine(Offset(p[8].dx, p[8].dy), Offset(p[9].dx, p[9].dy), paint0);
    }

    int paddingDimention = min((size.width/20).round(),(size.height/20).round());
    List<Offset> pDimention = new List(2);
    pDimention[0] = new Offset(p[1].dx - raduis - thikcnes / 2, p[1].dy - paddingDimention - thikcnes / 2);
    pDimention[1] = new Offset(centerX - thikcnes / 2 + width, p[1].dy - paddingDimention - thikcnes / 2);
    _State._drawDimention(paddingDimention, canvas, pDimention[1], pDimention[0], textPaint0, "W", textPaint0, alfa);

    pDimention[0] = new Offset (p[6].dx - paddingDimention - thikcnes/2,  pTop[1].dy);
    pDimention[1] = new Offset(p[6].dx - paddingDimention - thikcnes/2, pBottom[5].dy);
    _State._drawDimention(paddingDimention, canvas, pDimention[0], pDimention[1], textPaint0, "h", textPaint0, alfa);

    pDimention[0] = new Offset(pTop[0].dx + (raduis + thikcnes / 2) * tanTetaOn2 + paddingDimention * sinTeta,   pTop[0].dy - paddingDimention * cosTeta1);
    pDimention[1] = new Offset( pTop[9].dx + paddingDimention * sinTeta, pTop[9].dy - paddingDimention * cosTeta1);
    _State._drawDimention(paddingDimention, canvas, pDimention[0], pDimention[1], textPaint0, "h_lip", textPaint0, alfa);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
class draw_z_coldWith_tensionCompretionDetails extends CustomPainter {
  Paint paint0, textPaint0, paint0Axis;
  bool isFlexural;

  draw_z_coldWith_tensionCompretionDetails(this.isFlexural,this.paint0,this.textPaint0,this.paint0Axis);

  @override
  void paint(Canvas canvas, Size size) {
    //Canvas canvas;
    double alfa = double.parse(_State.alfa.toString()) * pi / 180;
    double cosTeta1 =  sin((alfa - pi / 2));
    double sinTeta =  cos((alfa - pi / 2));
    _State.scale_r =  min((size.width*0.8) / (_State.width * 2 - _State.thickness + _State.h_lip * sinTeta * 2),   (size.height*0.8) / (_State.height));
    int constant = 0;
    double width = _State.width * _State.scale_r;
    double height = _State.height * _State.scale_r;
    double raduis = _State.raduis * _State.scale_r;
    double thikcnes = _State.thickness * _State.scale_r;
    //double heightLips = _State.h_lip * _State.scale_r;
    double c1 = double.parse(_State.c1.toString())* _State.scale_r;
    double c2 = double.parse(_State.c2.toString())* _State.scale_r;
    double b1 , b2;
    if(isFlexural){
      b1 = double.parse(_State.b1.toString())* _State.scale_r;
      b2 = double.parse(_State.b2.toString())* _State.scale_r;
    }else{
      b1 = b2 = double.parse((_State.bA_eff / 2).toString())* _State.scale_r;
    }
    double Ls_Eff = double.parse(_State.LsEffect.toString())* _State.scale_r;
    double Ycg = _State.Ycg * _State.scale_r;
    double L_steffiner = _State.h_lip * _State.scale_r;
    double a = height - (2 * raduis + thikcnes);
    double b = width - (raduis + thikcnes / 2 + constant * (raduis + thikcnes / 2));
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double teta = pi/2;

    List<Offset> p = new List(10);
    p[0] = new Offset(centerX + raduis + b, centerY - height / 2 + thikcnes / 2);
    p[1] = new Offset(p[0].dx - b, centerY - height / 2 + thikcnes / 2);
    p[2] = new Offset(centerX, centerY - a / 2);
    p[3] = new Offset(centerX, centerY + a / 2);
    p[5] = new Offset(centerX - raduis - b, centerY + height / 2 - thikcnes / 2);
    p[4] = new Offset(p[5].dx + b, p[5].dy);
    p[6] = new Offset(p[5].dx - raduis * sinTeta, p[5].dy - raduis * (1 - cosTeta1));
    p[7] = new Offset(p[6].dx - L_steffiner * cosTeta1, p[6].dy - L_steffiner * sinTeta);
    p[8] = new Offset(p[0].dx + raduis * sinTeta, p[0].dy + raduis * (1 - cosTeta1));
    p[9] = new Offset(p[8].dx + L_steffiner * cosTeta1, p[8].dy + L_steffiner * sinTeta);
    //paint0.setPathEffect(new DashPathEffect(new double[]{40, 20, 10, 20}, 0));
    _State._drawArc(canvas, p[2], p[1], raduis, paint0, teta);
    _State._drawArcDimention(canvas, paint0Axis, p[2], p[1], raduis);

    double widthLine =  paint0.strokeWidth;
    paint0.strokeWidth =(1);
    List<Offset> pTop = new List(10);
    pTop[0] = new Offset(p[0].dx, p[0].dy - thikcnes / 2);
    pTop[1] = new Offset(p[1].dx, p[1].dy - thikcnes / 2);
    pTop[2] = new Offset(p[2].dx - thikcnes / 2, p[2].dy);
    pTop[3] = new Offset(p[3].dx - thikcnes / 2, p[3].dy);
    pTop[5] = new Offset(p[5].dx, p[5].dy - thikcnes / 2);
    pTop[4] = new Offset(p[4].dx, p[4].dy - thikcnes / 2);
    pTop[6] = new Offset(p[6].dx + sinTeta * thikcnes / 2, p[6].dy - cosTeta1 * thikcnes / 2);
    pTop[7] = new Offset(p[7].dx + sinTeta * thikcnes / 2, p[7].dy - cosTeta1 * thikcnes / 2);
    pTop[8] = new Offset(p[8].dx + sinTeta * thikcnes / 2, p[8].dy - cosTeta1 * thikcnes / 2);
    pTop[9] = new Offset(p[9].dx + sinTeta * thikcnes / 2, p[9].dy - cosTeta1 * thikcnes / 2);

    List<Offset> pBottom = new List(10);
    pBottom[0] = new Offset(p[0].dx, p[0].dy + thikcnes / 2);
    pBottom[1] = new Offset(p[1].dx, p[1].dy + thikcnes / 2);
    pBottom[2] = new Offset(p[2].dx + thikcnes / 2, p[2].dy);
    pBottom[3] = new Offset(p[3].dx + thikcnes / 2, p[3].dy);
    pBottom[5] = new Offset(p[5].dx, p[5].dy + thikcnes / 2);
    pBottom[4] = new Offset(p[4].dx, p[4].dy + thikcnes / 2);
    pBottom[6] = new Offset(p[6].dx - sinTeta * thikcnes / 2, p[6].dy + cosTeta1 * thikcnes / 2);
    pBottom[7] = new Offset(p[7].dx - sinTeta * thikcnes / 2, p[7].dy + cosTeta1 * thikcnes / 2);
    pBottom[8] = new Offset(p[8].dx - sinTeta * thikcnes / 2, p[8].dy + cosTeta1 * thikcnes / 2);
    pBottom[9] = new Offset(p[9].dx - sinTeta * thikcnes / 2, p[9].dy + cosTeta1 * thikcnes / 2);

    if (thikcnes != 0) {
      //paint0.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
      _State._drawArc(canvas, pTop[2], pTop[1], raduis + thikcnes / 2, paint0, pi / 2);
      _State._drawArc(canvas, pTop[3], pTop[4], raduis - thikcnes / 2, paint0, pi / 2);
      _State._drawArc(canvas, pTop[5], pTop[6], raduis - thikcnes / 2, paint0, alfa);
      _State._drawArc(canvas, pTop[0], pTop[8], raduis + thikcnes / 2, paint0, alfa);
      canvas.drawLine(Offset(pTop[6].dx, pTop[6].dy), Offset(pTop[7].dx, pTop[7].dy), paint0);
      canvas.drawLine(Offset(pTop[8].dx, pTop[8].dy), Offset(pTop[9].dx, pTop[9].dy), paint0);

      _State._drawArc(canvas, pBottom[5], pBottom[6], raduis + thikcnes / 2, paint0, alfa);
      _State._drawArc(canvas, pBottom[0], pBottom[8], raduis - thikcnes / 2, paint0, alfa);
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

    List<Offset> pF = new List(8);
    pF[0] = new Offset(p[0].dx - c2, p[0].dy);
    pF[1] = new Offset(p[1].dx + c1, p[1].dy);
    pF[2] = new Offset(p[2].dx, p[2].dy + b1);
    pF[3] = new Offset(p[3].dx, p[3].dy - b2);
    pF[5] = new Offset(p[5].dx + c2, p[5].dy);
    pF[4] = new Offset(p[4].dx - c1, p[4].dy);
    pF[6] = new Offset(p[6].dx - Ls_Eff * cosTeta1, p[6].dy - Ls_Eff * sinTeta);
    pF[7] = new Offset(p[8].dx + Ls_Eff * cosTeta1, p[8].dy + Ls_Eff * sinTeta);
    List<Offset> pFTop = new List(4);
    pFTop[0] = new Offset(pTop[0].dx - c2, pTop[0].dy);
    pFTop[1] = new Offset(pTop[1].dx + c1, pTop[1].dy);
    pFTop[2] = new Offset(pTop[2].dx, pTop[2].dy + b1);
    pFTop[3] = new Offset(pTop[3].dx, pTop[3].dy - b2);
    List<Offset> pFBottom = new List(4);
    pFBottom[0] = new Offset(pBottom[0].dx - c2, pBottom[0].dy);
    pFBottom[1] = new Offset(pBottom[1].dx + c1, pBottom[1].dy);
    pFBottom[2] = new Offset(pBottom[2].dx, pBottom[2].dy + b1);
    pFBottom[3] = new Offset(pBottom[3].dx, pBottom[3].dy - b2);

    paint0.strokeWidth =(thikcnes);
    canvas.drawLine(Offset(p[0].dx, p[0].dy), Offset(pF[0].dx, pF[0].dy), paint0);
    canvas.drawLine(Offset(p[1].dx, p[1].dy), Offset(pF[1].dx, pF[1].dy), paint0);
    canvas.drawLine(Offset(p[2].dx, p[2].dy), Offset(pF[2].dx, pF[2].dy), paint0);
    canvas.drawLine(Offset(p[3].dx, p[3].dy), Offset(pF[3].dx, pF[3].dy), paint0);
    canvas.drawLine(Offset(p[8].dx, p[8].dy), Offset(pF[7].dx, pF[7].dy), paint0);
    if (isFlexural) {
      canvas.drawLine(Offset(p[4].dx, p[4].dy), Offset(p[5].dx, p[5].dy), paint0);
      canvas.drawLine(Offset(p[6].dx, p[6].dy), Offset(p[7].dx, p[7].dy), paint0);
    } else {
      canvas.drawLine(Offset(p[4].dx, p[4].dy), Offset(pF[4].dx, pF[4].dy), paint0);
      canvas.drawLine(Offset(p[5].dx, p[5].dy), Offset(pF[5].dx, pF[5].dy), paint0);
      canvas.drawLine(Offset(p[6].dx, p[6].dy), Offset(pF[6].dx, pF[6].dy), paint0);
    }
    _State._drawArc(canvas, p[2], p[1], raduis, paint0, pi / 2);
    _State._drawArc(canvas, p[3], p[4], raduis, paint0, pi / 2);
    _State._drawArc(canvas, p[5], p[6], raduis, paint0, alfa);
    _State._drawArc(canvas, p[0], p[8], raduis, paint0, alfa);
    paint0.strokeWidth =(widthLine);

    int paddingDimention = min((size.width/20).round(),(size.height/20).round());
    Offset cG;
    if (isFlexural) {
      cG = new Offset(centerX, p[0].dy - thikcnes / 2 + Ycg);
    } else {
      cG = new Offset(centerX, centerY);
    }
    canvas.drawLine(Offset(cG.dx + width, cG.dy), Offset(cG.dx - width / 2, cG.dy), paint0Axis);
    //  paint0Axis.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
    _State._drawTextStart(canvas, _State.textStyleD,"Y", cG.dx + width, cG.dy);
    Offset pSDimen = new Offset(p[0].dx + raduis + thikcnes / 2 + 10 * _State.scale_r, p[0].dy - thikcnes / 2);
    Offset pEDimen = new Offset(p[0].dx + raduis + thikcnes / 2 + 10 * _State.scale_r, cG.dy);
    _State._drawDimention(paddingDimention, canvas, pEDimen, pSDimen, paint0Axis, "Ycg", paint0Axis, pi / 2);
    pTop[1] = new Offset( pTop[1].dx, pTop[1].dy - paddingDimention);
    pFTop[1] = new Offset(pFTop[1].dx,pFTop[1].dy - paddingDimention);
    pTop[0] = new Offset( pTop[0].dx, pTop[0].dy - paddingDimention);
    pFTop[0] = new Offset(pFTop[0].dx,pFTop[0].dy - paddingDimention);
    _State._drawDimention(paddingDimention, canvas, pTop[1], pFTop[1], paint0Axis, "C1", paint0Axis, pi / 2);
    _State._drawDimention(paddingDimention, canvas, pFTop[0], pTop[0], paint0Axis, "C2", paint0Axis, pi / 2);
    pFBottom[2] = new Offset(pFBottom[2].dx + paddingDimention,pFBottom[2].dy);
    pBottom[2] = new Offset(pBottom[2].dx + paddingDimention, pBottom[2].dy);
    pFBottom[3] = new Offset(pFBottom[3].dx + paddingDimention,pFBottom[3].dy);
    pBottom[3] = new Offset(pBottom[3].dx + paddingDimention, pBottom[3].dy);
    _State._drawDimention(paddingDimention, canvas, pFBottom[2], pBottom[2], paint0Axis, "b1", paint0Axis, pi / 2);
    _State._drawDimention(paddingDimention, canvas, pBottom[3], pFBottom[3], paint0Axis, "b2", paint0Axis, pi / 2);
    pTop[2] = new Offset(pTop[2].dx - paddingDimention,pTop[2].dy);
    pTop[3] = new Offset(pTop[3].dx - paddingDimention,pTop[3].dy);
    pTop[4] = new Offset(pTop[4].dx ,pTop[4].dy- paddingDimention);
    pTop[5] = new Offset(pTop[5].dx ,pTop[5].dy- paddingDimention);
    _State._drawDimention(paddingDimention, canvas, pTop[2], pTop[3], textPaint0, "L-web", textPaint0, pi / 2);
    _State._drawDimention(paddingDimention, canvas, pTop[5], pTop[4], textPaint0, "L-flang", textPaint0, 270);
    p[8] = new  Offset(p[8] .dx - (paddingDimention + thikcnes / 2) * sinTeta,p[8] .dy);
    pF[7] = new Offset(pF[7].dx - (paddingDimention + thikcnes / 2) * sinTeta,pF[7].dy);
    p[8] = new  Offset(p[8] .dx ,p[8] .dy + (paddingDimention + thikcnes / 2) * cosTeta1);
    pF[7] = new Offset(pF[7].dx ,pF[7].dy + (paddingDimention + thikcnes / 2) * cosTeta1);
    if (alfa != pi / 2) {
      _State._drawDimention(paddingDimention, canvas, pF[7], p[8], paint0Axis, "Ls_Eff", paint0Axis, alfa);
    } else {
      _State._drawDimention(paddingDimention, canvas, p[8], pF[7], paint0Axis, "Ls_Eff", paint0Axis, alfa);
    }
    //paint0Axis.setPathEffect(new DashPathEffect(new double[]{40, 15, 15, 15}, 0));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class draw_u_cold_generalDetails extends CustomPainter {
  Paint paint0, textPaint0, paint0Axis;
  BuildContext context;

  draw_u_cold_generalDetails(this.context,this.paint0,this.textPaint0,this.paint0Axis);

  @override
  void paint(Canvas canvas, Size size) {
    _State.scale_r =  min((size.width*0.8) / (_State.width + _State.thickness),   (size.height*0.8) / (_State.height));
    //Canvas canvas;
    double constant = 0;
    if ( _State.h_lip > 0) {
      constant = 1;
    }
    double width = _State.width * _State.scale_r;
    double height = _State.height * _State.scale_r;
    double raduis = _State.raduis * _State.scale_r;
    double thikcnes = _State.thickness * _State.scale_r;
    double heightLips = _State.h_lip * _State.scale_r;
    double Ycg = _State.Ycg * _State.scale_r;
    double ex = _State.ex * _State.scale_r;
    double x0 = _State.x0 * _State.scale_r;
    double teta = pi/2;
    double a = height - (2 * raduis + thikcnes);
    double b = width - 1 * (raduis + thikcnes / 2 + constant * (raduis + thikcnes / 2));
    double centerX = size.width/ 2.0;
    double centerY = size.height / 2.0;
    List<Offset> p = new List(6);
    p[0] = new Offset(centerX + b / 2, centerY - height / 2 + thikcnes / 2);
    p[1] = new Offset(p[0].dx - b, centerY - height / 2 + thikcnes / 2);
    p[2] = new Offset(centerX - b / 2 - raduis, centerY - a / 2);
    p[3] = new Offset(centerX - b / 2 - raduis, centerY + a / 2);
    p[4] = new Offset(centerX - b / 2, centerY + height / 2 - thikcnes / 2);
    p[5] = new Offset(p[4].dx + b, p[4].dy);
    Offset cG = new Offset(p[2].dx + ex, p[1].dy + Ycg);
    _State._drawAxis_uCold(canvas, paint0Axis, cG, x0, ex, height / 2, width + 20 * _State.scale_r);
    //paint0.setPathEffect(new DashPathEffect(new double[]{40, 5, 10, 5}, 0));
    paint0.strokeWidth =(3);
    _State._drawArc(canvas, p[2], p[1], raduis, paint0, teta);
    _State._drawArcDimention(canvas, paint0Axis, p[2], p[1], raduis);

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
      //paint0.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
      _State._drawArc(canvas, pTop[2], pTop[1], raduis + thikcnes / 2, paint0, teta);
      _State._drawArc(canvas, pTop[4], pTop[3], raduis + thikcnes / 2, paint0, teta);
      canvas.drawLine(Offset(pTop[1].dx, pTop[1].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
      canvas.drawLine(Offset(pTop[2].dx, pTop[2].dy), Offset(pTop[3].dx, pTop[3].dy), paint0);
      canvas.drawLine(Offset(pTop[5].dx, pTop[5].dy), Offset(pTop[4].dx, pTop[4].dy), paint0);
      _State._drawArc(canvas, pBottom[2], pBottom[1], raduis - thikcnes / 2, paint0, teta);
      _State._drawArc(canvas, pBottom[4], pBottom[3], raduis - thikcnes / 2, paint0, teta);
      canvas.drawLine(Offset(pBottom[1].dx, pBottom[1].dy), Offset(pBottom[0].dx, pBottom[0].dy), paint0);
      canvas.drawLine(Offset(pBottom[2].dx, pBottom[2].dy), Offset(pBottom[3].dx, pBottom[3].dy), paint0);
      canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pBottom[4].dx, pBottom[4].dy), paint0);
      canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pTop[5].dx, pTop[5].dy), paint0);
      canvas.drawLine(Offset(pBottom[0].dx, pBottom[0].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
    } else {
      _State._drawArc(canvas, p[4], p[3], raduis, paint0, teta);
      canvas.drawLine(Offset(p[1].dx, p[1].dy), Offset(p[0].dx, p[0].dy), paint0);
      canvas.drawLine(Offset(p[2].dx, p[2].dy), Offset(p[3].dx, p[3].dy), paint0);
      canvas.drawLine(Offset(p[5].dx, p[5].dy), Offset(p[4].dx, p[4].dy), paint0);
    }

    int paddingDimention = min((size.width/20).round(),(size.height/20).round());
    List<Offset> pDimention = new List(2);
    pDimention[0] = new Offset(p[1].dx - raduis - thikcnes / 2, p[1].dy - paddingDimention - thikcnes / 2);
    pDimention[1] = new Offset(p[0].dx, p[1].dy - paddingDimention - thikcnes / 2);
    _State._drawDimention(paddingDimention, canvas, pDimention[0], pDimention[1], textPaint0, "W", textPaint0, teta);

    pDimention[0] = new Offset (p[3].dx - paddingDimention - thikcnes/2,  pTop[1].dy);
    pDimention[1] = new Offset(p[3].dx - paddingDimention - thikcnes/2, pTop[5].dy);
    _State._drawDimention(paddingDimention, canvas, pDimention[0], pDimention[1], textPaint0, "h", textPaint0, teta);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
class draw_u_cold_CompretionDetails extends CustomPainter {
  Paint paint0, textPaint0, paint0Axis;

  draw_u_cold_CompretionDetails(this.paint0,this.textPaint0,this.paint0Axis);

  @override
  void paint(Canvas canvas, Size size) {
    _State.scale_r =  min((size.width*0.8) / (_State.width * 2 - _State.thickness),   (size.height*0.8) / (_State.height));
    //Canvas canvas;
    double constant = 0;
    if ( _State.h_lip > 0) {
      constant = 1;
    }
    double width = _State.width * _State.scale_r;
    double height = _State.height * _State.scale_r;
    double raduis = _State.raduis * _State.scale_r;
    double thikcnes = _State.thickness * _State.scale_r;
    double heightLips = _State.h_lip * _State.scale_r;
    double Ycg = _State.Ycg * _State.scale_r;
    double c1 = double.parse(_State.c1.toString())* _State.scale_r;
    double c2 = double.parse(_State.c2.toString())* _State.scale_r;
    double b1 = double.parse(_State.bA_eff.toString()) / 2 * _State.scale_r;
    double b2 = double.parse(_State.bA_eff.toString()) / 2 * _State.scale_r;
    double a = height - (2 * raduis + thikcnes);
    double b = width - 1 * (raduis + thikcnes / 2 + constant * (raduis + thikcnes / 2));
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

    /*paint0.setPathEffect(new DashPathEffect(new double[]{40, 5, 10, 5}, 0));
        paint0.strokeWidth =(3);
        _State._drawArc(canvas, p[2], p[1], raduis, paint0, teta);
        _State._drawArc(canvas, p[4], p[3], raduis, paint0, teta);
        canvas.drawLine(Offset(p[1].dx, p[1].dy, p[0].dx, p[0].dy, paint0);
        canvas.drawLine(Offset(p[2].dx, p[2].dy, p[3].dx, p[3].dy, paint0);
        canvas.drawLine(Offset(p[5].dx, p[5].dy, p[4].dx, p[4].dy, paint0);
*/
    double widthLine =  paint0.strokeWidth;
    paint0.strokeWidth =(1);
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

    List<Offset> pF = new List(6);
    pF[0] = new Offset(p[0].dx - c2, p[0].dy);
    pF[1] = new Offset(p[1].dx + c1, p[1].dy);
    pF[2] = new Offset(p[2].dx, p[2].dy + b1);
    pF[3] = new Offset(p[3].dx, p[3].dy - b2);
    pF[5] = new Offset(p[5].dx - c2, p[5].dy);
    pF[4] = new Offset(p[4].dx + c1, p[4].dy);
    List<Offset> pFTop = new List(4);
    pFTop[0] = new Offset(pTop[0].dx - c2, pTop[0].dy);
    pFTop[1] = new Offset(pTop[1].dx + c1, pTop[1].dy);
    pFTop[2] = new Offset(pTop[2].dx, pTop[2].dy + b1);
    pFTop[3] = new Offset(pTop[3].dx, pTop[3].dy - b2);
    List<Offset> pFBottom = new List(4);
    pFBottom[0] = new Offset(pBottom[0].dx - c2, pBottom[0].dy);
    pFBottom[1] = new Offset(pBottom[1].dx + c1, pBottom[1].dy);
    pFBottom[2] = new Offset(pBottom[2].dx, pBottom[2].dy + b1);
    pFBottom[3] = new Offset(pBottom[3].dx, pBottom[3].dy - b2);
    if (thikcnes != 0) {
      //paint0.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
      _State._drawArc(canvas, pTop[2], pTop[1], raduis + thikcnes / 2, paint0, teta);
      _State._drawArc(canvas, pTop[4], pTop[3], raduis + thikcnes / 2, paint0, teta);
      canvas.drawLine(Offset(pTop[1].dx, pTop[1].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
      canvas.drawLine(Offset(pTop[2].dx, pTop[2].dy), Offset(pTop[3].dx, pTop[3].dy), paint0);
      canvas.drawLine(Offset(pTop[5].dx, pTop[5].dy), Offset(pTop[4].dx, pTop[4].dy), paint0);
      _State._drawArc(canvas, pBottom[2], pBottom[1], raduis - thikcnes / 2, paint0, teta);
      _State._drawArc(canvas, pBottom[4], pBottom[3], raduis - thikcnes / 2, paint0, teta);
      canvas.drawLine(Offset(pBottom[1].dx, pBottom[1].dy), Offset(pBottom[0].dx, pBottom[0].dy), paint0);
      canvas.drawLine(Offset(pBottom[2].dx, pBottom[2].dy), Offset(pBottom[3].dx, pBottom[3].dy), paint0);
      canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pBottom[4].dx, pBottom[4].dy), paint0);
      canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pTop[5].dx, pTop[5].dy), paint0);
      canvas.drawLine(Offset(pBottom[0].dx, pBottom[0].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
    }

    paint0.strokeWidth =(thikcnes);
    canvas.drawLine(Offset(p[0].dx, p[0].dy), Offset(pF[0].dx, pF[0].dy), paint0);
    canvas.drawLine(Offset(p[1].dx, p[1].dy), Offset(pF[1].dx, pF[1].dy), paint0);
    canvas.drawLine(Offset(p[2].dx, p[2].dy), Offset(pF[2].dx, pF[2].dy), paint0);
    canvas.drawLine(Offset(p[3].dx, p[3].dy), Offset(pF[3].dx, pF[3].dy), paint0);
    canvas.drawLine(Offset(p[4].dx, p[4].dy), Offset(pF[4].dx, pF[4].dy), paint0);
    canvas.drawLine(Offset(p[5].dx, p[5].dy), Offset(pF[5].dx, pF[5].dy), paint0);
    _State._drawArc(canvas, p[2], p[1], raduis, paint0, pi / 2);
    _State._drawArc(canvas, p[4], p[3], raduis, paint0, pi / 2);
    paint0.strokeWidth =(widthLine);

    int paddingDimention = min((size.width/20).round(),(size.height/20).round());

    Offset cG = new Offset(p[2].dx + width / 2, p[1].dy + Ycg - thikcnes / 2);
    canvas.drawLine(Offset(cG.dx + width / 2 + 50 * _State.scale_r, cG.dy), Offset(cG.dx - width / 2 - 50 * _State.scale_r, cG.dy), paint0Axis);
    //paint0Axis.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
    _State._drawTextStart(canvas, _State.textStyleD,"Y", cG.dx + width / 2 + 50 * _State.scale_r, cG.dy);
    Offset pSDimen = new Offset(p[0].dx + raduis + thikcnes / 2 + paddingDimention, p[0].dy - thikcnes / 2);
    Offset pEDimen = new Offset(p[0].dx + raduis + thikcnes / 2 + paddingDimention, cG.dy);
    _State._drawDimention(paddingDimention, canvas, pSDimen, pEDimen, paint0Axis, "Ycg", paint0Axis, pi / 2);
    pTop[1] = new Offset( pTop[1].dx, pTop[1].dy - paddingDimention);
    pFTop[1] = new Offset(pFTop[1].dx,pFTop[1].dy - paddingDimention);
    pTop[0] = new Offset( pTop[0].dx, pTop[0].dy - paddingDimention);
    pFTop[0] = new Offset(pFTop[0].dx,pFTop[0].dy - paddingDimention);
    _State._drawDimention(paddingDimention, canvas, pTop[1], pFTop[1], paint0Axis, "C1", paint0Axis, pi / 2);
    _State._drawDimention(paddingDimention, canvas, pFTop[0], pTop[0], paint0Axis, "C2", paint0Axis, pi / 2);
    pFBottom[2] = new Offset(pFBottom[2].dx + paddingDimention,pFBottom[2].dy);
    pBottom[2] = new Offset( pBottom[2].dx + paddingDimention, pBottom[2].dy);
    pFBottom[3] = new Offset(pFBottom[3].dx + paddingDimention,pFBottom[3].dy);
    pBottom[3] = new Offset( pBottom[3].dx + paddingDimention, pBottom[3].dy);
    _State._drawDimention(paddingDimention, canvas, pFBottom[2], pBottom[2], paint0Axis, "b1", paint0Axis, pi / 2);
    _State._drawDimention(paddingDimention, canvas, pBottom[3], pFBottom[3], paint0Axis, "b2", paint0Axis, pi / 2);
    pTop[2]  = new Offset(pTop[2].dx - paddingDimention,pTop[2].dy);
    pTop[3]  = new Offset(pTop[3].dx - paddingDimention,pTop[3].dy);
    pBottom[4] = new Offset(pBottom[4].dx, pBottom[4].dy - paddingDimention);
    pBottom[5] = new Offset(pBottom[5].dx, pBottom[5].dy - paddingDimention);
    _State._drawDimention(paddingDimention, canvas, pTop[2], pTop[3],      textPaint0, "L-web",  textPaint0, pi / 2);
    _State._drawDimention(paddingDimention, canvas, pBottom[5], pBottom[4],textPaint0, "L-flang",textPaint0, 3 * pi /2);
    //   paint0Axis.setPathEffect(new DashPathEffect(new double[]{40, 15, 15, 15}, 0));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
class draw_u_cold_FlaxeurDetails extends CustomPainter {
  Paint paint0, textPaint0, paint0Axis;


  draw_u_cold_FlaxeurDetails(this.paint0,this.textPaint0,this.paint0Axis);

  @override
  void paint(Canvas canvas, Size size) {
    _State.scale_r =  min((size.width*0.8) / (_State.width * 2 - _State.thickness),   (size.height*0.8) / (_State.height));
    //Canvas canvas;
    double constant = 0;
    if ( _State.h_lip > 0) {
      constant = 1;
    }
    double width = _State.width * _State.scale_r;
    double height = _State.height * _State.scale_r;
    double raduis = _State.raduis * _State.scale_r;
    double thikcnes = _State.thickness * _State.scale_r;
    double heightLips = _State.h_lip * _State.scale_r;
    double Ycg = _State.Ycg * _State.scale_r;
    double c1 = double.parse(_State.c1.toString())* _State.scale_r;
    double c2 = double.parse(_State.c2.toString())* _State.scale_r;
    double b1 = double.parse(_State.b1.toString())* _State.scale_r;
    double b2 = double.parse(_State.b2.toString())* _State.scale_r;
    double a = height - (2 * raduis + thikcnes);
    double b = width - 1 * (raduis + thikcnes / 2 + constant * (raduis + thikcnes / 2));
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

    /*paint0.setPathEffect(new DashPathEffect(new double[]{40, 5, 10, 5}, 0));
        paint0.strokeWidth =(3);
        _State._drawArc(canvas, p[2], p[1], raduis, paint0, teta);
        _State._drawArc(canvas, p[4], p[3], raduis, paint0, teta);
        canvas.drawLine(Offset(p[1].dx, p[1].dy, p[0].dx, p[0].dy, paint0);
        canvas.drawLine(Offset(p[2].dx, p[2].dy, p[3].dx, p[3].dy, paint0);
        canvas.drawLine(Offset(p[5].dx, p[5].dy, p[4].dx, p[4].dy, paint0);
*/
    double widthLine =  paint0.strokeWidth;
    paint0.strokeWidth =(1);

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

    List<Offset> pF = new List(4);
    pF[0] = new Offset(p[0].dx - c2, p[0].dy);
    pF[1] = new Offset(p[1].dx + c1, p[1].dy);
    pF[2] = new Offset(p[2].dx, p[2].dy + b1);
    pF[3] = new Offset(p[3].dx, p[3].dy - b2);
    List<Offset> pFTop = new List(4);
    pFTop[0] = new Offset(pTop[0].dx - c2, pTop[0].dy);
    pFTop[1] = new Offset(pTop[1].dx + c1, pTop[1].dy);
    pFTop[2] = new Offset(pTop[2].dx, pTop[2].dy + b1);
    pFTop[3] = new Offset(pTop[3].dx, pTop[3].dy - b2);
    List<Offset> pFBottom = new List(4);
    pFBottom[0] = new Offset(pBottom[0].dx - c2, pBottom[0].dy);
    pFBottom[1] = new Offset(pBottom[1].dx + c1, pBottom[1].dy);
    pFBottom[2] = new Offset(pBottom[2].dx, pBottom[2].dy + b1);
    pFBottom[3] = new Offset(pBottom[3].dx, pBottom[3].dy - b2);
    if (thikcnes != 0) {
      // paint0.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
      _State._drawArc(canvas, pTop[2], pTop[1], raduis + thikcnes / 2, paint0, teta);
      _State._drawArc(canvas, pTop[4], pTop[3], raduis + thikcnes / 2, paint0, teta);
      canvas.drawLine(Offset(pTop[1].dx, pTop[1].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
      canvas.drawLine(Offset(pTop[2].dx, pTop[2].dy), Offset(pTop[3].dx, pTop[3].dy), paint0);
      canvas.drawLine(Offset(pTop[5].dx, pTop[5].dy), Offset(pTop[4].dx, pTop[4].dy), paint0);
      _State._drawArc(canvas, pBottom[2], pBottom[1], raduis - thikcnes / 2, paint0, teta);
      _State._drawArc(canvas, pBottom[4], pBottom[3], raduis - thikcnes / 2, paint0, teta);
      canvas.drawLine(Offset(pBottom[1].dx, pBottom[1].dy), Offset(pBottom[0].dx, pBottom[0].dy), paint0);
      canvas.drawLine(Offset(pBottom[2].dx, pBottom[2].dy), Offset(pBottom[3].dx, pBottom[3].dy), paint0);
      canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pBottom[4].dx, pBottom[4].dy), paint0);
      canvas.drawLine(Offset(pBottom[5].dx, pBottom[5].dy), Offset(pTop[5].dx, pTop[5].dy), paint0);
      canvas.drawLine(Offset(pBottom[0].dx, pBottom[0].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
    }

    paint0.strokeWidth =(thikcnes);
    canvas.drawLine(Offset(p[0].dx, p[0].dy), Offset(pF[0].dx, pF[0].dy), paint0);
    canvas.drawLine(Offset(p[1].dx, p[1].dy), Offset(pF[1].dx, pF[1].dy), paint0);
    canvas.drawLine(Offset(p[2].dx, p[2].dy), Offset(pF[2].dx, pF[2].dy), paint0);
    canvas.drawLine(Offset(p[3].dx, p[3].dy), Offset(pF[3].dx, pF[3].dy), paint0);
    canvas.drawLine(Offset(p[4].dx, p[4].dy), Offset(p[5].dx, p[5].dy), paint0);
    _State._drawArc(canvas, p[2], p[1], raduis, paint0, pi / 2);
    _State._drawArc(canvas, p[4], p[3], raduis, paint0, pi / 2);
    paint0.strokeWidth =(widthLine);

    int paddingDimention = min((size.width/20).round(),(size.height/20).round());

    Offset cG = new Offset(p[2].dx + width / 2, p[1].dy + Ycg - thikcnes / 2);
    canvas.drawLine(Offset(cG.dx + width / 2 + 50 * _State.scale_r, cG.dy), Offset(cG.dx - width / 2 - 50 * _State.scale_r, cG.dy), paint0Axis);
    //paint0Axis.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
    _State._drawTextStart(canvas, _State.textStyleD,"Y", cG.dx + width / 2 + 50 * _State.scale_r, cG.dy);
    Offset pSDimen = new Offset(p[0].dx + raduis + thikcnes / 2 + paddingDimention, p[0].dy - thikcnes / 2);
    Offset pEDimen = new Offset(p[0].dx + raduis + thikcnes / 2 + paddingDimention, p[0].dy - thikcnes / 2 + Ycg);
    _State._drawDimention(paddingDimention, canvas, pSDimen, pEDimen, paint0Axis, "Ycg", paint0Axis, pi / 2);
    pTop[1] = new Offset( pTop[1].dx, pTop[1].dy - paddingDimention);
    pFTop[1] = new Offset(pFTop[1].dx,pFTop[1].dy - paddingDimention);
    pTop[0] = new Offset( pTop[0].dx, pTop[0].dy - paddingDimention);
    pFTop[0] = new Offset(pFTop[0].dx,pFTop[0].dy - paddingDimention);
    _State._drawDimention(paddingDimention, canvas, pTop[1], pFTop[1], paint0Axis, "C1", paint0Axis, pi / 2);
    _State._drawDimention(paddingDimention, canvas, pFTop[0], pTop[0], paint0Axis, "C2", paint0Axis, pi / 2);
    pFBottom[2] = new Offset(pFBottom[2].dx + paddingDimention,pFBottom[2].dy);
    pBottom[2] = new Offset( pBottom[2].dx + paddingDimention, pBottom[2].dy);
    pFBottom[3] = new Offset(pFBottom[3].dx + paddingDimention,pFBottom[3].dy);
    pBottom[3] = new Offset( pBottom[3].dx + paddingDimention, pBottom[3].dy);
    _State._drawDimention(paddingDimention, canvas, pFBottom[2], pBottom[2], paint0Axis, "b1", paint0Axis, pi / 2);
    _State._drawDimention(paddingDimention, canvas, pBottom[3], pFBottom[3], paint0Axis, "b2", paint0Axis, pi / 2);
    pTop[2]  = new Offset(pTop[2].dx - paddingDimention,pTop[2].dy);
    pTop[3]  = new Offset(pTop[3].dx - paddingDimention,pTop[3].dy);
    pBottom[4] = new Offset(pBottom[4].dx, pBottom[4].dy - paddingDimention);
    pBottom[5] = new Offset(pBottom[5].dx, pBottom[5].dy - paddingDimention);
    _State._drawDimention(paddingDimention, canvas, pTop[2], pTop[3], textPaint0, "L-web",  textPaint0, pi / 2);
    _State._drawDimention(paddingDimention, canvas, pBottom[5], pBottom[4],textPaint0, "L-flang",textPaint0, 3 * pi /2);
    //   paint0Axis.setPathEffect(new DashPathEffect(new double[]{40, 15, 15, 15}, 0));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class draw_u_coldWith_generalDetails extends CustomPainter {
  Paint paint0, textPaint0, paint0Axis;
  BuildContext context;
  bool Top = false;

  draw_u_coldWith_generalDetails(this.context,this.paint0,this.textPaint0,this.paint0Axis,this.Top);

  @override
  void paint(Canvas canvas, Size size) {
    double teta = /*_State.alfa =*/ pi / 2;
    double tetaEave = _State.tetaEave * pi / 180;
    !Top ? _State.scale_r =  min((size.width*0.8) / (_State.width + _State.thickness),   (size.height*0.8) / (_State.height + 2 * _State.width * sin(tetaEave).abs()))
        : _State.scale_r =  min((size.width*0.8) / (_State.width + _State.thickness),   (size.height*0.8) / (_State.height + _State.h_lip * 2));
    double sinTeta =  sin((teta - pi / 2) * pi / 180);
    double cosTeta =  cos((teta - pi / 2) * pi / 180);
    double sinTetaEave =  sin((tetaEave));
    double cosTetaEave =  cos((tetaEave));
    double tanTetaEave =  tan((tetaEave));
    double constant = 0;
    double width = _State.width * _State.scale_r;
    double height = _State.height * _State.scale_r;
    double raduis = _State.raduis * _State.scale_r;
    double thikcnes = _State.thickness * _State.scale_r;
    double L_stiffener = _State.h_lip * _State.scale_r;
    double Ycg = _State.Ycg * _State.scale_r;
    double ex = _State.ex * _State.scale_r;
    double x0 = _State.x0 * _State.scale_r;
    double a = height - (2 * raduis + thikcnes);
    double b = width - 1 * (raduis + thikcnes / 2 + constant * (raduis + thikcnes / 2));
    double centerX = size.width/ 2.0;
    double centerY = size.height / 2.0;
    List<Offset> p = new List(10);
    p[0] = new Offset(centerX + b / 2, centerY - height / 2 + thikcnes / 2);
    p[1] = new Offset(p[0].dx - b, centerY - height / 2 + thikcnes / 2);
    p[2] = new Offset(centerX - b / 2 - raduis, centerY - a / 2);
    p[3] = new Offset(centerX - b / 2 - raduis, centerY + a / 2);
    p[4] = new Offset(centerX - b / 2, centerY + height / 2 - thikcnes / 2);
    p[5] = new Offset(p[4].dx + b, p[4].dy);
    if (Top) {
      p[6] = new Offset(p[0].dx + raduis, p[0].dy - raduis);
      p[7] = new Offset(p[6].dx, p[6].dy - L_stiffener);
      p[8] = new Offset(p[5].dx + raduis, p[5].dy + raduis);
      p[9] = new Offset(p[8].dx, p[8].dy + L_stiffener);
    } else {
      p[6] = new Offset(p[0].dx + raduis, p[0].dy + raduis);
      p[7] = new Offset(p[6].dx, p[6].dy + L_stiffener);
      p[8] = new Offset(p[5].dx + raduis, p[5].dy - raduis);
      p[9] = new Offset(p[8].dx, p[8].dy - L_stiffener);
      p[1] = new Offset(p[2].dx + raduis * (1 - sinTetaEave), p[2].dy - raduis * cosTetaEave);
      p[0] = new Offset(p[1].dx + (b + raduis * sinTetaEave) * cosTetaEave, p[1].dy - (b + raduis * sinTetaEave) * sinTetaEave);
      p[6] = new Offset(p[0].dx +  raduis * (cosTetaEave + sinTetaEave), p[0].dy + raduis * cosTetaEave * (1 - tanTetaEave));
      p[7] = new Offset(p[6].dx + L_stiffener * sinTetaEave, p[6].dy + L_stiffener * cosTeta * cosTetaEave);
    }
    //paint0.setPathEffect(new DashPathEffect(new double[]{40, 20, 10, 20}, 0));

    List<Offset> pTop = new List(10);
    pTop[0] = new Offset(p[0].dx - sinTetaEave * thikcnes / 2, p[0].dy - cosTetaEave * thikcnes / 2);
    pTop[1] = new Offset(p[1].dx - sinTetaEave * thikcnes / 2, p[1].dy - cosTetaEave * thikcnes / 2);
    pTop[2] = new Offset(p[2].dx - thikcnes / 2, p[2].dy);
    pTop[3] = new Offset(p[3].dx - thikcnes / 2, p[3].dy);
    pTop[4] = new Offset(p[4].dx, p[4].dy + thikcnes / 2);
    pTop[5] = new Offset(p[5].dx, p[5].dy + thikcnes / 2);

    if (Top) {
      pTop[6] = new Offset(p[6].dx - thikcnes / 2, p[6].dy);
      pTop[7] = new Offset(p[7].dx - thikcnes / 2, p[7].dy);
      pTop[8] = new Offset(p[8].dx - thikcnes / 2, p[8].dy);
      pTop[9] = new Offset(p[9].dx - thikcnes / 2, p[9].dy);
    } else {
      pTop[6] = new Offset(p[6].dx + cosTeta * thikcnes / 2 * cosTetaEave, p[6].dy - thikcnes / 2 * sinTetaEave);
      pTop[7] = new Offset(p[7].dx + cosTeta * thikcnes / 2 * cosTetaEave, p[7].dy - thikcnes / 2 * sinTetaEave);
      pTop[8] = new Offset(p[8].dx + thikcnes / 2, p[8].dy);
      pTop[9] = new Offset(p[9].dx + thikcnes / 2, p[9].dy);
    }
    List<Offset> pBottom = new List(10);
    pBottom[0] = new Offset(p[0].dx + sinTetaEave * thikcnes / 2, p[0].dy + cosTetaEave * thikcnes / 2);
    pBottom[1] = new Offset(p[1].dx + sinTetaEave * thikcnes / 2, p[1].dy + cosTetaEave * thikcnes / 2);
    pBottom[2] = new Offset(p[2].dx + thikcnes / 2, p[2].dy);
    pBottom[3] = new Offset(p[3].dx + thikcnes / 2, p[3].dy);
    pBottom[4] = new Offset(p[4].dx, p[4].dy - thikcnes / 2);
    pBottom[5] = new Offset(p[5].dx, p[5].dy - thikcnes / 2);
    if (Top) {
      pBottom[6] = new Offset(p[6].dx + thikcnes / 2, p[6].dy);
      pBottom[7] = new Offset(p[7].dx + thikcnes / 2, p[7].dy);
      pBottom[8] = new Offset(p[8].dx + thikcnes / 2, p[8].dy);
      pBottom[9] = new Offset(p[9].dx + thikcnes / 2, p[9].dy);
    } else {
      pBottom[6] = new Offset(p[6].dx - cosTeta * thikcnes / 2 * cosTetaEave, p[6].dy + sinTetaEave * thikcnes / 2);
      pBottom[7] = new Offset(p[7].dx - cosTeta * thikcnes / 2 * cosTetaEave, p[7].dy + sinTetaEave * thikcnes / 2);
      pBottom[8] = new Offset(p[8].dx - thikcnes / 2, p[8].dy);
      pBottom[9] = new Offset(p[9].dx - thikcnes / 2, p[9].dy);
    }
    if (thikcnes != 0) {
      //paint0.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
      _State._drawArcReight(canvas, pTop[2], pTop[1], (raduis + thikcnes / 2), paint0, pi / 2 - tetaEave);
      _State._drawArc(canvas, pTop[4], pTop[3], raduis + thikcnes / 2, paint0, teta);
      canvas.drawLine(Offset(pTop[1].dx, pTop[1].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
      canvas.drawLine(Offset(pTop[2].dx, pTop[2].dy), Offset(pTop[3].dx, pTop[3].dy), paint0);
      canvas.drawLine(Offset(pTop[5].dx, pTop[5].dy), Offset(pTop[4].dx, pTop[4].dy), paint0);
      canvas.drawLine(Offset(pTop[6].dx, pTop[6].dy), Offset(pTop[7].dx, pTop[7].dy), paint0);
      canvas.drawLine(Offset(pTop[8].dx, pTop[8].dy), Offset(pTop[9].dx, pTop[9].dy), paint0);
      _State._drawArcReight(canvas, pBottom[2], pBottom[1], (raduis - thikcnes / 2), paint0, pi / 2 - tetaEave);
      _State._drawArc(canvas, pBottom[4], pBottom[3], raduis - thikcnes / 2, paint0, teta);
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
    } else {
      _State._drawArcReight(canvas, p[2], p[1], raduis, paint0, pi / 2 - tetaEave);
      _State._drawArc(canvas, p[4], p[3], raduis, paint0, pi / 2);
      if (Top) {
        _State._drawArc(canvas, p[5], p[8], raduis, paint0, teta);
        _State._drawArc(canvas, p[6], p[0], raduis, paint0, teta);
      } else {
        _State._drawArc(canvas, p[8], p[5], raduis, paint0, teta);
        if  (tetaEave < pi/4) {
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
      canvas.drawLine(Offset(p[1].dx, p[1].dy), Offset(p[0].dx, p[0].dy), paint0);
      canvas.drawLine(Offset(p[2].dx, p[2].dy), Offset(p[3].dx, p[3].dy), paint0);
      canvas.drawLine(Offset(p[5].dx, p[5].dy), Offset(p[4].dx, p[4].dy), paint0);
      canvas.drawLine(Offset(p[6].dx, p[6].dy), Offset(p[7].dx, p[7].dy), paint0);
      canvas.drawLine(Offset(p[8].dx, p[8].dy), Offset(p[9].dx, p[9].dy), paint0);
    }
    Offset cG = new Offset(p[2].dx + ex, p[1].dy + Ycg);
    _State._drawAxis_uCold(canvas, paint0Axis, cG, x0, ex, height / 2, width + 20 * _State.scale_r);
    //paint0.setPathEffect(new DashPathEffect(new double[]{40, 5, 10, 5}, 0));
    paint0.strokeWidth =(1);

    int paddingDimention = min((size.width/20).round(),(size.height/20).round());
    List<Offset> pDimention = new List(2);
    pDimention[0] = new Offset(p[4].dx - raduis - thikcnes / 2, p[4].dy + paddingDimention + thikcnes / 2);
    pDimention[1] = new Offset(p[5].dx, p[5].dy + paddingDimention + thikcnes / 2);
    _State._drawDimention(paddingDimention, canvas, pDimention[1], pDimention[0], textPaint0, "W", textPaint0, teta);

    pDimention[0] = new Offset (p[3].dx - paddingDimention - thikcnes/2,  pTop[1].dy);
    pDimention[1] = new Offset(p[3].dx - paddingDimention - thikcnes/2, pTop[5].dy);
    _State._drawDimention(paddingDimention, canvas, pDimention[0], pDimention[1], textPaint0, "h", textPaint0, teta);
    if (Top) {
      pDimention[0] = new Offset(p[6].dx + (paddingDimention + thikcnes / 2) * cosTeta, pBottom[0].dy + paddingDimention * sinTeta);
      pDimention[1] = new Offset(p[7].dx + (paddingDimention + thikcnes / 2) * cosTeta, p[7].dy + paddingDimention * sinTeta);
      _State._drawDimention(paddingDimention, canvas, pDimention[0], pDimention[1], textPaint0, "h-lip", textPaint0, teta);
    } else {
      pDimention[0] = new Offset(p[8].dx + (paddingDimention + thikcnes / 2) * cosTeta, pTop[5].dy - paddingDimention * sinTeta);
      pDimention[1] = new Offset(p[9].dx + (paddingDimention + thikcnes / 2) * cosTeta, p[9].dy - paddingDimention * sinTeta);
      _State._drawDimention(paddingDimention, canvas, pDimention[0], pDimention[1], textPaint0, "h-lip", textPaint0, teta);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
class draw_u_coldWith_CompretionDetails extends CustomPainter {
  Paint paint0, textPaint0, paint0Axis;
  bool Top = false;

  draw_u_coldWith_CompretionDetails(this.paint0,this.textPaint0,this.paint0Axis,this.Top);

  @override
  void paint(Canvas canvas, Size size) {
    double teta = /*_State.alfa =*/ pi / 2;
    double tetaEave = _State.tetaEave * pi / 180;
    !Top ? _State.scale_r =  min((size.width*0.8) / (_State.width + _State.thickness),   (size.height*0.8) / (_State.height + 2 * _State.width * sin(tetaEave).abs()))
        : _State.scale_r =  min((size.width*0.8) / (_State.width + _State.thickness),   (size.height*0.8) / (_State.height + _State.h_lip * 2));
    double sinTeta =  sin((teta - pi / 2) * pi / 180);
    double cosTeta =  cos((teta - pi / 2) * pi / 180);
    double sinTetaEave =  sin((tetaEave));
    double cosTetaEave =  cos((tetaEave));
    double tanTetaEave =  tan((tetaEave));
    double constant = 0;
    double width = _State.width * _State.scale_r;
    double height = _State.height * _State.scale_r;
    double raduis = _State.raduis * _State.scale_r;
    double thikcnes = _State.thickness * _State.scale_r;
    double L_stiffener = _State.h_lip * _State.scale_r;
    double c1 = double.parse(_State.c1.toString())* _State.scale_r;
    double c2 = double.parse(_State.c2.toString())* _State.scale_r;
    double b1 = double.parse(_State.bA_eff.toString()) / 2 * _State.scale_r;
    double b2 = double.parse(_State.bA_eff.toString()) / 2 * _State.scale_r;
    double Ycg = _State.Ycg * _State.scale_r;
    double ex = _State.ex * _State.scale_r;
    double x0 = _State.x0 * _State.scale_r;
    double Ls_Eff = _State.LsEffect * _State.scale_r;
    double a = height - (2 * raduis + thikcnes);
    double b = width - 1 * (raduis + thikcnes / 2 + constant * (raduis + thikcnes / 2));
    double centerX = size.width/ 2.0;
    double centerY = size.height / 2.0;
    double strokWidth=2;
    List<Offset> p = new List(10);
    p[0] = new Offset(centerX + b / 2, centerY - height / 2 + thikcnes / 2);
    p[1] = new Offset(p[0].dx - b, centerY - height / 2 + thikcnes / 2);
    p[2] = new Offset(centerX - b / 2 - raduis, centerY - a / 2);
    p[3] = new Offset(centerX - b / 2 - raduis, centerY + a / 2);
    p[4] = new Offset(centerX - b / 2, centerY + height / 2 - thikcnes / 2);
    p[5] = new Offset(p[4].dx + b, p[4].dy);
    if (Top) {
      p[6] = new Offset(p[0].dx + raduis, p[0].dy - raduis);
      p[7] = new Offset(p[6].dx, p[6].dy - L_stiffener);
      p[8] = new Offset(p[5].dx + raduis, p[5].dy + raduis);
      p[9] = new Offset(p[8].dx, p[8].dy + L_stiffener);
    } else {
      p[6] = new Offset(p[0].dx + raduis, p[0].dy + raduis);
      p[7] = new Offset(p[6].dx, p[6].dy + L_stiffener);
      p[8] = new Offset(p[5].dx + raduis, p[5].dy - raduis);
      p[9] = new Offset(p[8].dx, p[8].dy - L_stiffener);
      p[1] = new Offset(p[2].dx + raduis * (1 - sinTetaEave), p[2].dy - raduis * cosTetaEave);
      p[0] = new Offset(p[1].dx + (b + raduis * sinTetaEave*0) * cosTetaEave, p[1].dy - (b + raduis * sinTetaEave*0) * sinTetaEave);
      p[6] = new Offset(p[0].dx +  raduis * (cosTetaEave + sinTetaEave), p[0].dy + raduis * cosTetaEave * (1 - tanTetaEave));
      p[7] = new Offset(p[6].dx + L_stiffener * sinTetaEave, p[6].dy + L_stiffener * cosTeta * cosTetaEave);
    }
    /*paint0.setPathEffect(new DashPathEffect(new double[]{40, 5, 10, 5}, 0));
        paint0.strokeWidth =(3);
        _State._drawArc(canvas, p[2], p[1], raduis, paint0, teta);
        _State._drawArc(canvas, p[4], p[3], raduis, paint0, teta);
        canvas.drawLine(Offset(p[1].dx, p[1].dy, p[0].dx, p[0].dy, paint0);
        canvas.drawLine(Offset(p[2].dx, p[2].dy, p[3].dx, p[3].dy, paint0);
        canvas.drawLine(Offset(p[5].dx, p[5].dy, p[4].dx, p[4].dy, paint0);
*/
    double widthLine =  paint0.strokeWidth;
    paint0.strokeWidth =(1);
    List<Offset> pTop = new List(10);
    pTop[0] = new Offset(p[0].dx - sinTetaEave * thikcnes / 2, p[0].dy - cosTetaEave * thikcnes / 2);
    pTop[1] = new Offset(p[1].dx - sinTetaEave * thikcnes / 2, p[1].dy - cosTetaEave * thikcnes / 2);
    pTop[2] = new Offset(p[2].dx - thikcnes / 2, p[2].dy);
    pTop[3] = new Offset(p[3].dx - thikcnes / 2, p[3].dy);
    pTop[4] = new Offset(p[4].dx, p[4].dy + thikcnes / 2);
    pTop[5] = new Offset(p[5].dx, p[5].dy + thikcnes / 2);
    if (Top) {
      pTop[6] = new Offset(p[6].dx - thikcnes / 2, p[6].dy);
      pTop[7] = new Offset(p[7].dx - thikcnes / 2, p[7].dy);
      pTop[8] = new Offset(p[8].dx - thikcnes / 2, p[8].dy);
      pTop[9] = new Offset(p[9].dx - thikcnes / 2, p[9].dy);
    } else {
      pTop[6] = new Offset(p[6].dx + cosTeta * thikcnes / 2 * cosTetaEave, p[6].dy - thikcnes / 2 * sinTetaEave);
      pTop[7] = new Offset(p[7].dx + cosTeta * thikcnes / 2 * cosTetaEave, p[7].dy - thikcnes / 2 * sinTetaEave);
      pTop[8] = new Offset(p[8].dx + thikcnes / 2, p[8].dy);
      pTop[9] = new Offset(p[9].dx + thikcnes / 2, p[9].dy);
    }

    List<Offset> pBottom = new List(10);
    pBottom[0] = new Offset(p[0].dx + sinTetaEave * thikcnes / 2, p[0].dy + cosTetaEave * thikcnes / 2);
    pBottom[1] = new Offset(p[1].dx + sinTetaEave * thikcnes / 2, p[1].dy + cosTetaEave * thikcnes / 2);
    pBottom[2] = new Offset(p[2].dx + thikcnes / 2, p[2].dy);
    pBottom[3] = new Offset(p[3].dx + thikcnes / 2, p[3].dy);
    pBottom[4] = new Offset(p[4].dx, p[4].dy - thikcnes / 2);
    pBottom[5] = new Offset(p[5].dx, p[5].dy - thikcnes / 2);
    if (Top) {
      pBottom[6] = new Offset(p[6].dx + thikcnes / 2, p[6].dy);
      pBottom[7] = new Offset(p[7].dx + thikcnes / 2, p[7].dy);
      pBottom[8] = new Offset(p[8].dx + thikcnes / 2, p[8].dy);
      pBottom[9] = new Offset(p[9].dx + thikcnes / 2, p[9].dy);
    } else {
      pBottom[6] = new Offset(p[6].dx - cosTeta * thikcnes / 2 * cosTetaEave, p[6].dy + sinTetaEave * thikcnes / 2);
      pBottom[7] = new Offset(p[7].dx - cosTeta * thikcnes / 2 * cosTetaEave, p[7].dy + sinTetaEave * thikcnes / 2);
      pBottom[8] = new Offset(p[8].dx - thikcnes / 2, p[8].dy);
      pBottom[9] = new Offset(p[9].dx - thikcnes / 2, p[9].dy);
    }

    List<Offset> pF = new List(8);
    pF[0] = new Offset(p[0].dx - c2 * cosTetaEave, p[0].dy + c2 * sinTetaEave);
    pF[1] = new Offset(p[1].dx + c1 * cosTetaEave, p[1].dy - c1 * sinTetaEave);
    pF[2] = new Offset(p[2].dx, p[2].dy + b1);
    pF[3] = new Offset(p[3].dx, p[3].dy - b2);
    pF[5] = new Offset(p[5].dx - c2, p[5].dy);
    pF[4] = new Offset(p[4].dx + c1, p[4].dy);
    if (Top) {
      pF[6] = new Offset(p[6].dx, p[6].dy - Ls_Eff);
      pF[7] = new Offset(p[8].dx, p[8].dy + Ls_Eff);
    } else {
      pF[6] = new Offset(p[6].dx + Ls_Eff * sinTetaEave, p[6].dy + Ls_Eff * cosTetaEave);
      pF[7] = new Offset(p[8].dx, p[8].dy - Ls_Eff);
    }
    List<Offset> pFTop = new List(4);
    pFTop[0] = new Offset(pTop[0].dx - c2 * cosTetaEave, pTop[0].dy + c2 * sinTetaEave);
    pFTop[1] = new Offset(pTop[1].dx + c1 * cosTetaEave, pTop[1].dy - c1 * sinTetaEave);
    pFTop[2] = new Offset(pTop[2].dx, pTop[2].dy + b1);
    pFTop[3] = new Offset(pTop[3].dx, pTop[3].dy - b2);
    List<Offset> pFBottom = new List(4);
    pFBottom[0] = new Offset(pBottom[0].dx - c2 * cosTetaEave, pBottom[0].dy + c2 * sinTetaEave);
    pFBottom[1] = new Offset(pBottom[1].dx + c1 * cosTetaEave, pBottom[1].dy - c1 * sinTetaEave);
    pFBottom[2] = new Offset(pBottom[2].dx, pBottom[2].dy + b1);
    pFBottom[3] = new Offset(pBottom[3].dx, pBottom[3].dy - b2);
    if (thikcnes != 0) {
      //paint0.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
      _State._drawArcReight(canvas, pTop[2], pTop[1], (raduis + thikcnes / 2), paint0, pi/2 - tetaEave);
      _State._drawArc(canvas, pTop[4], pTop[3], raduis + thikcnes / 2, paint0, teta);
      canvas.drawLine(Offset(pTop[1].dx, pTop[1].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
      canvas.drawLine(Offset(pTop[2].dx, pTop[2].dy), Offset(pTop[3].dx, pTop[3].dy), paint0);
      canvas.drawLine(Offset(pTop[5].dx, pTop[5].dy), Offset(pTop[4].dx, pTop[4].dy), paint0);
      canvas.drawLine(Offset(pTop[6].dx, pTop[6].dy), Offset(pTop[7].dx, pTop[7].dy), paint0);
      canvas.drawLine(Offset(pTop[8].dx, pTop[8].dy), Offset(pTop[9].dx, pTop[9].dy), paint0);
      _State._drawArcReight(canvas, pBottom[2], pBottom[1], (raduis - thikcnes / 2), paint0, pi/2 - tetaEave);
      _State._drawArc(canvas, pBottom[4], pBottom[3], raduis - thikcnes / 2, paint0, teta);
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
    paint0.strokeWidth =(thikcnes);
    canvas.drawLine(Offset(p[0].dx, p[0].dy), Offset(pF[0].dx, pF[0].dy), paint0);
    canvas.drawLine(Offset(p[1].dx, p[1].dy), Offset(pF[1].dx, pF[1].dy), paint0);
    canvas.drawLine(Offset(p[2].dx, p[2].dy), Offset(pF[2].dx, pF[2].dy), paint0);
    canvas.drawLine(Offset(p[3].dx, p[3].dy), Offset(pF[3].dx, pF[3].dy), paint0);
    canvas.drawLine(Offset(p[4].dx, p[4].dy), Offset(pF[4].dx, pF[4].dy), paint0);
    canvas.drawLine(Offset(p[5].dx, p[5].dy), Offset(pF[5].dx, pF[5].dy), paint0);
    canvas.drawLine(Offset(p[6].dx, p[6].dy), Offset(pF[6].dx, pF[6].dy), paint0);
    canvas.drawLine(Offset(p[8].dx, p[8].dy), Offset(pF[7].dx, pF[7].dy), paint0);
    _State._drawArcReight(canvas, p[2], p[1], raduis, paint0, pi / 2 - tetaEave);
    _State._drawArc(canvas, p[4], p[3], raduis, paint0, pi / 2);
    if (Top) {
      _State._drawArc(canvas, p[5], p[8], raduis, paint0, teta);
      _State._drawArc(canvas, p[6], p[0], raduis, paint0, teta);
    } else {
      _State._drawArc(canvas, p[8], p[5], raduis, paint0, teta);
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
    paint0.strokeWidth =(widthLine);
    int paddingDimention = min((size.width/20).round(),(size.height/20).round());
    Offset cG = new Offset(p[2].dx + width / 2, p[5].dy + thikcnes / 2 + Ycg - height);
    canvas.drawLine(Offset(cG.dx + width / 2 + 50 * _State.scale_r, cG.dy), Offset(cG.dx - width / 2 - 50 * _State.scale_r, cG.dy), paint0Axis);
    //paint0Axis.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
    _State._drawTextStart(canvas, _State.textStyleD,"Y", cG.dx + width / 2 + 50 * _State.scale_r, cG.dy);
    Offset pSDimen = new Offset(p[0].dx + raduis + thikcnes / 2 + paddingDimention, p[5].dy + thikcnes / 2);
    Offset pEDimen = new Offset(p[0].dx + raduis + thikcnes / 2 + paddingDimention, p[5].dy + thikcnes / 2 + Ycg - height);
    _State._drawDimention(paddingDimention, canvas, pSDimen, pEDimen, paint0Axis, "Ycg", paint0Axis, pi / 2);
    pTop[1] = new Offset( pTop[1].dx - paddingDimention * sinTetaEave, pTop[1].dy - paddingDimention * cosTetaEave);
    pFTop[1] = new Offset(pFTop[1].dx - paddingDimention * sinTetaEave,pFTop[1].dy - paddingDimention * cosTetaEave);
    pTop[0] = new Offset( pTop[0].dx - paddingDimention * sinTetaEave, pTop[0].dy - paddingDimention * cosTetaEave);
    pFTop[0] = new Offset(pFTop[0].dx - paddingDimention * sinTetaEave,pFTop[0].dy - paddingDimention * cosTetaEave);
    _State._drawDimention(paddingDimention, canvas, pTop[1], pFTop[1], paint0Axis, "C1", paint0Axis,pi/2+tetaEave);
    _State._drawDimention(paddingDimention, canvas, pFTop[0], pTop[0], paint0Axis, "C2", paint0Axis, pi / 2+tetaEave);
    pFBottom[2] = new Offset(pFBottom[2].dx + paddingDimention,pFBottom[2].dy);
    pBottom[2] = new Offset( pBottom[2].dx + paddingDimention, pBottom[2].dy);
    pFBottom[3] = new Offset(pFBottom[3].dx + paddingDimention,pFBottom[3].dy);
    pBottom[3] = new Offset( pBottom[3].dx + paddingDimention, pBottom[3].dy);
    _State._drawDimention(paddingDimention, canvas, pFBottom[2], pBottom[2], paint0Axis, "b1", paint0Axis, pi / 2);
    _State._drawDimention(paddingDimention, canvas, pBottom[3], pFBottom[3], paint0Axis, "b2", paint0Axis, pi / 2);
    pTop[2]  = new Offset(pTop[2].dx - paddingDimention,pTop[2].dy);
    pTop[3]  = new Offset(pTop[3].dx - paddingDimention,pTop[3].dy);
    pBottom[4] = new Offset(pBottom[4].dx, pBottom[4].dy - paddingDimention);
    pBottom[5] = new Offset(pBottom[5].dx, pBottom[5].dy - paddingDimention);
    _State._drawDimention(paddingDimention, canvas, pTop[2], pTop[3],       textPaint0, "L-web",  textPaint0, pi / 2);
    _State._drawDimention(paddingDimention, canvas, pBottom[4], pBottom[5], textPaint0, "L-flang",textPaint0, 3*pi/2);
    p[8] = new Offset( p[8].dx - (paddingDimention + thikcnes / 2), p[8].dy);
    pF[7] = new Offset(pF[7].dx - (paddingDimention + thikcnes / 2),pF[7].dy);
    if (Top) {
      _State._drawDimention(paddingDimention, canvas, p[8], pF[7], paint0Axis, "Ls_Eff", paint0Axis, pi / 2);
    } else {
      _State._drawDimention(paddingDimention, canvas, pF[7], p[8], paint0Axis, "Ls_Eff", paint0Axis, pi / 2);
    }
//    paint0Axis.setPathEffect(new DashPathEffect(new double[]{40, 15, 15, 15}, 0));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
class draw_u_coldWith_FlaxeurDetails extends CustomPainter {
  Paint paint0, textPaint0, paint0Axis;
  bool Top = false;

  draw_u_coldWith_FlaxeurDetails(this.paint0,this.textPaint0,this.paint0Axis,this.Top);

  @override
  void paint(Canvas canvas, Size size) {
    double teta = /*_State.alfa =*/ pi / 2;
    double tetaEave = _State.tetaEave * pi /180;
    !Top ? _State.scale_r =  min((size.width*0.8) / (_State.width + _State.thickness),   (size.height*0.8) / (_State.height + 2 * _State.width * sin(tetaEave).abs()))
        : _State.scale_r =  min((size.width*0.8) / (_State.width + _State.thickness),   (size.height*0.8) / (_State.height + _State.h_lip * 2));
    double sinTeta =  sin((teta - pi / 2) * pi / 180);
    double cosTeta =  cos((teta - pi / 2) * pi / 180);
    double sinTetaEave =  sin((tetaEave));
    double cosTetaEave =  cos((tetaEave));
    double tanTetaEave =  tan((tetaEave));
    double constant = 0;
    double width = _State.width * _State.scale_r;
    double height = _State.height * _State.scale_r;
    double raduis = _State.raduis * _State.scale_r;
    double thikcnes = _State.thickness * _State.scale_r;
    double L_stiffener = _State.h_lip * _State.scale_r;
    double c1 = double.parse(_State.c1.toString())* _State.scale_r;
    double c2 = double.parse(_State.c2.toString())* _State.scale_r;
    double b1 = double.parse(_State.b1.toString())* _State.scale_r;
    double b2 = double.parse(_State.b2.toString())* _State.scale_r;
    double Ycg = _State.Ycg * _State.scale_r;
    double Ls_Eff = _State.LsEffect * _State.scale_r;
    double a = height - (2 * raduis + thikcnes);
    double b = width - 1 * (raduis + thikcnes / 2 + constant * (raduis + thikcnes / 2));
    double centerX = size.width/ 2.0;
    double centerY = size.height / 2.0;
    double strokWidth=2;
    List<Offset> p = new List(10);
    p[0] = new Offset(centerX + b / 2, centerY - height / 2 + thikcnes / 2);
    p[1] = new Offset(p[0].dx - b, centerY - height / 2 + thikcnes / 2);
    p[2] = new Offset(centerX - b / 2 - raduis, centerY - a / 2);
    p[3] = new Offset(centerX - b / 2 - raduis, centerY + a / 2);
    p[4] = new Offset(centerX - b / 2, centerY + height / 2 - thikcnes / 2);
    p[5] = new Offset(p[4].dx + b, p[4].dy);
    if (Top) {
      p[6] = new Offset(p[0].dx + raduis, p[0].dy - raduis);
      p[7] = new Offset(p[6].dx, p[6].dy - L_stiffener);
      p[8] = new Offset(p[5].dx + raduis, p[5].dy + raduis);
      p[9] = new Offset(p[8].dx, p[8].dy + L_stiffener);
    } else {
      p[6] = new Offset(p[0].dx + raduis, p[0].dy + raduis);
      p[7] = new Offset(p[6].dx, p[6].dy + L_stiffener);
      p[8] = new Offset(p[5].dx + raduis, p[5].dy - raduis);
      p[9] = new Offset(p[8].dx, p[8].dy - L_stiffener);
      p[1] = new Offset(p[2].dx + raduis * (1 - sinTetaEave), p[2].dy - raduis * cosTetaEave);
      p[0] = new Offset(p[1].dx + (b + raduis * sinTetaEave*0) * cosTetaEave, p[1].dy - (b + raduis * sinTetaEave*0) * sinTetaEave);
      p[6] = new Offset(p[0].dx +  raduis * (cosTetaEave + sinTetaEave), p[0].dy + raduis * cosTetaEave * (1 - tanTetaEave));
      p[7] = new Offset(p[6].dx + L_stiffener * sinTetaEave, p[6].dy + L_stiffener * cosTeta * cosTetaEave);
    }
    /*paint0.setPathEffect(new DashPathEffect(new double[]{40, 5, 10, 5}, 0));
        paint0.strokeWidth =(3);
        _State._drawArc(canvas, p[2], p[1], raduis, paint0, teta);
        _State._drawArc(canvas, p[4], p[3], raduis, paint0, teta);
        canvas.drawLine(Offset(p[1].dx, p[1].dy, p[0].dx, p[0].dy, paint0);
        canvas.drawLine(Offset(p[2].dx, p[2].dy, p[3].dx, p[3].dy, paint0);
        canvas.drawLine(Offset(p[5].dx, p[5].dy, p[4].dx, p[4].dy, paint0);
*/
    double widthLine =  paint0.strokeWidth;
    paint0.strokeWidth =(1);
    List<Offset> pTop = new List(10);
    pTop[0] = new Offset(p[0].dx - sinTetaEave * thikcnes / 2, p[0].dy - cosTetaEave * thikcnes / 2);
    pTop[1] = new Offset(p[1].dx - sinTetaEave * thikcnes / 2, p[1].dy - cosTetaEave * thikcnes / 2);
    pTop[2] = new Offset(p[2].dx - thikcnes / 2, p[2].dy);
    pTop[3] = new Offset(p[3].dx - thikcnes / 2, p[3].dy);
    pTop[4] = new Offset(p[4].dx, p[4].dy + thikcnes / 2);
    pTop[5] = new Offset(p[5].dx, p[5].dy + thikcnes / 2);
    if (Top) {
      pTop[6] = new Offset(p[6].dx - thikcnes / 2, p[6].dy);
      pTop[7] = new Offset(p[7].dx - thikcnes / 2, p[7].dy);
      pTop[8] = new Offset(p[8].dx - thikcnes / 2, p[8].dy);
      pTop[9] = new Offset(p[9].dx - thikcnes / 2, p[9].dy);
    } else {
      pTop[6] = new Offset(p[6].dx + cosTeta * thikcnes / 2 * cosTetaEave, p[6].dy - thikcnes / 2 * sinTetaEave);
      pTop[7] = new Offset(p[7].dx + cosTeta * thikcnes / 2 * cosTetaEave, p[7].dy - thikcnes / 2 * sinTetaEave);
      pTop[8] = new Offset(p[8].dx + thikcnes / 2, p[8].dy);
      pTop[9] = new Offset(p[9].dx + thikcnes / 2, p[9].dy);
    }

    List<Offset> pBottom = new List(10);
    pBottom[0] = new Offset(p[0].dx + sinTetaEave * thikcnes / 2, p[0].dy + cosTetaEave * thikcnes / 2);
    pBottom[1] = new Offset(p[1].dx + sinTetaEave * thikcnes / 2, p[1].dy + cosTetaEave * thikcnes / 2);
    pBottom[2] = new Offset(p[2].dx + thikcnes / 2, p[2].dy);
    pBottom[3] = new Offset(p[3].dx + thikcnes / 2, p[3].dy);
    pBottom[4] = new Offset(p[4].dx, p[4].dy - thikcnes / 2);
    pBottom[5] = new Offset(p[5].dx, p[5].dy - thikcnes / 2);
    if (Top) {
      pBottom[6] = new Offset(p[6].dx + thikcnes / 2, p[6].dy);
      pBottom[7] = new Offset(p[7].dx + thikcnes / 2, p[7].dy);
      pBottom[8] = new Offset(p[8].dx + thikcnes / 2, p[8].dy);
      pBottom[9] = new Offset(p[9].dx + thikcnes / 2, p[9].dy);
    } else {
      pBottom[6] = new Offset(p[6].dx - cosTeta * thikcnes / 2 * cosTetaEave, p[6].dy + sinTetaEave * thikcnes / 2);
      pBottom[7] = new Offset(p[7].dx - cosTeta * thikcnes / 2 * cosTetaEave, p[7].dy + sinTetaEave * thikcnes / 2);
      pBottom[8] = new Offset(p[8].dx - thikcnes / 2, p[8].dy);
      pBottom[9] = new Offset(p[9].dx - thikcnes / 2, p[9].dy);
    }

    List<Offset> pF = new List(8);
    pF[0] = new Offset(p[0].dx - c2 * cosTetaEave, p[0].dy + c2 * sinTetaEave);
    pF[1] = new Offset(p[1].dx + c1 * cosTetaEave, p[1].dy - c1 * sinTetaEave);
    pF[2] = new Offset(p[2].dx, p[2].dy + b1);
    pF[3] = new Offset(p[3].dx, p[3].dy - b2);
    pF[5] = new Offset(p[5].dx - c2, p[5].dy);
    pF[4] = new Offset(p[4].dx + c1, p[4].dy);
    if (Top) {
      pF[6] = new Offset(p[6].dx, p[6].dy - Ls_Eff);
      pF[7] = new Offset(p[8].dx, p[8].dy + Ls_Eff);
    } else {
      pF[6] = new Offset(p[6].dx + Ls_Eff * sinTetaEave, p[6].dy + Ls_Eff * cosTetaEave);
      pF[7] = new Offset(p[8].dx, p[8].dy - Ls_Eff);
    }
    List<Offset> pFTop = new List(4);
    pFTop[0] = new Offset(pTop[0].dx - c2 * cosTetaEave, pTop[0].dy + c2 * sinTetaEave);
    pFTop[1] = new Offset(pTop[1].dx + c1 * cosTetaEave, pTop[1].dy - c1 * sinTetaEave);
    pFTop[2] = new Offset(pTop[2].dx, pTop[2].dy + b1);
    pFTop[3] = new Offset(pTop[3].dx, pTop[3].dy - b2);
    List<Offset> pFBottom = new List(4);
    pFBottom[0] = new Offset(pBottom[0].dx - c2 * cosTetaEave, pBottom[0].dy + c2 * sinTetaEave);
    pFBottom[1] = new Offset(pBottom[1].dx + c1 * cosTetaEave, pBottom[1].dy - c1 * sinTetaEave);
    pFBottom[2] = new Offset(pBottom[2].dx, pBottom[2].dy + b1);
    pFBottom[3] = new Offset(pBottom[3].dx, pBottom[3].dy - b2);
    if (thikcnes != 0) {
      //paint0.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
      _State._drawArcReight(canvas, pTop[2], pTop[1], (raduis + thikcnes / 2), paint0, pi/2 - tetaEave);
      _State._drawArc(canvas, pTop[4], pTop[3], raduis + thikcnes / 2, paint0, teta);
      canvas.drawLine(Offset(pTop[1].dx, pTop[1].dy), Offset(pTop[0].dx, pTop[0].dy), paint0);
      canvas.drawLine(Offset(pTop[2].dx, pTop[2].dy), Offset(pTop[3].dx, pTop[3].dy), paint0);
      canvas.drawLine(Offset(pTop[5].dx, pTop[5].dy), Offset(pTop[4].dx, pTop[4].dy), paint0);
      canvas.drawLine(Offset(pTop[6].dx, pTop[6].dy), Offset(pTop[7].dx, pTop[7].dy), paint0);
      canvas.drawLine(Offset(pTop[8].dx, pTop[8].dy), Offset(pTop[9].dx, pTop[9].dy), paint0);
      _State._drawArcReight(canvas, pBottom[2], pBottom[1], (raduis - thikcnes / 2), paint0, pi/2 - tetaEave);
      _State._drawArc(canvas, pBottom[4], pBottom[3], raduis - thikcnes / 2, paint0, teta);
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
    paint0.strokeWidth =(thikcnes);
    canvas.drawLine(Offset(p[0].dx, p[0].dy), Offset(pF[0].dx, pF[0].dy), paint0);
    canvas.drawLine(Offset(p[1].dx, p[1].dy), Offset(pF[1].dx, pF[1].dy), paint0);
    canvas.drawLine(Offset(p[2].dx, p[2].dy), Offset(pF[2].dx, pF[2].dy), paint0);
    canvas.drawLine(Offset(p[3].dx, p[3].dy), Offset(pF[3].dx, pF[3].dy), paint0);
    canvas.drawLine(Offset(p[5].dx, p[5].dy), Offset(p[4].dx, p[4].dy), paint0);
    canvas.drawLine(Offset(p[6].dx, p[6].dy), Offset(pF[6].dx, pF[6].dy), paint0);
    canvas.drawLine(Offset(p[8].dx, p[8].dy), Offset(p[9].dx, p[9].dy), paint0);
    _State._drawArcReight(canvas, p[2], p[1], raduis, paint0, pi/2 - tetaEave);
    _State._drawArc(canvas, p[4], p[3], raduis, paint0, teta);
    if (Top) {
      _State._drawArc(canvas, p[5], p[8], raduis, paint0, teta);
      _State._drawArc(canvas, p[6], p[0], raduis, paint0, teta);
    } else {
      _State._drawArc(canvas, p[8], p[5], raduis, paint0, teta);
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
    paint0.strokeWidth =(widthLine);
    int paddingDimention = min((size.width/20).round(),(size.height/20).round());
    Offset cG = new Offset(p[2].dx + width / 2, p[5].dy + thikcnes / 2 + Ycg - height);
    canvas.drawLine(Offset(cG.dx + width / 2 + 50 * _State.scale_r, cG.dy), Offset(cG.dx - width / 2 - 50 * _State.scale_r, cG.dy), paint0Axis);
    //    paint0Axis.setPathEffect(new DashPathEffect(new double[]{40, 0}, 0));
    _State._drawTextStart(canvas, _State.textStyleD,"Y", cG.dx + width / 2 + 50 * _State.scale_r, cG.dy);
    Offset pSDimen = new Offset(p[0].dx + raduis + thikcnes / 2 + paddingDimention, p[5].dy + thikcnes / 2);
    Offset pEDimen = new Offset(p[0].dx + raduis + thikcnes / 2 + paddingDimention, p[5].dy + thikcnes / 2 + Ycg - height);
    _State._drawDimention(paddingDimention, canvas, pSDimen, pEDimen, paint0Axis, "Ycg", paint0Axis, pi / 2);
    pTop[1] = new Offset( pTop[1].dx, pTop[1].dy - paddingDimention * cosTetaEave);
    pFTop[1] = new Offset(pFTop[1].dx,pFTop[1].dy - paddingDimention * cosTetaEave);
    pTop[0] = new Offset( pTop[0].dx, pTop[0].dy - paddingDimention * cosTetaEave);
    pFTop[0] = new Offset(pFTop[0].dx,pFTop[0].dy - paddingDimention * cosTetaEave);
    _State._drawDimention(paddingDimention, canvas, pTop[1], pFTop[1], paint0Axis, "C1", paint0Axis, pi / 2+tetaEave);
    _State._drawDimention(paddingDimention, canvas, pFTop[0], pTop[0], paint0Axis, "C2", paint0Axis, pi / 2+tetaEave);
    pFBottom[2] = new Offset(pFBottom[2].dx + paddingDimention,pFBottom[2].dy);
    pBottom[2] = new Offset( pBottom[2].dx + paddingDimention, pBottom[2].dy);
    pFBottom[3] = new Offset(pFBottom[3].dx + paddingDimention,pFBottom[3].dy);
    pBottom[3] = new Offset( pBottom[3].dx + paddingDimention, pBottom[3].dy);
    _State._drawDimention(paddingDimention, canvas, pFBottom[2], pBottom[2], paint0Axis, "b1", paint0Axis, pi / 2);
    _State._drawDimention(paddingDimention, canvas, pBottom[3], pFBottom[3], paint0Axis, "b2", paint0Axis, pi / 2);
    pTop[2]  = new Offset(pTop[2].dx - paddingDimention,pTop[2].dy);
    pTop[3]  = new Offset(pTop[3].dx - paddingDimention,pTop[3].dy);
    pBottom[4] = new Offset(pBottom[4].dx, pBottom[4].dy - paddingDimention);
    pBottom[5] = new Offset(pBottom[5].dx, pBottom[5].dy - paddingDimention);
    _State._drawDimention(paddingDimention, canvas, pTop[2], pTop[3], paint0Axis, "L-web", paint0Axis, pi / 2);
    _State._drawDimention(paddingDimention, canvas, pBottom[4], pBottom[5], paint0Axis, "L-flang", paint0Axis, 270);
    p[8] = new Offset( p[8].dx - (paddingDimention + thikcnes / 2), p[8].dy);
    pF[7] = new Offset(pF[7].dx - (paddingDimention + thikcnes / 2),pF[7].dy);
    if (Top) {
      _State._drawDimention(paddingDimention, canvas, p[8], pF[7], paint0Axis, "Ls_Eff", paint0Axis, pi / 2);
    } else {
      _State._drawDimention(paddingDimention, canvas, pF[7], p[8], paint0Axis, "Ls_Eff", paint0Axis, pi / 2);
    }
    //  paint0Axis.setPathEffect(new DashPathEffect(new double[]{40, 15, 15, 15}, 0));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

