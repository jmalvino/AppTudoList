import 'package:app_tudo_list/app/core/notifier/default_change_notifier.dart';
import 'package:app_tudo_list/app/models/all_task_model.dart';
import 'package:app_tudo_list/app/models/enuns/task_filter_enum.dart';
import 'package:app_tudo_list/app/models/month_task_model.dart';
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
  TotalTaskModel? monthTotalTasks;
  TotalTaskModel? allTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateOfWeek;
  DateTime? initialDateOfAll;
  DateTime? initialDateOfMonth;
  DateTime? selectedDay;
  bool showFinishingTasks = false;

  HomeController({
    required TaskServices taskServices,
  }) : _taskServices = taskServices;

  Future<void> loadTotalTask() async {
    final allTask = await Future.wait([
      _taskServices.getToday(),
      _taskServices.getTomorrow(),
      _taskServices.getWeek(),
      _taskServices.getMonth(),
      _taskServices.getAll(),
    ]);
    final todayTasks = allTask[0] as List<TaskModel>;
    final tomorrowTasks = allTask[1] as List<TaskModel>;
    final weekTasks = allTask[2] as WeekTaskModel;
    final monthTasks = allTask[3] as MonthTaskModel;
    final allTasks = allTask[4] as AllTaskModel;

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
    monthTotalTasks = TotalTaskModel(
      totalTask: monthTasks.tasks.length,
      totalTaskFinish: monthTasks.tasks.where((task) => task.finished).length,
    );
    allTotalTasks = TotalTaskModel(
      totalTask: allTasks.tasks.length,
      totalTaskFinish: allTasks.tasks.where((task) => task.finished).length,
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
      case TaskFilterEnum.month:
        final monthModel = await _taskServices.getMonth();
        initialDateOfAll = monthModel.staDate;
        tasks = monthModel.tasks;
        break;
      case TaskFilterEnum.all:
        final allModel = await _taskServices.getAll();
        initialDateOfAll = allModel.staDate;
        tasks = allModel.tasks;
        break;
    }
    filteredTasks = tasks;
    allTasks = tasks;

    if (filter == TaskFilterEnum.week) {
      if (initialDateOfWeek != null) {
        filterByDate(initialDateOfWeek!);
      }
    }

    if (filter == TaskFilterEnum.month) {
      if (initialDateOfMonth != null) {
        filterByDate(initialDateOfMonth!);
      }
    }

    if(!showFinishingTasks){
      filteredTasks = filteredTasks.where((task) => !task.finished).toList();
    }

    hideLoading();
    notifyListeners();
  }

  Future<void> findTaskNoCheck({required TaskFilterEnum filter}) async {
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
      case TaskFilterEnum.month:
        final monthModel = await _taskServices.getMonth();
        initialDateOfAll = monthModel.staDate;
        tasks = monthModel.tasks;
        break;
      case TaskFilterEnum.all:
        final allModel = await _taskServices.getAll();
        initialDateOfAll = allModel.staDate;
        tasks = allModel.tasks;
        break;
    }
    filteredTasks = tasks;
    allTasks = tasks;

    if (filter == TaskFilterEnum.week) {
      if (initialDateOfWeek != null) {
        filterByDate(initialDateOfWeek!);
      }
    }

    if (filter == TaskFilterEnum.month) {
      if (initialDateOfAll != null) {
        filterByDate(initialDateOfMonth!);
      }
    }

    if (filter == TaskFilterEnum.all) {
      if (initialDateOfAll != null) {
        filterByDate(initialDateOfAll!);
      }
    }

    if(!showFinishingTasks){
      filteredTasks = filteredTasks.where((task) => !task.finished).toList();
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
    filteredTasks = allTasks.where((task) {
      return task.dateTime == date;
    }).toList();
    notifyListeners();
    // filteredTask = allTasks.where((task) => DateUtils.isSameDay(task.dateTime, date)).toList();
  }

  Future<void> checkOrUncheckTask(TaskModel task) async {
    showLoadingAndResetState();
    notifyListeners();

    final taskUpdate = task.copyWith(
      finished: !task.finished,
    );
    await _taskServices.checkOrUncheckTask(taskUpdate);
    hideLoading();
    refreshPage();
  }

  void showOrHideFinishingTasks(){
    showFinishingTasks = !showFinishingTasks;
    refreshPage();
  }


}
