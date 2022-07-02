import 'package:flutter/material.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String mobile;
  String hostelNo;
  List<UserSlot> bookedSlots;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.hostelNo,
    required this.bookedSlots,
  });
}

class UserSlot {
  String mac;
  String floor;
  TimeOfDay start;
  TimeOfDay end;
  UserSlot({
    required this.mac,
    required this.floor,
    required this.start,
    required this.end,
  });
}
