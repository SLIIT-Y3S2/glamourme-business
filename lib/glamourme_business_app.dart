import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';
import 'package:glamourmebusiness/blocs/location/location_bloc.dart';
import 'package:glamourmebusiness/blocs/salon/salon_bloc.dart';
import 'package:glamourmebusiness/repositories/authentication/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/globals.dart';
import 'package:glamourmebusiness/repositories/location/location_repository.dart';
import 'package:glamourmebusiness/repositories/salon/salon_repository.dart';
import 'package:glamourmebusiness/screens/business_create_screen1.dart';
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
    bool ifr = await IsFirstRun.isFirstRun();
    if (user == null) {
      if (ifr) {
        globalNavigatorKey.currentState!.pushReplacementNamed('/onboarding');
      } else {
        globalNavigatorKey.currentState!.pushReplacementNamed('/login');
      }
    } else {
      var userDoc = firestore.FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid);
      firestore.FirebaseFirestore.instance
          .collection('salons')
          .where("salonOwner", isEqualTo: userDoc)
          .snapshots()
          .listen(
        (value) {
          value.size != 0
              ? globalNavigatorKey.currentState!.pushNamedAndRemoveUntil(
                  '/main', (Route<dynamic> route) => false)
              : globalNavigatorKey.currentState!
                  .pushReplacementNamed('/create_business');
        },
      );

      // globalNavigatorKey.currentState!.pushReplacementNamed('/create_business');
      // globalNavigatorKey.currentState!.pushReplacementNamed('/main');
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
  void dispose() {
    super.dispose();
    firestore.FirebaseFirestore.instance.terminate();
  }

  @override
  Widget build(context) {
    final authRepository = AuthenticationRepository();
    final AuthenticationBloc authenticationBloc =
        AuthenticationBloc(authRepository);

    ///Material App
    MaterialApp app = MaterialApp(
      title: 'GlamourMe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(kSeedColor),
          primary: Color(kPrimaryColor),
        ),
        textTheme: GoogleFonts.dmSansTextTheme(),
        useMaterial3: true,
      ).copyWith(),
      navigatorKey: globalNavigatorKey,
      onGenerateRoute: getRouteSettings(),
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => authRepository),
        RepositoryProvider(create: (context) => authenticationBloc),
        RepositoryProvider(create: (context) => SalonBloc()),
        RepositoryProvider(create: (context) => LocationBloc()),
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
    case '/create_business':
      return const BusinessCreationBasicDetails();
    default:
      //Todo add splash screen
      return const OnBoardingScreen();
  }
}
