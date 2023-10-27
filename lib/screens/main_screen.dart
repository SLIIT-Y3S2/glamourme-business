import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/appointments/appointments_bloc.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';
import 'package:glamourmebusiness/blocs/salon/salon_bloc.dart';

import 'package:glamourmebusiness/globals.dart';
import 'package:glamourmebusiness/screens/appointments_index_screen.dart';
import 'package:glamourmebusiness/screens/my_business_screen.dart';
import 'package:glamourmebusiness/screens/notifications_index_screen.dart';
import 'package:glamourmebusiness/screens/profile_index_screen.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainScreen> {
  final _pages = [
    const AppointmentIndexScreen(),
    const NotificationsIndexScreen(),
    const MyBusiness(),
    const ProfileIndexScreen(),
  ];
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    appointmetNavigatorKey,
    appointmetNavigatorKey,
    mybusinessNavigatorkey,
    profileNavigatorKey,
  ];

  int _currentIndex = 0;

  void _onDestinationSelected(int index) {
    if (_currentIndex == index) {
      var state = _navigatorKeys[index].currentState;
      if (state != null) {
        _navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
      }
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppointmentBloc>(context).add(
      GetAppointmentsEvent(
          userId: BlocProvider.of<AuthenticationBloc>(context).userId),
    );
    BlocProvider.of<SalonBloc>(context).add(GetSalonEvent());
    BlocProvider.of<AuthenticationBloc>(context).add(GetCurrentUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        key: bottomNavigationKey,
        animationDuration: const Duration(seconds: 1),
        selectedIndex: _currentIndex,
        onDestinationSelected: _onDestinationSelected,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 30,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Appointments',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notifications',
            selectedIcon: Icon(Icons.notifications),
          ),
          NavigationDestination(
            icon: Icon(Icons.home_work_outlined),
            selectedIcon: Icon(Icons.home_work),
            label: 'My Business',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.home_work),
            label: 'Profile',
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }
}
