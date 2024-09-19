import 'package:app_tudo_list/app/app_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppModule());
}
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       routes: {
//         '/auth/email_password/register': (_) => const RegisterPage(),
//         '/auth/email_password/login': (_) => const LoginPage(),
//         '/auth/email_password/user': (_) => const ShowUser(),
//       },
//       home: const MyHomePage(title: 'Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   void initState() {
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       print('Usario logado? ${user != null}');
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed('/auth/email_password/login');
//               },
//               child: const Text('Logar'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed('/auth/email_password/register');
//               },
//               child: const Text('Cadastre-se'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed('/auth/email_password/user');
//               },
//               child: const Text('Usuário'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//versão usada
// Flutter 3.13.2 • channel stable • https://github.com/flutter/flutter.git
// Framework • revision ff5b5b5fa6 (1 year, 1 month ago) • 2023-08-24 08:12:28 -0500
// Engine • revision b20183e040
// Tools • Dart 3.1.0 • DevTools 2.25.0

