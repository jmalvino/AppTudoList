import 'package:app_tudo_list/app/models/enuns/task_filter_enum.dart';
import 'package:app_tudo_list/app/models/task_model.dart';
import 'package:app_tudo_list/app/modules/home/home_controller.dart';
import 'package:app_tudo_list/app/modules/home/widgets/task.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          Selector<HomeController, String>(
            selector: (context, controller) {
              return controller.filterSelected.description;
            },
            builder: (context, value, child) {
              return Text(
                'TASK\'S $value',
                style: textStyle,
              );
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 500,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom:100),
                child: Column(
                  children: context
                      .select<HomeController, List<TaskModel>>((controller) => controller.filteredTasks)
                      .map(
                        (t) => Task(
                          appColors: appColors,
                          model: t,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
