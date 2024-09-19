import 'package:app_tudo_list/app/modules/auth/login/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const LoginPage(),
      //   ),
      // );
      Navigator.of(context).pushNamed('/login');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: const Image(
              image: AssetImage('assets/images/logo_tudo_list.png'),
            ),
          ),
        ),
      ),
    );
  }
}
