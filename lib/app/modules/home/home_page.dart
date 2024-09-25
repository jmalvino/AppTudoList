import 'package:app_tudo_list/app/core/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Column(
            children: [
              ElevatedButton(onPressed: (){
                context.read<AuthProvider>().logout();
              }, child: const Text('Logout')),
            ],
          ),
        ),
      ),
    );
  }
}
