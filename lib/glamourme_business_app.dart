import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';
import 'package:glamourmebusiness/repositories/authentication/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/globals.dart';
import 'package:glamourmebusiness/screens/login_screen.dart';
import 'package:glamourmebusiness/screens/main_screen.dart';
import 'package:glamourmebusiness/screens/onboarding_screen.dart';
import 'package:glamourmebusiness/screens/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_first_run/is_first_run.dart';

class GlamourMeBusinessApp extends StatefulWidget {
  const GlamourMeBusinessApp({super.key});

  @override
  State<GlamourMeBusinessApp> createState() => _GlamourMeAppState();
}

class _GlamourMeAppState extends State<GlamourMeBusinessApp> {
  // Used to redirect to the appropriate screen
  void _redirectToAuthenticate(auth.User? user) async {
    if (user == null) {
      bool ifr = await IsFirstRun.isFirstRun();
      //TODO check if the user has business or not if not to the business creation screen
      if (ifr) {
        globalNavigatorKey.currentState!.pushReplacementNamed('/onboarding');
      } else {
        globalNavigatorKey.currentState!.pushReplacementNamed('/login');
      }
    } else {
      globalNavigatorKey.currentState!.pushReplacementNamed('/main');
    }
  }

  @override
  void initState() {
    super.initState();
    auth.FirebaseAuth.instance.authStateChanges().listen((user) async {
      _redirectToAuthenticate(user);
    });
  }

  @override
  Widget build(context) {
    final authRepository = AuthenticationRepository();
    final AuthenticationBloc authenticationBloc =
        AuthenticationBloc(authRepository);

    ///Material App
    MaterialApp app = MaterialApp(
      title: 'GlamourMe',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(kSeedColor),
          primary: Color(kPrimaryColor),
        ),
        textTheme: GoogleFonts.dmSansTextTheme(),
        useMaterial3: true,
      ),
      navigatorKey: globalNavigatorKey,
      onGenerateRoute: getRouteSettings(),
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => authRepository),
        RepositoryProvider(create: (context) => authenticationBloc)
      ],
      child: app,
    );
  }
}

// Used to get the route settings
MaterialPageRoute Function(RouteSettings settings) getRouteSettings() {
  return (RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => _getPageRoutes(context, settings));
  };
}

// Used to get the page routes
_getPageRoutes(BuildContext context, RouteSettings settings) {
  switch (settings.name) {
    case '/login':
      return const LoginScreen();
    case '/signup':
      return const SignupScreen();
    case '/main':
      return const MainScreen();
    case '/onboarding':
      return const OnBoardingScreen();
    default:
      //Todo add splash screen
      return const OnBoardingScreen();
  }
}