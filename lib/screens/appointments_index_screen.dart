import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/appointments/appointments_bloc.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppointmentIndexScreen extends StatefulWidget {
  const AppointmentIndexScreen({super.key});

  @override
  State<AppointmentIndexScreen> createState() => _AppointmentIndexScreenState();
}

class _AppointmentIndexScreenState extends State<AppointmentIndexScreen> {
  @override
  void initState() {
    BlocProvider.of<AuthenticationBloc>(context)
        .add(const GetCurrentUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome ,",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return state is CurrentUserState
                      ? const Text(
                          // state.user!.email,
                          'Kamal Perera',
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        )
                      : const Text(
                          'loading...',
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        );
                },
              )
            ],
          ),
        ),
        // Add a burger menu icon (hamburger menu).
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
