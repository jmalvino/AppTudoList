import 'package:app_tudo_list/app/core/modules/todo_list_module.dart';
import 'package:app_tudo_list/app/modules/home/home_controller.dart';
import 'package:app_tudo_list/app/modules/home/home_page.dart';
import 'package:app_tudo_list/app/repositories/tasks/task_repository.dart';
import 'package:app_tudo_list/app/repositories/tasks/task_repository_implements.dart';
import 'package:app_tudo_list/app/services/tasks/tasks_service.dart';
import 'package:app_tudo_list/app/services/tasks/tasks_service_implements.dart';
import 'package:provider/provider.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          bindings: [
            Provider<TaskRepository>(
              create: (context) => TaskRepositoryImplements(
                sqliteConnectionFactory: context.read(),
              ),
            ),
            Provider<TaskServices>(
              create: (context) => TaskServicesImplements(
                taskRepository: context.read(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => HomeController(taskServices: context.read()),
            ),
          ],
          routers: {
            '/home': (context) => HomePage(homeController: context.read()),
          },
        );
}
