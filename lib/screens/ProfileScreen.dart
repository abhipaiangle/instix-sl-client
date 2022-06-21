import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:instix_sl_client/constants.dart';
import 'package:instix_sl_client/screens/LoginSSO.dart';
import 'package:instix_sl_client/screens/LoginSignupScreen.dart';
import 'package:intl/intl.dart';

int tabSelection = 1;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
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
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 30,
                  ),
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius)),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Container(
                          child: Text("Sign out"),
                        ),
                        onTap: () async {
                          var box = await Hive.openBox(AUTH_DATA);
                          await box.deleteFromDisk();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginSSO()),
                              (route) => false);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 15,
            ),
            Center(
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width / 3.2,
                backgroundColor: Colors.blue.withOpacity(0.25),
                child: Icon(
                  Icons.person_rounded,
                  color: Colors.blue,
                  size: MediaQuery.of(context).size.width / 2.4,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
              ),
              alignment: Alignment.center,
              child: Text(
                "Himanshu Choudhary",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5,
              ),
              alignment: Alignment.center,
              child: Text(
                "Hostel 15",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 15,
                // left: 30,
              ),
              alignment: Alignment.center,
              child: Text(
                "Your Bookings",
                style: TextStyle(
                  fontSize: subHeadingTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              alignment: Alignment.center,
              child: CustomSlidingSegmentedControl(
                fixedWidth: MediaQuery.of(context).size.width / 2.5,
                children: {
                  1: Text(
                    'Upcoming',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  2: Text(
                    'Past',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                },
                onValueChanged: (value) {
                  print(value);
                  setState(() {
                    tabSelection = int.parse(value.toString());
                  });
                },
                initialValue: 1,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(15),
                ),
                thumbDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: Offset(
                        0.0,
                        2.0,
                      ),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 300),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: (tabSelection == 1)
                          ? Column(
                              children: List.generate(
                                8,
                                (index) => (index == 0)
                                    ? UpcomingBooking(
                                        floor: index + 1,
                                        activated: true,
                                        slotStart: DateTime.now(),
                                      )
                                    : UpcomingBooking(
                                        floor: index + 1,
                                        activated: false,
                                        slotStart: DateTime.now()
                                            .add(Duration(hours: 8 * index)),
                                      ),
                              ),
                            )
                          : Column(
                              children: List.generate(
                                  8,
                                  (index) => PastBooking(
                                      slotStart: DateTime.now()
                                          .add(Duration(hours: 8 * index)),
                                      slotEnd: DateTime.now().add(
                                          Duration(hours: (8 * index) + 2)))),
                            ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UpcomingBooking extends StatefulWidget {
  bool activated;
  int floor;
  DateTime slotStart;
  UpcomingBooking({
    Key? key,
    required this.activated,
    required this.slotStart,
    required this.floor,
  }) : super(key: key);

  @override
  State<UpcomingBooking> createState() => _UpcomingBookingState();
}

class _UpcomingBookingState extends State<UpcomingBooking> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.25),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${widget.floor}", style: TextStyle(fontSize: 18)),
              Text(
                "FLOOR",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          Text(
            DateFormat("dd MMM yyyy\nhh:mm a").format(widget.slotStart),
            textAlign: TextAlign.center,
          ),
          RawMaterialButton(
            onPressed: () {},
            elevation: 0,
            fillColor: (widget.activated) ? Colors.green : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Container(
              child: Text(
                "Activate",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PastBooking extends StatefulWidget {
  DateTime slotStart;
  DateTime slotEnd;
  PastBooking({
    Key? key,
    required this.slotStart,
    required this.slotEnd,
  }) : super(key: key);

  @override
  State<PastBooking> createState() => _PastBookingState();
}

class _PastBookingState extends State<PastBooking> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.25),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("8", style: TextStyle(fontSize: 18)),
              Text(
                "FLOOR",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          Text(
            DateFormat("dd MMM yyyy\nhh:mm a").format(widget.slotStart),
            textAlign: TextAlign.center,
          ),
          Text(
            DateFormat("dd MMM yyyy\nhh:mm a").format(widget.slotEnd),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
