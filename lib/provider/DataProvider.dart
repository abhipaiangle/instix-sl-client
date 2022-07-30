import 'package:flutter/material.dart';
import 'package:instix_sl_client/classes/WashingMachine.dart';
import 'package:instix_sl_client/classes/user.dart';

import '../classes/Slot.dart';

class DataProvider extends ChangeNotifier {
  late User _user;
  bool _loading = false;
  List<WashingMachine> _machines = [];
  late DateTime _serverTime;

  void startLoading() {
    this._loading = true;
    notifyListeners();
  }

  void stopLoading() {
    this._loading = false;
    notifyListeners();
  }

  void setServerTime(DateTime time) {
    this._serverTime = time;
    notifyListeners();
  }

  void initializeUser(String id, String firstName, String lastName,
      String mobile, String hostel, List<UserSlot> upcomingSlots, List<UserSlot> pastSlots) {
    User user = User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      mobile: mobile,
      hostelNo: hostel,
      upcomingSlots: upcomingSlots,
      pastSlots: pastSlots,
    );
    this._user = user;
  }

  void addMachine(WashingMachine machine) {
    this._machines.add(machine);
    notifyListeners();
  }

  void clearSlot(String macId)
  {
    this._machines.firstWhere((element) => element.mac==macId).bookedSlots.clear();
    notifyListeners();
  }

  void clearUserSlots()
  {
    this._user.upcomingSlots.clear();
  }

  void addSlot(String macId, Slot slot) {
    WashingMachine wm =
        this._machines.firstWhere((element) => element.mac == macId);
    this
        ._machines
        .firstWhere((element) => element.mac == macId)
        .bookedSlots
        .add(slot);
    this
        ._machines
        .firstWhere((element) => element.mac == macId)
        .bookedSlots
        .sort(((a, b) => ((a.start.hour * 60) + a.start.minute)
            .compareTo((b.start.hour * 60) + b.start.minute)));
    /* this._user.bookedSlots.add(UserSlot(
        mac: wm.mac, floor: wm.floor, start: slot.start, end: slot.end)); */
    notifyListeners();
  }

  void addUpcomingUserSlot(UserSlot userSlot){
    this.user.upcomingSlots.add(userSlot);
    this._user.upcomingSlots.sort(((a, b) => (a.start.millisecondsSinceEpoch)
        .compareTo(b.start.millisecondsSinceEpoch)));
    notifyListeners();
  }

  void addPastUserSlot(UserSlot userSlot){
    this.user.pastSlots.add(userSlot);
    this._user.pastSlots.sort(((a, b) => (b.start.millisecondsSinceEpoch)
        .compareTo(a.start.millisecondsSinceEpoch)));
    notifyListeners();
  }

  WashingMachine getMachine(String macId) {
    return this._machines.firstWhere((element) => element.mac == macId);
  }

  void printData() {
    print("Provider data = ${this._machines.last}");
  }

  void printUser() {
    print(
        "USER NAME = ${this._user.firstName} ${this._user.lastName}, MOBILE = ${this._user.mobile}, ID = ${this._user.id}, HOSTEL = ${this._user.hostelNo}");
  }

  List<WashingMachine> get machines => _machines;
  User get user => _user;
  bool get loading => _loading;
  DateTime get serverTime => _serverTime;
}
