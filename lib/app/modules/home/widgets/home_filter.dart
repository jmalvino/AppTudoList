import 'package:app_tudo_list/app/models/enuns/task_filter_enum.dart';
import 'package:app_tudo_list/app/models/total_task_model.dart';
import 'package:app_tudo_list/app/modules/home/home_controller.dart';
import 'package:app_tudo_list/app/modules/home/widgets/todo_card_filter.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeFilter extends StatelessWidget {
  final AppColors appColors;

  const HomeFilter({super.key, required this.appColors});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: appColors.tetrialColor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'FILTROS',
          style: textStyle,
        ),
        const SizedBox(
          height: 15,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                appColors: appColors,
                label: 'HOJE',
                taskFilter: TaskFilterEnum.today,
                totalTaskModel: TotalTaskModel(totalTask: 10, totalTaskFinish: 5),
                selected: context.select<HomeController, TaskFilterEnum>((value) => value.filterSelected) == TaskFilterEnum.today,
              ),
              TodoCardFilter(
                appColors: appColors,
                label: 'AMANHÃ',
                taskFilter: TaskFilterEnum.tomorrow,
                totalTaskModel: TotalTaskModel(totalTask: 10, totalTaskFinish: 8),
                selected: context.select<HomeController, TaskFilterEnum>((value) => value.filterSelected) == TaskFilterEnum.tomorrow,
              ),
              TodoCardFilter(
                appColors: appColors,
                label: 'SEMANA',
                taskFilter: TaskFilterEnum.week,
                totalTaskModel: TotalTaskModel(totalTask: 8, totalTaskFinish: 5),
                selected: context.select<HomeController, TaskFilterEnum>((value) => value.filterSelected) == TaskFilterEnum.week,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
