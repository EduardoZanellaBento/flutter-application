import 'package:flutter/material.dart';
import 'package:flutter_application_teste/screens/login_screen.dart';
import 'package:flutter_application_teste/screens/register_screen.dart';
import 'package:flutter_application_teste/components/rounded_button.dart';

class WelcomeSreen extends StatefulWidget {
  const WelcomeSreen({super.key});
  static String id = 'welcome_screen';

  @override
  State<WelcomeSreen> createState() => _WelcomeSreenState();
}

class _WelcomeSreenState extends State<WelcomeSreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: const Color(0xff1C1F22),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/image.png', width: 240, height: 240),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: RoundedButton(
                    title: 'Entrar',
                    colour: const Color(0xff2E3338),
                    Press: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                RoundedButton(
                  title: 'Cadastrar-se',
                  colour: const Color(0xff606062),
                  Press: () {
                    Navigator.pushNamed(context, RegisterScreen.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
