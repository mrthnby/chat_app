import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialLogin extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  final Size size;
  const SocialLogin(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed,
      this.size = const Size(320, 55)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: size,
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 35,
                height: 40,
                child: icon,
              ),
              Text(
                text,
                style: GoogleFonts.comfortaa(fontSize: 16),
              ),
              const SizedBox(
                width: 35,
                height: 40,
              ),
            ],
          )),
    );
  }
}
