import 'package:flutter/material.dart';

class CustomSnackBar {
  final Color color;
  final String error;
  final BuildContext context;

  CustomSnackBar({
    required this.color,
    required this.error,
    required this.context,
  });

  void show() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(error),
      ),
    );
  }
}
