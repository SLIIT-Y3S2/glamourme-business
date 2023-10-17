import 'package:flutter/material.dart';
import 'package:glamourmebusiness/screens/business_create_screen4.dart';

List<CustomCheckBoxOpeningHours> openingHours = [
  CustomCheckBoxOpeningHours(
    OpeningTimeData(
      day: 'Monday',
      openingTime: const TimeOfDay(hour: 8, minute: 30),
      closingTime: const TimeOfDay(hour: 17, minute: 30),
    ),
    true,
  ),
  CustomCheckBoxOpeningHours(
    OpeningTimeData(
      day: 'Tuesday',
      openingTime: const TimeOfDay(hour: 8, minute: 30),
      closingTime: const TimeOfDay(hour: 17, minute: 30),
    ),
    true,
  ),
  CustomCheckBoxOpeningHours(
    OpeningTimeData(
      day: 'Wednesday',
      openingTime: const TimeOfDay(hour: 8, minute: 30),
      closingTime: const TimeOfDay(hour: 17, minute: 30),
    ),
    true,
  ),
  CustomCheckBoxOpeningHours(
    OpeningTimeData(
      day: 'Thursday',
      openingTime: const TimeOfDay(hour: 8, minute: 30),
      closingTime: const TimeOfDay(hour: 17, minute: 30),
    ),
    true,
  ),
  CustomCheckBoxOpeningHours(
    OpeningTimeData(
      day: 'Friday',
      openingTime: const TimeOfDay(hour: 8, minute: 30),
      closingTime: const TimeOfDay(hour: 17, minute: 30),
    ),
    true,
  ),
  CustomCheckBoxOpeningHours(
    OpeningTimeData(
      day: 'Saturday',
      openingTime: const TimeOfDay(hour: 8, minute: 30),
      closingTime: const TimeOfDay(hour: 17, minute: 30),
    ),
    false,
  ),
  CustomCheckBoxOpeningHours(
    OpeningTimeData(
      day: 'Sunday',
      openingTime: const TimeOfDay(hour: 8, minute: 30),
      closingTime: const TimeOfDay(hour: 17, minute: 30),
    ),
    false,
  ),
];
