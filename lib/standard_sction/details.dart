import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/popup.dart';
import 'package:stahl_section/popup_content.dart';
import 'package:stahl_section/standard_sction/ComputeDetails.dart';
import 'package:stahl_section/standard_sction/mainCode.dart';
import 'package:stahl_section/translate/app_localizations.dart';
import 'package:photo_view/photo_view.dart';

class details extends StatefulWidget {
  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
  String description = 'IPN 80';
  List<DetailsItem> listDetails = new List();
  List<String> listName = new List();
  List<FilterItem> listFilter = new List();

  @override
  void initState() {
    super.initState();
    description = mainCode.myController.text;
    listName = mainCode.arrayListName;
    ComputeDetails computeDetails =
        new ComputeDetails(mainCode.x_section, 0, 0, 0, 0, 0, 0, 0, 0);
    List<String> value = computeDetails.getvalue_detail(description);
    List<String> name = computeDetails.getname_detail();
    for (int i = 0; i < value.length; i++) {
      listDetails.add(DetailsItem(name[i], value[i]));
      listFilter.add(FilterItem(name[i],true));
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
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: color.red),
              ),
              _photo(),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: _listDetails(),
                    ),
                    Flexible(
                      flex: 1,
                      child: _listNames(),
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

  filter() {
    Widget FilterContent() {
      return Wrap(
        children: <Widget>[
          Container(
            decoration: _decoration(7, 2.5, color.White),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: _decoration(2, 1, color.red),
                  child: RaisedButton(
                    color: color.red,
                    child: Text(
                        AppLocalizations.of(context)
                            .translate('filter'),
                        style: Theme.of(context).textTheme.headline),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                  margin: EdgeInsets.all(3),
                ),
                Container(
                  height: 210,
                  child:  GridView.count(
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 4/2,
                    crossAxisCount: 3,
                    children: List.generate(listFilter.length, (index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            value: listFilter[index].value,
                            checkColor: color.White,
                            hoverColor: color.black,
                            focusColor: color.black,
                            activeColor: color.red,
                            onChanged: (bool value) {
                              setState(() {
                                listFilter[index].value = value;
                                Navigator.pop(context);
                                showPopupTopRight(context, FilterContent(), 'title');
                              });
                            },),
                          Text(listFilter[index].title,
                            style: Theme.of(context).textTheme.headline.copyWith(fontSize: 14,color: color.blackGray),
                          )
                        ],
                      );
                    }),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Container(
                        decoration: _decoration(2, 1, color.red),
                        child: RaisedButton(
                          color: color.red,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate('checkNone'),
                              style: Theme.of(context).textTheme.headline),
                          onPressed: (){
                            setState(() {
                              for(var i in listFilter){
                                i.value = false;
                              }
                              Navigator.pop(context);
                              showPopupTopRight(context, FilterContent(), 'title');
                            });
                          },
                        ),
                        margin: EdgeInsets.all(3),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        decoration: _decoration(2, 1, color.red),
                        child: RaisedButton(
                          color: color.red,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate('checkAll'),
                              style: Theme.of(context).textTheme.headline),
                          onPressed: (){
                            setState(() {
                              for(var i in listFilter){
                                i.value = true;
                              }
                              Navigator.pop(context);
                              showPopupTopRight(context, FilterContent(), 'title');
                            });
                          },
                        ),
                        margin: EdgeInsets.all(3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    }
    showPopupTopRight(context, FilterContent(), 'title');
    _checkNone() {
    }
    _checkAll() {}


  }

  _appBar() {
    return AppBar(
      title: new Text(''),
      actions: <Widget>[
        SvgPicture.asset(
          'assets/code_image/save.svg',
          fit: BoxFit.contain,
        ),
        GestureDetector(
          onTap: () => filter(),
          child: SvgPicture.asset(
            'assets/main_image/filtertrans.svg',
            fit: BoxFit.contain,
          ),
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
          child: SvgPicture.asset(mainCode.imageDetails),
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
        child: SvgPicture.asset(mainCode.imageDetails),
      ),
    );
  }

  _listDetails() {
    List<DetailsItem> listDetailsTrue = new List();
    for(int i = 0;i<listDetails.length; i++){
      if(listFilter[i].value) {
        listDetailsTrue.add(listDetails[i]);
      }
    }
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
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

  _listNames() {
    String selected = description;
    return Container(
      color: color.White,
      child: ListView.builder(
        itemCount: listName.length,
        itemBuilder: (context, i) {
          return GestureDetector(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: selected == listName[i] ? color.gray : color.White,
                  border: Border.all(color: color.black, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(
                          1) //                 <--- border radius here
                      ),
                ),
                child: Wrap(
                  children: <Widget>[
                    Text(
                      listName[i],
                      style: Theme.of(context)
                          .textTheme
                          .display3
                          .copyWith(fontSize: 15, fontFamily: 'SugeoUI'),
                    ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  _refreshValue(listName[i]);
                  selected = listName[i];
                });
              });
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
                Text(AppLocalizations.of(context).translate('meaningOFSYMBOLE')
                ,style: Theme.of(context).textTheme.display2,),
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

  _refreshValue(String name) {
    description = name;
    ComputeDetails computeDetails =
        new ComputeDetails(mainCode.x_section, 0, 0, 0, 0, 0, 0, 0, 0);
    List<String> value = computeDetails.getvalue_detail(description);
    for (int i = 0; i < value.length; i++) {
      listDetails[i].value = value[i];
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

  showPopupTopRight(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: 0,
        left: 70,
        right: 0,
        bottom: MediaQuery.of(context).size.height - 350,
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

class FilterItem {
  final String title;
  bool value = true;
  FilterItem(this.title,this.value);
}

