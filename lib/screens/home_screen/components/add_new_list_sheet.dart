import 'package:flutter/material.dart';
import 'package:nano_nfc/helper/constants.dart';
import 'package:nano_nfc/helper/size_config.dart';

class AddNewLinkSheet extends StatefulWidget {
  final String name;
  final String mediaImage;
  const AddNewLinkSheet({
    Key? key,
    required this.name,
    required this.mediaImage,
  }) : super(key: key);

  @override
  _AddNewLinkSheetState createState() => _AddNewLinkSheetState();
}

class _AddNewLinkSheetState extends State<AddNewLinkSheet> {
  TextEditingController mediaNameController = new TextEditingController();
  TextEditingController mediaDetailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    mediaNameController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  widget.mediaImage,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: mediaNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Set Name",
                    hintText: "Set text under the link icon",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: mediaDetailController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    labelText: "${widget.name} URL",
                    hintText: "Enter Your ${widget.name} URL",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.4,
                    height: getProportionateScreenHeight(56),
                    child: MaterialButton(
                      onPressed: () {},
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
                      onPressed: () {},
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
    );
  }
}
