import 'package:app_tudo_list/app/core/navigator/todo_list_navigator.dart';
import 'package:app_tudo_list/app/services/user/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;

  AuthProvider({
    required FirebaseAuth firebaseAuth,
    required UserService userService,
  })
      : _firebaseAuth = firebaseAuth,
        _userService = userService;

  Future<void> logout() => _userService.logout();

  User? get user => _firebaseAuth.currentUser;

  void loadListener() {
    Future.delayed(const Duration(seconds: 2), () {
      _firebaseAuth.userChanges().listen((_) => notifyListeners());
      _firebaseAuth.authStateChanges().listen((user) {
        if (user != null) {
          TodoListNavigator.to.pushNamedAndRemoveUntil('/home', (route) => false);
        } else {
          TodoListNavigator.to.pushNamedAndRemoveUntil('/login', (route) => false);
        }
      });
    }
    );
  }


}
