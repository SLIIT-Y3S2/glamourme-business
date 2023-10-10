import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Todo: Seperate UI into widgets
    return Scaffold(
      appBar: AppBar(title: Text('Appointments')),
      body: Container(
        child: SfCalendar(
          view: CalendarView.day,
          firstDayOfWeek: 1,
          headerStyle: const CalendarHeaderStyle(
            textAlign: TextAlign.left,
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
          ),
          weekNumberStyle: const WeekNumberStyle(
            backgroundColor: Colors.black,
            textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
