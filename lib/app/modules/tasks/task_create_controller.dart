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

  Future<void> save(String description) async {
    if (description.isEmpty) {
      throw Exception('O texto da tarefa não pode estar vazio');
    }
    if (_selectDate == null) {
      throw Exception('A data não foi selecionada');
    }
    await _taskServices.save(_selectDate!, description);
    notifyListeners();
  }

  // Future<void> delete(int id) async {
  //   await _taskServices.delete(id);
  //   notifyListeners();
  // }


}
