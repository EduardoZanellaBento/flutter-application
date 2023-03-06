import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_teste/components/rounded_button.dart';
import 'package:flutter_application_teste/screens/ola_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  bool showSpinner = false;
  late String email;
  late String password;
  late String repeatPassword;
  bool _disableButton = true;
  final _emailBlock = TextEditingController();
  final _senhaBlock = TextEditingController();
  final _senhaRepetidaBlock = TextEditingController();
  bool _obscureText = true;
  bool _obscureRepetidaText = true;
  final FocusNode _emailFocus = FocusNode();
  bool _focoEmail = false;
  final FocusNode _senhaFocus = FocusNode();
  bool _focoSenha = false;
  final FocusNode _senhaRepetidaFocus = FocusNode();
  bool _focoRepetidaSenha = false;
  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(_onFocusChange);
    _senhaFocus.addListener(_onFocusChangeSenha);
    _senhaRepetidaFocus.addListener(_onFocusChangeSenhaRepetida);
    _emailBlock.addListener(_checkValue);
    _senhaBlock.addListener(_checkValue);
    _senhaRepetidaBlock.addListener(_checkValue);
  }

  void _checkValue() {
    if (_emailBlock.text.isEmpty ||
        _senhaBlock.text.isEmpty ||
        _senhaRepetidaBlock.text.isEmpty) {
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

  void _onFocusChangeSenhaRepetida() {
    setState(() {
      if (_senhaRepetidaFocus.hasFocus) {
        _focoRepetidaSenha = true;
      } else {
        _focoRepetidaSenha = false;
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
            title: const Text('Cadastrar-se'),
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
                  child: Form(
                    key: formKey,
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
                            validator: (value) {
                              if (!GetUtils.isEmail(value!)) {
                                return "Email não cadastrado";
                              }
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
                          child: TextFormField(
                            validator: (value) {
                              if (value!.length < 6) {
                                return 'Senha deve ter no mínimo 6 caracteres';
                              }
                            },
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
                        const SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(bottom: 35, left: 30)),
                            Text(
                              "Repita sua senha",
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
                            validator: (value) {
                              if (value != _senhaBlock.text) {
                                return 'As senhas devem ser iguais';
                              }
                            },
                            onChanged: (value) {
                              repeatPassword = value;
                            },
                            controller: _senhaRepetidaBlock,
                            focusNode: _senhaRepetidaFocus,
                            style: GoogleFonts.inter(
                                fontSize: 16, color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              suffixIcon: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureRepetidaText =
                                          !_obscureRepetidaText;
                                    });
                                  },
                                  child: _obscureRepetidaText
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
                              fillColor: _focoRepetidaSenha
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
                            obscureText: _obscureRepetidaText,
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.height,
                            child: RoundedButton(
                              disabled: _disableButton,
                              title: 'Cadastrar-se',
                              colour: const Color(0xff2E3338),
                              Press: () async {
                                try {
                                  formKey.currentState!.validate();
                                  await auth.createUserWithEmailAndPassword(
                                      email: email, password: password);

                                  await firestore.collection('usuarios').add({
                                    "email": email,
                                    "password": password,
                                  });

                                  // if (newUser != null) {
                                  // }
                                  Navigator.pushNamed(context, OlaScreen.id);
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'senha-fraca') {
                                    print('A senha é muito curta.');
                                  } else if (e.code == 'email-ja-esta-em-uso') {
                                    print('Este email já esta em uso.');
                                  }
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
            ),
          ],
        ),
      ),
    );
  }
}
