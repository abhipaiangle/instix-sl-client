import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:instix_sl_client/classes/WashingMachine.dart';
import 'package:instix_sl_client/provider/DataProvider.dart';
import 'package:intl/intl.dart';
import 'package:instix_sl_client/constants.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../classes/Slot.dart';

class WMScreen extends StatefulWidget {
  String macId;
  WMScreen({
    Key? key,
    required this.macId,
  }) : super(key: key);

  @override
  State<WMScreen> createState() => _WMScreenState();
}

class _WMScreenState extends State<WMScreen> {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<DataProvider>(builder: (context, value, child) {
          WashingMachine machine = value.getMachine(widget.macId);
          return Column(
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
                  "$FLOOR ${machine.floor}",
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
                  WASHING_MACHINE,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, top: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  TODAY_BOOKED_SLOTS,
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
                      machine.bookedSlots.length,
                      (index) => SlotBox(
                        slotStart: machine.bookedSlots[index].start,
                        slotEnd: machine.bookedSlots[index].end,
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
                        BOOK_SLOT,
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
                        SLOT_START_TIME,
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
                                // reflectConflict();
                                setState(() {
                                  conflict = false;
                                });
                                for (int i = 0;
                                    i < machine.bookedSlots.length;
                                    i++) {
                                  DateTime SLOT_START = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    machine.bookedSlots[i].start.hour,
                                    machine.bookedSlots[i].start.minute,
                                  );
                                  DateTime SLOT_END = DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                      machine.bookedSlots[i].end.hour,
                                      machine.bookedSlots[i].end.minute);
                                  if (SLOT_START.millisecondsSinceEpoch >=
                                      start.millisecondsSinceEpoch) {
                                    if (SLOT_START.millisecondsSinceEpoch <
                                        end.millisecondsSinceEpoch) {
                                      setState(() {
                                        conflict = true;
                                      });
                                      break;
                                    } else {
                                      continue;
                                    }
                                  }
                                  if (SLOT_END.millisecondsSinceEpoch >
                                      start.millisecondsSinceEpoch) {
                                    if (SLOT_END.millisecondsSinceEpoch <=
                                        end.millisecondsSinceEpoch) {
                                      setState(() {
                                        conflict = true;
                                      });
                                      break;
                                    } else {
                                      continue;
                                    }
                                  }
                                }
                                print("$CONFLICT = $conflict");
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
                                HOURS,
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
                                // reflectConflict();
                                setState(() {
                                  conflict = false;
                                });
                                for (int i = 0;
                                    i < machine.bookedSlots.length;
                                    i++) {
                                  DateTime SLOT_START = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    machine.bookedSlots[i].start.hour,
                                    machine.bookedSlots[i].start.minute,
                                  );
                                  DateTime SLOT_END = DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                      machine.bookedSlots[i].end.hour,
                                      machine.bookedSlots[i].end.minute);
                                  if (SLOT_START.millisecondsSinceEpoch >=
                                      start.millisecondsSinceEpoch) {
                                    if (SLOT_START.millisecondsSinceEpoch <
                                        end.millisecondsSinceEpoch) {
                                      setState(() {
                                        conflict = true;
                                      });
                                      break;
                                    } else {
                                      continue;
                                    }
                                  }
                                  if (SLOT_END.millisecondsSinceEpoch >
                                      start.millisecondsSinceEpoch) {
                                    if (SLOT_END.millisecondsSinceEpoch <=
                                        end.millisecondsSinceEpoch) {
                                      setState(() {
                                        conflict = true;
                                      });
                                      break;
                                    } else {
                                      continue;
                                    }
                                  }
                                }
                                print("$CONFLICT = $conflict");
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
                                MINUTES,
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
                        SLOT_END_TIME,
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
                                // reflectConflict();
                                setState(() {
                                  conflict = false;
                                });
                                for (int i = 0;
                                    i < machine.bookedSlots.length;
                                    i++) {
                                  DateTime SLOT_START = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    machine.bookedSlots[i].start.hour,
                                    machine.bookedSlots[i].start.minute,
                                  );
                                  DateTime SLOT_END = DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                      machine.bookedSlots[i].end.hour,
                                      machine.bookedSlots[i].end.minute);
                                  if (SLOT_START.millisecondsSinceEpoch >=
                                      start.millisecondsSinceEpoch) {
                                    if (SLOT_START.millisecondsSinceEpoch <
                                        end.millisecondsSinceEpoch) {
                                      setState(() {
                                        conflict = true;
                                      });
                                      break;
                                    } else {
                                      continue;
                                    }
                                  }
                                  if (SLOT_END.millisecondsSinceEpoch >
                                      start.millisecondsSinceEpoch) {
                                    if (SLOT_END.millisecondsSinceEpoch <=
                                        end.millisecondsSinceEpoch) {
                                      setState(() {
                                        conflict = true;
                                      });
                                      break;
                                    } else {
                                      continue;
                                    }
                                  }
                                }
                                print("$CONFLICT = $conflict");
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
                                HOURS,
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
                                // reflectConflict();
                                setState(() {
                                  conflict = false;
                                });
                                for (int i = 0;
                                    i < machine.bookedSlots.length;
                                    i++) {
                                  DateTime SLOT_START = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    machine.bookedSlots[i].start.hour,
                                    machine.bookedSlots[i].start.minute,
                                  );
                                  DateTime SLOT_END = DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                      machine.bookedSlots[i].end.hour,
                                      machine.bookedSlots[i].end.minute);
                                  if (SLOT_START.millisecondsSinceEpoch >=
                                      start.millisecondsSinceEpoch) {
                                    if (SLOT_START.millisecondsSinceEpoch <
                                        end.millisecondsSinceEpoch) {
                                      setState(() {
                                        conflict = true;
                                      });
                                      break;
                                    } else {
                                      continue;
                                    }
                                  }
                                  if (SLOT_END.millisecondsSinceEpoch >
                                      start.millisecondsSinceEpoch) {
                                    if (SLOT_END.millisecondsSinceEpoch <=
                                        end.millisecondsSinceEpoch) {
                                      setState(() {
                                        conflict = true;
                                      });
                                      break;
                                    } else {
                                      continue;
                                    }
                                  }
                                }
                                print("$CONFLICT = $conflict");
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
                                MINUTES,
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
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: RawMaterialButton(
                  onPressed: (conflict)
                      ? null
                      : () {
                          Provider.of<DataProvider>(context, listen: false)
                              .addSlot(
                                  widget.macId,
                                  Slot(
                                      start:
                                          TimeOfDay(
                                              hour: hrs[startHrsIndex],
                                              minute: mins[startMinsIndex]),
                                      end: TimeOfDay(
                                          hour: hrs[endHrsIndex],
                                          minute: mins[endMinsIndex])));
                        },
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
                              BOOK_SLOT_BTN,
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
                                  SLOT_CONFLICT,
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
            ],
          );
        }),
      ),
    );
  }
}

class SlotBox extends StatefulWidget {
  TimeOfDay slotStart;
  TimeOfDay slotEnd;
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
            "${widget.slotStart.format(context)} - ${widget.slotEnd.format(context)}",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
