import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_teste/components/rounded_button.dart';
import 'package:flutter_application_teste/screens/ola_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool _disableButton = true;
  final _emailBlock = TextEditingController();
  final _senhaBlock = TextEditingController();
  bool _obscureText = true;
  final FocusNode _emailFocus = FocusNode();
  bool _focoEmail = false;
  final FocusNode _senhaFocus = FocusNode();
  bool _focoSenha = false;

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(_onFocusChange);
    _senhaFocus.addListener(_onFocusChangeSenha);
    _emailBlock.addListener(_checkValue);
    _senhaBlock.addListener(_checkValue);
  }

  void _checkValue() {
    if (_emailBlock.text.isEmpty || _senhaBlock.text.isEmpty) {
      setState(() {
        _disableButton = true;
      });
    } else {
      setState(() {
        _disableButton = false;
      });
    }
  }

  void _onFocusChange() {
    setState(() {
      if (_emailFocus.hasFocus) {
        _focoEmail = true;
      } else {
        _focoEmail = false;
      }
    });
  }

  void _onFocusChangeSenha() {
    setState(() {
      if (_senhaFocus.hasFocus) {
        _focoSenha = true;
      } else {
        _focoSenha = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xff1C1F22),
            title: const Text('Email'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.of(context).pop(),
            )),
        backgroundColor: const Color(0xff1C1F22),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(bottom: 35, left: 30)),
                            Text(
                              "Email",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.5,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: TextField(
                            onChanged: (value) {
                              email = value;
                            },
                            controller: _emailBlock,
                            focusNode: _emailFocus,
                            cursorColor: Colors.white,
                            style: GoogleFonts.inter(
                                fontSize: 16, color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: _focoEmail
                                  ? Colors.black
                                  : const Color(0xff2E3338),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(bottom: 35, left: 30)),
                            Text(
                              "Senha",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.5,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: TextField(
                            onChanged: (value) {
                              password = value;
                            },
                            controller: _senhaBlock,
                            focusNode: _senhaFocus,
                            style: GoogleFonts.inter(
                                fontSize: 16, color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              suffixIcon: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: _obscureText
                                      ? const Icon(
                                          Icons.visibility_off,
                                          color: Color(0xffD8D3D8),
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          color: Color(0xffD8D3D8),
                                        ),
                                ),
                              ),
                              fillColor: _focoSenha
                                  ? Colors.black
                                  : const Color(0xff2E3338),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            obscureText: _obscureText,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.fromLTRB(30, 45, 0, 10)),
                            InkWell(
                              onTap: () {
                                //Navigator.pushNamed(context, CalcScreen.id);
                              },
                              child: Text(
                                "Esqueceu sua senha?",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.6,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.height,
                            child: RoundedButton(
                              disabled: _disableButton,
                              title: 'Entrar',
                              colour: const Color(0xff2E3338),
                              Press: () async {
                                setState(() {
                                  showSpinner = true;
                                });
                                try {
                                  final user =
                                      await _auth.signInWithEmailAndPassword(
                                          email: email, password: password);
                                  if (user != null) {
                                    Navigator.pushNamed(context, OlaScreen.id);
                                  }
                                  setState(() {
                                    showSpinner = true;
                                  });
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
