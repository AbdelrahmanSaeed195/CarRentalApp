import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project3/screen/available_car_screen.dart';
import 'package:project3/screen/home_screen.dart';
import 'package:project3/screen/login_screen.dart';
import 'package:project3/screen/profile_screen.dart';
import 'package:project3/screen/register_screen.dart';
import 'package:project3/screen/welcome_screen.dart';
import 'package:project3/theme/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CarentalApp());
}

class CarentalApp extends StatelessWidget {
  const CarentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        AvailableCarScreen.id: (context) => const AvailableCarScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
      },
      initialRoute: WelcomeScreen.id,
      title: 'CarRentalApp',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
    );
  }
}
