import 'package:flutter/foundation.dart';

class LoginProvider extends ChangeNotifier {
  String _email = "";
  String _password = "";

  String get email => _email;
  String get password => _password;

  void complete(String email, String password) {
    _email=email;
    String star="";
    for(int i=0;i<password.length;i++){
      star=star+"* ";
    }
    _password=star;
    notifyListeners();
  }
}