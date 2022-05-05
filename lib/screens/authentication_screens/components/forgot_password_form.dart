import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:nano_nfc/helper/constants.dart';
import 'package:nano_nfc/helper/custom_suffix_icon.dart';
import 'package:nano_nfc/helper/default_button.dart';
import 'package:nano_nfc/helper/form_error.dart';
import 'package:nano_nfc/helper/http_handler.dart';
import 'package:nano_nfc/helper/size_config.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  late String email = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue!,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSuffixIcon(iconData: Icons.mail),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          if (isLoading)
            CircularProgressIndicator(color: kPrimaryColor)
          else
            DefaultButton(
              text: "Continue",
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Do what you want to do
                  sendEmail();
                }
              },
            ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          // NoAccountText(),
        ],
      ),
    );
  }

  Future<void> sendEmail() async {
    setState(() => isLoading = true);
    Map<String, String> header = new Map();
    header['Content-Type'] = 'application/json';

    Map<String, dynamic> body = new Map();
    body['email'] = email;

    var requestBody = jsonEncode(body);

    var response = await http.post(
      Uri.parse(HttpHandler.forgotPasswordUrl),
      headers: header,
      body: requestBody.toString(),
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() => isLoading = false);
      String status = jsonResponse['status'];
      String toast = jsonResponse['toast'];
      Fluttertoast.showToast(msg: toast);
    } else {
      setState(() => isLoading = false);
    }
  }
}
