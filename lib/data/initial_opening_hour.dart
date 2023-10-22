import 'package:flutter/material.dart';
import 'package:glamourmebusiness/models/salon_model.dart';
import 'package:glamourmebusiness/screens/business_create_screen4.dart';

List<OpeningHoursDataModel> openingHoursInitialData = [
  OpeningHoursDataModel(
    day: 'Monday',
    openingTime: const TimeOfDay(hour: 8, minute: 30),
    closingTime: const TimeOfDay(hour: 17, minute: 30),
    isOpen: true,
  ),
  OpeningHoursDataModel(
    day: 'Tuesday',
    openingTime: const TimeOfDay(hour: 8, minute: 30),
    closingTime: const TimeOfDay(hour: 17, minute: 30),
    isOpen: true,
  ),
  OpeningHoursDataModel(
    day: 'Wednesday',
    openingTime: const TimeOfDay(hour: 8, minute: 30),
    closingTime: const TimeOfDay(hour: 17, minute: 30),
    isOpen: true,
  ),
  OpeningHoursDataModel(
    day: 'Thursday',
    openingTime: const TimeOfDay(hour: 8, minute: 30),
    closingTime: const TimeOfDay(hour: 17, minute: 30),
    isOpen: true,
  ),
  OpeningHoursDataModel(
    day: 'Friday',
    openingTime: const TimeOfDay(hour: 8, minute: 30),
    closingTime: const TimeOfDay(hour: 17, minute: 30),
    isOpen: true,
  ),
  OpeningHoursDataModel(
    day: 'Saturday',
    openingTime: const TimeOfDay(hour: 8, minute: 30),
    closingTime: const TimeOfDay(hour: 17, minute: 30),
    isOpen: false,
  ),
  OpeningHoursDataModel(
    day: 'Sunday',
    openingTime: const TimeOfDay(hour: 8, minute: 30),
    closingTime: const TimeOfDay(hour: 17, minute: 30),
    isOpen: false,
  ),
];
