import 'package:app_tudo_list/app/models/enuns/task_filter_enum.dart';
import 'package:app_tudo_list/app/modules/home/home_controller.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeWeekFilter extends StatelessWidget {
  final AppColors appColors;

  const HomeWeekFilter({super.key, required this.appColors});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: appColors.tetrialColor);
    return Visibility(
      visible: context.select<HomeController, bool>(
        (controller) => controller.filterSelected == TaskFilterEnum.week,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'DIA DA SEMANA',
            style: textStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 95,
            child: Selector<HomeController, DateTime>(
              selector: (context, controller) => controller.initialDateOfWeek ?? DateTime.now(),
              builder: (_, value, __) {
                var startOfWeek = value.subtract(Duration(days: value.weekday - 1));
                return DatePicker(
                  startOfWeek,
                  locale: 'pt_BR',
                  initialSelectedDate: startOfWeek,
                  daysCount: 7,
                  selectionColor: appColors.corPrimaria,
                  dayTextStyle: textStyle,
                  monthTextStyle: textStyle,
                  selectedTextColor: Colors.white,
                  dateTextStyle: TextStyle(
                    color: appColors.colorTextField,
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                  ),
                  onDateChange: (date) {
                    context.read<HomeController>().filterByDate(date);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
