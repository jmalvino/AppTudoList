import 'package:app_tudo_list/global/app_color.dart';
import 'package:app_tudo_list/widgets/customButton.dart';
import 'package:app_tudo_list/widgets/customSnackBar.dart';
import 'package:app_tudo_list/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  final AppColors appColors = AppColors();

  @override
  void initState() {
    super.initState();
    emailController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';

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
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: confirmPasswordController,
                  obscureText: true,
                  isObscureText: true,
                  colorPrincipal: appColors.corPrimaria,
                  textFieldColor: appColors.colorTextField,
                ),
                const SizedBox(height: 15),
                CustomButton(
                  onpress: () {
                    if (emailController.text != '' && passwordController.text != '' && passwordController.text.length > 5) {
                      registerUser();
                      // emailController.clear();
                      // passwordController.clear();
                    } else {
                      CustomSnackBar(
                        color: Colors.red,
                        error: 'Verifique os campos',
                      ).show(context);
                    }
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

  Future<void> registerUser() async {
    if(confirmPasswordController.text != passwordController.text){
      CustomSnackBar(
        color: Colors.red,
        error: 'Senha não confere',
      ).show(context);
    }else{
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        final user = credential.user;
        print(user);

        //verifica se o e-mail foi verificado
        // if (user != null && !user.emailVerified) {
        //   messageError(Colors.red, 'E-mail não verificado, por favor verifique seu e-mail', context);
        // }

        CustomSnackBar(
          color: Colors.green,
          error: 'Cadastrado com sucesso!',
        ).show(context);
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'weak-password') {
          errorMessage = 'A senha fornecida é muito fraca.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'O email já está sendo usado em outra conta.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'O email fornecido é inválido.';
        } else {
          errorMessage = 'Erro ao cadastrar: ${e.message}';
        }
        CustomSnackBar(
          color: Colors.red,
          error: errorMessage,
        ).show(context);
      } catch (e) {
        CustomSnackBar(
          color: Colors.black,
          error: 'Ocorreu um erro inesperado.',
        ).show(context);
      }
    }

  }
}
