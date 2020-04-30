import 'package:flutter/material.dart';
import 'package:notebookapp/models/user.dart';
import 'package:notebookapp/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user == null ? Authenticate() : Home();
  }
}
