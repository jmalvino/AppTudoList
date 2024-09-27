import 'package:app_tudo_list/app/modules/tasks/task_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalendarButton extends StatelessWidget {
  final dateFormat = DateFormat('dd/MM/y');

  CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () async {
        var lastDate = DateTime.now();
        var firstDate = lastDate.subtract(
          const Duration(days: 15 * 365),
        );
        lastDate = lastDate.add(
          const Duration(days: 15 * 365),
        );

        final DateTime? selectDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: firstDate,
          lastDate: lastDate,
        );

        context.read<TaskCreateController>().selectedDate = selectDate;
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 2, color: Colors.grey[500]!),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 5),
              Icon(Icons.calendar_month_outlined, color: Colors.grey[500]),
              const SizedBox(width: 10),
              Selector<TaskCreateController, DateTime?>(
                selector: (context, controller) => controller.selectedDate,
                builder: (context, selectedDate, child) {
                  if (selectedDate != null) {
                    return Text(
                      dateFormat.format(selectedDate),
                      style: TextStyle(
                        color: Colors.grey[500]!,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  } else {
                    return Text(
                      'SELECIONE UMA DATA',
                      style: TextStyle(
                        color: Colors.grey[500]!,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
