import 'package:flutter/material.dart';
import 'package:nano_nfc/screens/home_screen/add_new_link_screen.dart';

class AddLinkButtonLayout extends StatefulWidget {
  const AddLinkButtonLayout({Key? key}) : super(key: key);

  @override
  _AddLinkButtonLayoutState createState() => _AddLinkButtonLayoutState();
}

class _AddLinkButtonLayoutState extends State<AddLinkButtonLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          minWidth: 80,
          height: 80,
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (buildContext) => AddNewLinkScreen(),
              ),
            ).then((value) {
              setState(() {});
            });
          },
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
        const SizedBox(height: 10),
        Text('Add Link'),
      ],
    );
  }
}
