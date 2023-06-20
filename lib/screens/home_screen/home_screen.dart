import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:nano_nfc/helper/constants.dart';
import 'package:nano_nfc/helper/custom_progress_bar.dart';
import 'package:nano_nfc/helper/http_handler.dart';
import 'package:nano_nfc/helper/size_config.dart';
import 'package:nano_nfc/models/model_user.dart';
import 'package:nano_nfc/screens/home_screen/components/circular_user_image.dart';
import 'package:nano_nfc/screens/home_screen/links_grid_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late ModelUser modelUser = new ModelUser();
  bool isLoading = false;
  Box<ModelUser> userBox = Hive.box(user);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Nano NFC'),
        leading: SizedBox(),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: isLoading
            ? CustomProgressBar(message: 'Please Wait')
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // CircularUserImage(modelUser: userBox.getAt(0)!),
                    CircularUserImage(modelUser: ModelUser()),
                    const SizedBox(height: 20),
                    LinksGridList(),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> fetchData() async {
    setState(() => isLoading = true);
    Map<String, String> header = new Map();
    header['Content-Type'] = 'application/json';
    header['Authorization'] = 'JWT ${userBox.getAt(0)!.jwtToken}';

    var response = await http.post(
      Uri.parse(HttpHandler.fetchDataUrl),
      headers: header,
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    print('fetchData: $jsonResponse');

    if (response.statusCode == 200) {
      setState(() => isLoading = false);
      String status = jsonResponse['status'];
      String toast = jsonResponse['toast'];
      Fluttertoast.showToast(msg: toast);
    } else {
      setState(() => isLoading = false);
    }
  }
}
