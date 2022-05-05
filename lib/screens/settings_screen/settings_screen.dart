import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nano_nfc/helper/constants.dart';
import 'package:nano_nfc/helper/shared_preference_manager.dart';
import 'package:nano_nfc/models/model_user.dart';
import 'package:nano_nfc/screens/authentication_screens/sign_in_screen.dart';
import 'package:nano_nfc/screens/settings_screen/change_name_sheet.dart';
import 'package:nano_nfc/screens/settings_screen/change_password_sheet.dart';
import 'package:nano_nfc/screens/settings_screen/edit_circular_user_image.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late ModelUser modelUser = new ModelUser();
  Box<ModelUser> userBox = Hive.box(user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'),
        leading: SizedBox(),
      ),
      body: Column(
        children: [
          EditCircularUserImage(
            modelUser: userBox.getAt(0)!,
            editUserCallback: () {
              //
            },
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 1),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Change Name'),
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isDismissible: true,
                isScrollControlled: true,
                enableDrag: true,
                elevation: 10,
                builder: (context) => ChangeNameSheet(modelUser: modelUser),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password'),
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isDismissible: true,
                isScrollControlled: true,
                enableDrag: true,
                elevation: 10,
                builder: (context) => ChangePasswordSheet(),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Privacy Policy'),
            onTap: () {
              //
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              SharedPreferenceManager().removeValues();
              Box<ModelUser> userBox = Hive.box(user);
              userBox.clear();
              Navigator.popUntil(context, (route) => false);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
