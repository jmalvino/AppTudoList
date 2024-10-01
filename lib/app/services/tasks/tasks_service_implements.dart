import 'package:app_tudo_list/app/models/task_model.dart';
import 'package:app_tudo_list/app/models/week_task_model.dart';
import 'package:app_tudo_list/app/repositories/tasks/task_repository.dart';
import 'package:app_tudo_list/app/services/tasks/tasks_service.dart';

class TaskServicesImplements implements TaskServices {
  final TaskRepository _taskRepository;

  TaskServicesImplements({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<void> save(DateTime date, String description) => _taskRepository.save(date, description);

  @override
  Future<List<TaskModel>> getToday() {
    return _taskRepository.findByPeriod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    var tomorrowDate = DateTime.now().add(const Duration(days: 1));
    return _taskRepository.findByPeriod(tomorrowDate, tomorrowDate);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();
    var startFilter = today.subtract(Duration(days: today.weekday - 1));
    var endFilter = startFilter.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
    final tasks = await _taskRepository.findByPeriod(startFilter, endFilter);
    return WeekTaskModel(staDate: startFilter, endDate: endFilter, tasks: tasks);
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) => _taskRepository.checkOrUncheckTask(task);

  @override
  Future<void> delete(int id) => _taskRepository.delete(id);

}
