import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:instix_sl_client/classes/WashingMachine.dart';
import 'package:instix_sl_client/constants.dart';
import 'package:instix_sl_client/provider/DataProvider.dart';
import 'package:instix_sl_client/screens/HomePage.dart';
import 'package:instix_sl_client/screens/LoginSSO.dart';
import 'package:instix_sl_client/screens/LoginSignupScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

List<dynamic> machines = [
  {
    "floor": 1,
    "macId": "jfn45n3m5m",
    "booked": [
      {
        "start": "2022-06-13 09:30:00",
        "end": "2022-06-13 10:20:00",
      },
      {
        "start": "2022-06-13 13:30:00",
        "end": "2022-06-13 14:40:00",
      },
      {
        "start": "2022-06-13 16:10:00",
        "end": "2022-06-13 17:00:00",
      },
      {
        "start": "2022-06-13 17:10:00",
        "end": "2022-06-13 17:50:00",
      },
      {
        "start": "2022-06-13 20:10:00",
        "end": "2022-06-13 20:40:00",
      },
    ],
  },
  {
    "floor": 2,
    "macId": "dsf093jd9s",
    "booked": [
      {
        "start": "2022-06-13 09:30:00",
        "end": "2022-06-13 10:20:00",
      },
      {
        "start": "2022-06-13 13:30:00",
        "end": "2022-06-13 14:40:00",
      },
      {
        "start": "2022-06-13 16:10:00",
        "end": "2022-06-13 17:00:00",
      },
      {
        "start": "2022-06-13 17:10:00",
        "end": "2022-06-13 17:50:00",
      },
      {
        "start": "2022-06-13 20:10:00",
        "end": "2022-06-13 20:40:00",
      },
    ],
  },
  {
    "floor": 3,
    "macId": "hc45hc9ddf",
    "booked": [
      {
        "start": "2022-06-13 09:30:00",
        "end": "2022-06-13 10:20:00",
      },
      {
        "start": "2022-06-13 13:30:00",
        "end": "2022-06-13 14:40:00",
      },
      {
        "start": "2022-06-13 16:10:00",
        "end": "2022-06-13 17:00:00",
      },
      {
        "start": "2022-06-13 17:10:00",
        "end": "2022-06-13 17:50:00",
      },
      {
        "start": "2022-06-13 20:10:00",
        "end": "2022-06-13 20:40:00",
      },
    ],
  },
  {
    "floor": 4,
    "macId": "fdfd4c9834",
    "booked": [
      {
        "start": "2022-06-13 09:30:00",
        "end": "2022-06-13 10:20:00",
      },
      {
        "start": "2022-06-13 13:30:00",
        "end": "2022-06-13 14:40:00",
      },
      {
        "start": "2022-06-13 16:10:00",
        "end": "2022-06-13 17:00:00",
      },
      {
        "start": "2022-06-13 17:10:00",
        "end": "2022-06-13 17:50:00",
      },
      {
        "start": "2022-06-13 20:10:00",
        "end": "2022-06-13 20:40:00",
      },
    ],
  },
  {
    "floor": 5,
    "macId": "ssd5hc9b5f",
    "booked": [
      {
        "start": "2022-06-13 09:30:00",
        "end": "2022-06-13 10:20:00",
      },
      {
        "start": "2022-06-13 13:30:00",
        "end": "2022-06-13 14:40:00",
      },
      {
        "start": "2022-06-13 16:10:00",
        "end": "2022-06-13 17:00:00",
      },
      {
        "start": "2022-06-13 17:10:00",
        "end": "2022-06-13 17:50:00",
      },
      {
        "start": "2022-06-13 20:10:00",
        "end": "2022-06-13 20:40:00",
      },
    ],
  },
  {
    "floor": 6,
    "macId": "zsu76h3f5d",
    "booked": [
      {
        "start": "2022-06-13 09:30:00",
        "end": "2022-06-13 10:20:00",
      },
      {
        "start": "2022-06-13 13:30:00",
        "end": "2022-06-13 14:40:00",
      },
      {
        "start": "2022-06-13 16:10:00",
        "end": "2022-06-13 17:00:00",
      },
      {
        "start": "2022-06-13 17:10:00",
        "end": "2022-06-13 17:50:00",
      },
      {
        "start": "2022-06-13 20:10:00",
        "end": "2022-06-13 20:40:00",
      },
    ],
  },
  {
    "floor": 7,
    "macId": "uf8s9d0old",
    "booked": [
      {
        "start": "2022-06-13 09:30:00",
        "end": "2022-06-13 10:20:00",
      },
      {
        "start": "2022-06-13 13:30:00",
        "end": "2022-06-13 14:40:00",
      },
      {
        "start": "2022-06-13 16:10:00",
        "end": "2022-06-13 17:00:00",
      },
      {
        "start": "2022-06-13 17:10:00",
        "end": "2022-06-13 17:50:00",
      },
      {
        "start": "2022-06-13 20:10:00",
        "end": "2022-06-13 20:40:00",
      },
    ],
  },
];

class MainScreenSplash extends StatefulWidget {
  const MainScreenSplash({Key? key}) : super(key: key);

  @override
  State<MainScreenSplash> createState() => MainScreenSplashState();
}

class MainScreenSplashState extends State<MainScreenSplash> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 3000), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Lottie.asset(
            'assets/laundry_animation.json',
            repeat: true,
          ),
        ),
      ),
    );
  }
}
