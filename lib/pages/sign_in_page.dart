import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../viewmodel/user_viewmodel.dart';
import '../widgets/social_login_button.dart';
import 'email_sign_in_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sign In",
              style: GoogleFonts.comfortaa(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SocialLogin(
              text: "Continue with Google",
              icon: Image.asset(
                "assets/google_icon.png",
                fit: BoxFit.fitWidth,
              ),
              onPressed: () => _signInWithGoogle(context),
            ),
            SocialLogin(
              text: "Continue with Email",
              icon: const Icon(
                Icons.mail_rounded,
                size: 30,
              ),
              onPressed: () => _signInWithEmail(context),
            ),
            Text(
              "Or",
              style: GoogleFonts.comfortaa(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SocialLogin(
              text: "Continue as a Guest",
              icon: const Icon(
                Icons.person_rounded,
                size: 30,
              ),
              onPressed: () => _anonymLogin(context),
            ),
          ],
        ),
      ),
    );
  }

  void _anonymLogin(BuildContext context) async {
    UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);

    UserModel? result = await userViewModel.signInAnonymously();
    debugPrint(result!.userId.toString());
  }

  void _signInWithGoogle(BuildContext context) async {
    UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);

    UserModel? result = await userViewModel.signInWithGoogle();
    debugPrint(result!.userId.toString());
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => const EmailSignInPage()),
      ),
    );
  }
}
