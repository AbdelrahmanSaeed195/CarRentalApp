import 'package:flutter/material.dart';

class NavigationItem {
  IconData iconData;
  final String label;

  NavigationItem(this.iconData, this.label);
}

List<NavigationItem> getNavigationItemList() {
  return <NavigationItem>[
    NavigationItem(
      Icons.home,
      'Home'
    ),
    NavigationItem(
      Icons.calendar_today,
      'Calendar'
    ),
    NavigationItem(
      Icons.notifications,
      'Notifications'
    ),
    NavigationItem(
      Icons.person,
      'Profile'
    ),
  ];
}

class Car {
  String brand;
  String model;
  String condition;
  String color;
  String gearbox;
  int seats;
  String motor;
  String speed;
  String topSpeed;
  List<String> images;
  double price;

  Car(
      this.brand,
      this.model,
      this.condition,
      this.color,
      this.gearbox,
      this.seats,
      this.motor,
      this.speed,
      this.topSpeed,
      this.images,
      this.price);
}

List<Car> getCarList() {
  return <Car>[
    Car(
      "Ferrari",
      "488 Spider",
      "Weekly",
      'blue',
      "Automatic",
      2,
      "3.9L Twin-Turbo V8",
      "3.0 sec",
      "211 mph",
      [
        "assets/images/ferrari_spider_488_0.png",
        "assets/images/ferrari_spider_488_1.png",
        "assets/images/ferrari_spider_488_2.png",
        "assets/images/ferrari_spider_488_3.png",
        "assets/images/ferrari_spider_488_4.png",
      ],
      300,
    ),
    Car(
      "Alfa Romeo",
      "C4",
      "Monthly",
      'grey',
      "Automatic",
      2,
      "1.75L Turbocharged Inline-4",
      "4.1 sec",
      "160 mph",
      [
        "assets/images/alfa_romeo_c4_0.png",
      ],
      200,
    ),
    Car(
      "Nissan",
      "GTR",
      "Daily",
      'white',
      "Automatic",
      2,
      "3.8L Twin-Turbo V6",
      "2.9 sec",
      "205 mph",
      [
        "assets/images/nissan_gtr_0.png",
        "assets/images/nissan_gtr_1.png",
        "assets/images/nissan_gtr_2.png",
        "assets/images/nissan_gtr_3.png",
      ],
      150,
    ),
    Car(
      "Ford",
      "Focus",
      "Weekly",
      'white',
      "Automatic",
      5,
      "2.0L Turbocharged Inline-4",
      "6.8 sec",
      "155 mph",
      [
        "assets/images/ford_0.png",
        "assets/images/ford_1.png",
      ],
      50,
    ),
    Car(
      "Acura",
      "MDX 2020",
      "Monthly",
      'blue',
      "Automatic",
      7,
      "3.5L V6",
      "6.2 sec",
      "112 mph",
      [
        "assets/images/acura_0.png",
        "assets/images/acura_1.png",
        "assets/images/acura_2.png",
      ],
      80,
    ),
    Car(
      "Chevrolet",
      "Camaro",
      "Weekly",
      'yellow',
      "Automatic",
      2,
      "6.2L V8",
      "4.0 sec",
      "165 mph",
      [
        "assets/images/camaro_0.png",
        "assets/images/camaro_1.png",
        "assets/images/camaro_2.png",
      ],
      180,
    ),
    Car(
      "Land Rover",
      "Discovery",
      "Weekly",
      "Fuji White",
      "Automatic",
      7,
      "3.0L Turbocharged Inline-6",
      "7.7 sec",
      "130 mph",
      [
        "assets/images/land_rover_0.png",
        "assets/images/land_rover_1.png",
        "assets/images/land_rover_2.png",
      ],
      150,
    ),
    Car(
      "Fiat",
      "500x",
      "Weekly",
      'white',
      "Automatic",
      4,
      "1.3L Turbocharged Inline-4",
      "8.5 sec",
      "112 mph",
      [
        "assets/images/fiat_0.png",
        "assets/images/fiat_1.png",
      ],
      40,
    ),
    Car(
      "Honda",
      "Civic",
      "Daily",
      "Lunar Silver Metallic",
      "Automatic",
      5,
      "1.5L Turbocharged Inline-4",
      "7.0 sec",
      "125 mph",
      [
        "assets/images/honda_0.png",
      ],
      50,
    ),
    Car(
      "Citroen",
      "Picasso",
      "Monthly",
      "Arctic Steel",
      "Automatic",
      5,
      "1.6L Turbocharged Inline-4",
      "11.0 sec",
      "118 mph",
      [
        "assets/images/citroen_0.png",
        "assets/images/citroen_1.png",
        "assets/images/citroen_2.png",
      ],
      20,
    ),
  ];
}

class Dealer {
  String name;
  int offers;
  String image;

  Dealer(this.name, this.offers, this.image);
}

List<Dealer> getDealerList() {
  return <Dealer>[
    Dealer(
      "Tesla",
      89,
      "assets/images/tesla.jpg",
    ),
    Dealer(
      "Avis",
      126,
      "assets/images/avis.png",
    ),
    Dealer(
      "Hertz",
      174,
      "assets/images/hertz.png",
    ),
    Dealer(
      "ferrari",
      155,
      "assets/images/ferrari.png",
    ),
    Dealer(
      "lamborghini",
      200,
      "assets/images/Lamborghini.png",
    ),
    Dealer(
      "Ford",
      120,
      "assets/images/ford.jpeg",
    ),
    Dealer(
      "Fiat",
      95,
      "assets/images/fiat.jpeg",
    ),
  ];
}

class Filter {
  String name;

  Filter(this.name);
}

List<Filter> getFilterList() {
  return <Filter>[
    Filter("Best Match"),
    Filter("Highest Price"),
    Filter("Lowest Price"),
  ];
}
