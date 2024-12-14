import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project3/screen/available_car_screen.dart';
import 'package:project3/screen/book_car_screen.dart';
import 'package:project3/screen/calender_screen.dart';
import 'package:project3/screen/login_screen.dart';
import 'package:project3/screen/notifications_screen.dart';
import 'package:project3/screen/profile_screen.dart';
import 'package:project3/widgets/car_widget.dart';
import 'package:project3/theme/theme.dart';
import 'package:project3/data.dart';
import 'package:project3/widgets/dealers_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  static String id = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<NavigationItem> navigationitems = getNavigationItemList();
  NavigationItem? selectItem;
  List<Car> car = getCarList();
  List<Dealer> dealers = getDealerList();
  List<Car> filteredCars = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      selectItem = navigationitems[0];
      filteredCars = car;
    });
    searchController.addListener(_filterCars);
  }

  void _filterCars() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredCars = car
          .where((car) =>
              car.brand.toLowerCase().contains(query) ||
              car.model.toLowerCase().contains(query) ||
              car.condition.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterCars);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: lightColorScheme.primary,
        elevation: 0,
        title: const Text(
          'Car Rental App',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, LoginScreen.id);
            },
            icon: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.exit_to_app,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  helperStyle: const TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.only(left: 30),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: Icon(
                      searchController.text.isNotEmpty
                          ? Icons.clear
                          : Icons.search,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOP DEALS',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'View all',
                          //       style: TextStyle(
                          //         color: lightColorScheme.primary,
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       width: 8,
                          //     ),
                          //     Icon(
                          //       Icons.arrow_forward_ios,
                          //       size: 12,
                          //       color: lightColorScheme.primary,
                          //     )
                          //   ],
                          // )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 280,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: buildDeals(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AvailableCarScreen.id);
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 16, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: lightColorScheme.primary,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          padding: const EdgeInsets.all(24),
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Available Cars',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Long term and short term',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: lightColorScheme.primary,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOP DEALERS',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'View all',
                          //       style: TextStyle(
                          //         color: lightColorScheme.primary,
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       width: 8,
                          //     ),
                          //     Icon(
                          //       Icons.arrow_forward_ios,
                          //       size: 12,
                          //       color: lightColorScheme.primary,
                          //     )
                          //   ],
                          // )
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: buildDealers(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
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
          children: buildNavigationItems(),
        ),
      ),
    );
  }

  List<Widget> buildDeals() {
    List<Widget> list = [];
    for (var i = 0; i < filteredCars.length; i++) {
      list.add(GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookCarScreen(
                car: filteredCars[i],
              ),
            ),
          );
        },
        child: buildCar(filteredCars[i], i),
      ));
    }
    return list;
  }

  List<Widget> buildDealers() {
    List<Widget> list = [];
    for (var i = 0; i < dealers.length; i++) {
      list.add(buildDealer(dealers[i], i));
    }
    return list;
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
