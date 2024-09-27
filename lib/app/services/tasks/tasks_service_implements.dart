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
    var starFilter = DateTime(today.year, today.month, today.weekday, 0, 0, 0);
    DateTime endFilter;

    if (starFilter.weekday != DateTime.monday) {
      starFilter = starFilter.subtract(Duration(days: (starFilter.weekday - 1)));
    }
    endFilter = starFilter.add(const Duration(days: 7));
    final tasks = await _taskRepository.findByPeriod(DateTime.now(), endFilter);

    return WeekTaskModel(staDate: starFilter, endDate: endFilter, tasks: tasks);
  }
}
