import 'package:flutter/material.dart';
import 'package:notebookapp/provider/auth_notifier.dart';
import 'package:notebookapp/screens/wrapper.dart';
import 'package:notebookapp/services/auth_service.dart';
import 'package:notebookapp/services/database_service.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: AuthService().user),
        StreamProvider<List<UserData>>.value(value: DatabaseService().userData),
        ChangeNotifierProvider(create: (context) => AuthNotifier()),
      ],
      child: MaterialApp(
        title: 'Note book App',
        theme: ThemeData(
            primaryColor: Colors.white, backgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
