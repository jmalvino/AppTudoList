import 'package:flutter/material.dart';

class CustomSnackBar {
  final Color color;
  final String error;

  CustomSnackBar({
    required this.color,
    required this.error,
  });

  void show(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(error),
      ),
    );
  }
}
