import 'package:flutter/material.dart';
import 'package:notebookapp/provider/auth_notifier.dart';
import 'package:notebookapp/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'note_grid.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //create instance of AuthService class
    AuthService auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4342FE),
        title: Text('NoteBook'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                Provider.of<AuthNotifier>(context, listen: false).isLoading =
                    false;
                await auth.logOut();
              },
              icon: Icon(Icons.person),
              label: Text('log out'))
        ],
      ),
      body: NoteGridView(),
    );
  }
}
