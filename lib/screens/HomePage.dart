import 'package:flutter/material.dart';
import 'package:instix_sl_client/screens/ProfileScreen.dart';
import 'package:instix_sl_client/screens/WashingMachineScreen.dart';
import 'package:provider/provider.dart';

import '../classes/WashingMachine.dart';
import '../constants.dart';
import '../provider/DataProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  void initState() {
    machines.forEach((element) {
      Provider.of<DataProvider>(context, listen: false).addMachine(
          WashingMachine(
              floor: element["floor"], mac: element["macId"], bookedSlots: []));
    });
    Provider.of<DataProvider>(context, listen: false).printData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        "Smart Laundry",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 32,
                      ),
                      child: Text(
                        "Hostel 15",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.person_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 25,
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      machines.length,
                      (index) => WashingMachineTile(
                        index: machines[index]['floor'],
                        bookedSlots: machines[index]["booked"],
                        macId: machines[index]["macId"],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            /* Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius,
                  ),
                ),
                fillColor: Colors.blue,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Proceed",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ) */
          ],
        ),
      ),
    );
  }
}

class WashingMachineTile extends StatefulWidget {
  int index;
  List<dynamic> bookedSlots;
  String macId;
  WashingMachineTile({
    Key? key,
    required this.macId,
    required this.bookedSlots,
    required this.index,
  }) : super(key: key);

  @override
  State<WashingMachineTile> createState() => _WashingMachineTileState();
}

class _WashingMachineTileState extends State<WashingMachineTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WMbusyState(
                macId: widget.macId,
                floor: widget.index,
                bookedSlots: widget.bookedSlots,
              ),
            ),
          );
          /* if (widget.busy) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WMbusyState()));
          }
          if (!widget.busy) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WMFreeState()));
          } */
        },
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.blue.withOpacity(0.25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Washing Machine",
                      style: TextStyle(fontSize: 20),
                      softWrap: true,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Floor ${widget.index}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.local_laundry_service_rounded,
                    color: Colors.blue,
                    size: 100,
                  ),
                  /* Container(
                    decoration: BoxDecoration(
                      color: (widget.busy) ? Colors.orange : Colors.green,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Text(
                      (widget.busy) ? "BUSY" : "FREE",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ), */
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
