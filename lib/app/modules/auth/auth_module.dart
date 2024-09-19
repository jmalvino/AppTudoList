import 'package:app_tudo_list/app/core/modules/todo_list_module.dart';
import 'package:app_tudo_list/app/modules/auth/login/login_controller.dart';
import 'package:app_tudo_list/app/modules/auth/login/login_page.dart';
import 'package:app_tudo_list/app/modules/auth/login/register_controller.dart';
import 'package:app_tudo_list/app/modules/auth/login/register_page.dart';
import 'package:provider/provider.dart';

class AuthModule extends TodoListModule {
  AuthModule()
      : super(bindings: [
          ChangeNotifierProvider(
            create: (_) => LoginController(),
          ),
          ChangeNotifierProvider(
            create: (_) => RegisterController(),
          ),
        ], routers: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
        });
}
