import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../viewmodel/user_viewmodel.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/platform_sensitive_allertdialog.dart';
import '../widgets/social_login_button.dart';
import 'home_page.dart';

class EmailSignUpPage extends StatelessWidget {
  EmailSignUpPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  late final String _email, _password, _userName;
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

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
                                "Sign Up",
                                style: GoogleFonts.comfortaa(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              CustomTextField(
                                textEditingController: TextEditingController(),
                                hintText: "Name",
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (value) {
                                  _userName = value!;
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomTextField(
                                textEditingController: TextEditingController(),
                                hintText: "E-Mail",
                                keyboardType: TextInputType.emailAddress,
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
                                text: "Sign Up",
                                icon:
                                    const Icon(Icons.person_add_alt_1_rounded),
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
                                        text: "Already have an account?"),
                                    TextSpan(
                                      text: " Sign In",
                                      style: GoogleFonts.comfortaa(
                                        fontSize: 15,
                                        color: Colors.deepPurple,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pop(context);
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
    try {
      UserViewModel userViewModel = Provider.of<UserViewModel>(
        context,
        listen: false,
      );
      _formKey.currentState!.save();
      userViewModel.signUpWithEmail(_email, _password, _userName);
    } catch (e) {
      PlatformSensitiveAlertDialog(
        title: "Error",
        content: "E-Mail already in use",
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close"),
          ),
        ],
      ).show(context);
    }
  }
}
