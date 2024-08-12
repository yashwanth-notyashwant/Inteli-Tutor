import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intellitutor/Providers/auth.dart';
import 'package:intellitutor/Screens/create_user_screen.dart';

import 'package:loading_btn/loading_btn.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailPasswordController = TextEditingController();
  final AuthService _authService = AuthService();

  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    return Container(
      color: const Color.fromRGBO(250, 247, 247, 1),
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: hi * 0.1),
                // ignore: avoid_unnecessary_containers
                Container(
                  child: const Text(
                    '''INTELI  TUTOR''',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(height: hi * 0.1),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(29),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      hintText: "Email ID",
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email address';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(29),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: emailPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.password,
                        color: Colors.black,
                      ),
                      hintText: "Passcode",
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter passcode';
                      }
                      if (value.length <= 6) {
                        return 'Min charachter count 6';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                LoadingBtn(
                  height: 50,
                  borderRadius: 5,
                  animate: true,
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.85,
                  loader: Container(
                    padding: const EdgeInsets.all(10),
                    width: 40,
                    height: 40,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  onTap: ((startLoading, stopLoading, btnState) async {
                    startLoading();
                    if (_formKey.currentState!.validate()) {
                      try {
                        print(emailController.text.toString().trim());
                        print(emailPasswordController.text.toString().trim());
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: emailController.text.toString().trim(),
                          password:
                              emailPasswordController.text.toString().trim(),
                        );
                        print('User signed in: ${credential.user}');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          try {
                            // ignore: unused_local_variable
                            final credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: emailController.text.toString().trim(),
                              password: emailPasswordController.text
                                  .toString()
                                  .trim(),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            }
                          }

                          // add here
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      } catch (e) {
                        print(e);
                        stopLoading();
                        return;
                      }

                      stopLoading();
                      return;
                    }
                  }),
                  child: const Text(
                    'Login / Create',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ), //add some styles
                ),
                const SizedBox(height: 10.0),
                LoadingBtn(
                  height: 50,
                  borderRadius: 5,
                  animate: true,
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.85,
                  loader: Container(
                    padding: const EdgeInsets.all(10),
                    width: 40,
                    height: 40,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  onTap: ((startLoading, stopLoading, btnState) async {
                    startLoading();

                    User? user = await _authService.signInWithGoogle();

                    if (user != null) {
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CreateUserScreen(user.email.toString())),
                      );
                    }

                    stopLoading();
                    return;
                  }),
                  child: const Text(
                    'Continue with google account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ), //add some styles
                ),
                SizedBox(height: hi * 0.05),
                const Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                    endIndent: 10,
                  )),
                  Text("OR"),
                  Expanded(
                      child: Divider(
                    indent: 10,
                  )),
                ]),
                SizedBox(height: hi * 0.05),
                LoadingBtn(
                  height: 50,
                  borderRadius: 5,
                  animate: true,
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.85,
                  loader: Container(
                    padding: const EdgeInsets.all(10),
                    width: 40,
                    height: 40,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  onTap: ((startLoading, stopLoading, btnState) async {
                    startLoading();
                    // User? user = await _authService.signInWithGoogle();

                    // if (user != null) {
                    //   // ignore: use_build_context_synchronously
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const CreateUserScreen()),
                    //   );
                    // }
                    stopLoading();
                    return;
                  }),
                  child: const Text(
                    'New User  >>',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ), //add some styles
                ),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
