import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nano_nfc/helper/constants.dart';
import 'package:nano_nfc/helper/size_config.dart';
import 'package:nano_nfc/models/model_user.dart';

class ChangeNameSheet extends StatefulWidget {
  final ModelUser modelUser;
  const ChangeNameSheet({Key? key, required this.modelUser}) : super(key: key);

  @override
  _ChangeNameSheetState createState() => _ChangeNameSheetState();
}

class _ChangeNameSheetState extends State<ChangeNameSheet> {
  TextEditingController nameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = 'Enter name';
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
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
                  "Change Name",
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
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Enter your name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
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
                          if (nameController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please enter your name');
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
                            // fontSize: getProportionateScreenWidth(18),
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
