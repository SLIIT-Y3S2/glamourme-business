import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/appointments/appointments_bloc.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';

class NotificationsIndexScreen extends StatefulWidget {
  const NotificationsIndexScreen({super.key});

  @override
  State<NotificationsIndexScreen> createState() =>
      _NotificationsIndexScreenState();
}

class _NotificationsIndexScreenState extends State<NotificationsIndexScreen> {
  String timeStampToString(Timestamp timestamp) {
    var date = timestamp.toDate();
    switch (date.month) {
      case 1:
        return '${date.day} Jan ${date.year}';
      case 2:
        return '${date.day} Feb ${date.year}';
      case 3:
        return '${date.day} Mar ${date.year}';
      case 4:
        return '${date.day} Apr ${date.year}';
      case 5:
        return '${date.day} May ${date.year}';
      case 6:
        return '${date.day} Jun ${date.year}';
      case 7:
        return '${date.day} Jul ${date.year}';
      case 8:
        return '${date.day} Aug ${date.year}';
      case 9:
        return '${date.day} Sep ${date.year}';
      case 10:
        return '${date.day} Oct ${date.year}';
      case 11:
        return '${date.day} Nov ${date.year}';
      case 12:
        return '${date.day} Dec ${date.year}';
      default:
        return '${date.day} ${date.month} ${date.year}';
    }
  }

  String timeStampToTime(Timestamp timestamp) {
    var date = timestamp.toDate();
    return '${(date.hour).toString().padLeft(2, '0')}:${(date.minute).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () {
            BlocProvider.of<AppointmentBloc>(context).add(
              GetAppointmentsEvent(
                  userId: BlocProvider.of<AuthenticationBloc>(context).userId),
            );
            return Future.delayed(
              const Duration(seconds: 2),
            );
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Notifications',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            body: state is AppointmentsLoaded
                ? state.appointments.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.all(24),
                        itemCount: state.appointments.length,
                        itemBuilder: (context, index) {
                          return Card(
                            surfaceTintColor: Colors.white,
                            elevation: 1,
                            child: ListTile(
                              title: Text(
                                state.appointments[index].clientName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.appointments[index].title),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    timeStampToString(
                                        state.appointments[index].startTime),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Colors.grey,
                                        ),
                                  ),
                                  Text(
                                    timeStampToTime(
                                        state.appointments[index].startTime),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Colors.grey,
                                        ),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                  '${state.appointments[index].appointmentPrice.toStringAsFixed(2)} LKR'),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text('Notifications will appear here'),
                      )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }
}
