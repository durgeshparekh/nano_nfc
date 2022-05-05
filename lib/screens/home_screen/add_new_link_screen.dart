import 'package:flutter/material.dart';
import 'package:nano_nfc/helper/marquee.dart';
import 'package:nano_nfc/helper/size_config.dart';
import 'package:nano_nfc/screens/home_screen/components/add_new_list_sheet.dart';

class AddNewLinkScreen extends StatefulWidget {
  const AddNewLinkScreen({Key? key}) : super(key: key);

  @override
  _AddNewLinkScreenState createState() => _AddNewLinkScreenState();
}

class _AddNewLinkScreenState extends State<AddNewLinkScreen> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Link'),
      ),
      body: GridView.builder(
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
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isDismissible: true,
                    isScrollControlled: true,
                    enableDrag: true,
                    elevation: 10,
                    builder: (context) => AddNewLinkSheet(
                      name: linksList[index],
                      mediaImage: linksImageList[index],
                    ),
                  );
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
    );
  }
}
