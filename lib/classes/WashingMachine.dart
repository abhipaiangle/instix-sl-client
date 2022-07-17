import 'package:instix_sl_client/classes/Slot.dart';

class WashingMachine {
  String floor;
  String wing;
  String mac;
  List<Slot> bookedSlots;
  WashingMachine({
    required this.floor,
    required this.mac,
    required this.wing,
    required this.bookedSlots,
  });
}
