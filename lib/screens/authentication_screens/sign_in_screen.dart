import 'package:flutter/material.dart';
import 'package:nano_nfc/helper/constants.dart';
import 'package:nano_nfc/helper/no_account_text.dart';
import 'package:nano_nfc/helper/size_config.dart';

import 'components/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Sign In'),
      // ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Text(
                    "Sign In",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                  SignInForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                  NoAccountText(),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
