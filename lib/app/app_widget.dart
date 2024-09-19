import 'package:app_tudo_list/app/core/database/sqlite_adm_connection.dart';
import 'package:app_tudo_list/app/modules/auth/auth_module.dart';
import 'package:app_tudo_list/app/modules/auth/login/login_controller.dart';
import 'package:app_tudo_list/app/modules/auth/login/login_page.dart';
import 'package:app_tudo_list/app/modules/splash/splah_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  var sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tarefas - TUDO List',
      routes: {
        ...AuthModule().routers
      },
      home: const SplashPage(),
    );
  }
}
