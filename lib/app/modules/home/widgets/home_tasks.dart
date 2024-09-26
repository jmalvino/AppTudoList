import 'package:app_tudo_list/app/modules/home/widgets/task.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:flutter/material.dart';

class HomeTasks extends StatelessWidget {
  final AppColors appColors;
  const HomeTasks({super.key, required this.appColors});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: appColors.tetrialColor);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'TASK\'S DE HOJE',
            style: textStyle,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 500,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Task(appColors: appColors),
                  Task(appColors: appColors),
                  Task(appColors: appColors),
                  Task(appColors: appColors),
                  Task(appColors: appColors),
                  Task(appColors: appColors),
                  Task(appColors: appColors),
                  Task(appColors: appColors),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
