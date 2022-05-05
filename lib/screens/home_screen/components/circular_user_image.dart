import 'package:flutter/material.dart';
import 'package:nano_nfc/helper/size_config.dart';
import 'package:nano_nfc/models/model_user.dart';

class CircularUserImage extends StatelessWidget {
  final ModelUser modelUser;
  const CircularUserImage({Key? key, required this.modelUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Card(
          margin: EdgeInsets.only(left: 10, top: 10),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Icon(
              Icons.person,
              size: 40,
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: Text(
                modelUser.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: Text(
                modelUser.email,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
