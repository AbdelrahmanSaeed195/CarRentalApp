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

  @override
  void initState() {
    super.initState();
    setState(
      () {
        selectedfilter = filters[0];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                      color: const Color(0xFFE0E0E0),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Available Cars (${getCarList().length})",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  childAspectRatio: 1 / 1.7,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: getCarList().map((item) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookCarScreen(
                              car: item,
                            ),
                          ),
                        );
                      },
                      child: buildCar(item, 1),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: [
              buildFilterIcon(),
              Row(
                children: buildFilters(),
              )
            ],
          ),
        ),
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
          )),
      child: const Center(
        child: Icon(
          Icons.filter_list,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  List<Widget> buildFilters() {
    List<Widget> list = [];
    for (var i = 0; i < filters.length; i++) {
      list.add(buildFilter(filters[i]));
    }
    return list;
  }

  Widget buildFilter(Filter filter) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedfilter = filter;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Text(
          filter.name,
          style: TextStyle(
            color: selectedfilter == filter
                ? lightColorScheme.primary
                : Colors.grey[300],
            fontSize: 16,
            fontWeight:
                selectedfilter == filter ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
