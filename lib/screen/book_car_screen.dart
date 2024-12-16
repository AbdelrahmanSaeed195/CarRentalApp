import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project3/data.dart';
import 'package:project3/helper/show_Message.dart';
import 'package:project3/theme/theme.dart';
import 'package:share_plus/share_plus.dart';

class BookCarScreen extends StatefulWidget {
  final Car car;
  const BookCarScreen({super.key, required this.car});
  @override
  State<BookCarScreen> createState() => _BookCarScreenState();
}

class _BookCarScreenState extends State<BookCarScreen> {
  int _currentImage = 0;
  int _selectedPeriod = 12;
  bool _isBookmarked = false;

  List<Widget> buildPageIndicator() {
    return List.generate(widget.car.images.length, (index) {
      return buildIndicator(index == _currentImage);
    });
  }

  final Map<int, String> _prices = {
    12: "4.350",
    6: "4.800",
    1: "5.100",
  };
  Future<void> bookCar() async {
    try {
      final carBooking = {
        "carModel": widget.car.model,
        "carBrand": widget.car.brand,
        "selectedPeriod": _selectedPeriod,
        "price": _prices[_selectedPeriod],
        "bookingDate":
            DateTime.now().toIso8601String(), // Store the current date
      };
      await FirebaseFirestore.instance.collection('bookings').add(carBooking);
      showMessage(context, 'Car booking successful!');
    } catch (e) {
      showMessage(context, 'Failed to book car: $e');
    }
  }

  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[400],
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  void toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    showMessage(
        context, _isBookmarked ? 'Car bookmarked!' : 'Bookmark removed.');
  }

  void shareCar() {
    final String carDetails =
        'Check out this ${widget.car.brand} ${widget.car.model} available for rent. Price: USD ${_prices[_selectedPeriod]} per month.';
    Share.share(carDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(),
              const SizedBox(height: 16),
              buildCarInfo(),
              const SizedBox(height: 16),
              buildImageSlider(),
              if (widget.car.images.length > 1) buildPageIndicatorWidget(),
              buildPricingOptions(),
              const SizedBox(height: 16),
              buildSpecifications(),
              buildBookingSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const IconContainer(icon: Icons.keyboard_arrow_left),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: toggleBookmark,
                child: IconContainer(
                    icon:
                        _isBookmarked ? Icons.bookmark : Icons.bookmark_border),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: shareCar,
                child: const IconContainer(icon: Icons.share),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding buildCarInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.car.model,
            style: const TextStyle(
                color: Colors.black, fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(widget.car.brand,
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 18,
              )),
        ],
      ),
    );
  }

  Widget buildImageSlider() {
    return Expanded(
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.car.images.length,
        onPageChanged: (int page) {
          setState(() => _currentImage = page);
        },
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Hero(
            tag: widget.car.brand,
            child: Image.asset(
              widget.car.images[index],
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPageIndicatorWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 30,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buildPageIndicator()),
    );
  }

  Padding buildPricingOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildPriceOption("12", "4.350"),
          buildPriceOption("6", "4.80"),
          buildPriceOption(
            "1",
            "5.100",
          ),
        ],
      ),
    );
  }

  Widget buildPriceOption(String months, String price) {
    return GestureDetector(
      onTap: () => setState(() => _selectedPeriod = int.parse(months)),
      child: PriceOptionWidget(
        months: months,
        price: price,
        selected: _selectedPeriod.toString() == months,
      ),
    );
  }

  Widget buildSpecifications() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Column(
        children: [
          Text("SPECIFICATIONS",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700])),
          const SizedBox(height: 8),
          buildSpecificationList()
        ],
      ),
    );
  }

  Container buildSpecificationList() {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(top: 8, left: 16),
      margin: const EdgeInsets.only(bottom: 16),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          buildSpecificationCar("Color", widget.car.color),
          buildSpecificationCar("Gearbox", widget.car.gearbox),
          buildSpecificationCar("Seat", widget.car.seats.toString()),
          buildSpecificationCar("Motor", widget.car.motor),
          buildSpecificationCar("Speed", widget.car.speed),
          buildSpecificationCar("Top Speed", widget.car.topSpeed),
        ],
      ),
    );
  }

  Widget buildSpecificationCar(String title, String data) {
    return SpecificationCard(title: title, data: data);
  }

  Container buildBookingSection() {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildBookingDetails(),
          buildBookButton(),
        ],
      ),
    );
  }

  Widget buildBookingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$_selectedPeriod Month",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Row(
          children: [
            Text("USD ${_prices[_selectedPeriod]} XRP",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            const SizedBox(width: 8),
            Text("Per Month",
                style: TextStyle(color: Colors.grey[900], fontSize: 14)),
          ],
        )
      ],
    );
  }

  Widget buildBookButton() {
    return GestureDetector(
      onTap: bookCar,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: lightColorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        alignment: Alignment.center,
        child: const Text("Book This Car",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  final IconData icon;
  const IconContainer({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.black),
    );
  }
}

class PriceOptionWidget extends StatelessWidget {
  final String months;
  final String price;
  final bool selected;
  const PriceOptionWidget({
    super.key,
    required this.months,
    required this.price,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          Text(months,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text("USD $price XRP", style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class SpecificationCard extends StatelessWidget {
  final String title;
  final String data;
  const SpecificationCard({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(right: 16),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(data),
          ],
        ),
      ),
    );
  }
}
