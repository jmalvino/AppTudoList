import 'package:app_tudo_list/global/app_color.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class HomeWeekFilter extends StatelessWidget {
  final AppColors appColors;
  const HomeWeekFilter({super.key, required this.appColors});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: appColors.tetrialColor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          'DIA DA SEMANA',
          style: textStyle,
        ),
        const SizedBox(height: 10,),
        Container(
          height: 95,
          child: DatePicker(
            DateTime.now(),
            locale: 'pt_BR',
            initialSelectedDate: DateTime.now(),
            daysCount: 7,
            selectionColor: appColors.corPrimaria,
            dayTextStyle: textStyle,
            monthTextStyle: textStyle ,
            selectedTextColor: Colors.white,
            dateTextStyle: TextStyle(
              color: appColors.colorTextField,
              fontSize: 27,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
