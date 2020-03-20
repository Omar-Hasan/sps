import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/translate/app_localizations.dart';

class mainCold extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<mainCold> {
  @override
  Widget build(BuildContext context) {
    double _radius =40;
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
                  _cardDrawer('assets/main_image/filtertrans.svg',
                      AppLocalizations.of(context).translate('savedSection'), _radius),
                  _cardDrawer('assets/main_image/filtertrans.svg',
                      AppLocalizations.of(context).translate('userSection'), _radius),
                  _cardDrawer('assets/main_image/filtertrans.svg',
                      AppLocalizations.of(context).translate('standardSection'), _radius),
                  _cardDrawer('assets/main_image/filtertrans.svg',
                      AppLocalizations.of(context).translate('weldedSection'), _radius),
                  _cardDrawer('assets/main_image/icon_cold_formed.svg',
                      AppLocalizations.of(context).translate('coldFormedSection'), _radius),
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
                  new Container(
                      width: double.infinity,
                      height: 70,
                      color: color.gray,
                      child: _listViewHorisental()),
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
                'assets/main_image/filtertrans.svg',
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
    switch(selct){
      case 0:
        list[0].assetsImage = 'assets/code_image/icon_ir.svg';
        break;
      case 1:
        list[1].assetsImage = 'assets/code_image/icon_ur.svg';
        break;
      case 2:
        list[2].assetsImage = 'assets/code_image/icon_tr.svg';
        break;
      case 3:
        list[3].assetsImage = 'assets/code_image/icon_zr.svg';
        break;
      case 4:
        list[4].assetsImage = 'assets/code_image/icon_lr.svg';
        break;
      case 5:
        list[5].assetsImage = 'assets/code_image/icon_circler.svg';
        break;
      case 6:
        list[6].assetsImage = 'assets/code_image/icon_squarr.svg';
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
                      child:  FittedBox(
                        child: SvgPicture.asset(
                          svgAssets,
                          fit: BoxFit.fill,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),SizedBox(
                      width: _radius * 2,
                      child: Center(
                        child: Text(
                          text,
                          style: Theme.of(context).textTheme.display3.copyWith(color: color.White),
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

  _navigate(String text) {}
}

class ListItem {
  String assetsImage;
  Color color;
  ListItem(this.color, this.assetsImage);
}
