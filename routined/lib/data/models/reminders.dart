// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class Reminders {
  int? id;

  @HiveField(0)
  String title;

  @HiveField(1)
  bool isDone;

  @HiveField(2)
  String description;


  @HiveField(4)
  VoidCallbackAction action;

  Reminders({
    this.id,
    required this.title,
    this.isDone = false,
    this.description = '',
    required this.action,
  });
}
