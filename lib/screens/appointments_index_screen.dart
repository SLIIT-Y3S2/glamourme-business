import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/appointments/appointments_bloc.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentIndexScreen extends StatefulWidget {
  const AppointmentIndexScreen({super.key});

  @override
  State<AppointmentIndexScreen> createState() => _AppointmentIndexScreenState();
}

class _AppointmentIndexScreenState extends State<AppointmentIndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Appointments',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        // Add a burger menu icon (hamburger menu).
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu), // You can use any icon you prefer.
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: green1,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Handle item 1 click here.
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Handle item 2 click here.
              },
            ),
          ],
        ),
      ),

      ///       body part started  ---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>>>>>>>>>>>>>
      body: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          final List<Meeting> meetings = <Meeting>[];
          if (state is AppointmentsLoaded) {
            for (var appointment in state.appointments) {
              meetings.add(
                Meeting(
                  appointment.title,
                  appointment.startTime.toDate(),
                  appointment.endTime.toDate(),
                  Theme.of(context).colorScheme.primary,
                  false,
                ),
              );
            }
          } else {
            BlocProvider.of<AppointmentBloc>(context).add(GetAppointmentsEvent(
                userId: BlocProvider.of<AuthenticationBloc>(context).userId));
          }

          return state is AppointmentsLoaded
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Row(
                        children: [
                          Text(
                            "Welcome!",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Kamal",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: SfCalendar(
                        view: CalendarView.day,
                        initialDisplayDate: DateTime.now(),
                        allowedViews: const <CalendarView>[
                          CalendarView.month,
                          CalendarView.week,
                          CalendarView.workWeek,
                        ],
                        onTap: (calendarTapDetails) {},
                        firstDayOfWeek: 1,
                        dataSource: MeetingDataSource(meetings),
                        monthViewSettings: const MonthViewSettings(
                          appointmentDisplayMode:
                              MonthAppointmentDisplayMode.indicator,
                        ),
                      ),
                    ),
                  ],
                )
              : state is LoadingAppoinments
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : state is AppointmentError
                      ? Center(
                          child: Text(state.message),
                        )
                      : const Center(
                          child: Text('No Appointments'),
                        );
        },
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
