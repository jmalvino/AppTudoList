import 'package:app_tudo_list/app/modules/home/widgets/home_drawer.dart';
import 'package:app_tudo_list/app/modules/home/widgets/home_filter.dart';
import 'package:app_tudo_list/app/modules/home/widgets/home_header.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppColors appColors = AppColors();

  @override
  void initState() {
    if (appColors.isModo == false) {
      appColors.darkModo();
    } else {
      appColors.lightModo();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.secondColor,
      appBar: AppBar(
        backgroundColor: appColors.secondColor,
        elevation: 0,
        title: const Text('Home'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [const PopupMenuItem(child: Text('Mostrar tarefas concluidas'))],
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
      ),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Container(
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(appColors: appColors),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: HomeFilter(appColors: appColors),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
