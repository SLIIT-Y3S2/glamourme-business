import 'package:flutter/material.dart';
import 'package:glamourmebusiness/globals.dart';
import 'package:glamourmebusiness/screens/business_create_screen1.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';

class ProfileIndexScreen extends StatelessWidget {
  const ProfileIndexScreen({Key? key}) : super(key: key);

  void _signOut(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(const SignOutEvent());
  }

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
                    builder: (context) =>
                        const BusinessCreationBasicDetails(), // Use the SecondScreen widget from the imported file.
                  ),
                );
              },
              child: Text('Go to Second Screen'),
            ),
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



// ProfileScreenListItem(
            //   title: 'Signout',
            //   leadingIcon: Icons.logout,
            //   // onTapFunc: () => _signOut(context),
            //   subtitle: '',
            //   trailingIcon: Icons.arrow_forward_ios,
            //   isSignOutButton: true,
            // ),
            //Sign out button