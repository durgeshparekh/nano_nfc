import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:nano_nfc/helper/constants.dart';
import 'package:nano_nfc/helper/custom_suffix_icon.dart';
import 'package:nano_nfc/helper/default_button.dart';
import 'package:nano_nfc/helper/form_error.dart';
import 'package:nano_nfc/helper/http_handler.dart';
import 'package:nano_nfc/helper/shared_preference_manager.dart';
import 'package:nano_nfc/helper/size_config.dart';
import 'package:nano_nfc/models/model_user.dart';
import 'package:nano_nfc/screens/authentication_screens/forgot_password_screen.dart';
import 'package:nano_nfc/screens/main_navigation_screen.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool remember = false;
  bool isLoading = false;
  late Timer timer;
  final List<String> errors = [];
  Box<ModelUser> userBox = Hive.box(user);

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: isLoading
          ? CircularProgressIndicator(color: kPrimaryColor)
          : Column(
              children: [
                buildEmailFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                Row(
                  children: [
                    // Checkbox(
                    //   value: remember,
                    //   activeColor: kPrimaryColor,
                    //   onChanged: (value) {
                    //     setState(() => remember = value!);
                    //   },
                    // ),
                    // Text("Remember me"),
                    Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (buildContext) => ForgotPasswordScreen(),
                        ),
                      ).then((value) {
                        setState(() {
                          errors.clear();
                        });
                      }),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                DefaultButton(
                  text: "Sign In",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      // _signInUser();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (buildContext) => MainNavigationScreen(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(iconData: Icons.lock),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      // cursorColor: kPrimaryColor,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        // labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter your email",
        // hintStyle: TextStyle(color: kPrimaryColor),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(iconData: Icons.mail),
      ),
    );
  }

  Future<void> _signInUser() async {
    setState(() => isLoading = true);
    timer = new Timer.periodic(Duration(seconds: 10), (timer) {
      Fluttertoast.showToast(msg: 'Something went wrong, Please try again!');
      timer.cancel();
    });

    Map<String, String> header = new Map();
    header['Content-Type'] = 'application/json';

    Map<String, dynamic> body = new Map();
    body['email'] = email;
    body['password'] = password;

    print('body: $body');

    var requestBody = jsonEncode(body);

    var response = await http.post(
      Uri.parse(HttpHandler.userLoginUrl),
      headers: header,
      body: requestBody.toString(),
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    print('login_response: $jsonResponse');
    if (response.statusCode == 200) {
      setState(() => isLoading = false);
      String status = jsonResponse['status'];
      String toast = jsonResponse['toast'];
      if (status == 'SUCCESS') {
        String jwtToken = jsonResponse['token'];
        Map<String, dynamic> userObject = jsonResponse['user'];
        String userEmail = userObject['email'];
        String userName = userObject['name'];

        ModelUser modelUser = new ModelUser();
        modelUser.email = userEmail;
        modelUser.name = userName;
        modelUser.jwtToken = jwtToken;

        userBox.add(modelUser);
        SharedPreferenceManager().saveLoginStatus(true);
        Fluttertoast.showToast(msg: toast);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (buildContext) => MainNavigationScreen(),
          ),
        );
      } else if (status == 'FAIL') {
        setState(() => isLoading = false);
      } else {
        setState(() => isLoading = false);
      }
      print(jsonResponse);
    } else {
      setState(() => isLoading = false);
      print(response.reasonPhrase);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer.cancel();
    }
  }
}
