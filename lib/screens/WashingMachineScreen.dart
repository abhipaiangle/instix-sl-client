import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:instix_sl_client/constants.dart';
import 'package:numberpicker/numberpicker.dart';

class WMbusyState extends StatefulWidget {
  List<dynamic> bookedSlots;
  int floor;
  String macId;
  WMbusyState({
    Key? key,
    required this.macId,
    required this.floor,
    required this.bookedSlots,
  }) : super(key: key);

  @override
  State<WMbusyState> createState() => _WMbusyStateState();
}

class _WMbusyStateState extends State<WMbusyState> {
  List<int> hrs = List.generate(24, (index) => index);
  List<int> mins = List.generate(6, (index) => index * 10);
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  bool conflict = false;
  int startHrsIndex = 0;
  int startMinsIndex = 0;
  int endHrsIndex = 0;
  int endMinsIndex = 0;
  int _currentValue = 0;

  void reflectConflict() {
    setState(() {
      conflict = false;
    });
    for (int i = 0; i < widget.bookedSlots.length; i++) {
      DateTime SLOT_START = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          DateTime.parse(widget.bookedSlots[i]["start"]).hour,
          DateTime.parse(widget.bookedSlots[i]["start"]).minute);
      DateTime SLOT_END = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          DateTime.parse(widget.bookedSlots[i]["end"]).hour,
          DateTime.parse(widget.bookedSlots[i]["end"]).minute);
      if (SLOT_START.millisecondsSinceEpoch >= start.millisecondsSinceEpoch) {
        if (SLOT_START.millisecondsSinceEpoch < end.millisecondsSinceEpoch) {
          setState(() {
            conflict = true;
          });
          break;
        } else {
          continue;
        }
      }
      if (SLOT_END.millisecondsSinceEpoch > start.millisecondsSinceEpoch) {
        if (SLOT_END.millisecondsSinceEpoch <= end.millisecondsSinceEpoch) {
          setState(() {
            conflict = true;
          });
          break;
        } else {
          continue;
        }
      }
    }
    print("CONFLICT = $conflict");
  }

  @override
  void initState() {
    print("BOOKED SLOTS = ${widget.bookedSlots}");
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
            Container(
              margin: EdgeInsets.only(
                left: 28,
              ),
              child: Text(
                "Floor ${widget.floor}",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 30,
              ),
              child: Text(
                "Washing Machine",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, top: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Today's Booked Slots",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    widget.bookedSlots.length,
                    (index) => SlotBox(
                      slotStart: widget.bookedSlots[index]["start"],
                      slotEnd: widget.bookedSlots[index]["end"],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 30,
                      top: 15,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Book a slot",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 30,
                      top: 15,
                      bottom: 20,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Slot Start Time",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DirectSelect(
                            itemMagnification: 1,
                            mode: DirectSelectMode.tap,
                            selectionColor: Colors.blue.withOpacity(0.25),
                            itemExtent: 100.0,
                            selectedIndex: startHrsIndex,
                            child: Container(
                              child: Text(
                                hrs[startHrsIndex].toString(),
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            onSelectedItemChanged: (index) {
                              setState(
                                () {
                                  startHrsIndex = index!;
                                  start = DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                      hrs[startHrsIndex],
                                      mins[startMinsIndex]);
                                },
                              );
                              reflectConflict();
                            },
                            items: List.generate(
                              hrs.length,
                              (index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 40),
                                child: Text(
                                  hrs[index].toString(),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 15, top: 15),
                            alignment: Alignment.center,
                            child: Text(
                              "Hours",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DirectSelect(
                            itemMagnification: 1,
                            mode: DirectSelectMode.tap,
                            selectionColor: Colors.blue.withOpacity(0.25),
                            itemExtent: 100.0,
                            selectedIndex: startMinsIndex,
                            child: Container(
                              child: Text(
                                mins[startMinsIndex].toString(),
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                startMinsIndex = index!;
                                start = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    hrs[startHrsIndex],
                                    mins[startMinsIndex]);
                              });
                              reflectConflict();
                            },
                            items: List.generate(
                              mins.length,
                              (index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 40),
                                child: Text(
                                  mins[index].toString(),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 15, top: 15),
                            alignment: Alignment.center,
                            child: Text(
                              "Minutes",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 30,
                      top: 15,
                      bottom: 20,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Slot End Time",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DirectSelect(
                            itemMagnification: 1,
                            mode: DirectSelectMode.tap,
                            selectionColor: Colors.blue.withOpacity(0.25),
                            itemExtent: 100.0,
                            selectedIndex: endHrsIndex,
                            child: Container(
                              child: Text(
                                hrs[endHrsIndex].toString(),
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                endHrsIndex = index!;
                                end = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    hrs[endHrsIndex],
                                    mins[endMinsIndex]);
                              });
                              reflectConflict();
                            },
                            items: List.generate(
                              hrs.length,
                              (index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 40),
                                child: Text(
                                  hrs[index].toString(),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 15, top: 15),
                            alignment: Alignment.center,
                            child: Text(
                              "Hours",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DirectSelect(
                            itemMagnification: 1,
                            mode: DirectSelectMode.tap,
                            selectionColor: Colors.blue.withOpacity(0.25),
                            itemExtent: 100.0,
                            selectedIndex: startMinsIndex,
                            child: Container(
                              child: Text(
                                mins[endMinsIndex].toString(),
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                endMinsIndex = index!;
                                end = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    hrs[endHrsIndex],
                                    mins[endMinsIndex]);
                              });
                              reflectConflict();
                            },
                            items: List.generate(
                              mins.length,
                              (index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 40),
                                child: Text(
                                  mins[index].toString(),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 15, top: 15),
                            alignment: Alignment.center,
                            child: Text(
                              "Minutes",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    child: Text(
                      "${DateFormat.jm().format(start)} - ${DateFormat.jm().format(end)}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  /* Container(
                    margin: EdgeInsets.only(
                      top: 15,
                      left: 45,
                      right: 45,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          color: Colors.red,
                        ),
                        Text(
                          "Conflicts in slot",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ), */
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: RawMaterialButton(
                onPressed: (conflict) ? null : () {},
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius,
                  ),
                ),
                fillColor: (conflict) ? Colors.red : Colors.blue,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: AnimatedSwitcher(
                    duration: Duration(
                      milliseconds: 250,
                    ),
                    child: (!conflict)
                        ? Text(
                            "Book slot",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline_outlined,
                                color: Colors.white,
                              ),
                              Container(
                                width: 10,
                              ),
                              Text(
                                "Slot Conflict",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                  ),
                ),
              ),
            )
            /* Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(borderRadius * 3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  Container(
                    child: Text(
                      "Currently booked in this slot",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Text(
                                "Slot Details",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.person_rounded,
                                color: Colors.blue,
                                size: 36,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 25),
                              child: Text(
                                "Himanshu Choudhary",
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.schedule_rounded,
                                color: Colors.blue,
                                size: 36,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 25),
                              child: Text(
                                "13:15 to 14:00 hrs",
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.call_rounded,
                                color: Colors.blue,
                                size: 36,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 25),
                              child: Text(
                                "+91 98765 43210",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, top: 15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Slot Details",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 90),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Icon(
                            Icons.schedule_rounded,
                            color: Colors.blue,
                            size: 36,
                          ),
                        ),
                        Container(
                          width: 12,
                        ),
                        Container(
                          child: Text(
                            "13:15 to 14:00 hrs",
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 90),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Icon(
                            Icons.timelapse,
                            color: Colors.blue,
                            size: 36,
                          ),
                        ),
                        Container(
                          width: 12,
                        ),
                        Container(
                          child: Text(
                            "45 minutes",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: RawMaterialButton(
                      onPressed: () {},
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      fillColor: Colors.blue,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(
                          "Book this slot",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ), */
          ],
        ),
      ),
    );
  }
}

/* class WMFreeState extends StatefulWidget {
  const WMFreeState({Key? key}) : super(key: key);

  @override
  State<WMFreeState> createState() => _WMFreeStateState();
}

class _WMFreeStateState extends State<WMFreeState> {
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
            Container(
              margin: EdgeInsets.only(
                left: 28,
              ),
              child: Text(
                "Floor 4",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 30,
              ),
              child: Text(
                "Washing Machine",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /* Icon(
                      Icons.local_laundry_service_rounded,
                      size: 300,
                      color: Colors.blue,
                    ), */
                    Container(
                      margin: EdgeInsets.only(left: 30, top: 25),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "All Slots",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            10,
                            (index) => SlotBox(
                              busy: (index % 2 != 0) ? false : true,
                              slotStart: DateTime.now()
                                  .add(Duration(minutes: (45 * index))),
                              slotEnd: DateTime.now()
                                  .add(Duration(minutes: (45 * index) + 5)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} */

class SlotBox extends StatefulWidget {
  String slotStart;
  String slotEnd;
  SlotBox({
    Key? key,
    required this.slotStart,
    required this.slotEnd,
  }) : super(key: key);

  @override
  State<SlotBox> createState() => _SlotBoxState();
}

class _SlotBoxState extends State<SlotBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.orange,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // "${DateFormat("hh:mm a").format(widget.slotStart)} - ${DateFormat("hh:mm a").format(widget.slotEnd)}",
            "${DateFormat.jm().format(DateTime.parse(widget.slotStart))} - ${DateFormat.jm().format(DateTime.parse(widget.slotEnd))}",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
