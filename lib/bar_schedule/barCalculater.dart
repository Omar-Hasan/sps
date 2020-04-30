import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/popup.dart';
import 'package:stahl_section/popup_content.dart';
import 'package:stahl_section/translate/app_localizations.dart';

class barCalculater extends StatefulWidget {
  @override
  _barCalculaterState createState() => _barCalculaterState();
}

class _barCalculaterState extends State<barCalculater> {
  static const double radius = 30, hieght = 50;
  bool spacing = false;
  Caculator caculator;
  TextEditingController textEditingController = new TextEditingController();
  TextEditingController textEditingController1 = new TextEditingController();
  String fie = 'Փ', mm2 = 'mm²';

  bool AreaIn_mm = true;
  int smallestBar = 10,
      largestBar = 28,
      minimumBars = 2,
      maximumBars = 10,
      minimumSpacing = 70,
      maximumSpacing = 200,
      uniteLength = 1000,
      okPercent = 20,
      numberBarSolution = 0,
      numberSpaceSolution = 0;
  double area = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    caculator = new Caculator(area, largestBar, smallestBar, okPercent);
  }

  @override
  Widget build(BuildContext context) {
    area = _getArea();
    caculator = new Caculator(area, largestBar, smallestBar, okPercent);

    caculator._barSolution(maximumBars, minimumBars);
    numberBarSolution = caculator.solution.length;
    caculator._spacingSolution(maximumSpacing, minimumSpacing, uniteLength);
    numberSpaceSolution = caculator.solution.length;
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(),
      body: Builder(
        builder: (context) => Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: _tap(AppLocalizations.of(context).translate('bars'),
                      !spacing, numberBarSolution),
                ),
                Flexible(
                  flex: 1,
                  child: _tap(AppLocalizations.of(context).translate('spacing'),
                      spacing, numberSpaceSolution),
                )
              ],
            ),
            new Expanded(
                child: Container(
              height: double.infinity,
              padding: EdgeInsets.all(3),
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: _listViewResult(),
                    margin: EdgeInsets.only(bottom: 320),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextField(
                          controller: textEditingController,
                          readOnly: true,
                          onChanged: (String s) {
                            setState(() {});
                          },
                          style: Theme.of(context).textTheme.display1,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: color.White,
                            hintText: 'Area mm2',
                            contentPadding: const EdgeInsets.only(left: 7),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: color.gray, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        new Container(
                            width: double.infinity,
                            height: 40,
                            color: color.White,
                            child: _listViewHorisental()),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: _raisedBottun(
                                  double.infinity, hieght, '7', _click7),
                            ),
                            Flexible(
                              flex: 1,
                              child: _raisedBottun(
                                  double.infinity, hieght, '8', _click8),
                            ),
                            Flexible(
                              flex: 1,
                              child: _raisedBottun(
                                  double.infinity, hieght, '9', _click9),
                            ),
                            Flexible(
                              flex: 1,
                              child: _raisedBottunred(
                                  double.infinity, hieght, '<', _clickBack),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: _raisedBottun(
                                  double.infinity, hieght, '4', _click4),
                            ),
                            Flexible(
                              flex: 1,
                              child: _raisedBottun(
                                  double.infinity, hieght, '5', _click5),
                            ),
                            Flexible(
                              flex: 1,
                              child: _raisedBottun(
                                  double.infinity, hieght, '6', _click6),
                            ),
                            Flexible(
                              flex: 1,
                              child: _raisedBottunred(
                                  double.infinity, hieght, 'C', _clickClear),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: _raisedBottun(
                                  double.infinity, hieght, '1', _click1),
                            ),
                            Flexible(
                              flex: 1,
                              child: _raisedBottun(
                                  double.infinity, hieght, '2', _click2),
                            ),
                            Flexible(
                              flex: 1,
                              child: _raisedBottun(
                                  double.infinity, hieght, '3', _click3),
                            ),
                            Flexible(
                              flex: 1,
                              child: AreaIn_mm
                                  ? _raisedBottunred(double.infinity, hieght,
                                      mm2, _clickmmArea)
                                  : _raisedBottunGray(double.infinity, hieght,
                                      mm2, _clickmmArea),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: _raisedBottun(
                                  double.infinity, hieght, '0', _click0),
                            ),
                            Flexible(
                              flex: 1,
                              child: _raisedBottun(
                                  double.infinity, hieght, '.', _clickPoint),
                            ),
                            Flexible(
                              flex: 1,
                              child: _raisedBottun(
                                  double.infinity, hieght, '+', _clickPlus),
                            ),
                            Flexible(
                              flex: 1,
                              child: AreaIn_mm
                                  ? _raisedBottunGray(double.infinity, hieght,
                                      fie, _clickdiameterArea)
                                  : _raisedBottunred(double.infinity, hieght,
                                      fie, _clickdiameterArea),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
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
                style: Theme.of(context)
                    .textTheme
                    .display3
                    .copyWith(fontSize: 22))),
        onTap: () {
          setState(() {
            click();
          });
        });
  }

  _raisedBottunfie(double width, double height, String text, click()) {
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
              borderRadius: BorderRadius.all(Radius.circular(7)),
              border: Border.all(color: color.black, width: 1),
            ),
            child: Text(text,
                style: Theme.of(context)
                    .textTheme
                    .display3
                    .copyWith(fontSize: 18))),
        onTap: () {
          setState(() {
            click();
          });
        });
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
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(fontSize: 25))),
        onTap: () {
          setState(() {
            click();
          });
        });
  }

  _raisedBottunGray(double width, double height, String text, click()) {
    return GestureDetector(
        child: Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[color.gray, color.gray],
              ),
              borderRadius: BorderRadius.all(Radius.circular(0)),
              border: Border.all(color: color.black, width: 1),
            ),
            child: Text(text,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(fontSize: 30))),
        onTap: () {
          setState(() {
            click();
          });
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

  _selectBar(String title,bool larg) {
    List<int> d = caculator._getDiameter(44, 5);
    d = d.reversed.toList();
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
                          style: Theme.of(context)
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
                  child: ListView.builder(
                    itemCount: d.length,
                  /*  separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      color: color.Whitegray,
                      thickness: 2,
                    ),*/
                    itemBuilder: (context, i) {
                      return Container(
                        padding: EdgeInsets.only(left: 3,right: 3),
                        child: OutlineButton(
                          color: color.White,
                          textColor: color.red,
                          borderSide: BorderSide(width: 2, color: color.black),
                          onPressed: () {
                            setState(() {
                              larg? largestBar = d[i]: smallestBar = d[i];
                            });
                            Navigator.pop(context);
                            Navigator.pop(context);
                            _showSetting();
                          },
                          child: Text(
                            fie + d[i].toString(),
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ),
                        color: color.White,
                      );
                    },
                  ),
                ),
              )
            ],
          ));
    }

    _showPopupCenter(context, _popupBody(), 'setting');
  }
  _selectBarLarg() => _selectBar(AppLocalizations.of(context).translate('largestBar'),true);

  _selectBarSmall() => _selectBar(AppLocalizations.of(context).translate('smallestBar'),false);

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
                          style: Theme.of(context)
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
                        controller: textEditingController1,
                        readOnly: true,
                        onChanged: (String s) {
                          setState(() {});
                        },
                        style: Theme.of(context).textTheme.display1,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: color.White,
                           contentPadding: const EdgeInsets.only(left: 7),
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: color.gray, width: 1),
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
                            child:  _raisedBottunSelver(double.infinity, hieght),
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
                            child: _raisedBottunSelver(double.infinity, hieght),
                          ),
                          Flexible(
                            flex: 1,
                            child: _raisedBottunSelver(double.infinity, hieght),
                          ),
                          Flexible(
                            flex: 1,
                            child:  _raisedBottunred(double.infinity, hieght,
                                AppLocalizations.of(context).translate('ok'), _1clickOk),
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

  _selectValuMaxBar() {
    boolValue = 'maximumBars';
    textEditingController1.text = '$maximumBars';
      _selectValue(AppLocalizations.of(context).translate('maximumBar'));
}
  _selectValuMinBar() {
    boolValue = 'minimumBars';
    textEditingController1.text = '$minimumBars';
    _selectValue(AppLocalizations.of(context).translate('minimumBar'));
  }
  _selectValuMaxSpacing() {
    boolValue = 'maximumSpacing';
    textEditingController1.text = '$maximumSpacing';
    _selectValue(AppLocalizations.of(context).translate('maximumSpacing'));
  }
  _selectValuMinSpacing() {
    boolValue = 'minimumSpacin';
    textEditingController1.text = '$minimumSpacing';
    _selectValue(AppLocalizations.of(context).translate('minimumSpacing'));
  }
  _selectValuUniteLength() {
    boolValue = 'uniteLength';
    textEditingController1.text = '$uniteLength';
    _selectValue(AppLocalizations.of(context).translate('uniteLength'));
  }
  _selectValuMaxExcessArea() {
    boolValue = 'okPercent';
    textEditingController1.text = '$okPercent';
    _selectValue(AppLocalizations.of(context).translate('maxExcessArea'));
  }
  _showSetting(){
    row(String text, int value, click()) {
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
                  style: Theme.of(context)
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
                      style: Theme.of(context).textTheme.display1.copyWith(
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
                          AppLocalizations.of(context).translate('setting'),
                          style: Theme.of(context)
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
                            AppLocalizations.of(context)
                                .translate('barSelection'),
                            style: Theme.of(context)
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
                                row(
                                    AppLocalizations.of(context)
                                        .translate('smallestBar'),
                                    smallestBar,
                                    _selectBarSmall),
                                row(
                                    AppLocalizations.of(context)
                                        .translate('largestBar'),
                                    largestBar,
                                    _selectBarLarg),
                                row(
                                    AppLocalizations.of(context)
                                        .translate('maximumBar'),
                                    maximumBars,
                                    _selectValuMaxBar),
                                row(
                                    AppLocalizations.of(context)
                                        .translate('minimumBar'),
                                    minimumBars,
                                    _selectValuMinBar),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: color.gray,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('spacingSelection'),
                            style: Theme.of(context)
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
                                row(
                                    AppLocalizations.of(context)
                                        .translate('maximumSpacing'),
                                    maximumSpacing,
                                    _selectValuMaxSpacing),
                                row(
                                    AppLocalizations.of(context)
                                        .translate('minimumSpacing'),
                                    minimumSpacing,
                                    _selectValuMinSpacing),
                                row(
                                    AppLocalizations.of(context)
                                        .translate('uniteLength'),
                                    uniteLength,
                                    _selectValuUniteLength),
                                row(
                                    AppLocalizations.of(context)
                                        .translate('maximumExcessArea'),
                                    okPercent,
                                    _selectValuMaxExcessArea),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ));
    }
    _showPopupRight(context, _popupBody(), 'setting');
  }
  _appBar() {

    choiceAction(String choice) {
      if (choice == Constants.Setting) {
        _showSetting();
      } else if (choice == Constants.Subscribe) {
        print('Subscribe');
      } else if (choice == Constants.SignOut) {
        print('SignOut');
      }
    }

    return AppBar(
      title: new Text(
        AppLocalizations.of(context).translate('barsCalculator'),
        style: Theme.of(context).textTheme.headline,
      ),
      actions: <Widget>[
        /*GestureDetector(
          onTap: () => filter(),
          child: SvgPicture.asset(
            'assets/main_image/filtertrans.svg',
            fit: BoxFit.contain,
          ),
        ),*/
        PopupMenuButton<String>(
          onSelected: choiceAction,
          itemBuilder: (BuildContext context) {
            return Constants.choices.map((String choice) {
              return PopupMenuItem<String>(
                height: 33,
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

  _tap(String text, final bool select, int numberS) {
    return GestureDetector(
      onTap: () {
        setState(() {
          text == AppLocalizations.of(context).translate('bars')
              ? spacing = false
              : spacing = true;
        });
      },
      child: Ink(
        decoration: const BoxDecoration(
          /*gradient: LinearGradient(
            colors: <Color>[color.White, color.WhiteSelver],
          ),*/
          borderRadius: BorderRadius.all(Radius.circular(1)),
        ),
        child: Container(
          color: !select ? color.WhiteSelver : color.White,
          padding: EdgeInsets.all(7),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: color.red,
                  child: Text(
                    numberS.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontSize: 20),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.display1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _listViewHorisental() {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 2.0, right: 2, top: 2),
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        _raisedBottunfie(50, 30, fie + '6', _click_d6),
        _raisedBottunfie(50, 30, fie + '8', _click_d8),
        _raisedBottunfie(50, 30, fie + '10', _click_d10),
        _raisedBottunfie(50, 30, fie + '12', _click_d12),
        _raisedBottunfie(50, 30, fie + '14', _click_d14),
        _raisedBottunfie(50, 30, fie + '16', _click_d16),
        _raisedBottunfie(50, 30, fie + '20', _click_d20),
        _raisedBottunfie(50, 30, fie + '22', _click_d22),
        _raisedBottunfie(50, 30, fie + '25', _click_d25),
        _raisedBottunfie(50, 30, fie + '28', _click_d28),
        _raisedBottunfie(50, 30, fie + '32', _click_d32),
        _raisedBottunfie(50, 30, fie + '40', _click_d40),
      ],
    );
  }

  _reversS(String s) {
    return s.split('').reversed.join();
  }

  _clickClear() {
    textEditingController.text = "";
  }

  _1clickClear() {
    textEditingController1.text = "";
  }

  editTextadd(String string) {
    String s = textEditingController.text;
    if (s.length > 0) {
      if (AreaIn_mm) {
        if (s.substring(s.length - 1) == ("+")) {
        } else
          s = s.substring(0, s.length - 3);
        textEditingController.text = (s + string + mm2);
      } else {
        int i = 0;
        String s1 = s.substring(s.length - i), s2 = s1;
        if (s.substring(s.length - 1) == ("+")) {
          textEditingController.text = (s + string + fie + '8');
          return;
        }
        for (i = 1; i < 5; i++) {
          s1 = s.substring(s.length - i, s.length - i + 1);
          if (s1 == fie) {
            s = s.substring(0, s.length - (i));
            textEditingController.text = (s + string + fie + _reversS(s2));
            break;
          } else
            s2 += s1;
        }
      }
    } else {
      if (AreaIn_mm) {
        textEditingController.text = (s + string + mm2);
      } else {
        textEditingController.text = (s + string + fie + '8' + "");
      }
    }
  }
  editText1add(String string) {
    textEditingController1.text += string;
  }

  editTextaddDiameter(String string) {
    if (AreaIn_mm) {
      _showToast(AppLocalizations.of(context).translate('firstCheckFieBottun'));
      return;
    }
    String s = textEditingController.text;
    if (s.length > 0) {
      if (s.substring(s.length - 1) == ("+")) {
      } else {
        for (int i = 1; i < 5; i++) {
          String s1 = s.substring(s.length - i, s.length - i + 1);
          if (s1 == (fie)) {
            s = s.substring(0, s.length - (i));
            break;
          }
        }
      }
      textEditingController.text = (s + string);
    }
  }

  _clickBack() {
    String s = textEditingController.text, s2;
    if (s.length == 0) return;
    if (s.substring(s.length - 1) == ("+")) {
      textEditingController.text = (s.substring(0, s.length - 1));
      return;
    }
    String s1 = "";
    s2 = s1;
    List<String> ss = s.split("+");
    String txt = "";
    for (int i = 0; i < ss.length - 1; i++) {
      txt += ss[i] + "+";
    }
    if (AreaIn_mm) {
      s1 = ss[ss.length - 1].substring(0, ss[ss.length - 1].length - 4);
      txt += ss[ss.length - 1].substring(0, ss[ss.length - 1].length - 4);
      if (s1.length > 0) {
        txt += mm2;
      }
      textEditingController.text = (txt);
      /*                   try {
                        if (s.substring(s.length() - 1).equals("+")) {
                            s = s.substring(0, s.length() - 1);
                            editText.setText(s);
                            return;
                        }
                    } catch (Exception ex) {
                        editText.setText("");
                    }
  */
    } else {
      s1 = ss[ss.length - 1].split(fie)[0];
      s2 = ss[ss.length - 1].split(fie)[1];
      if (s1.length > 1) {
        txt += s1.substring(0, s1.length - 1) + fie + s2;
      }
      textEditingController.text = (txt);
    }
  }

  _click_d6() {
    String s = fie + "6";
    editTextaddDiameter(s);
  }

  _click_d8() {
    String s = fie + "8";
    editTextaddDiameter(s);
  }

  _click_d10() {
    String s = fie + "10";
    editTextaddDiameter(s);
  }

  _click_d12() {
    String s = fie + "12";
    editTextaddDiameter(s);
  }

  _click_d14() {
    String s = fie + "14";
    editTextaddDiameter(s);
  }

  _click_d16() {
    String s = fie + "16";
    editTextaddDiameter(s);
  }

  _click_d20() {
    String s = fie + "20";
    editTextaddDiameter(s);
  }

  _click_d22() {
    String s = fie + "22";
    editTextaddDiameter(s);
  }

  _click_d25() {
    String s = fie + "25";
    editTextaddDiameter(s);
  }

  _click_d28() {
    String s = fie + "28";
    editTextaddDiameter(s);
  }

  _click_d32() {
    String s = fie + "32";
    editTextaddDiameter(s);
  }

  _click_d40() {
    String s = fie + "40";
    editTextaddDiameter(s);
  }

  _click0() {
    String s = "0";
    editTextadd(s);
  }

  _click1() {
    String s = "1";
    editTextadd(s);
  }

  _click2() {
    String s = "2";
    editTextadd(s);
  }

  _click3() {
    String s = "3";
    editTextadd(s);
  }

  _click4() {
    String s = "4";
    editTextadd(s);
  }

  _click5() {
    String s = "5";
    editTextadd(s);
  }

  _click6() {
    String s = "6";
    editTextadd(s);
  }

  _click7() {
    String s = "7";
    editTextadd(s);
  }

  _click8() {
    String s = "8";
    editTextadd(s);
  }

  _click9() {
    String s = "9";
    editTextadd(s);
  }

  _clickPlus() {
    String s = textEditingController.text;
    if (s == ("") || s == ("+")) {
    } else
      s = s + "+";
    textEditingController.text = s;
  }

  _clickPoint() {
    String s = ".";
    editTextadd(s);
  }

  _1clickBack() {
    String s = textEditingController1.text;
    if (s.length == 0) return;
    textEditingController1.text = (s.substring(0, s.length - 1));
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
    boolValue == 'maximumBars'? maximumBars = int.parse(textEditingController1.text):
    boolValue == 'minimumBars'? minimumBars = int.parse(textEditingController1.text):
    boolValue == 'maximumSpacing'? maximumSpacing = int.parse(textEditingController1.text):
    boolValue == 'minimumSpacing'? minimumSpacing = int.parse(textEditingController1.text):
    boolValue == 'uniteLength'? uniteLength = int.parse(textEditingController1.text):
    boolValue == 'okPercent'? okPercent = int.parse(textEditingController1.text):{};
    Navigator.pop(context);
    Navigator.pop(context);
    _showSetting();
  }



  _clickmmArea() {
    if (AreaIn_mm == true) return;
    // linear_dimater.setBackground(getResources().getDrawable(R.drawable.style_tab));
    // linear_mm.setBackground(getResources().getDrawable(R.drawable.style_red));
    AreaIn_mm = true;
    int i = 0;
    String s = textEditingController.text;
    String s1 = "";
    if (s.length > 0) {
      for (i = 1; i < 5; i++) {
        if (s.substring(s.length - 1) == ("+")) return;
        s1 = s.substring(s.length - i, s.length - i + 1);
        if (s1 == (fie)) {
          s = s.substring(0, s.length - (i));
          textEditingController.text = (s + mm2);
          break;
        }
      }
    }
  }

  _clickdiameterArea() {
    if (!AreaIn_mm == true) return;
    //linear_dimater.setBackground(getResources().getDrawable(R.drawable.style_red));
    //linear_mm.setBackground(getResources().getDrawable(R.drawable.style_tab));
    AreaIn_mm = false;
    String s = textEditingController.text;
    if (s.length > 0) {
      if (s.substring(s.length - 1) == ("+")) {
        textEditingController.text = (s + fie + '8');
        return;
      }
      s = s.substring(0, s.length - 3);
      textEditingController.text = (s + fie + '8');
    }
  }

  _getArea() {
    double Area = 0;
    String sEdit = textEditingController.text;
    int j = 0;
    List<String> s = sEdit.split("+");
    for (int k = 0; k < s.length; k++) {
      if (s[k].contains(mm2)) {
        s[k] = s[k].substring(0, s[k].length - 3);
        Area += _getDouble(s[k]);
      } else if (s[k].contains(fie)) {
        String s1 = s[k].split(fie)[0];
        String s2 = s[k].split(fie)[1];
        /*for (int i = 1; i < 5; i++) {
                s1 = s[k].substring(s[k].length() - i, s[k].length() - i + 1);
                if (s1.equals(fie))) {
                    s[k] = s[k].substring(0, s[k].length() - (i));
                    break;
                } else
                    s2 += s1;
            }*/
        Area += _getDouble(s1) * pi * pow(_getDouble(s2), 2) / 4;
      }
    }
    return Area;
  }

  _getDouble(String number) {
    double d = 0;
    try {
      d = double.parse(number);
    } catch (Exception) {}
    return d;
  }

  _listViewResult() {
    if (!spacing)
      caculator._barSolution(maximumBars, minimumBars);
    else
      caculator._spacingSolution(maximumSpacing, minimumSpacing, uniteLength);

    if (area == 0) {
      return _optionContainer(
          color.green, AppLocalizations.of(context).translate('inputArea'));
    } else if (area != 0 && caculator.solution.length == 0) {
      return _optionContainer(
          color.red, AppLocalizations.of(context).translate('noBarFound'));
    } else {
      return Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        //height: double.infinity,
        child: ListView.separated(
          itemCount: caculator.solution.length,
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: color.Whitegray,
            thickness: 2,
          ),
          itemBuilder: (context, i) {
            return Container(
              //alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.all(1),
              //height: 16,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: new Text(
                              caculator.solution[i],
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(fontSize: 20),
                            ),
                          ),
                          Container(
                            child: new Text(
                              caculator.Area[i],
                              style: Theme.of(context)
                                  .textTheme
                                  .display2
                                  .copyWith(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      //color: color.red,
                      margin: EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_drop_up,
                            color: color.green,
                            size: 30,
                          ),
                          Container(
                            child: new Text(
                              caculator.percent[i],
                              style:
                                  Theme.of(context).textTheme.display1.copyWith(
                                        fontSize:
                                            18, /* fontFamily: 'SugeoUI_bold'*/
                                      ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  _optionContainer(Color Scolor, String text) {
    return Wrap(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: color.black, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.info_outline,
                color: Scolor,
                size: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: new Text(
                  text,
                  style: Theme.of(context).textTheme.display1.copyWith(
                      color: color.black,
                      fontSize: 16,
                      fontWeight:
                          FontWeight.normal /* fontFamily: 'SugeoUI_bold'*/),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showToast(String text) {
    /*   final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
            label: AppLocalizations.of(context).translate('ok'), onPressed: scaffold.hideCurrentSnackBar),
      ),
    );*/
    // 3.1 use showToast method
    SnackBar snackBar = new SnackBar(
      content: new Text(
          text /*"Changes saved at " + new DateTime.now().toString()*/),
      action: SnackBarAction(
          label: AppLocalizations.of(context).translate('ok'),
          onPressed: _scaffoldKey.currentState.hideCurrentSnackBar),
      backgroundColor: color.gray,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _showPopupCenter(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: max(40,(MediaQuery.of(context).size.height-300)/2),
        left: max(30,(MediaQuery.of(context).size.width-300)/2),
        right: max(30,(MediaQuery.of(context).size.width-300)/2),
        bottom: max(40,(MediaQuery.of(context).size.height-300)/2),
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
        bottom: max(10, MediaQuery.of(context).size.height - 570),
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

class Caculator {
  static String _format2(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  static String _format3(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 3);
  }

  static String _format1(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  static String roundToString(double x) {
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

  List<String> solution = new List();
  List<String> Area = new List();
  List<String> percent = new List();
  List<int> diameter = new List();
  double area = 0;
  int okPercent = 1, dMax = 26, dMin = 6;
  String fie = 'Փ', mm2 = 'mm²';

  Caculator(double Area, int dMAx, int dMin, int okPercent) {
    this.area = Area;
    this.dMax = dMAx;
    this.dMin = dMin;
    this.okPercent = okPercent;
  }

  _barSolution(int numberMAx, int numberMin) {
    solution = new List();
    this.Area = new List();
    percent = new List();

    diameter = _getDiameter(dMax, dMin);
    for (int d in diameter) {
      //int d = diameter.get(i);
      int n = (area / (pi * pow(d, 2) / 4)).ceil();
      if (n > numberMAx || n < numberMin) continue;
      int perCent = ((n * pi * pow(d, 2) / 4 - area) / area * 100).ceil();
      if (perCent <= okPercent) {
        percent.add(perCent.toString() + "%");
        this.Area.add(roundToString(n * pi * pow(d, 2) / 4) + mm2);
        solution.add(n.toString() + fie + d.toString());
      }
    }
  }

  _spacingSolution(int spacingMAx, int spacingMin, int uniteLength) {
    solution = new List();
    this.Area = new List();
    percent = new List();

    if (area == 0) {
      return;
    }
    diameter = _getDiameter(dMax, dMin);
    for (int d in diameter) {
      int distanc = (uniteLength * pi * pow(d, 2) / (area * 4)).floor();
      /*while(uniteLength%distanc!=0 && distanc > spacingMin){
        distanc -=1;
      }*/
      if (distanc > spacingMAx || distanc < spacingMin) continue;
      int perCent =
          ((uniteLength * pi * pow(d, 2) / (4 * distanc) - area) / area * 100)
              .ceil();
      if (perCent <= okPercent) {
        percent.add((perCent).toString() + "%");
        this.Area.add(
            roundToString(uniteLength * pi * pow(d, 2) / (4 * distanc)) + mm2);
        solution.add(fie + d.toString() + "@" + distanc.toString() + "mm");
      }
    }
  }

  List<int> _getDiameter(int maxD, int minD) {
    List<int> diameter = [40, 32, 28, 25, 22, 20, 16, 14, 12, 10, 8, 6];
    List<int> d = new List();
    for (int i in diameter) {
      if (i <= maxD && i >= minD) {
        d.add(i);
      }
    }
    return d;
  }
}

class Constants {
  static const String Subscribe = 'Subscribe';
  static String Setting = 'Settings';
  static const String SignOut = 'Sign out';

  static List<String> choices = <String>[
    Setting,
  ];
  static BuildContext context;
}
