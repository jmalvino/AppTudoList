import 'package:app_tudo_list/app/core/auth/auth_provider.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  final AppColors appColors;

  HomeHeader({super.key, required this.appColors});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(color: appColors.colorTextField, fontSize: 18, fontWeight: FontWeight.bold);
    return Selector<AuthProvider, String>(
        builder: (_, value, __) {
          return Row(
            children: [
              Text(
                'Bem vindo, ',
                style: textStyle.copyWith(fontWeight: FontWeight.w300),
              ),
              Text('$value !', style: textStyle),
            ],
          );
        },
        selector: (context, authProvider) => authProvider.user?.displayName ?? 'Não Informado!');
  }
}
