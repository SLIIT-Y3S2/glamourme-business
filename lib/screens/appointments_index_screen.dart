import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';

class AppointmentIndexScreen extends StatelessWidget {
  const AppointmentIndexScreen({super.key});
  void _signOut(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(const SignOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    //Todo: Seperate UI into widgets
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: Center(
        child: Column(
          children: [
            const Text('Appointments Screen'),
            ElevatedButton(
              onPressed: () => _signOut(context),
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
