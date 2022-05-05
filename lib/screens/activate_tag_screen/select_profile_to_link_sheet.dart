import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nano_nfc/helper/constants.dart';
import 'package:nano_nfc/helper/marquee.dart';
import 'package:nano_nfc/helper/size_config.dart';
import 'package:nfc_manager/nfc_manager.dart';

class SelectProfileToLinkSheet extends StatefulWidget {
  const SelectProfileToLinkSheet({Key? key}) : super(key: key);

  @override
  _SelectProfileToLinkSheetState createState() =>
      _SelectProfileToLinkSheetState();
}

class _SelectProfileToLinkSheetState extends State<SelectProfileToLinkSheet> {
  ValueNotifier<dynamic> result = ValueNotifier(null);

  bool isLoading = false;
  late Timer? timer;
  List<String> linksList = [
    'Custom Link',
    'Facebook',
    'WhatsApp',
    'Instagram',
    'Twitter',
    'Snapchat',
    'Youtube',
    'Skype',
  ];

  List<String> linksImageList = [
    'assets/images/link.png',
    'assets/images/facebook.png',
    'assets/images/whatsapp.png',
    'assets/images/instagram.png',
    'assets/images/twitter.png',
    'assets/images/snap_chat.png',
    'assets/images/youtube_1.png',
    'assets/images/skype.png',
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: isLoading
          ? Container(
              // color: Colors.cyan,
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Text(
                    "Searching for tag",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * 0.55,
                    // color: Colors.grey,
                    child: AvatarGlow(
                      endRadius: 150.0,
                      startDelay: Duration(milliseconds: 600),
                      glowColor: kPrimaryColor,
                      duration: Duration(milliseconds: 2000),
                      repeat: true,
                      // showTwoGlows: true,
                      shape: BoxShape.circle,
                      animate: true,
                      curve: Curves.fastOutSlowIn,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: kPrimaryColor,
                        child: Icon(
                          Icons.nfc,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text(
                  "Select Link",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisCount: 3,
                    ),
                    itemCount: linksList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              setState(() => isLoading = true);
                              startWriteToTag();
                              timer = new Timer.periodic(Duration(seconds: 10),
                                  (timer) {
                                timer.cancel();
                                Fluttertoast.showToast(
                                    msg: 'Please try again!');
                                NfcManager.instance.stopSession();
                                setState(() => isLoading = false);
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                linksImageList[index],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.3,
                            child: Align(
                              alignment: Alignment.center,
                              child: Marquee(
                                child: Text(
                                  linksList[index],
                                  softWrap: false,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  void startWriteToTag() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);

      // NfcManager.instance.
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        Fluttertoast.showToast(msg: 'Tag is not ndef writable');
        NfcManager.instance.stopSession(errorMessage: result.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createUri(Uri.parse('https://google.com')),
      ]);

      try {
        await ndef.write(message);
        result.value = 'Success to "Ndef Write"';
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: 'Tag activated successfully');
        NfcManager.instance.stopSession();
        Navigator.pop(context);
      } catch (e) {
        result.value = e;
        Fluttertoast.showToast(msg: 'Error occurred, please try again!');
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }
}
