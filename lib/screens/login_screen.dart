import 'package:flutter/material.dart';
import 'package:glamourmebusiness/screens/appointment_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AppointmentScreen()));
            },
            child: Text('Appointments')),
      ],
      appBar: AppBar(
        title: Text('Login'),
      ),
    );
  }
}
