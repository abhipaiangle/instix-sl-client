import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:instix_sl_client/APIs/APIFunctions.dart';
import 'package:instix_sl_client/classes/user.dart';
import 'package:instix_sl_client/constants.dart';
import 'package:instix_sl_client/provider/DataProvider.dart';
import 'package:instix_sl_client/screens/LoginSSO.dart';
import 'package:instix_sl_client/screens/LoginSignupScreen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../classes/Slot.dart';

int tabSelection = 1;
bool slotsLoaded = false;
late DateTime serverTime;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  void fetchUserData() async {
    setState(() {
      slotsLoaded = false;
    });
    await getUserSlots(context);
    await Future.delayed(Duration(milliseconds: 2500));
    setState(() {
      slotsLoaded = true;
    });
  }

  @override
  void initState() {
    setState(() {
      slotsLoaded = false;
    });
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<DataProvider>(
          builder: ((context, provider, child) {
            return Column(
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
                        PROFILE,
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
                              child: Text(SIGNOUT),
                            ),
                            onTap: () async {},
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
                  child: /* FadeShimmer.round(
                    size: MediaQuery.of(context).size.width / 2,
                    fadeTheme: FadeTheme.light,
                    baseColor: Color(0xffE6E8EB),
                  ), */
                      CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 4,
                    backgroundColor: Colors.blue.withOpacity(0.25),
                    child: Icon(
                      Icons.person_rounded,
                      color: Colors.blue,
                      size: MediaQuery.of(context).size.width / 3,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${provider.user.firstName} ${provider.user.lastName}",
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
                    "$HOSTEL ${provider.user.hostelNo}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 5,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    provider.user.mobile,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    // left: 30,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    YOUR_BOOKINGS,
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
                        UPCOMING,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      2: Text(
                        PAST,
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
                          child: (slotsLoaded)
                              ? (tabSelection == 1)
                                  ? Column(
                                      key: Key("0"),
                                      children: List.generate(
                                          provider.user.upcomingSlots.length,
                                          (index) {
                                        print(provider.serverTime
                                            .difference(provider
                                                .user.upcomingSlots[index].start)
                                            .inMinutes);
                                        return UpcomingBooking(
                                          slot:
                                              provider.user.upcomingSlots[index],
                                          enabled: provider.user
                                                      .upcomingSlots[index].start
                                                  .difference(provider.serverTime)
                                                  .inMinutes <=
                                              10,
                                        );
                                      }),
                                    )
                                  : Column(
                                      key: Key("1"),
                                      children: List.generate(
                                          provider.user.pastSlots.length,
                                          (index) => PastBooking(slot: provider.user.pastSlots[index],)),
                                    )
                              : Column(
                                  key: Key("2"),
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: FadeShimmer(
                                        height: 60,
                                        width: 150,
                                        radius: borderRadius,
                                        highlightColor: Color(0xffF9F9FB),
                                        baseColor: Color(0xffE6E8EB),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: FadeShimmer(
                                        height: 60,
                                        width: 150,
                                        millisecondsDelay: 150,
                                        radius: borderRadius,
                                        highlightColor: Color(0xffF9F9FB),
                                        baseColor: Color(0xffE6E8EB),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: FadeShimmer(
                                        height: 60,
                                        width: 150,
                                        millisecondsDelay: 300,
                                        radius: borderRadius,
                                        highlightColor: Color(0xffF9F9FB),
                                        baseColor: Color(0xffE6E8EB),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

class UpcomingBooking extends StatefulWidget {
  UserSlot slot;
  bool enabled;
  UpcomingBooking({
    Key? key,
    required this.slot,
    required this.enabled,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${widget.slot.floor}", style: TextStyle(fontSize: 16)),
              Text(
                FLOOR,
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${widget.slot.wing}", style: TextStyle(fontSize: 16)),
              Text(
                WING,
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
          Text(
            DateFormat('yyyy-MM-dd – kk:mm').format(widget.slot.start),
            textAlign: TextAlign.center,
          ),
          RawMaterialButton(
            onPressed: () {},
            elevation: 0,
            fillColor: (widget.enabled) ? Colors.green : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Container(
              child: Text(
                ACTIVATE,
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
  UserSlot slot;
  PastBooking({
    Key? key,
    required this.slot,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.slot.floor, style: TextStyle(fontSize: 18)),
              Text(
                FLOOR,
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.slot.wing, style: TextStyle(fontSize: 18)),
              Text(
                WING,
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          Text(
            DateFormat("dd MMM yyyy\nhh:mm a").format(widget.slot.start),
            textAlign: TextAlign.center,
          ),
          Text(
            DateFormat("dd MMM yyyy\nhh:mm a").format(widget.slot.end),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
