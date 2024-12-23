import 'package:flutter/material.dart';
import 'package:project3/data.dart';
import 'package:project3/screen/home_screen.dart';
import 'package:project3/screen/notifications_screen.dart';
import 'package:project3/screen/profile_screen.dart';
import 'package:project3/theme/theme.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final List<NavigationItem> navigationItems;
  final NavigationItem selectedItem;
  final Function(NavigationItem) onItemSelected;

  const CustomBottomNavigationBar({
    required this.navigationItems,
    required this.selectedItem,
    required this.onItemSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: lightColorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 8,
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navigationItems.map((item) {
          return _buildNavigationItem(item, context);
        }).toList(),
      ),
    );
  }

  Widget _buildNavigationItem(NavigationItem item, BuildContext context) {
    final screens = [
      const HomeScreen(),
      // const CalendarScreen(),
      const NotificationsScreen(),
      const ProfileScreen(),
    ];

    return GestureDetector(
      onTap: () {
        onItemSelected(item);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screens[navigationItems.indexOf(item)],
          ),
        );
      },
      child: SizedBox(
        width: 50,
        child: Stack(
          children: [
            if (selectedItem == item)
              Center(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: lightColorScheme.onPrimary,
                  ),
                ),
              ),
            Center(
              child: Icon(
                item.iconData,
                color: selectedItem == item
                    ? lightColorScheme.primary
                    : Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
