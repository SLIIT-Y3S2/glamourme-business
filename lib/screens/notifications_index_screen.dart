import 'package:flutter/material.dart';

class NotificationsIndexScreen extends StatelessWidget {
  const NotificationsIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Todo: Seperate UI into widgets
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: const Center(
        child: Text('Appointments Screen'),
      ),
    );
  }
}
