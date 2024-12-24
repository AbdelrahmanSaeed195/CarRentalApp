import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project3/helper/show_Message.dart';
import 'package:project3/screen/login_screen.dart';
import 'package:project3/theme/theme.dart';
import 'package:project3/widgets/customformfeild.dart';

class UpdataProfileScreen extends StatefulWidget {
  const UpdataProfileScreen({super.key});
  static String id = "UpadataProfileScreen";

  @override
  State<UpdataProfileScreen> createState() => _UpdataProfileScreenState();
}

class _UpdataProfileScreenState extends State<UpdataProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController idController = TextEditingController();
  bool isSaving = false;
  bool isdelete = false;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    idController.dispose();
    super.dispose();
  }

  void clearFields() {
    fullNameController.clear();
    emailController.clear();
    phoneController.clear();
    idController.clear();
  }

  Future<void> _fetchUserData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          setState(() {
            fullNameController.text = data['FullName'] ?? 'Not Provided';
            emailController.text = data['Email'] ?? 'Not Provided';
            phoneController.text = data['Phone'] ?? 'Not Provided';
            idController.text = data['Id'] ?? 'Not Provided';
          });
        }
      }
    } catch (e) {
      showMessage(context, "Error fetching data: ${e.toString()}");
    }
  }

  Future<void> _saveProfile() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isSaving = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({
        'FullName': fullNameController.text.trim(),
        'Email': emailController.text.trim(),
        'Phone': phoneController.text.trim(),
        'Id': idController.text.trim(),
      });
      showMessage(context, "Profile updated successfully!");
      clearFields();
    } catch (e) {
      showMessage(context, "Error updating profile: ${e.toString()}");
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }

  Future<void> _deleteProfile() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .delete();
      showMessage(context, "Profile deleted successfully!");
      // FirebaseAuth.instance.signOut();
       Navigator.pushNamed(context, LoginScreen.id);
      clearFields();
    } catch (e) {
      showMessage(context, "Error deleting  profile: ${e.toString()}");
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
          'Edit Profile',
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                        child: Image.asset("assets/images/profile.jpg")),
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
              const SizedBox(height: 50),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Customformfeild(
                      controller: fullNameController,
                      keyboardtype: TextInputType.text,
                      hintText: 'Enter FullName',
                      labeltext: const Text('FullName'),
                      icon: Icons.perm_identity_sharp,
                      validator: (value) =>
                          value!.isEmpty ? "Full name cannot be empty" : null,
                    ),
                    const SizedBox(height: 20),
                    Customformfeild(
                      controller: emailController,
                      hintText: 'Enter Email',
                      labeltext: const Text('Email'),
                      icon: Icons.email_sharp,
                      validator: (value) => value!.isEmpty
                          ? "Email cannot be empty"
                          : (!value.contains('@')
                              ? "Enter a valid email"
                              : null),
                    ),
                    const SizedBox(height: 20),
                    Customformfeild(
                      controller: phoneController,
                      maxLength: 11,
                      keyboardtype: TextInputType.phone,
                      hintText: 'Enter Phone',
                      labeltext: const Text('Phone'),
                      icon: Icons.phone,
                      validator: (value) => value!.isEmpty
                          ? "Phone cannot be empty"
                          : (value.length != 11
                              ? "Enter a valid phone number"
                              : null),
                    ),
                    const SizedBox(height: 20),
                    Customformfeild(
                      controller: idController,
                      maxLength: 14,
                      keyboardtype: TextInputType.number,
                      hintText: 'Enter ID',
                      labeltext: const Text('ID'),
                      icon: Icons.phone,
                      validator: (value) => value!.isEmpty
                          ? "Id cannot be empty"
                          : (value.length != 14
                              ? "Enter a valid id number"
                              : null),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isSaving ? null : _saveProfile,
                        child: isSaving
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text:
                                ('Joined Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}'),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _showConfirmationDialog(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent.withOpacity(0.1),
                            elevation: 0,
                            foregroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Delete Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Are you sure you want to delete all related data?",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(
              foregroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.white,
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.red,
            ),
            child: const Text(
              "Delete",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      _deleteProfile();
    }
  }
}
