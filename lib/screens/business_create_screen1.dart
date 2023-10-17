import 'package:flutter/material.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/screens/business_create_screen2.dart';

class BusinessCreationBasicDetails extends StatefulWidget {
  const BusinessCreationBasicDetails({super.key});

  @override
  State<BusinessCreationBasicDetails> createState() =>
      _BusinessCreationBasicDetailsState();
}

class _BusinessCreationBasicDetailsState
    extends State<BusinessCreationBasicDetails> {
  String selectedService = '';

  void selectService(String service) {
    setState(() {
      selectedService = service;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Create Business'),
          ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
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
            const SizedBox(height: 24),
            _buildInputField('Business Name', 'Enter your business name'),
            const SizedBox(height: 24),
            _buildInputField('Website (optional)', 'Enter your website'),
            const SizedBox(height: 24),
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
        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
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
              fontSize: 14,
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
                fontSize: 16,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ServiceOption(
          service: "Unisex",
          isSelected: selectedService == "Unisex",
          onTap: () {
            selectService("Unisex");
          },
        ),
        ServiceOption(
          service: "Gents",
          isSelected: selectedService == "gents",
          onTap: () {
            selectService("gents");
          },
        ),
        ServiceOption(
          service: "Ladies",
          isSelected: selectedService == "ladies",
          onTap: () {
            selectService("ladies");
          },
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

class ServiceOption extends StatelessWidget {
  final String service;
  final bool isSelected;
  final VoidCallback onTap;

  ServiceOption({
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: isSelected ? Colors.green : Colors.white,
        child: SizedBox(
          width: 100,
          height: 80,
          child: Center(
            child: Text(
              service,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
