import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:glamourmebusiness/blocs/appointments/appointments_bloc.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';
import 'package:glamourmebusiness/blocs/salon/salon_bloc.dart';
import 'package:glamourmebusiness/globals.dart';
import 'package:glamourmebusiness/screens/appointments_index_screen.dart';
import 'package:glamourmebusiness/screens/my_business_screen.dart';
import 'package:glamourmebusiness/screens/notifications_index_screen.dart';
import 'package:glamourmebusiness/screens/profile_index_screen.dart';

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
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.calendar_month_outlined),
            selectedIcon: const Icon(Icons.calendar_month),
            label: AppLocalizations.of(context)!.appointments,
          ),
          NavigationDestination(
            icon: const Icon(Icons.notifications_outlined),
            label: AppLocalizations.of(context)!.notifications,
            selectedIcon: const Icon(Icons.notifications),
          ),
          NavigationDestination(
            icon: const Icon(Icons.home_work_outlined),
            selectedIcon: const Icon(Icons.home_work),
            label: AppLocalizations.of(context)!.myBusiness,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outlined),
            selectedIcon: const Icon(Icons.person),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppointmentBloc>(context).add(
      GetAppointmentsEvent(
          userId: BlocProvider.of<AuthenticationBloc>(context).userId),
    );
    BlocProvider.of<SalonBloc>(context).add(const GetSalonEvent());
    BlocProvider.of<AuthenticationBloc>(context)
        .add(const GetCurrentUserEvent());
  }

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
}
