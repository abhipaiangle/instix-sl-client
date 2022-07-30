import 'package:flutter/material.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String mobile;
  String hostelNo;
  List<UserSlot> upcomingSlots;
  List<UserSlot> pastSlots;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.hostelNo,
    required this.upcomingSlots,
    required this.pastSlots,
  });
}

class UserSlot {
  String mac;
  String hostel;
  String wing;
  String floor;
  DateTime start;
  DateTime end;
  UserSlot({
    required this.mac,
    required this.hostel,
    required this.wing,
    required this.floor,
    required this.start,
    required this.end,
  });
}
