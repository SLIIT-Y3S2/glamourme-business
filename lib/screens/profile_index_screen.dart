import 'package:flutter/material.dart';
import 'package:glamourmebusiness/globals.dart';

class ProfileIndexScreen extends StatelessWidget {
  const ProfileIndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: profileNavigatorKey,
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
