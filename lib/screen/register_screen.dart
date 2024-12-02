import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project3/screen/login_screen.dart';
import 'package:project3/theme/theme.dart';
import 'package:project3/widgets/custom_password_field.dart';
import 'package:project3/widgets/custom_scaffold.dart';

import '../helper/show_snack_bar.dart';
import '../widgets/customformfeild.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email, password;
  bool isloading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  bool agreePersonalData = true;
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final idController = TextEditingController();
  final phoneController = TextEditingController();
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: CustomScaffold(
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: SizedBox(
                height: 10,
              ),
            ),
            Expanded(
              flex: 12,
              child: Container(
                padding: const EdgeInsets.fromLTRB(25, 50, 25, 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: lightColorScheme.primary),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Customformfeild(
                          keyboardtype: TextInputType.text,
                          controller: fullNameController,
                          hintText: 'Enter FullName',
                          labeltext: const Text('FullName'),
                          icon: Icons.perm_identity_sharp,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Customformfeild(
                          keyboardtype: TextInputType.emailAddress,
                          controller: emailController,
                          hintText: 'Enter Email',
                          labeltext: const Text('Email'),
                          onChanged: (data) {
                            email = data;
                          },
                          icon: Icons.email_sharp,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Customformfeild(
                          maxLength: 11,
                          keyboardtype: TextInputType.phone,
                          controller: phoneController,
                          hintText: 'Enter Phone',
                          labeltext: const Text('Phone'),
                          icon: Icons.phone,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Customformfeild(
                          maxLength: 14,
                          keyboardtype: TextInputType.number,
                          controller: idController,
                          hintText: 'Enter National Id',
                          labeltext: const Text('Id'),
                          icon: Icons.info,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomPasswordField(
                          onChanged: (data) {
                            password = data;
                          },
                          hintText: 'Enter Password',
                          labeltext: const Text('Password'),
                          controller: passwordController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomPasswordField(
                          hintText: 'Enter Confirm Password',
                          labeltext: const Text('Confirm Password'),
                          controller: confirmpasswordController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              value: agreePersonalData,
                              onChanged: (bool? value) {
                                setState(() {
                                  agreePersonalData = value!;
                                });
                              },
                              activeColor: lightColorScheme.primary,
                            ),
                            const Text(
                              'I agree to the processing of',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                            Text(
                              'Personal data',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate() &&
                                  agreePersonalData) {
                                setState(() {});
                                isloading = true;
                                setState(() {});

                                try {
                                  await registerUser();
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    // ShowSnakBar(context,
                                    //     'The password provided is too weak.');
                                    showErrorMessage(
                                        'The password provided is too weak.');
                                  } else if (e.code == 'email-already-in-use') {
                                    // ShowSnakBar(context,
                                    //     'The account already exists for that email.');
                                    showErrorMessage(
                                        'The account already exists for that email.');
                                  }
                                } catch (e) {
                                  print(e);
                                  // ShowSnakBar(context, 'there was an error');
                                  showErrorMessage('there was an error');
                                }
                                isloading = false;
                                setState(() {});
                              } else if (!agreePersonalData) {
                                // ShowSnakBar(context,
                                //     'please agree the processing of personal data');
                                showErrorMessage(
                                    'please agree the processing of personal data');
                              }
                            },
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Register')),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: lightColorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    if (passwordController.text == confirmpasswordController.text) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // ShowSnakBar(context, 'The email success.');
      showErrorMessage('The email success.');
    } else {
      // ShowSnakBar(context, 'Password don\'t match');
      showErrorMessage('Password don\'t match');
    }
  }
}
