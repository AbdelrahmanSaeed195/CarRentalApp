import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project3/helper/show_Message.dart';
import 'package:project3/widgets/custom_scaffold.dart';
import 'package:project3/widgets/customformfeild.dart';
import '../theme/theme.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key, this.email});
  final String? email;
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showMessage(context, 'Password Reset Link Sent! Check your Email');
      emailController.clear();
    } on FirebaseAuthException catch (e) {
      print(e);
      showMessage(context, 'Please Enter Actual Email to resent password link');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: const EdgeInsets.fromLTRB(25, 50, 25, 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Customformfeild(
                        validator: (value) => value!.isEmpty
                            ? "Email cannot be empty"
                            : (!value.contains('@')
                                ? "Enter a valid email"
                                : null),
                        controller: emailController,
                        hintText: 'Enter Email',
                        labeltext: const Text('Email'),
                        icon: Icons.email_sharp,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    MaterialButton(
                      shape: const RoundedRectangleBorder(),
                      onPressed: passwordReset,
                      color: lightColorScheme.primary,
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
