///
/// This is the signup screen widget
///

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/widgets/signup_form_widget.dart';
import 'package:glamourmebusiness/widgets/social_buttons_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(signupScreenColor),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical, // Allow vertical scrolling

        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Color(signupScreenColor)),
              padding: const EdgeInsets.fromLTRB(35, 70, 24, 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15), // Use SizedBox for spacing
                  Row(
                    children: [
                      const Text(
                        'Already have an account?  ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Additional widgets added after the green color area
            const Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 26, 24, 28),
                  child: SignupFormWidget(),
                ),
                Row(children: [
                  Padding(padding: EdgeInsets.fromLTRB(35, 0, 0, 0)),
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text(
                      'Or SignUp using',
                      style: TextStyle(
                        color: Color(0xFF1C1C28),
                        fontSize: 13,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ),
                  Expanded(child: Divider()),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 35, 0)),
                ]),
                Padding(padding: EdgeInsets.fromLTRB(0, 27, 0, 0)),
                Center(
                  child: SocialLoginButtons(),
                ),
                Padding(padding: EdgeInsets.only(bottom: 60))
              ],
            )

            // Add more widgets as needed
          ],
        ),
      ),
    );
  }
}
