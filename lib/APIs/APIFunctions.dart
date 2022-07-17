import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:instix_sl_client/APIs/APIConstants.dart';
import 'package:instix_sl_client/classes/WashingMachine.dart';
import 'package:instix_sl_client/provider/DataProvider.dart';
import 'package:provider/provider.dart';

Future<Response> fetchMachines(BuildContext context, String hostel_no) async {
  Response response = await get(
    Uri.parse(BASE_URL + LIST_MACHINES_URL + hostel_no),
  );
  return response;
}
