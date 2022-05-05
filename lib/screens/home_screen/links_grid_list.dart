import 'package:flutter/material.dart';
import 'package:nano_nfc/helper/size_config.dart';
import 'package:nano_nfc/screens/home_screen/components/add_link_button_layout.dart';

import 'components/links_list_item_layout.dart';

class LinksGridList extends StatefulWidget {
  const LinksGridList({Key? key}) : super(key: key);

  @override
  _LinksGridListState createState() => _LinksGridListState();
}

class _LinksGridListState extends State<LinksGridList> {
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
      // color: Colors.grey,
      height: SizeConfig.screenHeight,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisCount: 3,
        ),
        // reverse: true,
        itemCount: linksList.length,
        itemBuilder: (buildContext, index) {
          if (index == 0) {
            return AddLinkButtonLayout();
          } else {
            return LinksListItemLayout(
                mediaImage: linksImageList[index], name: linksList[index]);
          }
        },
      ),
    );
  }
}
