import 'package:app_tudo_list/global/app_color.dart';
import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  final AppColors appColors;

  const Task({super.key, required this.appColors});

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
                    fillColor: MaterialStateProperty.all<Color>(appColors.corPrimaria),
                    value: true,
                    onChanged: (value) {},
                  ),
                  title: const Text(
                    'Descrição da TASK',
                    style: TextStyle(
                      decoration: false ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: const Text(
                    '26/09/2024',
                    style: TextStyle(
                      decoration: false ? TextDecoration.lineThrough : null,
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
