import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final bool obSecure;
  final bool readOnly;
  final int radius;
  final bool noPadding;
  final Color? backgroundColor;
  final TextEditingController textEditingController;
  final void Function(String? value)? onSaved;
  final void Function(String? value)? onChanged;
  const CustomTextField({
    Key? key,
    required this.textEditingController,
    this.radius = 9,
    this.backgroundColor,
    this.readOnly = false,
    this.noPadding = false,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obSecure = false,
    this.onSaved,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: noPadding ? 0 : 32),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.black.withOpacity(.6),
          borderRadius: BorderRadius.circular(radius.toDouble()),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: TextFormField(
            controller: textEditingController,
            onChanged: onChanged,
            readOnly: readOnly,
            onSaved: onSaved,
            obscureText: obSecure,
            style: GoogleFonts.comfortaa(
              color: Colors.white,
              fontSize: 16,
            ),
            keyboardType: keyboardType,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: GoogleFonts.comfortaa(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
