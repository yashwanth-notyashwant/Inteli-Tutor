import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intellitutor/Providers/courses_list.dart';

import 'package:intellitutor/Widgets/card_desc_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_btn/loading_btn.dart';

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
          items = ['Nott found error'];
          isLoading = false;
        });
      }
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
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniStartDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
            right: 20,
            top:
                20), // as startdocked will give starting a bit of padding for some reason
        child: LoadingBtn(
          height: 60,
          borderRadius: 20,
          animate: true,
          color: Color.fromARGB(255, 236, 240, 243),
          width: MediaQuery.of(context).size.width,
          loader: Container(
            padding: const EdgeInsets.all(10),
            width: 40,
            height: 40,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          onTap: ((startLoading, stopLoading, btnState) async {
            if (btnState == ButtonState.idle) {
              startLoading();
              final courseProvider = CourseProvider();
              await courseProvider
                  .createOrUpdateCourse(widget.email, "csadasg ", {});
              stopLoading();
            }
          }),
          child: const Text(
            'Floating button ',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w300, color: Colors.black),
          ), //add some styles
        ),
      ),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.only(left: 30, top: 40),
                    child: SizedBox(
                      width: 36,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: widget.itemColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: widget.itemColor2,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 45, left: 10),
                    height: 120,
                    child: const Text(
                      "Courses",
                      style: TextStyle(
                        color: Color.fromARGB(255, 231, 231, 231),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              isLoading
                  ? Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.3),
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: 150,
                      ))
                  : CardRounded(items),
            ],
          ),
        ),
      ),
    );
  }
}
