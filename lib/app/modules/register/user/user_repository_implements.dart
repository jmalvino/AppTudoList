import 'package:app_tudo_list/app/exception/auth_exceptions.dart';
import 'package:app_tudo_list/app/modules/register/user/user_repository.dart';
import 'package:app_tudo_list/widgets/customSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Future<User?> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthExepetions(message: e.message ?? 'Erro ao realizar login!');
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'Nenhum usuário encontrado com este e-mail.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'A senha está incorreta. Por favor, tente novamente.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'O email fornecido é inválido.';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'Esta conta foi desativada. Entre em contato com o suporte.';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'Erro de Credencial.';
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Bloqueamos todas as solicitações deste dispositivo devido a atividade incomum. Tente novamente mais tarde.';
      } else {
        print("ERRO DO FIREBASE: ${e.message}");
        errorMessage = 'Erro ao tentar fazer login. Tente novamente mais tarde.';
      }
      // CustomSnackBar(color: Colors.red, error: errorMessage); FALTA O CONTEXTO PARA FUNCIONAR .show(context)
      throw AuthExepetions(message: 'Erro ao logar, motivo $errorMessage');
    }
  }

  @override
  Future<void> forgorPassword(String email) async {
    final loginMethods = await _firebaseAuth.fetchSignInMethodsForEmail(email);

    try {
      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if(loginMethods.contains('google')){
        throw AuthExepetions(message: 'Cadastro realizado com o Google, senha não pode ser redefinida!');
      }else {
        throw AuthExepetions(message: 'E-mail não cadastrado!');
      }
    } on PlatformException catch (e, s) {
      print('ERRROORR: $e');
      print('ERRROORR: $s');
      throw AuthExepetions(message: 'Erro ao resetar senha!');
    }
  }
}
