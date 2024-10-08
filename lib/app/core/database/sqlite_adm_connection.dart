import 'package:app_tudo_list/app/core/database/sqlite_connection_factory.dart';
import 'package:flutter/cupertino.dart';

class SqliteAdmConnection with WidgetsBindingObserver{

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final connection = SqliteConnectionFactory();

    switch(state){

      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      connection.closeConnection();
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
    }

    super.didChangeAppLifecycleState(state);
  }

}