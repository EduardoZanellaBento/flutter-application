import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_teste/screens/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
late User loggeddInUser;

class OlaScreen extends StatefulWidget {
  const OlaScreen({super.key});
  static String id = 'ola_screen';

  @override
  State<OlaScreen> createState() => _OlaScreenState();
}

class _OlaScreenState extends State<OlaScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Seja Bem-vindo'),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => Navigator.pushNamed(context, WelcomeSreen.id),
            )
          ],
        ),
        backgroundColor: const Color(0xff1C1F22),
        body: Column(
          children: [
            Expanded(
                child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "VAI TOMA NO CU PIRANHAAAAAAAAA HEY HEY HEY HEY HEY",
                      style: GoogleFonts.amaticSc(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 3,
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
