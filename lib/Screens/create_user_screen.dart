import 'package:flutter/material.dart';
import 'package:intellitutor/Providers/profile.dart';
import 'package:intellitutor/Screens/course_list_screen.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Models/AuthUser.dart';

// ignore: must_be_immutable
class CreateUserScreen extends StatefulWidget {
  String email;

  CreateUserScreen(this.email, {super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    final UserDataProvider _userDataProvider = UserDataProvider();
    _userDataProvider.checkUserExists(widget.email).then((userExists) {
      if (userExists) {
        // SummarizePicScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseListScreen(
              email: widget.email,
              numb: 1,
              itemColor: Color.fromARGB(255, 255, 197, 36),
              itemColor2: Color(0xFF00FFFF),
            ),
          ),
        );

        print("================= Going to home screen ============");
      } else {
        // User hasnt checked this page out yet
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController languageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        body: isLoading
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                color: Color.fromARGB(255, 26, 24, 43),
                size: 150,
              ))
            : Form(
                key: _formKey,
                child: Container(
                  color: const Color.fromRGBO(250, 247, 247, 1),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: hi * 0.1),
                          Container(
                            child: const Text(
                              '''INTELI TUTOR''',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          SizedBox(height: hi * 0.3),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
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
                              controller: nameController,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                hintText: "Name",
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter name ';
                                }
                                if (value.length <= 3) {
                                  return 'Please enter a valid name';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
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
                              keyboardType: TextInputType.number,
                              controller: ageController,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.black,
                                ),
                                hintText: "Age",
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your age.';
                                }
                                int age = int.tryParse(value) ?? 0;
                                if (age < 10 || age > 120) {
                                  return 'Please enter a valid age between 1 and 120.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
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
                              controller: languageController,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.language,
                                  color: Colors.black,
                                ),
                                hintText: "Language ",
                                border: InputBorder.none,
                              ),
                              // keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter language ';
                                }
                                if (value.length <= 3) {
                                  return 'Please enter a valid language';
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
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            onTap:
                                ((startLoading, stopLoading, btnState) async {
                              startLoading();
                              if (_formKey.currentState!.validate()) {
                                //

                                final UserDataProvider _userDataProvider =
                                    UserDataProvider();
                                bool abc = await _userDataProvider
                                    .createOrUpdateUserDoc(
                                  AuthUser(
                                    age: ageController.text.toString(),
                                    language:
                                        languageController.text.toString(),
                                    name: nameController.text.toString(),
                                    milestone: "Noob",
                                  ),
                                  widget.email.toString(),
                                );
                                print("=======================");
                                print(abc);
                                print("=======================");
                                if (abc == true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CourseListScreen(
                                        email: widget.email,
                                        numb: 1,
                                        itemColor:
                                            Color.fromARGB(255, 255, 197, 36),
                                        itemColor2: Color(0xFF00FFFF),
                                      ),
                                    ),
                                  );
                                }

                                stopLoading();
                                return;
                              }
                              stopLoading();
                              return;
                            }),
                            child: const Text(
                              'Create Profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ), //add some styles
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
