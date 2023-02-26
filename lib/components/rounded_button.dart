import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.title,
      required this.colour,
      required this.Press,
      this.disabled = false});

  final Color colour;
  final String title;
  final Function Press;
  bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: MaterialButton(
        elevation: 5.0,
        color: colour,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        disabledColor: const Color(0xff2E3338).withOpacity(0.5),
        onPressed: disabled ? null : () => {Press()},
        minWidth: 200.0,
        height: 54,
        child: Text(
          title,
          style: GoogleFonts.rubik(
            fontSize: 15,
            color: disabled ? Colors.white.withOpacity(0.5) : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
