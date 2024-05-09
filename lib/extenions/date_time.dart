import 'package:flutter/material.dart';

extension DateTimeExtensions on DateTime {
  DateTime get date => DateUtils.dateOnly(this);
}
