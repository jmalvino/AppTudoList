import 'package:app_tudo_list/app/core/modules/todo_list_module.dart';
import 'package:app_tudo_list/app/modules/home/home_page.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          // bindings: [],
          routers: {
            '/home' : (context) => HomePage(),
          },
        );
}
