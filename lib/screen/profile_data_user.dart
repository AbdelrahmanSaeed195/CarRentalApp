import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project3/helper/show_Message.dart';
import 'package:project3/theme/theme.dart';

class ProfileDataUser extends StatefulWidget {
  const ProfileDataUser({super.key});

  @override
  State<ProfileDataUser> createState() => _ProfileDataUserState();
}

class _ProfileDataUserState extends State<ProfileDataUser> {
  final user = FirebaseAuth.instance.currentUser!;
  Map<String, dynamic>? userData; // State variable to hold user data
  bool isLoading = true; // Loading indicator

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Fetch user data from Firestore
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: lightColorScheme.primary,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Personal Data',
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
              ? const Center(
                  child: Text("No data available")) // Handle null data
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Profile Picture Section
                        Center(
                          child: SizedBox(
                            height: 120,
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset("assets/images/profile.jpg"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Section Header
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Profile Information',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Profile Details Card
                        detailCard(),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget detailCard() {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            // Name Row
            _buildDetailRow(
              icon: Icons.perm_identity_sharp,
              title: 'Name',
              value: userData?['FullName'] ?? 'Not Provided',
            ),
            _divider(),
            // Email Row
            _buildDetailRow(
              icon: Icons.email,
              title: 'Email',
              value: userData?['Email'] ?? 'Not Provided',
            ),
            _divider(),
            // Phone Row
            _buildDetailRow(
              icon: Icons.phone,
              title: 'Phone',
              value: userData?['Phone']?.toString() ?? 'Not Provided',
            ),
            _divider(),
            // ID Row
            _buildDetailRow(
              icon: Icons.info,
              title: 'User ID',
              value: userData?['Id']?.toString() ?? 'Not Provided',
            ),
            _divider(),
            // Created At Row
            _buildDetailRow(
              icon: Icons.calendar_today,
              title: 'Created At',
              value: (userData?['createdAt'] as Timestamp)
                      .toDate()
                      .toLocal()
                      .toString()
                      .split(' ')[0] ??
                  'Not Provided',
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create detail rows
  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: lightColorScheme.primary),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      ),
    );
  }

  // Divider for consistent spacing
  Widget _divider() {
    return const Divider(
      color: Colors.grey,
      height: 16,
      thickness: 0.8,
      indent: 16,
      endIndent: 16,
    );
  }
}
