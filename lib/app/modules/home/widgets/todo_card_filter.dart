import 'package:app_tudo_list/global/app_color.dart';
import 'package:flutter/material.dart';

class TodoCardFilter extends StatelessWidget {
  final AppColors appColors;

  const TodoCardFilter({super.key, required this.appColors});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: appColors.secondColor);
    return Container(
      margin: const EdgeInsets.only(right: 10),
      constraints: const BoxConstraints(
        minHeight: 110,
        minWidth: 150,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: appColors.tetrialColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          height: 100,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.transparent,
            border: Border.all(color: appColors.corPrimaria, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('1 TESKS', style: textStyle),
                Text(
                  'HOJE',
                  style: TextStyle(
                    color: appColors.colorTextField,
                    fontSize: 20,
                  ),
                ),
                LinearProgressIndicator(
                  backgroundColor: appColors.secondColor,
                  valueColor: AlwaysStoppedAnimation<Color>(appColors.corPrimaria),
                  value: 0.4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
