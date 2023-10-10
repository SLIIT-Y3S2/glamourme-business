import 'package:flutter/material.dart';
import 'package:glamourmebusiness/firebase_options.dart';
import 'package:glamourmebusiness/glamourme_business_app.dart';
import 'package:logging/logging.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logging configuration that logs all messages via print
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName} : ${record.level.name} ===> ${record.message}');
  });

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GlamourMeBusinessApp();
  }
}
