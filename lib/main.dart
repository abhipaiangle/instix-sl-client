import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:instix_sl_client/constants.dart';
import 'package:instix_sl_client/provider/DataProvider.dart';
import 'package:instix_sl_client/screens/HomePage.dart';
import 'package:instix_sl_client/screens/LoginSSO.dart';
import 'package:instix_sl_client/screens/LoginSignupScreen.dart';
import 'package:flutter/services.dart';
import 'package:instix_sl_client/screens/MainScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DataProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: SMART_LAUNDRY,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreenSplash(),
      ),
    );
  }
}
