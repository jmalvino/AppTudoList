import 'package:app_tudo_list/app/app_widget.dart';
import 'package:app_tudo_list/app/core/auth/auth_provider.dart' as firebaseAuthProvider;
import 'package:app_tudo_list/app/core/database/sqlite_connection_factory.dart';
import 'package:app_tudo_list/app/modules/tasks/task_create_controller.dart';
import 'package:app_tudo_list/app/repositories/tasks/task_repository_implements.dart';
import 'package:app_tudo_list/app/repositories/user/user_repository.dart';
import 'package:app_tudo_list/app/repositories/user/user_repository_implements.dart';
import 'package:app_tudo_list/app/services/user/user_service.dart';
import 'package:app_tudo_list/app/services/user/user_service_implements.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false,
        ),
        Provider<TaskRepositoryImplements>(
          create: (_) => TaskRepositoryImplements(sqliteConnectionFactory: SqliteConnectionFactory()),
        ),
        Provider<TaskCreateController>(
          create: (_) => TaskCreateController(taskServices: context.read()),
        ),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImplements(firebaseAuth: context.read()),
        ),
        Provider<UserService>(
          create: (context) => UserServiceImplements(userRepository: context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => firebaseAuthProvider.AuthProvider(firebaseAuth: context.read(), userService: context.read())..loadListener(),
          lazy: false,
        ),
      ],
      child: const AppWidget(),
    );
  }
}
