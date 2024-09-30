import 'package:app_tudo_list/app/models/task_model.dart';
import 'package:app_tudo_list/app/modules/home/home_controller.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Task extends StatelessWidget {
  final AppColors appColors;
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/y');

  Task({super.key, required this.appColors, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 77,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                height: 50,
                child: ListTile(
                  contentPadding: const EdgeInsetsDirectional.all(5),
                  leading: Checkbox(
                    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                      if ( states.contains(MaterialState.selected)){
                        return appColors.corPrimaria;
                      }
                      return Colors.grey;
                    }),
                    // fillColor: MaterialStateProperty.all<Color>(appColors.corPrimaria),
                    value: model.finished,
                    onChanged: (value) => context.read<HomeController>().checkOrUncheckTask(model),
                  ),
                  title: Text(
                    model.description,
                    style: TextStyle(
                      decoration: model.finished ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Text(
                    dateFormat.format(model.dateTime),
                    style: TextStyle(
                      decoration: model.finished ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
