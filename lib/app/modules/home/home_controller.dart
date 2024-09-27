import 'package:app_tudo_list/app/core/notifier/default_change_notifier.dart';
import 'package:app_tudo_list/app/models/enuns/task_filter_enum.dart';

class HomeController extends DefaultChangeNotifier{
  TaskFilterEnum filterSelected = TaskFilterEnum.today;

}