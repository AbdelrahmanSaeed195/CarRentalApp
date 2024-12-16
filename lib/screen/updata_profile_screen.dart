import 'package:flutter/material.dart';
import 'package:project3/theme/theme.dart';
import 'package:project3/widgets/custom_password_field.dart';
import 'package:project3/widgets/customformfeild.dart';

class UpdataProfileScreen extends StatefulWidget {
  const UpdataProfileScreen({super.key});
  static String id = "ProfileScreen";

  @override
  State<UpdataProfileScreen> createState() => _UpdataProfileScreenState();
}

class _UpdataProfileScreenState extends State<UpdataProfileScreen> {
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
                        Icons.camera_alt_sharp,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Form(
                child: Column(
                  children: [
                    Customformfeild(
                      keyboardtype: TextInputType.text,
                      hintText: 'Enter FullName',
                      labeltext: const Text('FullName'),
                      icon: Icons.perm_identity_sharp,
                    ),
                    const SizedBox(height: 15),
                    Customformfeild(
                      hintText: 'Enter Email',
                      labeltext: const Text('Email'),
                      icon: Icons.email_sharp,
                    ),
                    const SizedBox(height: 15),
                    Customformfeild(
                      maxLength: 11,
                      keyboardtype: TextInputType.phone,
                      hintText: 'Enter Phone',
                      labeltext: const Text('Phone'),
                      icon: Icons.phone,
                    ),
                    const SizedBox(height: 15),
                    CustomPasswordField(
                      hintText: 'Enter Confirm Password',
                      labeltext: const Text('Confirm Password'),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, UpdataProfileScreen.id);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                              text: 'Joined ',
                              style: TextStyle(fontSize: 15),
                              children: [
                                TextSpan(
                                  text: '31 October 2023',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ]),
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.redAccent.withOpacity(0.1),
                                elevation: 0,
                                foregroundColor: Colors.red,
                                side: BorderSide.none),
                            child: Text('Delete'))
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
}
