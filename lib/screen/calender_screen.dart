import 'package:flutter/material.dart';
import 'package:project3/data.dart';
import 'package:project3/screen/home_screen.dart';
import 'package:project3/screen/notifications_screen.dart';
import 'package:project3/screen/profile_screen.dart';
import 'package:project3/theme/theme.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final List<NavigationItem> navigationitems = getNavigationItemList();
  NavigationItem? selectItem;
  @override
  void initState() {
    super.initState();
    setState(() {
      selectItem = navigationitems[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Column(
        children: [
          Center(
            child: Text(
              'Calender Screen',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
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
          children: buildNavigationItems(),
        ),
      ),
    );
  }

  List<Widget> buildNavigationItems() {
    List<Widget> list = [];
    for (var i = 0; i < navigationitems.length; i++) {
      list.add(buildNavigationItem(navigationitems[i]));
    }
    return list;
  }

  Widget buildNavigationItem(NavigationItem item) {
    final screens = [
      const HomeScreen(),
      const CalenderScreen(),
      const NotificationsScreen(),
      const ProfileScreen(),
    ];
    return GestureDetector(
      onTap: () {
        setState(() {
          selectItem = item;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => screens[navigationitems.indexOf(item)]));
      },
      child: SizedBox(
        width: 50,
        child: Stack(
          children: [
            selectItem == item
                ? Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: lightColorScheme.onPrimary,
                      ),
                    ),
                  )
                : Container(),
            Center(
              child: Icon(
                item.iconData,
                color: selectItem == item
                    ? lightColorScheme.primary
                    : Colors.grey[400],
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
