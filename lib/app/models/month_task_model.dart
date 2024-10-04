import 'package:app_tudo_list/app/models/task_model.dart';

class MonthTaskModel {
  final DateTime staDate;
  final DateTime endDate;
  final List<TaskModel> tasks;

  MonthTaskModel({
    required this.staDate,
    required this.endDate,
    required this.tasks,
  });
}