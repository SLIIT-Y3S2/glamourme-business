import 'package:flutter/material.dart';
import 'package:glamourmebusiness/widgets/profile_screen_list_item.dart';

class NotificationsIndexScreen extends StatelessWidget {
  const NotificationsIndexScreen({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   //Todo: Seperate UI into widgets
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('Notifications')),
  //     body: const Center(
  //       child: Text('Notifications Screen'),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: profileNavigatorKey,
        appBar: AppBar(title: const Text('Profile')),
        body: Text("Notifications")
        );
  }


}
