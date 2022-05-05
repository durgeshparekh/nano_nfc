import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nano_nfc/helper/constants.dart';
import 'package:nano_nfc/helper/shared_preference_manager.dart';
import 'package:nano_nfc/helper/size_config.dart';
import 'package:nano_nfc/screens/main_navigation_screen.dart';

import 'authentication_screens/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    new Timer.periodic(Duration(seconds: 2), (timer) {
      SharedPreferenceManager().getLoginStatus().then((value) {
        print('loginValue: $value');
        if (value == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignInScreen(),
            ),
          );
        } else {
          if (value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainNavigationScreen(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
            );
          }
        }
        // if (value != null || value!) {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => MainNavigationScreen(),
        //     ),
        //   );
        // } else {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => SignInScreen(),
        //     ),
        //   );
        // }
      });

      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.35,
                margin: EdgeInsets.only(right: 1),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(200),
                    // topLeft: Radius.circular(50),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.25,
                margin: EdgeInsets.only(right: 1),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(200),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                'Nano NFC',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
