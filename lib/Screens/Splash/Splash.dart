import 'dart:async';
import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weight_app_firebase/AppConsts/AppConsts.dart';
import 'package:weight_app_firebase/CommonFunctions/CommonFunctions.dart';
import 'package:weight_app_firebase/Screens/Login/Login.dart';

class Splash extends StatefulWidget {
  static String id = 'splash';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () => Navigator.pushNamed(context, Login.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConsts.primaryColor,
      body: Container(
        color: AppConsts.primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DelayedDisplay(
                fadingDuration: Duration(milliseconds: 1800),
                slidingCurve: Curves.easeInOutBack,
                slidingBeginOffset: Offset(0, -1.2),
                child: AutoSizeText(
                  'Weight',
                  style: AppConsts.whiteBoldWithSpacing,
                  presetFontSizes: [28],
                ),
              ),
              DelayedDisplay(
                fadingDuration: Duration(milliseconds: 1800),
                slidingBeginOffset: Offset(0, 1.2),
                child: AutoSizeText(
                  'Tracker',
                  style: AppConsts.whiteBoldWithSpacing,
                  presetFontSizes: [28],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
