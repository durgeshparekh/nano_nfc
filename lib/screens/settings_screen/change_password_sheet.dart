import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nano_nfc/helper/constants.dart';
import 'package:nano_nfc/helper/size_config.dart';

class ChangePasswordSheet extends StatefulWidget {
  const ChangePasswordSheet({Key? key}) : super(key: key);

  @override
  _ChangePasswordSheetState createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<ChangePasswordSheet> {
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Change Password",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: oldPasswordController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Old Password",
                      hintText: "Enter old password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: newPasswordController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "New Password",
                      hintText: "Enter new password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      hintText: "Please confirm your password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.4,
                      height: getProportionateScreenHeight(56),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.white,
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            // fontSize: getProportionateScreenWidth(18),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.4,
                      height: getProportionateScreenHeight(56),
                      child: MaterialButton(
                        onPressed: () {
                          if (oldPasswordController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please enter old password');
                          } else if (newPasswordController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please enter new password');
                          } else if (confirmPasswordController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please confirm your password');
                          } else if (newPasswordController.text !=
                              confirmPasswordController.text) {
                            Fluttertoast.showToast(
                                msg: "New password doesn't match");
                          } else {
                            _savePassword();
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: kPrimaryColor,
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _savePassword() async {
    //
  }
}
