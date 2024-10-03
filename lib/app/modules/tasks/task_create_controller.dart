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

  Future<void> save(String description, String divide) async {
    if (description.isEmpty) {
      throw Exception('O texto da tarefa não pode estar vazio');
    }
    if (_selectDate == null) {
      throw Exception('A data não foi selecionada');
    }

    int repeatCount = int.tryParse(divide) ?? 1;
    DateTime currentDate = _selectDate!;

    for (int i = 0; i < repeatCount; i++) {
      await _taskServices.save(currentDate, i > 0 ? '$description (${i + 1}/$divide)' : description);
      currentDate = DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
    }

    notifyListeners();
  }

// Future<void> save(String description, String divide) async {
//   if (description.isEmpty) {
//     throw Exception('O texto da tarefa não pode estar vazio');
//   }
//   if (_selectDate == null) {
//     throw Exception('A data não foi selecionada');
//   }
//   await _taskServices.save(_selectDate!, description);
//   notifyListeners();
// }

// Future<void> delete(int id) async {
//   await _taskServices.delete(id);
//   notifyListeners();
// }
}
