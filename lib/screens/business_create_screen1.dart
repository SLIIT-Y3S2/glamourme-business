import 'package:flutter/material.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/screens/business_create_screen2.dart';

class BusinessCreationBasicDetails extends StatelessWidget {
  const BusinessCreationBasicDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Business'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.fromLTRB(32, 50, 32, 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What’s your business name?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1C1C28),
                fontSize: 23,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                height: 0,
                letterSpacing: -0.46,
              ),
            ),
            const SizedBox(height: 16),
            _buildInputField('Business Name', 'Enter your business name'),
            const SizedBox(height: 16),
            _buildInputField('Website (optional)', 'Enter your website'),
            const SizedBox(height: 16),
            _serveForGenderRadioButton(),
            // Expanded(
            //   child: Container(
            //     color: Colors.amber,
            //     width: 100,
            //   ),
            // ),
            // _nextButton(context),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
        child: _nextButton(context),
      ),
    );
  }

  Widget _buildInputField(String labelText, String placeholder,
      {bool isPassword = false,
      bool isEmail = false,
      isConfirmPassword = false}) {
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
          child: TextFormField(
            obscureText: isPassword || isConfirmPassword,
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

  Widget _serveForGenderRadioButton() {
    String _gender = "male";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 2, left: 9),
          child: const Text(
            'Select your gender:',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF1C1C28),
              fontSize: 10,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        RadioListTile<String>(
          title: const Text('Male'),
          value: 'male',
          groupValue: _gender, onChanged: (String? value) {},
          // onChanged: (value) {
          //   setState(() {
          //     _gender = value;
          //   });
          // },
        ),
        RadioListTile<String>(
          title: const Text('Female'),
          value: 'female',
          groupValue: _gender, onChanged: (String? value) {},
          // onChanged: (value) {
          //   setState(() {
          //     _gender = value;
          //   });
          // },
        ),
        RadioListTile<String>(
          title: const Text('Unisex'),
          value: 'unisex',
          groupValue: _gender, onChanged: (String? value) {},
          // onChanged: (value) {
          //   setState(() {
          //     _gender = value;
          //   });
          // },
        ),
      ],
    );
  }

  Widget _nextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BusinessCreationServiceSelection(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(signupScreenColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
