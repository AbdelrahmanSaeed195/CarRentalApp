import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project3/data.dart';
import 'package:project3/helper/show_Message.dart';
import 'package:project3/screen/login_screen.dart';
import 'package:project3/screen/CardDetailsScreen.dart';
import 'package:project3/screen/profile_data_user.dart';
import 'package:project3/screen/updata_profile_screen.dart';
import 'package:project3/theme/theme.dart';
import 'package:project3/widgets/bottom_bar.dart';
import 'package:project3/widgets/profile_menu.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static String id = "ProfileScreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<NavigationItem> navigationItems = getNavigationItemList();
  NavigationItem? selectedItem;
  Map<String, dynamic>? userData;
  final user = FirebaseAuth.instance.currentUser!;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    setState(() {
      selectedItem = navigationItems[2];
    });
  }

  Future<void> fetchUserData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      if (doc.exists) {
        setState(() {
          userData = doc.data(); // Assign Firestore data to state variable
          isLoading = false; // Stop loading indicator
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading even if there's an error
      });
      showMessage(context, "Error fetching data: ${e.toString()}");
    }
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
          'Profile',
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loader while data is fetching
          : userData == null
              ? const Center(child: Text("No data available"))
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child:
                                      Image.asset("assets/images/profile.jpg")),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: lightColorScheme.primary),
                                child: const Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userData?['FullName'] ?? 'Not Provided',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userData?['Email'] ?? 'Not Provided',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, UpdataProfileScreen.id);
                            },
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Divider(color: Colors.grey.withOpacity(0)),
                        const SizedBox(height: 10),

                        // menu
                        ProfileMenuWidget(
                          title: 'Settings',
                          icon: Icons.settings_outlined,
                          onpress: () {},
                        ),
                        ProfileMenuWidget(
                          title: 'Card Details',
                          icon: Icons.wallet_outlined,
                          onpress: () {
                            Navigator.pushNamed(
                              context,
                              CardDetailsScreen.id,
                            );
                          },
                        ),
                        ProfileMenuWidget(
                          title: 'Personal Data',
                          icon: Icons.account_box_outlined,
                          onpress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileDataUser(),
                              ),
                            );
                          },
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(0),
                        ),
                        const SizedBox(height: 10),
                        ProfileMenuWidget(
                          title: 'About Us',
                          icon: Icons.info_outline_rounded,
                          onpress: () {},
                        ),
                        ProfileMenuWidget(
                          title: 'Logout',
                          icon: Icons.arrow_circle_right_outlined,
                          onpress: () async {
                            GoogleSignIn googleSignIn = GoogleSignIn();
                            googleSignIn.disconnect();
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          textcolor: Colors.red,
                          endIcon: false,
                        ),
                      ],
                    ),
                  ),
                ),
      // bottomNavigationBar: bottomNavBar(),
      bottomNavigationBar: CustomBottomNavigationBar(
        navigationItems: navigationItems,
        selectedItem: selectedItem!,
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}
