import 'package:app_tudo_list/app/models/task_model.dart';

class WeekTaskModel {
  final DateTime staDate;
  final DateTime endDate;
  final List<TaskModel> tasks;

  WeekTaskModel({
    required this.staDate,
    required this.endDate,
    required this.tasks,
  });
}