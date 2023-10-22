import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';
import 'package:glamourmebusiness/blocs/location/location_bloc.dart';
import 'package:glamourmebusiness/blocs/salon/salon_bloc.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/models/salon_model.dart';
import 'package:glamourmebusiness/screens/business_create_screen2.dart';
import 'package:glamourmebusiness/widgets/gender_selection_option_widget.dart';

class BusinessCreationBasicDetails extends StatefulWidget {
  const BusinessCreationBasicDetails({super.key});

  @override
  State<BusinessCreationBasicDetails> createState() =>
      _BusinessCreationBasicDetailsState();
}

class _BusinessCreationBasicDetailsState
    extends State<BusinessCreationBasicDetails> {
  void _signOut(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(const SignOutEvent());
  }

  // to access the salon bloc
  late SalonBloc _salonBloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _enteredSalonNameController = TextEditingController();
  TextEditingController _enteredWebsiteController = TextEditingController();
  String _salonType = 'unisex';

  void selectService(String service) {
    setState(() {
      _salonType = service;
    });
  }

  @override
  void initState() {
    super.initState();
    _salonBloc = SalonBloc();
    _enteredSalonNameController = TextEditingController();
    _enteredWebsiteController = TextEditingController();
    BlocProvider.of<AuthenticationBloc>(context)
        .add(const GetCurrentUserEvent());
  }

  String? _salonNameValidate(value) {
    if (value.trim().isEmpty || value == null) {
      return 'Please enter a valid name';
    }

    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _enteredSalonNameController.dispose();
    _enteredWebsiteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SalonBloc, SalonState>(
      listener: (context, state) {
        // TODO: implement listener: forward if salon created
      },
      child: Scaffold(
        appBar: AppBar(
          // title: const Text('Create Business'),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
              ),
              onPressed: () => _signOut(context),
              child: const Text('Sign out'),
            ),
          ],
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
              _buildInputField('Business Name', 'Enter your business name',
                  _enteredSalonNameController),
              const SizedBox(height: 24),
              _buildInputField('Website (optional)', 'Enter your website',
                  _enteredWebsiteController),
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
      ),
    );
  }

  Widget _buildInputField(
    String labelText,
    String placeholder,
    TextEditingController controller,
  ) {
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
            controller: controller,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ServiceOption(
          service: "Unisex",
          isSelected: _salonType == "unisex",
          onTap: () {
            selectService("unisex");
          },
        ),
        ServiceOption(
          service: "Gents",
          isSelected: _salonType == "gents",
          onTap: () {
            selectService("gents");
          },
        ),
        ServiceOption(
          service: "Ladies",
          isSelected: _salonType == "ladies",
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
          // _onSubmit();
          if (_enteredSalonNameController.text.length < 3) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please enter a valid name'),
              ),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusinessCreationServiceSelection(
                basicSalonDetails: BasicSalonDetails(
                  salonName: _enteredSalonNameController.text,
                  website: _enteredWebsiteController.text,
                  salonType: _salonType,
                ),
              ),
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
