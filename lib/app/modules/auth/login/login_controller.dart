import 'package:app_tudo_list/app/core/notifier/default_change_notifier.dart';
import 'package:app_tudo_list/app/services/user/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;

  LoginController({required UserService userService}) : _userService = userService;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.login(email, password);
      if(user != null){
        success();
      }else{
        setError('Usuario ou senha inválidos');
      }
    } on FirebaseAuthException catch (e) {
      setError(e.message);
    }finally{
      hideLoading();
      notifyListeners();
    }
  }
}
