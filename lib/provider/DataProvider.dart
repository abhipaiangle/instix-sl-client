import 'package:flutter/material.dart';
import 'package:instix_sl_client/classes/WashingMachine.dart';

class DataProvider extends ChangeNotifier {
  List<WashingMachine> _machines = [];

  void addMachine(WashingMachine machine) {
    this._machines.add(machine);
    notifyListeners();
  }

  void printData() {
    print("Provider data = ${this._machines}");
  }

  List<WashingMachine> get machines => _machines;
}
