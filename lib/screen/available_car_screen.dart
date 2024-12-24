import 'package:flutter/material.dart';
import 'package:project3/data.dart';
import 'package:project3/theme/theme.dart';
import 'package:project3/widgets/car_widget.dart';
import 'package:project3/screen/book_car_screen.dart';

class AvailableCarScreen extends StatefulWidget {
  const AvailableCarScreen({super.key});
  static String id = "AvailableCarScreen ";

  @override
  State<AvailableCarScreen> createState() => _AvailableCarScreenState();
}

class _AvailableCarScreenState extends State<AvailableCarScreen> {
  List<Filter> filters = getFilterList();
  Filter? selectedfilter;
  // List<Car> filteredCars = getCarList();
  List<Car> allCars = getCarList();
  late List<Car> filteredCars;

  @override
  void initState() {
    super.initState();
    filteredCars = allCars;
  }

  List<Car> applyFilter(List<Car> cars, Filter? filter) {
    if (filter == null) return cars;
    switch (filter.name) {
      case "Highest Price":
        cars.sort((a, b) => b.price.compareTo(a.price));
        return List.from(cars);
      case "Lowest Price":
        cars.sort((a, b) => a.price.compareTo(b.price));
        return List.from(cars);
      default:
        return cars;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton(context),
              const SizedBox(height: 16),
              _buildTitle(),
              const SizedBox(height: 16),
              _buildCarGrid(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  GestureDetector _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        ),
        child: const Icon(
          Icons.keyboard_arrow_left,
          color: Colors.black,
          size: 28,
        ),
      ),
    );
  }

  Text _buildTitle() {
    return Text(
      "Available Cars (${allCars.length})",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Expanded _buildCarGrid(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1 / 1.7,
        ),
        itemCount: filteredCars.length,
        itemBuilder: (context, index) {
          final car = filteredCars[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookCarScreen(car: car),
                ),
              );
            },
            child: buildCar(car, 1),
          );
        },
      ),
    );
  }

  Widget buildFilterIcon() {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: lightColorScheme.primary,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.filter_list,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildFilter(Filter filter) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            selectedfilter = filter;
            filteredCars = applyFilter(allCars, selectedfilter);
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Text(
          filter.name,
          style: TextStyle(
            color: selectedfilter == filter
                ? lightColorScheme.primary
                : Colors.grey[900],
            fontSize: 16,
            fontWeight:
                selectedfilter == filter ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _buildBottomNavigationBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 70,
        width: 450,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            buildFilterIcon(),
            const SizedBox(width: 45),
            Row(
              children: filters.map((filter) => _buildFilter(filter)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
