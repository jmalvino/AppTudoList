import 'package:app_tudo_list/app/models/all_task_model.dart';
import 'package:app_tudo_list/app/models/month_task_model.dart';
import 'package:app_tudo_list/app/models/task_model.dart';
import 'package:app_tudo_list/app/models/week_task_model.dart';

abstract class TaskServices{
  Future<void> save(DateTime date, String description);
  Future<void> delete(int id);
  Future<List<TaskModel>> getToday();
  Future<List<TaskModel>> getTomorrow();
  Future<WeekTaskModel> getWeek();
  Future<MonthTaskModel> getMonth();
  Future<AllTaskModel> getAll();
  Future<void> checkOrUncheckTask(TaskModel task);
}