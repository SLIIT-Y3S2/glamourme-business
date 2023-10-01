///
/// This is the signup form widget
///

import 'package:flutter/material.dart';
import 'package:glamourmebusiness/constants.dart';

class SignupFormWidget extends StatelessWidget {
  const SignupFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // To monitor the device orientation
    // final orientation = MediaQuery.of(context).orientation;

    return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 28),
          child: Column(
            children: [
              _buildInputField("Name", "Your name here"),
              const SizedBox(height: 16), // Add spacing between input fields
              _buildInputField("Email", "Your email here"),
              const SizedBox(height: 16), // Add spacing between input fields
              _buildInputField("Password", "Your password here",
                  isPassword: true),
              const SizedBox(height: 16), // Add spacing between input fields
              _buildInputField("Confirm Password", "Confirm your password here",
                  isPassword: true),
              const Padding(padding: EdgeInsets.only(top: 28)),
              Center(
                  child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(signupScreenColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ))
            ],
          ),
        ));
  }

  Widget _buildInputField(String labelText, String placeholder,
      {bool isPassword = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 2, left: 9),
          child: Text(
            labelText,
            style: const TextStyle(
              color: Color(0xFF1C1C28),
              fontSize: 10,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: const Color(0xFFC7C8D8)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(
                color: Color(0xFF8E90A5),
                fontSize: 15,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
