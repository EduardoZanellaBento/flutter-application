import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_teste/components/rounded_button.dart';
import 'package:flutter_application_teste/screens/ola_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../global.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  const LoginScreen({key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //var formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

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

  // void signUserIn() async {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });
  // }
  SnackBar _buildSnackBar(String message) {
    return SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.userChanges().listen((User? user) {
    //   if (user == null) {
    //     print('User is currently signed out!');
    //   } else {
    //     print('User is signed in!');
    //   }
    // });
    return MaterialApp(
      scaffoldMessengerKey: snackbarKey,
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
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 150),
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
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value;
                          },
                          textInputAction: TextInputAction.next,
                          // onSubmitted: (value) {
                          //   FocusScope.of(context).nextFocus();
                          // },

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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                        child: TextFormField(
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                              Navigator.pushNamed(context, OlaScreen.id);
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
                              try {
                                //formKey.currentState!.validate();
                                final user =
                                    await auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                Navigator.pushNamed(context, OlaScreen.id);
                              } on FirebaseAuthException catch (error) {
                                String errorMessage =
                                    'Ocorreu um erro ao fazer o login. Verifique suas credenciais e tente novamente.';
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(_buildSnackBar(errorMessage));
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
    );
  }
}
