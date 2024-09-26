import 'package:app_tudo_list/app/core/database/sqlite_connection_factory.dart';
import 'package:app_tudo_list/app/repositories/tasks/task_repository.dart';

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
}
