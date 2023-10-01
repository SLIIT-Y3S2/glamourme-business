import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Todo: Seperate UI into widgets
    return Scaffold(
      appBar: AppBar(title: Text('Appointments')),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        height: 70,
        elevation: 0,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.calendar_today_outlined, size: 30),
              tooltip: 'Appointments',
              label: ''),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined, size: 30),
            tooltip: 'Notifications',
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.home_outlined, size: 30),
            tooltip: 'Home',
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined, size: 30),
            tooltip: 'Profile',
            label: '',
          ),
        ],
      ),
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
