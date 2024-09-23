import 'package:app_tudo_list/app/core/notifier/dafault_listener_notifier.dart';
import 'package:app_tudo_list/app/modules/auth/login/login_controller.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:app_tudo_list/widgets/customButton.dart';
import 'package:app_tudo_list/widgets/customSnackBar.dart';
import 'package:app_tudo_list/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AppColors appColors = AppColors();

  @override
  void initState() {
    super.initState();
    _emailController.text = '';
    _passwordController.text = '';

    DefaultListenerNotifier(changeNotifier: context.read<LoginController>()).listener(
      context: context,
      successCallback: (notifier, listenerInstance) {
        print("LOGOU COM SUCESSO!");
      },
    );

    // Verificar o modo e definir as cores
    if (appColors.isModo == false) {
      appColors.darkModo();
    } else {
      appColors.lightModo();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
                  SizedBox(
                    width: 177,
                    child: Image(
                      image: appColors.isModo ? const AssetImage('assets/images/logo_tudo_list2.png') : const AssetImage('assets/images/logo_tudo_list.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
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
                    controller: _emailController,
                    obscureText: false,
                    isObscureText: false,
                    colorPrincipal: appColors.corPrimaria,
                    textFieldColor: appColors.colorTextField,
                    validator: Validatorless.multiple([
                      Validatorless.email('Digite um e-mail válido!'),
                    ]),
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
                    controller: _passwordController,
                    obscureText: true,
                    isObscureText: true,
                    colorPrincipal: appColors.corPrimaria,
                    textFieldColor: appColors.colorTextField,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória!'),
                      Validatorless.min(6, 'A senha deve ser maior que 5 caractér!'),
                    ]),
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    onpress: () {
                      final formValid = _formKey.currentState?.validate() ?? false;
                      if(formValid){
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        context.read<LoginController>().login(email, password);
                      }

                      // loginUser();
                      // if (emailController.text != '' && passwordController.text != '' && passwordController.text.length > 5) {
                      //   loginUser();
                      //   // emailController.clear();
                      //   // passwordController.clear();
                      // } else {
                      //   CustomSnackBar(
                      //     color: Colors.red,
                      //     error: 'Verifique os campos',
                      //   ).show(context);
                      // }
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

                            // if (_emailController.text != '' && _passwordController.text != '' && _passwordController.text.length > 5) {
                            //   // loginUser();
                            //   // emailController.clear();
                            //   // passwordController.clear();
                            // } else {
                            //   CustomSnackBar(
                            //     color: Colors.red,
                            //     error: 'Verifique os campos',
                            //   ).show(context);
                            // }
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
                      Text(
                        'Não tem conta?',
                        style: TextStyle(color: appColors.secondColor),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/register');
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(color: appColors.secondColor),
                      ),
                      TextButton(
                        onPressed: () {
                         if(_emailController.text.isNotEmpty){
                           //recuperarSenha
                         }else{
                           CustomSnackBar(error: 'Digite um e-mail para recuperar senha',color: Colors.red).show(context);
                         }
                        },
                        child: Text(
                          'Redefinir',
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
                    appColors.isModo ? Icons.sunny : Icons.gps_off,
                    color: appColors.corPrimaria,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        appColors.isModo = !appColors.isModo;
                        if (appColors.isModo) {
                          appColors.lightModo();
                        } else {
                          appColors.darkModo();
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> loginUser() async {
  //   try {
  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: _emailController.text,
  //       password: _passwordController.text,
  //     );
  //     print(credential.user?.email);
  //
  //     //Verificação de e-mail. envia um e-mail para verificar o cadastro
  //     //credential.user?.sendEmailVerification();
  //     // print(credential.user?.emailVerified);
  //     CustomSnackBar(
  //       color: Colors.green,
  //       error: 'Login realizado com sucesso!',
  //     ).show(context);
  //   } on FirebaseAuthException catch (e) {
  //     String errorMessage;
  //     if (e.code == 'user-not-found') {
  //       errorMessage = 'Nenhum usuário encontrado com este email.';
  //     } else if (e.code == 'wrong-password') {
  //       errorMessage = 'Senha incorreta. Tente novamente.';
  //     } else if (e.code == 'invalid-email') {
  //       errorMessage = 'O email fornecido é inválido.';
  //     } else if (e.code == 'invalid-credential') {
  //       errorMessage = 'Credenciais inválidas';
  //     } else {
  //       errorMessage = 'Erro ao fazer login: ${e.message}';
  //     }
  //
  //     CustomSnackBar(
  //       color: Colors.red,
  //       error: errorMessage,
  //     ).show(context);
  //   } catch (e) {
  //     CustomSnackBar(
  //       color: Colors.black,
  //       error: 'Ocorreu um erro inesperado.',
  //     ).show(context);
  //   }
  // }
}
