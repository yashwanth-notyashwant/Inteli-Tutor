import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intellitutor/Providers/courses_list.dart';

import 'package:intellitutor/Screens/login_page.dart';
import 'package:intellitutor/Screens/three_in_one_screen.dart';
import 'package:intellitutor/Screens/web.dart';

import 'package:intellitutor/Widgets/card_desc_widget_course.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_btn/loading_btn.dart';
import '../Widgets/bottom_sheet_message.dart';

import 'package:url_launcher/url_launcher.dart';

class CourseListScreen extends StatefulWidget {
  final int numb;
  final Color itemColor;
  final Color itemColor2;
  final String email;

  CourseListScreen({
    required this.email,
    required this.numb,
    required this.itemColor,
    required this.itemColor2,
  });

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> items = [];
  bool isLoading = true;
  void initState() {
    super.initState();
    final CourseProvider courseProvider = CourseProvider();
    courseProvider.fetchAllCourses(widget.email).then((courseExists) {
      if (courseExists != null) {
        print(courseExists.toList().toString());
        items = courseExists;
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          print("No courses found ");
          items = [];
          isLoading = false;
        });
      }
    });
  }

  Future<void> fetchsdfCourse() async {
    setState(() {
      isLoading = true;
    });
    final CourseProvider courseProvider = CourseProvider();
    var temp = (await courseProvider.fetchAllCourses(widget.email));
    if (temp == null) {
      items = [];
    } else {
      items = temp;
    }

    setState(() {
      isLoading = false;
    });
  }

  final List<Color> colors = [
    Color.fromARGB(255, 255, 197, 36),
    Color.fromARGB(255, 138, 193, 134),
    Color(0xFF00FFFF),
    Color.fromARGB(255, 255, 212, 127),
    Color.fromARGB(255, 120, 104, 216),
  ];

  // Define the list of items

  @override
  Widget build(BuildContext context) {
    void openBottomSheetChoice(BuildContext context) {
      final _formKey = GlobalKey<FormState>();
      String topicName = '';
      String complexity = 'Beginner'; // Default value
      String endGoals = '';

      showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40.0),
                ),
                border: Border(
                  top: BorderSide(
                    color: Color.fromARGB(255, 231, 231, 231),
                    width: 1.0,
                  ),
                  left: BorderSide(
                    color: Color.fromARGB(255, 231, 231, 231),
                    width: 1.0,
                  ),
                  right: BorderSide(
                    color: Color.fromARGB(255, 231, 231, 231),
                    width: 1.0,
                  ),
                  bottom: BorderSide.none,
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Topic Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a topic name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        topicName = value;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: complexity,
                      decoration: InputDecoration(labelText: 'Complexity'),
                      items: ['Beginner', 'Advanced', 'Expert']
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        complexity = newValue!;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'End Goals'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter end goals';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        endGoals = value;
                      },
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: LoadingBtn(
                        height: 60,
                        borderRadius: 20,
                        animate: true,
                        color: const Color.fromARGB(255, 236, 240, 243),
                        width: MediaQuery.of(context).size.width,
                        loader: Container(
                          padding: const EdgeInsets.all(10),
                          width: 40,
                          height: 40,
                          child: const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        onTap: (startLoading, stopLoading, btnState) async {
                          if (btnState == ButtonState.idle) {
                            if (_formKey.currentState!.validate()) {
                              startLoading();
                              print('Topic Name: $topicName');
                              print('Complexity: $complexity');
                              print('End Goals: $endGoals');

                              final courseProvider = CourseProvider();
                              bool stat =
                                  await courseProvider.createOrUpdateCourse(
                                widget.email,
                                topicName,
                                {},
                                complexity,
                                endGoals,
                              );
                              if (stat == true) {
                                fetchsdfCourse();
                                Navigator.pop(
                                    context); // successful addition of course
                              }

                              if (stat == false) {
                                // failed to genereate course
                                Future.delayed(Duration(milliseconds: 20), () {
                                  OpenBottomSheet instance = OpenBottomSheet();
                                  instance.openBottomSheet(context,
                                      "Content not suitable for learning or Explicit content warning, Candidate was blocked due to safety Error code #34624e");
                                });
                                Navigator.pop(context);
                              }
                              stopLoading();
                            }
                          }
                        },
                        child: const Text(
                          'Submit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 140,
              margin: EdgeInsets.only(left: 10, top: 50),
              color: Colors.black,
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 120, 104, 216),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Color(0xFF00FFFF),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 40,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 197, 36),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 0.3,
              color: Colors.grey,
              endIndent: 20,
              indent: 20,
            ),
            ListTile(
              leading: Icon(Icons.short_text),
              title: Text('Summarize'),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const SummarizeOrSimplifyScreen(whereFrom: 0),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat'),
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewContainer(
                            websiteURL: "https://gemini.google.com/app")));
              },
            ),
            ListTile(
              leading: Icon(Icons.spellcheck),
              title: Text('Correct IT!'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const SummarizeOrSimplifyScreen(whereFrom: 2),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.lightbulb),
              title: Text('Make It Easy'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const SummarizeOrSimplifyScreen(whereFrom: 1),
                  ),
                );
              },
            ),
            const Divider(
              thickness: 0.3,
              color: Colors.grey,
              endIndent: 20,
              indent: 20,
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help & Feedback'),
              onTap: () async {
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'yashwanth051202@gmail.com',
                  query: 'subject=${'Intelli-Tutor Android Feedback'}&body=${'''
Please attact a screen shot if necessary
For reporting bug please mention steps to reproduce the bug along with device details 
User email: ${widget.email}'''}',
                );
                if (await canLaunchUrl(emailUri)) {
                  await launchUrl(emailUri);
                } else {
                  //replace with the custom toast
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not open the email app.')),
                  );
                }

                // Handle the tap
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                print("pressed");
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
                // Handle the tap
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                        top: 65,
                        left: 20,
                      ),
                      height: 160,
                      child: InkWell(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        splashColor: Colors.transparent,
                        child: Container(
                          color: Colors.black,
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 38.0,
                          ),
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.only(top: 80, left: 10),
                    height: 160,
                    child: const Text(
                      " Courses",
                      style: TextStyle(
                        color: Color.fromARGB(255, 231, 231, 231),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                      padding: const EdgeInsets.only(
                        top: 70,
                        right: 20,
                      ),
                      height: 160,
                      child: InkWell(
                        onTap: () {
                          openBottomSheetChoice(context);
                        },
                        splashColor: Colors.transparent,
                        child: Container(
                          color: Colors.black,
                          child: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                            size: 38.0,
                          ),
                        ),
                      )),
                ],
              ),
              isLoading
                  ? Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.3),
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: 150,
                      ),
                    )
                  : items.isEmpty
                      ? Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.3),
                              height: 110,
                              width: 110,
                              child: Image.asset(
                                'lib/assets/not_found_image_asset.png',
                                fit: BoxFit
                                    .contain, // Ensure the image fits within the container
                              ),
                            ),
                            const Text("No course found, try creating some !"),
                          ],
                        )
                      : CardRounded(
                          items: items,
                          email: widget.email,
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
