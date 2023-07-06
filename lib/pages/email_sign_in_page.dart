import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../viewmodel/user_viewmodel.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_login_button.dart';
import 'email_sign_up_page.dart';
import 'home_page.dart';

class EmailSignInPage extends StatefulWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  State<EmailSignInPage> createState() => _EmailSignInPageState();
}

class _EmailSignInPageState extends State<EmailSignInPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(
      context,
    );

    return userViewModel.state == ViewState.IDLE && userViewModel.user != null
        ? const HomePage()
        : Scaffold(
            body: Center(
                child: userViewModel.state == ViewState.BUSY &&
                        userViewModel.user == null
                    ? const CircularProgressIndicator()
                    : SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Text(
                                "Sign In",
                                style: GoogleFonts.comfortaa(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              CustomTextField(
                                hintText: "E-Mail",
                                keyboardType: TextInputType.emailAddress,
                                textEditingController: TextEditingController(),
                                onSaved: (value) {
                                  _email = value!;
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomTextField(
                                textEditingController: TextEditingController(),
                                hintText: "Password",
                                obSecure: true,
                                keyboardType: TextInputType.visiblePassword,
                                onSaved: (value) {
                                  _password = value!;
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SocialLogin(
                                size: const Size(200, 55),
                                text: "Sign In",
                                icon: const Icon(Icons.login_rounded),
                                onPressed: () => _formSubmit(context),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: "Don't have an account?"),
                                    TextSpan(
                                      text: " Sign Up",
                                      style: GoogleFonts.comfortaa(
                                        fontSize: 15,
                                        color: Colors.deepPurple,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EmailSignUpPage(),
                                            ),
                                          );
                                        },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
          );
  }

  _formSubmit(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(
      context,
      listen: false,
    );
    _formKey.currentState!.save();
    userViewModel.signInWithEmail(
      _email,
      _password,
    );
  }
}
