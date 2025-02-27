import 'package:fin_track/modules/dashboard/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: navigationShell.currentIndex,
        onTap: _switchBranch,
      ),
    );
  }

  _switchBranch(int index) {
    navigationShell.goBranch(index);
    initialLocation:
    index == navigationShell.currentIndex;
  }
}
