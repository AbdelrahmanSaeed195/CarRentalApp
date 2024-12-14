import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project3/helper/show_Message.dart';
import 'package:project3/screen/forget_password_screen.dart';
import 'package:project3/screen/home_screen.dart';
import 'package:project3/screen/register_screen.dart';
import 'package:project3/theme/theme.dart';
import 'package:project3/widgets/custom_scaffold.dart';
import '../widgets/custom_password_field.dart';
import '../widgets/customformfeild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String id = "login Screen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool rememberPassword = true;
  bool isloading = false;
  String? email, password;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: lightColorScheme.primary,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Customformfeild(
                            controller: emailController,
                            hintText: 'Enter Email',
                            labeltext: const Text('Email'),
                            onChanged: (data) {
                              email = data;
                            },
                            icon: Icons.email_sharp,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          CustomPasswordField(
                            onChanged: (data) {
                              password = data;
                            },
                            hintText: 'Enter Password',
                            labeltext: const Text(' Password'),
                            controller: passwordController,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: rememberPassword,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        rememberPassword = value!;
                                      });
                                    },
                                    activeColor: lightColorScheme.primary,
                                  ),
                                  const Text(
                                    'Remember me',
                                    style: TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPasswordScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forget Password',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: lightColorScheme.primary,
                                  ),
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
                                    rememberPassword) {
                                  isloading = true;
                                  setState(() {});
                                  try {
                                    await loginUser();
                                    Navigator.pushNamed(context, HomeScreen.id);
                                    // showErrorMessage('The email Login.');
                                    // ShowSnakBar(context, 'The email Login.');
                                  } on FirebaseAuthException catch (e) {
                                    showMessage(context,e.code);
                                    // if (e.code == 'wrong-password') {
                                    //  showErrorMessage('Wrong password provided for that user.');
                                    // } else if (e.code == ' user-not-found') {
                                    // showErrorMessage(
                                    //     'No user found for that email.');
                                    // }
                                  } catch (e) {
                                    showMessage(context,'there was an error');
                                  }
                                  isloading = false;
                                  setState(() {});
                                }
                              },
                              child: const Text('Login'),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Expanded(
                          //       child: Divider(
                          //         thickness: 0.7,
                          //         color: Colors.grey.withOpacity(0.5),
                          //       ),
                          //     ),
                          //     const Padding(
                          //       padding: EdgeInsets.symmetric(
                          //         vertical: 0,
                          //         horizontal: 10,
                          //       ),
                          //       child: Text(
                          //         'Register With',
                          //         style: TextStyle(
                          //           color: Colors.black45,
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child: Divider(
                          //         thickness: 0.7,
                          //         color: Colors.grey.withOpacity(0.5),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 25,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Logo(Logos.facebook_f),
                          //     Logo(Logos.google),
                          //     Logo(Logos.apple),
                          //   ],
                          // ),
                          MaterialButton(
                            height: 60,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: lightColorScheme.primary,
                            textColor: Colors.white,
                            onPressed: () {
                              signInWithGoogle();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Login With Google  '),
                                Image.asset(
                                  'assets/images/google.jpeg',
                                  width: 30,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account? ',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()),
                                  );
                                },
                                child: Text(
                                  'Register',
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

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.pushNamed(context, HomeScreen.id);
  }
}
