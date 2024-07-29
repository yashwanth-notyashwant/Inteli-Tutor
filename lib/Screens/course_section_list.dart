import 'package:flutter/material.dart';
import 'package:intellitutor/Providers/courses_list.dart';
import 'package:intellitutor/Widgets/card_desc_sectionslist.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class CourseSecionsScreen extends StatefulWidget {
  final String email;
  final String courseName;

  CourseSecionsScreen({
    required this.email,
    required this.courseName,
  });
  @override
  State<CourseSecionsScreen> createState() => _CourseSecionsScreenState();
}

class _CourseSecionsScreenState extends State<CourseSecionsScreen> {
  bool isLoading = true;
  List<String> items = [];

  void initState() {
    super.initState();
    final CourseProvider courseProvider = CourseProvider();
    courseProvider
        .sectionNameFetcher(widget.email, widget.courseName)
        .then((courseExists) {
      if (courseExists != null) {
        print(courseExists.toList().toString());
        items = courseExists;
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          print("No sections found ");
          items = [];
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    padding: const EdgeInsets.only(top: 80, left: 10),
                    height: 160,
                    child: const Text(
                      "  Sections",
                      style: TextStyle(
                        color: Color.fromARGB(255, 231, 231, 231),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      // maxLines: 1,
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
                            const Text(
                                "No course sections found, Something went wrong"),
                          ],
                        ) // for this add
                      : CardRoundedSections(
                          items: items,
                          email: widget.email,
                          courseName: widget.courseName,
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
