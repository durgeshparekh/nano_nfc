import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:nano_nfc/helper/marquee.dart';
import 'package:nano_nfc/helper/size_config.dart';

class LinksListItemLayout extends StatefulWidget {
  final String mediaImage;
  final String name;
  const LinksListItemLayout(
      {Key? key, required this.mediaImage, required this.name})
      : super(key: key);

  @override
  _LinksListItemLayoutState createState() => _LinksListItemLayoutState();
}

class _LinksListItemLayoutState extends State<LinksListItemLayout> {
  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      blurSize: 3,
      animateMenuItems: true,
      duration: const Duration(milliseconds: 200),
      menuOffset: 10,
      menuWidth: MediaQuery.of(context).size.width * 0.5,
      onPressed: () {
        print('object');
      },
      menuItems: [
        FocusedMenuItem(
          title: const Text(
            'Edit Link',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            //
          },
        ),
        // scene schedule
        FocusedMenuItem(
          title: const Text(
            'Delete',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {},
        ),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              print('onTap:');
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.mediaImage,
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
                  widget.name,
                  softWrap: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
