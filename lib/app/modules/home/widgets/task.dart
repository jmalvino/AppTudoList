import 'package:app_tudo_list/app/models/task_model.dart';
import 'package:app_tudo_list/app/modules/home/home_controller.dart';
import 'package:app_tudo_list/app/repositories/tasks/task_repository_implements.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:app_tudo_list/widgets/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Task extends StatefulWidget {
  final AppColors appColors;
  final TaskModel model;

  Task({super.key, required this.appColors, required this.model});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final dateFormat = DateFormat('dd/MM/y');

  @override
  Widget build(BuildContext context) {
    final taskRepositoryImplements = context.read<TaskRepositoryImplements>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Slidable(
        direction: Axis.horizontal,
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            const SizedBox(width: 10),
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (_) async {
                ///PROBLEMA NÂO ESTA RECARREGANDO APÓS A EXCLUSAO
                  final success = await taskRepositoryImplements.delete(widget.model.id);
                  if(success){
                    Navigator.of(context).pushNamed('/home');
                  }else{
                    CustomSnackBar(color: Colors.orange, error: 'Erro ao deletar TASK');
                  }
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            leading: Checkbox(
              fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.selected)) {
                  return widget.appColors.corPrimaria;
                }
                return Colors.grey;
              }),
              value: widget.model.finished,
              onChanged: (value) => context.read<HomeController>().checkOrUncheckTask(widget.model),
            ),
            title: Text(
              widget.model.description,
              style: TextStyle(
                decoration: widget.model.finished ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              dateFormat.format(widget.model.dateTime),
              style: TextStyle(
                decoration: widget.model.finished ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ),
      ),
    );
  }


}
