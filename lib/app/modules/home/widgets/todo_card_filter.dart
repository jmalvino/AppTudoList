import 'dart:ffi';

import 'package:app_tudo_list/app/models/enuns/task_filter_enum.dart';
import 'package:app_tudo_list/app/models/total_task_model.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:flutter/material.dart';

class TodoCardFilter extends StatelessWidget {
  final AppColors appColors;
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTaskModel? totalTaskModel;
  final bool selected;

  const TodoCardFilter({
    super.key,
    required this.appColors,
    required this.label,
    required this.taskFilter,
    this.totalTaskModel,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    var textStyle = selected
        ? TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white.withAlpha(80))
        : TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: appColors.secondColor);
    return Container(
      margin: const EdgeInsets.only(right: 10),
      constraints: const BoxConstraints(
        minHeight: 110,
        minWidth: 150,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: selected ? appColors.corPrimaria : appColors.tetrialColor.withAlpha(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          height: 100,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.transparent,
            border: Border.all(color: selected ? Colors.white.withAlpha(80) : appColors.corPrimaria, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${totalTaskModel?.totalTask ?? 0} TESKS', style: textStyle),
                Text(
                  label,
                  style: TextStyle(
                    color: selected ? Colors.white :appColors.colorTextField,
                    fontSize: 20,
                  ),
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween(
                    end: _getPercentFinish(),
                    begin: 0.0,
                  ),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      value: value,
                      backgroundColor: selected ? Colors.white.withAlpha(70) : appColors.tetrialColor,
                      valueColor: AlwaysStoppedAnimation<Color>(selected ? Colors.white.withAlpha(80) : appColors.corPrimaria),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _getPercentFinish() {
    final total = totalTaskModel?.totalTask ?? 0.0;
    final totalFinish = totalTaskModel?.totalTaskFinish ?? 0.1;

    if (total == 0) {
      return 0;
    }
    final percent = (totalFinish * 100) / total;

    return percent / 100;
  }
}
