import 'package:flutter/material.dart';

class Slot {
  String id = "";
  TimeOfDay start;
  TimeOfDay end;
  Slot({
    this.id = "",
    required this.start,
    required this.end,
  });
}
