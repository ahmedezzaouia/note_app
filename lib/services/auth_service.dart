import 'package:firebase_auth/firebase_auth.dart';
import 'package:notebookapp/models/user.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  //create user object based o FireBaseUser
  userFromFireBase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Register wih Email and Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Sign In wih Email and Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Log out User
  Future logOut() async {
    try {
      await _auth.signOut();
      print('logOut of user');
    } catch (e) {
      print(e.toString());
    }
  }

  //get stream of the user
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => userFromFireBase(user));
  }

  //stream get user email

}
