import 'package:app_tudo_list/app/core/notifier/default_change_notifier.dart';
import 'package:app_tudo_list/app/models/enuns/task_filter_enum.dart';
import 'package:app_tudo_list/app/models/task_model.dart';
import 'package:app_tudo_list/app/models/total_task_model.dart';
import 'package:app_tudo_list/app/models/week_task_model.dart';
import 'package:app_tudo_list/app/services/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TaskServices _taskServices;
  TaskFilterEnum filterSelected = TaskFilterEnum.today;
  TotalTaskModel? todayTotalTasks;
  TotalTaskModel? tomorrowTotalTasks;
  TotalTaskModel? weekTotalTasks;

  HomeController({
    required TaskServices taskServices,
  }) : _taskServices = taskServices;

  Future<void> loadTotalTask() async {
    final allTask = await Future.wait([
      _taskServices.getToday(),
      _taskServices.getTomorrow(),
      _taskServices.getWeek(),
    ]);
    final todayTasks = allTask[0] as List<TaskModel>;
    final tomorrowTasks = allTask[1] as List<TaskModel>;
    final weekTasks = allTask[2] as WeekTaskModel;

    todayTotalTasks = TotalTaskModel(
      totalTask: todayTasks.length,
      totalTaskFinish: todayTasks.where((task) => task.finished).length,
    );
    tomorrowTotalTasks = TotalTaskModel(
      totalTask: tomorrowTasks.length,
      totalTaskFinish: tomorrowTasks.where((task) => task.finished).length,
    );
    weekTotalTasks = TotalTaskModel(
      totalTask: weekTasks.tasks.length,
      totalTaskFinish: weekTasks.tasks.where((task) => task.finished).length,
    );
    notifyListeners();
  }
}
