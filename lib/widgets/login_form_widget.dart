///
/// This is the login form widget
///

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';
import 'package:glamourmebusiness/constants.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  // To access the OnboardingBloc
  late AuthenticationBloc _authenticationBloc;
  // Global key that uniquely identifies the Form widget
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // to store the email entered by the user
  String _enteredEmail = '';
  // to store the password entered by the user
  String _enteredPassword = '';

  // Controllers for the input fields
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  //

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

// Function to handle form submission
  void _submit() {
    final isValid = _formKey.currentState!.validate();
    // Check if the form is valid
    if (!isValid) {
      return;
    }
    // Check if the controllers are not null
    if (_emailController == null || _passwordController == null) {
      return;
    }
    _formKey.currentState!.save();

    // Get the entered email, name and password
    _enteredEmail = _emailController!.text;
    _enteredPassword = _passwordController!.text;

    _authenticationBloc.add(SigninEvent(
      email: _enteredEmail,
      password: _enteredPassword,
    ));
  }

  //Validator functions for email and password
  String? _emailValidate(value) {
    if (value.trim().isEmpty || value == null || !value.contains('@')) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? _passwordValidate(value) {
    if (value.trim().isEmpty || value == null || value.length < 6) {
      return 'Enter a valid password with 6 or more characters';
    }

    return null;
  }

  String? _nameValidate(value) {
    if (value.trim().isEmpty || value == null) {
      return 'Please enter a valid name';
    }

    return null;
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose
    _emailController!.dispose();
    _passwordController!.dispose();
    _formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        if (state is SignedInState) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Signing in...')));
        } else if (state is SigningInErrorState) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
            duration: const Duration(milliseconds: 1500),
          ));
        } else if (state is UserCreatedState) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Signed in successfully.'),
            duration: Duration(milliseconds: 500),
          ));
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
      },
      child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 28),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                      height: 16), // Add spacing between input fields
                  _buildInputField(
                    "Email",
                    "Your email here",
                    isEmail: true,
                  ),
                  const SizedBox(
                      height: 16), // Add spacing between input fields
                  _buildInputField(
                    "Password",
                    "Your password here",
                    isPassword: true,
                  ),

                  const Padding(padding: EdgeInsets.only(top: 28)),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return state is SigningInState
                          ? const CircularProgressIndicator()
                          : Center(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(signupScreenColor),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            );
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildInputField(
    String labelText,
    String placeholder, {
    bool isPassword = false,
    bool isEmail = false,
  }) {
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
            controller: isPassword ? _passwordController : _emailController,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(
                color: Color(0xFF8E90A5),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
            validator: isPassword
                ? _passwordValidate
                : isEmail
                    ? _emailValidate
                    : _nameValidate,
          ),
        ),
      ],
    );
  }
}
