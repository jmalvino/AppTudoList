import 'package:app_tudo_list/app/core/notifier/default_change_notifier.dart';
import 'package:app_tudo_list/app/services/tasks/tasks_service.dart';

class TaskCreateController extends DefaultChangeNotifier {
  final TaskServices _taskServices;
  DateTime? _selectDate;

  TaskCreateController({required TaskServices taskServices}) : _taskServices = taskServices;

  set selectedDate(DateTime? selectedDate) {
    _selectDate = selectedDate;
    notifyListeners();
  }
  DateTime? get selectedDate => _selectDate;

  void save(String text) {

  }


}
