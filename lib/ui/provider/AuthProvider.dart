import 'package:todo/ui/database/model/User.dart';
import 'package:flutter/material.dart';
class AuthProvider extends ChangeNotifier{
  String locale ='en';
  changelanganeEN(){
    locale='en';
    notifyListeners();
  }
  changelanganeAR(){
    locale='ar';
    notifyListeners();
  }

  User? AccountUser;
  void updateUser(User Account){
    AccountUser=Account;
    notifyListeners();
  }
}

