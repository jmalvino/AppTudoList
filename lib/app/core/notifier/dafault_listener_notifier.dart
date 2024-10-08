import 'package:app_tudo_list/app/core/notifier/default_change_notifier.dart';
import 'package:app_tudo_list/widgets/customSnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class DefaultListenerNotifier {
  final DefaultChangeNotifier changeNotifier;

  DefaultListenerNotifier({
    required this.changeNotifier,
  });

  void listener({
    required BuildContext context,
    required SuccessVoidCallback successCallback,
    EverVoidCallback? everCallback,
    ErrorVoidCallback? errorCallback,
  }) {
    changeNotifier.addListener(() {
      if (everCallback != null) {
        everCallback(changeNotifier, this);
      }
      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }
      if (changeNotifier.hasError) {
        CustomSnackBar(color: Colors.orange, error: changeNotifier.error ?? 'Erro Interno').show(context);
      } else if (changeNotifier.isSuccess) {
        successCallback(changeNotifier, this);
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidCallback = void Function(
  DefaultChangeNotifier notifier,
  DefaultListenerNotifier listenerInstance,
);
typedef EverVoidCallback = void Function(
  DefaultChangeNotifier notifier,
  DefaultListenerNotifier listenerInstance,
);
typedef ErrorVoidCallback = void Function(
  DefaultChangeNotifier notifier,
  DefaultListenerNotifier listenerInstance,
);
