import 'package:flutter/material.dart';
import 'package:nano_nfc/helper/constants.dart';
import 'package:nano_nfc/helper/size_config.dart';
import 'package:nano_nfc/screens/activate_tag_screen/select_profile_to_link_sheet.dart';

class ActivateTagScreen extends StatelessWidget {
  const ActivateTagScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Activate Tag'),
        leading: SizedBox(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Press button to activate tag',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(50)),
            SizedBox(
              width: SizeConfig.screenWidth * 0.4,
              height: getProportionateScreenHeight(50),
              child: MaterialButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isDismissible: true,
                    isScrollControlled: true,
                    enableDrag: false,
                    elevation: 10,
                    builder: (context) => SelectProfileToLinkSheet(),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: kPrimaryColor,
                child: Text(
                  'Write Tag',
                  style: TextStyle(
                    // fontSize: getProportionateScreenWidth(18),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
