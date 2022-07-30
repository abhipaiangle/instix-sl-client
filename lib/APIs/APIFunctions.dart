import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:instix_sl_client/APIs/APIConstants.dart';
import 'package:instix_sl_client/classes/Slot.dart';
import 'package:instix_sl_client/classes/WashingMachine.dart';
import 'package:instix_sl_client/classes/user.dart';
import 'package:instix_sl_client/provider/DataProvider.dart';
import 'package:provider/provider.dart';

Future<void> fetchMachines(BuildContext context, String hostel_no) async {
  Response response = await get(
    Uri.parse(BASE_URL + LIST_MACHINES_URL + hostel_no),
  );
  print(response.body);
  dynamic jsonResponse = json.decode(response.body);
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
  Response response = await get(
    Uri.parse(BASE_URL + GET_MACHINE_SLOTS + mac),
  );
  dynamic jsonResponse = json.decode(response.body);
  Provider.of<DataProvider>(context, listen: false).clearSlot(mac);
  (jsonResponse as List).forEach((element) {
    Provider.of<DataProvider>(context, listen: false).addSlot(
        mac,
        Slot(
          start: DateTime.parse(element["start_time"]),
          end: DateTime.parse(element["end_time"]),
        ));
  });
}

Future<void> getServerTime(BuildContext context) async {
  Response response = await get(
    Uri.parse(BASE_URL + TIME),
  );
  dynamic jsonResponse = json.decode(response.body);
  Provider.of<DataProvider>(context, listen: false)
      .setServerTime(DateTime.parse(jsonResponse["time"]));
}

Future<void> getUserSlots(BuildContext context) async {
  Provider.of<DataProvider>(context, listen: false).clearUserSlots();
  await getServerTime(context);
  String userId = Provider.of<DataProvider>(context, listen: false).user.id;
  Response response = await get(
    Uri.parse(BASE_URL + GET_USER_SLOTS + userId),
  );
  dynamic jsonResponse = json.decode(response.body);
  (jsonResponse as List).forEach((element) async {
    Response machineDetailsResponse = await get(
      Uri.parse(BASE_URL + GET_MACHINE_DETAILS + element["mac"]),
    );
    dynamic machineDetails = json.decode(machineDetailsResponse.body);
    print("Server Time = ${Provider.of<DataProvider>(context, listen: false)
            .serverTime.millisecondsSinceEpoch} and Slot Time = ${DateTime.parse(element["start_time"]).millisecondsSinceEpoch}");
    UserSlot userSlot = UserSlot(
        mac: element["mac"],
        hostel: machineDetails["hostel"].toString(),
        wing: machineDetails["wing"],
        floor: machineDetails["floor"].toString(),
        start: DateTime.parse(element["start_time"]),
        end: DateTime.parse(element["end_time"]));
    if (Provider.of<DataProvider>(context, listen: false)
            .serverTime
            .millisecondsSinceEpoch <=
        DateTime.parse(element["start_time"]).millisecondsSinceEpoch) {
      Provider.of<DataProvider>(context, listen: false)
          .addUpcomingUserSlot(userSlot);
    } else {
      Provider.of<DataProvider>(context, listen: false)
          .addPastUserSlot(userSlot);
    }
  });
}
