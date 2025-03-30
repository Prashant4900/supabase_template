import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions.dart';
import 'package:flutter_template/routes/router.dart';
import 'package:go_router/go_router.dart';

class MyDashboard extends StatelessWidget {
  const MyDashboard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Get current location to determine selected tab
    final location = GoRouterState.of(context).uri.path;
    final currentIndex = location.startsWith(MyRoutes.setting) ? 1 : 0;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          if (index == 0) {
            if (location != MyRoutes.home) {
              const HomeRoute().go(context);
            }
          } else if (index == 1) {
            if (location != MyRoutes.setting) {
              const SettingRoute().go(context);
            }
          }
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard),
            label: context.lang.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            label: context.lang.settings,
          ),
        ],
      ),
    );
  }
}
