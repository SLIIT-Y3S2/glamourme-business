import 'package:flutter/material.dart';
import 'package:glamourmebusiness/globals.dart';
import 'package:glamourmebusiness/screens/add_business_screen_1.dart';


class ProfileIndexScreen extends StatelessWidget {
  const ProfileIndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: profileNavigatorKey,
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile Screen'),
            ElevatedButton(
              onPressed: () {
                // Navigate to the new screen when the button is pressed.
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddbusinessScreen1(), // Use the SecondScreen widget from the imported file.
                  ),
                );
              },
              child: Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
