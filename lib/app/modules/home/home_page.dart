import 'package:app_tudo_list/app/modules/home/home_controller.dart';
import 'package:app_tudo_list/app/modules/home/widgets/home_drawer.dart';
import 'package:app_tudo_list/app/modules/home/widgets/home_filter.dart';
import 'package:app_tudo_list/app/modules/home/widgets/home_header.dart';
import 'package:app_tudo_list/app/modules/home/widgets/home_tasks.dart';
import 'package:app_tudo_list/app/modules/home/widgets/home_week_filter.dart';
import 'package:app_tudo_list/app/modules/tasks/task_module.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final HomeController _homeController;
  HomePage({super.key, required HomeController homeController}): _homeController = homeController;

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
    widget._homeController.loadTotalTask();
    super.initState();
  }

  void _goToCreateTask(BuildContext context) {
    // Navigator.of(context).pushNamed('/task/create');
    Navigator.of(context).push(
      // MaterialPageRoute(
      //   builder: (_) => TaskModule().getPage('/task/create', context),
      // ),
      PageRouteBuilder(
        transitionDuration: const Duration(microseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return TaskModule().getPage('/task/create', context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.bgColor,
      appBar: AppBar(
        backgroundColor: appColors.bgColor,
        iconTheme: IconThemeData(
          color: appColors.colorTextField,
        ),
        elevation: 0,
        title: Text(
          '',
          style: TextStyle(color: appColors.colorTextField),
        ),
        actions: [
          PopupMenuButton(
            color: appColors.colorTextField,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ), // Define o arredondamento
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'Mostrar tarefas concluidas',
                  style: TextStyle(
                    color: appColors.bgColor,
                  ),
                ),
              ),
            ],
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToCreateTask(context),
        backgroundColor: appColors.corPrimaria,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      drawer: HomeDrawer(appColors: appColors),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeader(appColors: appColors),
                      const SizedBox(height: 20),
                      HomeFilter(appColors: appColors),
                      const SizedBox(height: 20),
                      HomeWeekFilter(appColors: appColors),
                      const SizedBox(height: 20),
                      HomeTasks(
                        appColors: appColors,
                      )
                    ],
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
