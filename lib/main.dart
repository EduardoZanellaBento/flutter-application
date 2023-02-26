import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_teste/services/auth_service.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_teste/screens/ola_screen.dart';
import 'package:flutter_application_teste/screens/login_screen.dart';
import 'package:flutter_application_teste/screens/register_screen.dart';
import 'package:flutter_application_teste/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CalcMonstra());
}

class CalcMonstra extends StatelessWidget {
  const CalcMonstra({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeSreen.id,
        routes: {
          OlaScreen.id: (context) => const OlaScreen(),
          WelcomeSreen.id: (context) => const WelcomeSreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          RegisterScreen.id: (context) => const RegisterScreen(),
        });
  }
}
