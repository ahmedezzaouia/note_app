import 'package:flutter/material.dart';
import 'package:notebookapp/provider/auth_notifier.dart';
import 'package:notebookapp/screens/authenticate/register.dart';
import 'package:notebookapp/screens/authenticate/sign_in.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool showSignIn = Provider.of<AuthNotifier>(context).showSignIn;
    if (showSignIn) {
      return SignIn();
    } else {
      return Register();
    }
  }
}
