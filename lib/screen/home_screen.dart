import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project3/screen/available_car_screen.dart';
import 'package:project3/screen/book_car_screen.dart';
import 'package:project3/screen/login_screen.dart';
import 'package:project3/widgets/bottom_bar.dart';
import 'package:project3/widgets/car_widget.dart';
import 'package:project3/theme/theme.dart';
import 'package:project3/data.dart';
import 'package:project3/widgets/dealers_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<NavigationItem> navigationitems = getNavigationItemList();
  NavigationItem? selectedItem;
  List<Car> car = getCarList();
  List<Dealer> dealers = getDealerList();
  List<Car> filteredCars = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedItem = navigationitems[0];
    filteredCars = car;
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
    void _onNavigationItemSelected(NavigationItem item) {
    setState(() {
      selectedItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSearchField(),
          Expanded(
            child: _buildBodyContent(context),
          ),
        ],
      ),
      // bottomNavigationBar: bottomNavBar(),
      bottomNavigationBar: CustomBottomNavigationBar(
        navigationItems: navigationitems,
        selectedItem: selectedItem!,
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
 AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: lightColorScheme.primary,
      elevation: 0,
      title: const Text(
        'Car Rental App',
        style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
      ),
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
    );
  }

Padding _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.only(left: 30),
          suffixIcon: IconButton(
            onPressed: () => searchController.clear(),
            icon: Icon(
              searchController.text.isNotEmpty ? Icons.clear : Icons.search,
              color: Colors.black,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
  /// Builds the main content of the home screen. This includes the top deals, 
  /// available cars, and top dealers sections. The content is wrapped in a 

  SingleChildScrollView _buildBodyContent(BuildContext context) {
    return SingleChildScrollView(
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
            _buildSectionTitle('TOP DEALS'),
            _buildCarDeals(),
            _buildAvailableCarsSection(context),
            _buildSectionTitle('TOP DEALERS'),
            _buildDealerList(),
          ],
        ),
      ),
    );
  }

  Padding _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  /// Builds a horizontal list of car deals. 
  /// The list is wrapped in a SizedBox with a fixed height of 280.
  SizedBox _buildCarDeals() {
    return SizedBox(
      height: 280,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: buildDeals(),
      ),
    );
  }
  GestureDetector _buildAvailableCarsSection(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AvailableCarScreen.id),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
        child: Container(
          decoration: BoxDecoration(
            color: lightColorScheme.primary,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
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
    );
  }


  
  Container _buildDealerList() {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: buildDealers(),
      ),
    );
  }


  List<Widget> buildDealers() {
    return dealers
        .map((dealer) => buildDealer(dealer, dealers.indexOf(dealer)))
        .toList();
  }

 

  List<Widget> buildDeals() {
    return filteredCars.map((car) {
      return GestureDetector(
        onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BookCarScreen(car: car)),
        ),
        child: buildCar(car, filteredCars.indexOf(car)),
      );
    }).toList();
  }


}
