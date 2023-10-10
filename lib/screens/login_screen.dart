import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/globals.dart';
import 'package:glamourmebusiness/widgets/login_form_widget.dart';
import 'package:glamourmebusiness/widgets/social_buttons_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(35, 70, 24, 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // const SizedBox(height: 15), // Use SizedBox for spacing
                  Row(
                    children: [
                      Text(
                        'Don t you have an account?  ',
                        style: TextStyle(
                          color: Color(black2),
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Sign Up',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              globalNavigatorKey.currentState!
                                  .pushReplacementNamed('/signup');
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
                  child: LoginFormWidget(),
                ),
                Row(children: [
                  Padding(padding: EdgeInsets.fromLTRB(35, 0, 0, 0)),
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text(
                      'Or Login using',
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
        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        // children: [
        //   ElevatedButton(
        //       onPressed: () {
        //         Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => HomeScreen(),
        //         ));
        //       },
        //       child: Text('Home')),
        //   ElevatedButton(
        //     onPressed: () {
        //       Navigator.of(context).push(
        //           MaterialPageRoute(builder: (context) => SignupScreen()));
        //     },
        //     child: Text('Signup'),
        //   )
        // ],
      ),
    );
  }
}
