import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/popup.dart';
import 'package:stahl_section/popup_content.dart';
import 'package:stahl_section/welded_section/computeDetailsWelded.dart';
import 'package:stahl_section/translate/app_localizations.dart';
import 'package:photo_view/photo_view.dart';
import 'package:stahl_section/welded_section/weldMain.dart';


class details extends StatefulWidget {
  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
  String description = 'IPN 80';
  List<DetailsItem> listDetails = new List();

  @override
  void initState() {
    super.initState();
    description = weldMain.myController.text;
    double t_plate = weldMain.t_plate;
    double b_plate = weldMain.b_plate;
    double h = weldMain.h;
    double b_Top = weldMain.b_Top;
    double tw = weldMain.tw;
    double tf_Top = weldMain.tf_Top;
    double b_Bottom = weldMain.b_Bottom;
    double tf_Bottom = weldMain.tf_Bottom;
    double twChannelle = weldMain.tPlateRL;
    double hChannelle = weldMain.h;
    double AreaChannelle = weldMain.aC;
    double IyChannelle = weldMain.IyC;
    double IzChannelle = weldMain.IzC;
    double ezChannelle = weldMain.ezC;
    double WplyChannelle = weldMain.WplyC;
    double alfa = weldMain.alfa;
    String  x_section = weldMain.x_section,
        from, channelleName = weldMain.spinner[weldMain.numberUpn];
    computeDetailsWelded computeDetails =
    new computeDetailsWelded(x_section, h, b_Top, tw, tf_Top, b_Bottom, tf_Bottom, t_plate, b_plate, channelleName, twChannelle, hChannelle, AreaChannelle, IyChannelle, IzChannelle, WplyChannelle, ezChannelle, alfa *  pi / 180);

    List<String> value = computeDetails.getvalue_detail();
    List<String> name = computeDetails.getname_detail();
    for (int i = 0; i < value.length; i++) {
      listDetails.add(DetailsItem(name[i], value[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                style: Theme
                    .of(context)
                    .textTheme
                    .headline
                    .copyWith(color: color.red),
              ),
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

  _photo() {
    Widget _popupBody() {
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: PhotoView.customChild(
          backgroundDecoration: BoxDecoration(
            color: color.White,
          ),
          child: SvgPicture.asset(weldMain.imageDetails),
        ),
      );
    }

    _photoView() {
      showPopupCenter(context, _popupBody(), 'title');
    }

    return GestureDetector(
      onTap: () => _photoView(),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: color.White,
          border: Border.all(color: color.black, width: 3.0),
          borderRadius: BorderRadius.all(
              Radius.circular(17.0) //                 <--- border radius here
          ),
        ),
        width: double.infinity,
        height: 200,
        child: SvgPicture.asset(weldMain.imageDetails),
      ),
    );
  }

  _listDetails() {
    List<DetailsItem> listDetailsTrue = new List();
    for (int i = 0; i < listDetails.length; i++) {
         listDetailsTrue.add(listDetails[i]);
    }
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: ListView.separated(
        itemCount: listDetailsTrue.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(
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
                        style: Theme
                            .of(context)
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
                        style: Theme
                            .of(context)
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

  void choiceAction(String choice) {
    if (choice == Constants.symbols) {
      Widget _popupBody() {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: color.White,
          padding: EdgeInsets.all(3),
          child: ListView(
            children: <Widget>[
              Text(AppLocalizations.of(context).translate('meaningOFSYMBOLEWelded')
                , style: Theme
                    .of(context)
                    .textTheme
                    .display2,),
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
