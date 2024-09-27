import 'package:app_tudo_list/app/core/database/sqlite_connection_factory.dart';
import 'package:app_tudo_list/app/repositories/tasks/task_repository.dart';

import '../../models/task_model.dart';

class TaskRepositoryImplements implements TaskRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  TaskRepositoryImplements({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(
      'todo',
      {
        'id': null,
        'descricao': description,
        'data_hora': date.toIso8601String(),
        'finalizado': 0,
      },
    );
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final starFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
      '''
   select *
   from todo
   where data_hora betweem ? and ?
   order by data_hora
   ''',
      [
        starFilter.toIso8601String(),
        endFilter.toIso8601String(),
      ],
    );
    return result.map((e) => TaskModel.loadFromDB(e)).toList();
  }
}
