import 'package:flutter/material.dart';

class AppColors {
  late Color corPrimaria;
  late Color buttonTextColor;
  late Color colorTextField;
  late Color secondColor;
  late Color tetrialColor;
  late Color bgColor;

  bool isModo = false;

  // Modo claro
  void lightModo() {
    corPrimaria = Colors.deepPurple;
    buttonTextColor = Colors.white;
    colorTextField = Colors.black;
    secondColor = const Color(0xFF616161);
    tetrialColor = const Color(0xFFE0E0E0);
    bgColor = const Color(0xFFEEEEEE);
  }

  // Modo escuro
  void darkModo() {
    corPrimaria = Colors.deepPurple;
    buttonTextColor = Colors.white;
    colorTextField = Colors.white;
    secondColor = const Color(0xFF707070);
    tetrialColor = const Color(0xFF757575);
    bgColor = const Color(0xFF303030);
  }
}
