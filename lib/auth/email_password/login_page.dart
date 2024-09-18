import 'package:app_tudo_list/auth/email_password/register_page.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:app_tudo_list/widgets/customButton.dart';
import 'package:app_tudo_list/widgets/customSnackBar.dart';
import 'package:app_tudo_list/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AppColors appColors = AppColors();

  @override
  void initState() {
    super.initState();

    // Verificar o modo e definir as cores
    if (appColors.isModo == false) {
      appColors.clearModo();
    } else {
      appColors.darkModo();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String nomeDoApp = "APP";
    var loginComGoogle = true;

    return Scaffold(
      backgroundColor: appColors.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const SizedBox(
                    width: 177,
                    child: Image(
                      image: AssetImage('assets/images/no-image.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bem vindo ao $nomeDoApp',
                        style: TextStyle(
                          color: appColors.colorTextField,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Entre com seu e-mail e senha para continuar',
                        style: TextStyle(
                          color: appColors.secondColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                            color: appColors.colorTextField,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextField(
                    hintText: 'Digite seu e-mail',
                    colorHint: appColors.secondColor,
                    controller: emailController,
                    obscureText: false,
                    isObscureText: false,
                    colorPrincipal: appColors.corPrimaria,
                    textFieldColor: appColors.colorTextField,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      children: [
                        Text('Senha', style: TextStyle(color: appColors.colorTextField)),
                      ],
                    ),
                  ),
                  CustomTextField(
                    hintText: 'Digite sua senha',
                    colorHint: appColors.secondColor,
                    controller: passwordController,
                    obscureText: true,
                    isObscureText: true,
                    colorPrincipal: appColors.corPrimaria,
                    textFieldColor: appColors.colorTextField,
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    onpress: () {
                      if (emailController.text != '' && passwordController.text != '' && passwordController.text.length > 5) {
                        loginUser();
                        // emailController.clear();
                        // passwordController.clear();
                      } else {
                        CustomSnackBar(
                          color: Colors.red,
                          context: context,
                          error: 'Verifique os campos',
                        ).show();
                      }
                    },
                    nameButton: 'Logar',
                    colorButton: appColors.corPrimaria,
                    colorTextButton: appColors.buttonTextColor,
                  ),
                  Visibility(
                    visible: loginComGoogle,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                color: appColors.tetrialColor,
                                child: const SizedBox(
                                  width: 100,
                                  height: 2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Ou login por',
                                style: TextStyle(color: appColors.secondColor),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: appColors.tetrialColor,
                                width: 100,
                                child: const SizedBox(
                                  height: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomButton(
                          onpress: () {
                            if (emailController.text != '' && passwordController.text != '' && passwordController.text.length > 5) {
                              loginUser();
                              // emailController.clear();
                              // passwordController.clear();
                            } else {
                              CustomSnackBar(
                                color: Colors.red,
                                context: context,
                                error: 'Verifique os campos',
                              ).show();
                            }
                          },
                          nameButton: 'Google',
                          imagePath: 'assets/images/icon-google.png',
                          colorButton: appColors.corPrimaria,
                          colorTextButton: appColors.buttonTextColor,
                        ),
                      ],
                    ),
                  ),
                  //Cadastro
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Não tem conta?',
                          style: TextStyle(color: appColors.secondColor),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                        },
                        child: Text(
                          'Cadastre-se',
                          style: TextStyle(
                            color: appColors.secondColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 7,
                right: 7,
                child: IconButton(
                  icon: Icon(
                    appColors.isModo ? Icons.gps_off : Icons.sunny,
                    color: appColors.corPrimaria,
                  ),
                  onPressed: () {
                    setState(() {
                      appColors.isModo = !appColors.isModo;
                      if (appColors.isModo) {
                        appColors.darkModo();
                      } else {
                        appColors.clearModo();
                      }
                    });
                  },
                ),
              ),
            ],
          ),
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
      CustomSnackBar(
        color: Colors.green,
        context: context,
        error: 'Login realizado com sucesso!',
      ).show();
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'Nenhum usuário encontrado com este email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Senha incorreta. Tente novamente.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'O email fornecido é inválido.';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'Credenciais inválidas';
      } else {
        errorMessage = 'Erro ao fazer login: ${e.message}';
      }

      CustomSnackBar(
        color: Colors.red,
        context: context,
        error: errorMessage,
      ).show();
    } catch (e) {
      CustomSnackBar(
        color: Colors.black,
        context: context,
        error: 'Ocorreu um erro inesperado.',
      ).show();
    }
  }
}
