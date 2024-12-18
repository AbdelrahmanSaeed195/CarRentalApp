import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project3/helper/show_Message.dart';
import 'package:project3/screen/home_screen.dart';
import 'package:project3/theme/theme.dart';
import 'package:project3/widgets/custom_password_field.dart';
import 'package:project3/widgets/custom_scaffold.dart';
import '../widgets/customformfeild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static String id = "Register Screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email, password;
  bool isloading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  bool agreePersonalData = true;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
              flex: 14,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'field is required';
                              }
                              return null;
                            },
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
                            validator: (value) => value!.isEmpty
                                ? "Email cannot be empty"
                                : (!value.contains('@')
                                    ? "Enter a valid email"
                                    : null),
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
                            validator: (value) => value!.isEmpty
                                ? "Phone cannot be empty"
                                : (value.length != 11
                                    ? "Enter a valid phone number"
                                    : null),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'field is required';
                              }
                              return null;
                            },
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
                                      showMessage(context,
                                          'The password provided is too weak.');
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      showMessage(context,
                                          'The account already exists for that email.');
                                    }
                                  } catch (e) {
                                    print(e);
                                    showMessage(context, 'there was an error');
                                  }
                                  isloading = false;
                                  setState(() {});
                                } else if (!agreePersonalData) {
                                  showMessage(context,
                                      'please agree the processing of personal data');
                                }
                              },
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Register'),
                              ),
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    if (passwordController.text == confirmpasswordController.text) {
      try {
        // Register the user
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        String userid = FirebaseAuth.instance.currentUser!.uid;

        // Add user details to Firestore
        await addUserDelails(
          fullNameController.text,
          emailController.text,
          int.parse(idController.text),
          int.parse(phoneController.text),
          DateTime.now(),
          userid,
        );

        // Clear controllers after successful registration
        fullNameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmpasswordController.clear();
        idController.clear();
        phoneController.clear();

        // Navigate to the home screen
        Navigator.pushNamed(context, HomeScreen.id);
      } catch (e) {
        showMessage(context, 'Error: ${e.toString()}');
      }
    } else {
      showMessage(context, 'Passwords don\'t match');
    }
  }

  Future addUserDelails(String fullName, String email, int id, int phone,
      DateTime createdAt, String userid) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(userid).set({
        'FullName': fullName,
        'Email': email,
        'Id': id,
        'Phone': phone,
        'createdAt': createdAt,
      });
    } on Exception catch (e) {
      showMessage(context, "Error ${e.toString()}");
    }
  }


}
