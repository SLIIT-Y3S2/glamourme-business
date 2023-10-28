import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/appointments/appointments_bloc.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';
import 'package:glamourmebusiness/blocs/salon/salon_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppointmentIndexScreen extends StatefulWidget {
  const AppointmentIndexScreen({super.key});

  @override
  State<AppointmentIndexScreen> createState() => _AppointmentIndexScreenState();
}

class _AppointmentIndexScreenState extends State<AppointmentIndexScreen> {
  String _subjectText = '',
      _startTimeText = '',
      _endTimeText = '',
      _dateText = '',
      _timeDetails = '';

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Appointment appointmentDetails = details.appointments![0];
      _subjectText = appointmentDetails.subject;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.startTime)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
      _timeDetails = '$_startTimeText - $_endTimeText';
    } else if (details.targetElement == CalendarElement.calendarCell) {
      _subjectText = "Appointment Details";
      _dateText = DateFormat('MMMM dd, yyyy').format(details.date!).toString();
      _timeDetails = '';
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(_subjectText),
            content: SizedBox(
              height: 80,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        _dateText,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Text(_timeDetails,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

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
              Text(
                AppLocalizations.of(context)!.welcome,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              BlocBuilder<SalonBloc, SalonState>(
                builder: (context, state) {
                  return state is SalonLoaded
                      ? Text(
                          state.salon.salonName,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                        )
                      : Text(
                          'loading...',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
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
          final List<Appointment> meetings = <Appointment>[];
          if (state is AppointmentsLoaded) {
            for (var appointment in state.appointments) {
              meetings.add(
                Appointment(
                  subject: appointment.title,
                  startTime: appointment.startTime.toDate(),
                  endTime: appointment.endTime.toDate(),
                  color: Theme.of(context).colorScheme.primary,
                  isAllDay: false,
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SfCalendar(
                          headerStyle: CalendarHeaderStyle(
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          appointmentTextStyle:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                          view: CalendarView.day,
                          initialDisplayDate: DateTime.now(),
                          allowedViews: const <CalendarView>[
                            CalendarView.month,
                            CalendarView.week,
                            CalendarView.workWeek,
                            CalendarView.day
                          ],
                          onTap: calendarTapped,
                          firstDayOfWeek: 1,
                          dataSource: MeetingDataSource(meetings),
                          monthViewSettings: const MonthViewSettings(
                            appointmentDisplayMode:
                                MonthAppointmentDisplayMode.indicator,
                          ),
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
  MeetingDataSource(List<Appointment> source) {
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
