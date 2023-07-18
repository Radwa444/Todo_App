import 'package:todo/ui/database/model/User.dart';
import 'package:flutter/material.dart';
class AuthProvider extends ChangeNotifier{
  User? AccountUser;
  void updateUser(User Account){
    AccountUser=Account;
    notifyListeners();
  }
}
