import 'package:app_tudo_list/app/core/notifier/default_change_notifier.dart';
import 'package:app_tudo_list/app/exception/auth_exceptions.dart';
import 'package:app_tudo_list/app/services/user/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService}) : _userService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
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

  Future<void> forgorPassword(String email) async{
    try{
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = 'Reset de senha enviado para seu e-mail!';
    } on AuthExepetions catch (e){
      setError(e.message);
    }catch (e){
      setError('Erro ao redefinir a senha!');
    } finally{
      hideLoading();
      notifyListeners();
    }

  }
}
