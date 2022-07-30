import 'package:flutter/material.dart';

class Slot {
  String id = "";
  DateTime start;
  DateTime end;
  Slot({
    this.id = "",
    required this.start,
    required this.end,
  });
}
