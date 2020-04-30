import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notebookapp/models/user.dart';
import 'package:notebookapp/provider/auth_notifier.dart';
import 'package:notebookapp/services/auth_service.dart';
import 'package:notebookapp/shared/constants.dart';
import 'package:notebookapp/shared/loading.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  final myControllerEmail = TextEditingController();
  final myControllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _keyValue = GlobalKey<FormState>();
    AuthService auth = AuthService();
    final authNotifier = Provider.of<AuthNotifier>(context);
    return authNotifier.isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF4342FE),
              title: Text('Register to NoteBook'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () => authNotifier.toggleView(),
                    icon: Icon(Icons.person),
                    label: Text('Sign In'))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              alignment: Alignment.center,
              child: Form(
                  key: _keyValue,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('NoteBook',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold)),
                      SizedBox(height: 40),
                      Flexible(
                        child: TextFormField(
                          controller: myControllerEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              kTextInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an Email' : null,
                        ),
                      ),
                      SizedBox(height: 20),
                      Flexible(
                        child: TextFormField(
                          controller: myControllerPassword,
                          decoration: kTextInputDecoration.copyWith(
                              hintText: 'Password'),
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? 'your password is less than 6 chars'
                              : null,
                        ),
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 15),
                        onPressed: () async {
                          if (_keyValue.currentState.validate()) {
                            //implement sign in  method
                            authNotifier.updateLoading(true);
                            User result =
                                await auth.registerWithEmailAndPassword(
                                    myControllerEmail.text,
                                    myControllerPassword.text);
                            if (result == null) {
                              authNotifier
                                  .updateError('please supply a valide Email');
                              authNotifier.updateLoading(false);
                            }
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Color(0xFF4342FE),
                      ),
                      SizedBox(height: 20),
                      Text(
                        authNotifier.error,
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  )),
            ),
          );
  }
}
