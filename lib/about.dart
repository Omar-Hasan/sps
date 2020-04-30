import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stahl_section/color/color.dart';
import 'package:stahl_section/translate/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class about extends StatefulWidget {
  @override
  _aboutState createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.red,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate('app_title'),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline,),
                  Text(AppLocalizations.of(context).translate('version'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.display2.copyWith(color: color.Whitegray)),
                  SvgPicture.asset('assets/main_image/logo-01.svg',height: 175,),
                  GestureDetector(
                    child: Text(AppLocalizations.of(context).translate('info'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline.copyWith(fontSize: 18),),
                    onTap: () async {
                      if (await canLaunch(AppLocalizations.of(context).translate('url'))) {
                       await launch(AppLocalizations.of(context).translate('url'));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset('assets/main_image/logo_subh.png', height: 75),
                  ),
                  Align(alignment: Alignment.center,
                    child: GestureDetector(
                      child: Text(AppLocalizations.of(context).translate('companyname'),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.display2.copyWith(color: color.Whitegray,fontSize: 18)),
                      onTap: () async {
                        if (await canLaunch('http://subhengineering.com/')) {
                          await launch('http://subhengineering.com/');
                        }
                      },
                    ),
                     )
                ],
              ),
            ),
          )
        ],
      ),

    );
  }
}
