import 'package:app_tudo_list/app/core/auth/auth_provider.dart';
import 'package:app_tudo_list/app/services/user/user_service.dart';
import 'package:app_tudo_list/global/app_color.dart';
import 'package:app_tudo_list/widgets/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');
  final AppColors appColors;

  HomeDrawer({super.key, required this.appColors});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(color: appColors.colorTextField);
    return Drawer(
      backgroundColor: appColors.bgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: appColors.corPrimaria,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Selector<AuthProvider, String>(
                    selector: (context, authProvider) {
                      return authProvider.user?.photoURL ?? 'https://cdn-icons-png.flaticon.com/512/1144/1144760.png';
                    },
                    builder: (_, value, __) {
                      return Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[400],
                            backgroundImage: NetworkImage(value),
                            radius: 25,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadiusDirectional.circular(15),
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: Icon(Icons.add_circle_outline, color: Colors.grey[500], size: 13),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Selector<AuthProvider, String>(
                    selector: (context, authProvider) {
                      return authProvider.user?.displayName ?? 'Nome, não Informado';
                    },
                    builder: (_, value, __) {
                      return Expanded(
                        child: Text(
                          value,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  title: Text(
                    'Alterar nome',
                    style: textStyle,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text(
                            'Alterar nome',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'Cancelar',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                var nameValue = nameVN.value;
                                if (nameValue.isEmpty) {
                                  CustomSnackBar(color: Colors.red, error: 'Nome obrigatorio').show(context);
                                } else {
                                  await context.read<UserService>().updateDisplayName(nameValue);
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                'Alterar',
                                style: TextStyle(color: appColors.corPrimaria),
                              ),
                            ),
                          ],
                          content: TextField(
                            onChanged: (value) => nameVN.value = value,
                          ),
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  dense: true,
                  onTap: () => context.read<AuthProvider>().logout(),
                  title: Text(
                    'Sair',
                    style: textStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
