import 'package:app_tudo_list/app/exception/auth_exceptions.dart';
import 'package:app_tudo_list/app/modules/register/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImplements implements UserRepository {
  FirebaseAuth _firebaseAuth;

  UserRepositoryImplements({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredencial.user;
      print(user);

      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'A senha fornecida é muito fraca.';
      } else if (e.code == 'email-already-in-use') {
        final loginTypes = await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthExepetions(message: 'E-mail já utlizado, por favor escolha outro e-mail!');
        } else {
          throw AuthExepetions(message: 'Você se cadastrou com uma conta google, utilize a conta google para entrar!');
        }
      } else if (e.code == 'invalid-email') {
        errorMessage = 'O email fornecido é inválido.';
      } else {
        print("ERRO DO FIREBASE ${e.message}");
        errorMessage = 'Erro ao registrar usurário';
      }
    }
  }
}
