import 'package:app_tudo_list/app/repositories/tasks/task_repository.dart';
import 'package:app_tudo_list/app/services/tasks/tasks_service.dart';

class TaskServicesImplements implements TaskServices {
  final TaskRepository _taskRepository;

  TaskServicesImplements({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<void> save(DateTime date, String description) => _taskRepository.save(date, description);
}
