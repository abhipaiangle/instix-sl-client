import 'package:instix_sl_client/classes/Slot.dart';

class WashingMachine {
  int floor;
  String mac;
  List<Slot> bookedSlots;
  WashingMachine({
    required this.floor,
    required this.mac,
    required this.bookedSlots,
  });
}
