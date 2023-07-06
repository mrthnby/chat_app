
import 'package:chat_app/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/user_viewmodel.dart';
import 'home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);

    if (userViewModel.state == ViewState.IDLE) {
      if (userViewModel.user == null) {
        return const SignInPage();
      } else {
        return const HomePage();
      }
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      );
    }
  }
}
