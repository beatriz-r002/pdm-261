import 'package:flutter/material.dart';

import '../animations.dart';                          // Add this import
import '../destinations.dart';
import '../transitions/bottom_bar_transition.dart';   // Add this import

class DisappearingBottomNavigationBar extends StatelessWidget {
  const DisappearingBottomNavigationBar({
    super.key,
    required this.barAnimation,                       // Add this parameter
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  final BarAnimation barAnimation;                   // Add this variable
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
                                                     // Modify from here...
    return BottomBarTransition(
      animation: barAnimation,
      backgroundColor: Colors.white,
      child: NavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        destinations: destinations.map<NavigationDestination>((d) {
          return NavigationDestination(icon: Icon(d.icon), label: d.label);
        }).toList(),
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
      ),
    );
                                                     // ... to here.
  }
}