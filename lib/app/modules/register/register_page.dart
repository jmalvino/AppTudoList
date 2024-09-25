import 'package:app_tudo_list/app/core/notifier/dafault_listener_notifier.dart';
import 'package:app_tudo_list/app/modules/register/register_controller.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:app_tudo_list/widgets/customButton.dart';
import 'package:app_tudo_list/widgets/customSnackBar.dart';
import 'package:app_tudo_list/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final AppColors appColors = AppColors();

  @override
  void initState() {
    super.initState();
    _emailController.text = '';
    _passwordController.text = '';
    _confirmPasswordController.text = '';

    final defaultListener = DefaultListenerNotifier(changeNotifier: context.read<RegisterController>());
    defaultListener.listener(
      context: context,
      successCallback: (notifier, listenerInstance) {
        // listenerInstance.dispose();
        Navigator.of(context).pushNamed('/login');
        CustomSnackBar(color: Colors.green, error: 'Conta cadastrada com sucesso!').show(context);
      },
    );
    // context.read<RegisterController>().addListener((){});
    // var controller = context.read<RegisterController>();
    // var success = controller.success;
    // var error = controller.error;
    // if(success){
    //   Navigator.of(context).pop();
    // }else if(error != null && error.isNotEmpty){
    //   CustomSnackBar(
    //     color: Colors.red,
    //     error: 'Aconteceu um erro ao verificar conta! $error',
    //   ).show(context);
    // }

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
    // context.read<RegisterController>().removeListener(() { });
    // _emailController.dispose();
    // _passwordController.dispose();
    // _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: appColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: appColors.secondColor),
        backgroundColor: appColors.bgColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cadastro',
              style: TextStyle(color: appColors.secondColor),
            ),
            IconButton(
              icon: Icon(appColors.isModo ? Icons.sunny : Icons.gps_off),
              onPressed: () {
                setState(() {
                  appColors.isModo = !appColors.isModo;
                  if (appColors.isModo) {
                    appColors.lightModo();
                  } else {
                    appColors.darkModo();
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: forKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  validator: Validatorless.multiple([Validatorless.required('E-mail obrigatório!'), Validatorless.email('E-mail inválido!')]),
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
                    Validatorless.required('Senha obrigatória'),
                    Validatorless.min(6, 'Senha deve ter no mínimo 6 caracteres!'),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      Text('Confirmar Senha', style: TextStyle(color: appColors.colorTextField)),
                    ],
                  ),
                ),
                CustomTextField(
                  hintText: 'Confirme sua senha',
                  colorHint: appColors.secondColor,
                  controller: _confirmPasswordController,
                  obscureText: true,
                  isObscureText: true,
                  colorPrincipal: appColors.corPrimaria,
                  textFieldColor: appColors.colorTextField,
                  validator: Validatorless.multiple([
                    Validatorless.compare(_passwordController, 'Os campos de senha não correspondem, verifique!'),
                  ]),
                ),
                const SizedBox(height: 15),
                CustomButton(
                  onpress: () {
                    final formValid = forKey.currentState?.validate() ?? false;
                    if(formValid){
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      context.read<RegisterController>().registerUser(email, password);
                    }

                    // registerUser();
                    // if (_emailController.text != '' && _passwordController.text != '' && _passwordController.text.length > 5) {
                    //   registerUser();
                    //   // emailController.clear();
                    //   // passwordController.clear();
                    // } else {
                    //   CustomSnackBar(
                    //     color: Colors.red,
                    //     error: 'Verifique os campos',
                    //   ).show(context);
                    // }
                  },
                  nameButton: 'Salvar',
                  colorButton: appColors.corPrimaria,
                  colorTextButton: appColors.buttonTextColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> registerUser() async {
  //   if (_confirmPasswordController.text != _passwordController.text) {
  //     CustomSnackBar(
  //       color: Colors.red,
  //       error: 'Senha não confere',
  //     ).show(context);
  //   } else {
  //     try {
  //       final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: _emailController.text,
  //         password: _passwordController.text,
  //       );
  //
  //       final user = credential.user;
  //       print('CREDENCIAL DO USUARIO : $user');
  //
  //       //verifica se o e-mail foi verificado
  //       // if (user != null && !user.emailVerified) {
  //       //   messageError(Colors.red, 'E-mail não verificado, por favor verifique seu e-mail', context);
  //       // }
  //
  //       clearTextField();
  //
  //       /// O certo é entrar na pagina principal logado!!
  //       // Navigator.of(context).pushNamed('/login');
  //
  //       CustomSnackBar(
  //         color: Colors.green,
  //         error: 'Cadastrado com sucesso!',
  //       ).show(context);
  //     } on FirebaseAuthException catch (e) {
  //       String errorMessage;
  //       if (e.code == 'weak-password') {
  //         errorMessage = 'A senha fornecida é muito fraca.';
  //       } else if (e.code == 'email-already-in-use') {
  //         errorMessage = 'O email já está sendo usado em outra conta.';
  //       } else if (e.code == 'invalid-email') {
  //         errorMessage = 'O email fornecido é inválido.';
  //       } else {
  //         errorMessage = 'Erro ao cadastrar: ${e.message}';
  //       }
  //       CustomSnackBar(
  //         color: Colors.red,
  //         error: errorMessage,
  //       ).show(context);
  //     } catch (e) {
  //       CustomSnackBar(
  //         color: Colors.black,
  //         error: 'Ocorreu um erro inesperado.',
  //       ).show(context);
  //     }
  //   }
  // }

  void clearTextField() {
    _emailController.text = '';
    _passwordController.text = '';
    _confirmPasswordController.text = '';
  }
}
