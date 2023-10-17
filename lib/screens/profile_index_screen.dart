import 'package:flutter/material.dart';
import 'package:glamourmebusiness/globals.dart';
import 'package:glamourmebusiness/screens/business_create_screen1.dart';

class ProfileIndexScreen extends StatelessWidget {
  const ProfileIndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: profileNavigatorKey,
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          children: [
            const Text('Profile Screen'),
            //TODO: remove temporary button to navigate business create screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BusinessCreationBasicDetails(),
                  ),
                );
              },
              child: const Text('Create Business'),
            ),
          ],
        ),
      ),
    );
  }
}
