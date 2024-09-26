import 'package:app_tudo_list/app/core/modules/todo_list_module.dart';
import 'package:app_tudo_list/app/modules/tasks/task_create_controller.dart';
import 'package:app_tudo_list/app/modules/tasks/task_create_page.dart';
import 'package:app_tudo_list/app/repositories/tasks/task_repository.dart';
import 'package:app_tudo_list/app/repositories/tasks/task_repository_implements.dart';
import 'package:app_tudo_list/app/services/tasks/tasks_service.dart';
import 'package:app_tudo_list/app/services/tasks/tasks_service_implements.dart';
import 'package:provider/provider.dart';

class TaskModule extends TodoListModule {
  TaskModule()
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
              create: (context) => TaskCreateController(
                taskServices: context.read(),
              ),
            )
          ],
          routers: {
            '/task/create': (context) => TaskCreatePage(
                  controller: context.read(),
                ),
          },
        );
}
