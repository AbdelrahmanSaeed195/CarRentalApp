import 'package:flutter/material.dart';
import 'package:project3/data.dart';
import 'package:project3/theme/theme.dart';
import 'package:project3/widgets/bottom_bar.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NavigationItem> navigationItems = getNavigationItemList();
  NavigationItem? selectedItem;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedItem = navigationItems[1];
    });
  }

  void _onNavigationItemSelected(NavigationItem item) {
    setState(() {
      selectedItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: lightColorScheme.primary,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        navigationItems: navigationItems,
        selectedItem: selectedItem!,
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}
