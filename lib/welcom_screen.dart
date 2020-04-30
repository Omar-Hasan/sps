import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:stahl_section/color/color.dart';
import 'package:flutter/material.dart';
import 'package:stahl_section/translate/app_localizations.dart';
import 'package:stahl_section/MyHomePage.dart';

class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {

  @override
  Widget build(BuildContext context) {
    var pages = [
      PageViewModel(
        titleWidget: Center(
          child: Column(
            children: <Widget>[
              Image.asset('assets/main_image/hello.png', height: 100),
              Text(AppLocalizations.of(context).translate('slide_1_titl'),
                style: Theme.of(context).textTheme.headline,)
            ],
          ),
        ),
        body: AppLocalizations.of(context).translate('slide_1_desc'),
        image: Container(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset('assets/main_image/logo-01.svg', height: 175)),
        decoration: PageDecoration(
          pageColor: color.red,
          titleTextStyle: TextStyle(color: Colors.orange),
          bodyTextStyle: Theme.of(context).textTheme.display1,
        ),
      ),
      PageViewModel(
        titleWidget: Center(
          child: Column(
            children: <Widget>[
              Image.asset('assets/main_image/hello.png', height: 100),
              Text(AppLocalizations.of(context).translate('slide_2_titl'),
                style: Theme.of(context).textTheme.headline,)
            ],
          ),
        ),
        body: AppLocalizations.of(context).translate('slide_2_desc'),
        image: Container(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset('assets/main_image/icon_code.svg', height: 175)),
        decoration: PageDecoration(
          pageColor: color.red,
          titleTextStyle: TextStyle(color: Colors.orange),
          bodyTextStyle: Theme.of(context).textTheme.display1,
        ),
      ),
      PageViewModel(
        titleWidget: Center(
          child: Column(
            children: <Widget>[
              Image.asset('assets/main_image/hello.png', height: 100),
              Text(AppLocalizations.of(context).translate('slide_3_titl'),
                style: Theme.of(context).textTheme.headline,)
            ],
          ),
        ),
        body: AppLocalizations.of(context).translate('slide_3_desc'),
        image: Container(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset('assets/main_image/icon_user.svg', height: 175)),
        decoration: PageDecoration(
          pageColor: color.red,
          titleTextStyle: TextStyle(color: Colors.orange),
          bodyTextStyle: Theme.of(context).textTheme.display1,
        ),
      ),
      PageViewModel(
        titleWidget: Center(
          child: Column(
            children: <Widget>[
              Image.asset('assets/main_image/hello.png', height: 100),
              Text(AppLocalizations.of(context).translate('slide_4_titl'),
                style: Theme.of(context).textTheme.headline,)
            ],
          ),
        ),
        body: AppLocalizations.of(context).translate('slide_4_desc'),
        image: Container(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset('assets/main_image/icon_weld.svg', height: 175)),
        decoration: PageDecoration(
          pageColor: color.red,
          titleTextStyle: TextStyle(color: Colors.orange),
          bodyTextStyle: Theme.of(context).textTheme.display1,
        ),
      ),
      PageViewModel(
        titleWidget: Center(
          child: Column(
            children: <Widget>[
              Image.asset('assets/main_image/hello.png', height: 100),
              Text(AppLocalizations.of(context).translate('slide_5_titl'),
                style: Theme.of(context).textTheme.headline,)
            ],
          ),
        ),
        body: AppLocalizations.of(context).translate('slide_5_desc'),
        image: Container(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset('assets/main_image/icon_cold.svg', height: 175)),
        decoration: PageDecoration(
          pageColor: color.red,
          titleTextStyle: TextStyle(color: Colors.orange),
          bodyTextStyle: Theme.of(context).textTheme.display1,
        ),
      ),
      PageViewModel(
        titleWidget: Center(
          child: Column(
            children: <Widget>[
              Image.asset('assets/main_image/hello.png', height: 100),
              Text(AppLocalizations.of(context).translate('slide_6_titl'),
                style: Theme.of(context).textTheme.headline,)
            ],
          ),
        ),
        body: AppLocalizations.of(context).translate('slide_6_desc'),
        image: Container(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset('assets/main_image/icon_save.svg', height: 175)),
        decoration: PageDecoration(
          pageColor: color.red,
          titleTextStyle: TextStyle(color: Colors.orange),
          bodyTextStyle: Theme.of(context).textTheme.display1,
        ),
      ),
      PageViewModel(
        titleWidget: Center(
          child: Column(
            children: <Widget>[
              Image.asset('assets/main_image/hello.png', height: 100),
              Text(AppLocalizations.of(context).translate('slide_7_titl'),
                style: Theme.of(context).textTheme.headline,)
            ],
          ),
        ),
        body: AppLocalizations.of(context).translate('slide_7_desc'),
        image: Container(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset('assets/main_image/icon_bar.svg', height: 175)),
        decoration: PageDecoration(
          pageColor: color.red,
          titleTextStyle: TextStyle(color: Colors.orange),
          bodyTextStyle: Theme.of(context).textTheme.display1,
        ),
      ),
    ];

    return Scaffold(
      body: IntroductionScreen(
        pages: pages,
        onDone: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
          // When done button is press
        },
        onSkip: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
          // You can also override onSkip callback
        },
        showSkipButton: true,
        skip: const Icon(Icons.skip_next, color: color.White,),
        next: const Icon(Icons.arrow_forward),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600, color: color.White)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: color.White,
            color: color.gray,
            spacing: const EdgeInsets.symmetric(horizontal: 2.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
