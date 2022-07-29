import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:instix_sl_client/APIs/APIConstants.dart';
import 'package:instix_sl_client/classes/Slot.dart';
import 'package:instix_sl_client/classes/WashingMachine.dart';
import 'package:instix_sl_client/provider/DataProvider.dart';
import 'package:provider/provider.dart';

Future<void> fetchMachines(BuildContext context, String hostel_no) async {
  Response response = await get(
    Uri.parse(BASE_URL + LIST_MACHINES_URL + hostel_no),
  );
  print(response.body);
  var jsonResponse = json.decode(response.body);
  (jsonResponse as List).forEach((element) {
    Provider.of<DataProvider>(context, listen: false).addMachine(WashingMachine(
      floor: element["floor"],
      mac: element["mac_address"],
      wing: element["wing"],
      bookedSlots: [],
    ));
  });
}

Future<void> fetchMachineSlots(BuildContext context, String mac) async {
  Map<String, String> data = {"mac": "1234"};
  Response response = await get(
    Uri.parse(BASE_URL + GET_MACHINE_SLOTS + mac),
  );
  var jsonResponse = json.decode(response.body);
  Provider.of<DataProvider>(context, listen: false).clearSlot(mac);
  (jsonResponse as List).forEach((element) {
    Provider.of<DataProvider>(context, listen: false).addSlot(
        mac,
        Slot(
          start: TimeOfDay.fromDateTime(DateTime.parse(element["start_time"])),
          end: TimeOfDay.fromDateTime(DateTime.parse(element["end_time"])),
        ));
  });
}
