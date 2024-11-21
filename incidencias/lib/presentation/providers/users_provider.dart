import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginappgoogle/config/helpers/get_authorized_users.dart';
import 'package:loginappgoogle/presentation/entities/user_authorized.dart';

class UsersProvider extends ChangeNotifier {
  List<UserAuthorized> usersList = [];

  Future<void> chargeAuthorizedUsers() async {
    usersList = await GetAuthorizedUsers().getHttp();
    notifyListeners();
  }

  bool isAuthorized(String? email) {
    bool isAuthorized = false;
    for (UserAuthorized user in usersList) {
      user.mail == email ? isAuthorized = true : isAuthorized;
    }
    return isAuthorized;
  }

  Future<void> logOut() async {
    FirebaseAuth.instance.signOut();
  }

 
}
