import 'package:flutter/material.dart';
import 'package:nano_nfc/helper/size_config.dart';
import 'package:nano_nfc/models/model_user.dart';

class EditCircularUserImage extends StatefulWidget {
  final ModelUser modelUser;
  final VoidCallback editUserCallback;
  const EditCircularUserImage({
    Key? key,
    required this.modelUser,
    required this.editUserCallback,
  }) : super(key: key);

  @override
  _EditCircularUserImageState createState() => _EditCircularUserImageState();
}

class _EditCircularUserImageState extends State<EditCircularUserImage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Card(
                margin: EdgeInsets.only(left: 5, top: 15, bottom: 5, right: 5),
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
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: widget.editUserCallback,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: Text(
                widget.modelUser.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: Text(
                widget.modelUser.email,
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
