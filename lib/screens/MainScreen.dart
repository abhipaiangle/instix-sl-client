import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:instix_sl_client/classes/Slot.dart';
import 'package:instix_sl_client/classes/WashingMachine.dart';
import 'package:instix_sl_client/constants.dart';
import 'package:instix_sl_client/provider/DataProvider.dart';
import 'package:instix_sl_client/screens/HomePage.dart';
import 'package:instix_sl_client/screens/LoginSSO.dart';
import 'package:instix_sl_client/screens/LoginSignupScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

Map<dynamic, dynamic> user = {
  "id": "200020059",
  "first_name": "Himanshu",
  "last_name": "Choudhary",
  "mobile": "+91 79760 73886",
  "hostel": "16",
};

List<dynamic> machines = [
  {
    "floor": "1",
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
    "floor": "2",
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
    "floor": "3",
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
    "floor": "4",
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
    "floor": "5",
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
    "floor": "6",
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
    "floor": "7",
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
  void initialLoading() async {
    await Future.delayed(Duration(milliseconds: 1000), () async {
      for (int i = 0; i < machines.length; i++) {
        List<Slot> slots = [];
        for (int j = 0; j < machines[i]["booked"].length; j++) {
          slots.add(Slot(
              start: DateTime.parse(machines[i]["booked"][j]["start"]),
              end: DateTime.parse(machines[i]["booked"][j]["end"])));
        }
        slots.sort(((a, b) => ((a.start.hour * 60) + a.start.minute)
            .compareTo((b.start.hour * 60) + b.start.minute)));
      }
      Provider.of<DataProvider>(context, listen: false).initializeUser(
        user["id"],
        user["first_name"],
        user["last_name"],
        user["mobile"],
        user["hostel"],
        [],
        [],
      );
    });
    Provider.of<DataProvider>(context, listen: false).printUser();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }

  @override
  void initState() {
    initialLoading();
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
