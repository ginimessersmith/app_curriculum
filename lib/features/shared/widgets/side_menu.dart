import 'package:curriculum/features/shared/widgets/menu_user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:curriculum/features/shared/shared.dart';

import '../../../config/router/app_router.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

    return NavigationDrawer(
        elevation: 1,
        selectedIndex: navDrawerIndex,
        onDestinationSelected: (value) {
          setState(() {
            navDrawerIndex = value;
          });

          final MenuUser = appMenuUser[value];
          GoRouter.of(context).go(MenuUser.link);
          widget.scaffoldKey.currentState?.closeDrawer();
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
            child: Text(
              'Menu',
              style: textStyles.titleMedium,
            ),
          ),
          for(var item in appMenuUser)
            ListTile(
              leading: Icon(item.icon),
              title: Text(item.label),
              onTap: (){
                setState(() {
                  navDrawerIndex=appMenuUser.indexOf(item);

                });
                widget.scaffoldKey.currentState?.openEndDrawer();
                GoRouter.of(context).go(item.link);
              },
            ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text('Otras opciones'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                onPressed: () {
                  appRouter.go('/login');
                },
                text: 'Cerrar sesión'),
          ),
        ]);
  }
}
