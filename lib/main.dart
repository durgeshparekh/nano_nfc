import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:nano_nfc/helper/theme.dart';
import 'package:nano_nfc/screens/splash_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'models/model_user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(ModelUserAdapter());
  await Hive.openBox<ModelUser>('user');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nano NFC',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: SplashScreen(),
    );
  }
}
