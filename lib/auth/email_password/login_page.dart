import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Logar',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                label: Text('E-mail'),
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                label: Text('Senha'),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if(emailController.text != '' && passwordController.text != '' && passwordController.text.length > 5){
                  loginUser();
                  // emailController.clear();
                  // passwordController.clear();

                }else{
                  messageError(Colors.red,'Verifique os campos', context);
                }
              },
              child: Text('Logar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print(credential.user?.email);

      //Verificação de e-mail. envia um e-mail para verificar o cadastro
      //credential.user?.sendEmailVerification();
      // print(credential.user?.emailVerified);

      messageError(Colors.green, 'Login realizado com sucesso!', context);
    } on FirebaseAuthException catch (e) {

      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'Nenhum usuário encontrado com este email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Senha incorreta. Tente novamente.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'O email fornecido é inválido.';
      } else {
        errorMessage = 'Erro ao fazer login: ${e.message}';
      }

      messageError(Colors.red, errorMessage, context);
    } catch (e) {
      messageError(Colors.black, 'Ocorreu um erro inesperado.', context);
    }
  }

}

messageError(Color color, String error, context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(error),
    ),
  );
}
