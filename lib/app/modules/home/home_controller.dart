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
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateOfWeek;
  DateTime? selectedDay;

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

  Future<void> findTask({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _taskServices.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _taskServices.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _taskServices.getWeek();
        initialDateOfWeek = weekModel.staDate;
        tasks = weekModel.tasks;
        break;
    }
    filteredTasks = tasks;
    allTasks = tasks;

    if (filter == TaskFilterEnum.week) {
      if (initialDateOfWeek != null) {
        filterByDate(initialDateOfWeek!);
      }
    }

    hideLoading();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTask(filter: filterSelected);
    await loadTotalTask();
    notifyListeners();
  }

  void filterByDate(DateTime date) {
    selectedDay = date;
    filteredTasks = allTasks.where((task){
      return task.dateTime == date;
    }).toList();
    notifyListeners();
    // filteredTask = allTasks.where((task) => DateUtils.isSameDay(task.dateTime, date)).toList();
  }
}
