import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project3/screen/available_car_screen.dart';
import 'package:project3/screen/home_screen.dart';
import 'package:project3/screen/login_screen.dart';
import 'package:project3/screen/notifications_screen.dart';
import 'package:project3/screen/profile_screen.dart';
import 'package:project3/screen/register_screen.dart';
import 'package:project3/screen/updata_profile_screen.dart';
import 'package:project3/screen/welcome_screen.dart';
import 'package:project3/theme/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseNotifications().initnotifications();
  runApp(const CarentalApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class CarentalApp extends StatelessWidget {
  const CarentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: navigatorKey,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        AvailableCarScreen.id: (context) => const AvailableCarScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        UpdataProfileScreen.id: (context) => const UpdataProfileScreen(),
        NotificationsScreen.id: (context) => const NotificationsScreen(),
      },
      initialRoute: LoginScreen.id,
      title: 'CarRentalApp',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
    );
  }
}
