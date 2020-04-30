import 'package:flutter/foundation.dart';

class AuthNotifier extends ChangeNotifier {
  bool showSignIn = true;
  String error = '';
  bool isLoading = false;

  // change the value and notifier listener
  void toggleView() {
    showSignIn = !showSignIn;
    notifyListeners();
  }

  //update value error text
  updateError(String errorUser) {
    error = errorUser;
    notifyListeners();
  }

  //update the loading to ether false or true
  updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
