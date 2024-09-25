import 'package:app_tudo_list/app/modules/home/widgets/todo_card_filter.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:flutter/material.dart';

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
              TodoCardFilter(appColors: appColors),
              TodoCardFilter(appColors: appColors),
              TodoCardFilter(appColors: appColors),
            ],
          ),
        ),
      ],
    );
  }
}
