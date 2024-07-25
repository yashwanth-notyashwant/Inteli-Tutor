import 'package:flutter/material.dart';
import 'package:intellitutor/Providers/courses_list.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DescWidget extends StatefulWidget {
  final String email;
  final String sectionName;
  final String courseName;

  DescWidget(
      {required this.email,
      required this.sectionName,
      required this.courseName});

  @override
  State<DescWidget> createState() => _DescWidgetState();
}

class _DescWidgetState extends State<DescWidget> {
  bool isLoading = true;
  String desc = "";

  @override
  void initState() {
    super.initState();
    final CourseProvider courseProvider = CourseProvider();
    courseProvider
        .specificSectionFieldFetcher(
            widget.email, widget.courseName, widget.sectionName)
        .then((descExists) {
      print("checker 1");
      print(descExists);
      if (descExists == null) {
        print("checker 2");
        desc = "Something went wrong";
      } else if (descExists == "") {
        print("checker 3");
        // get query
        courseProvider
            .specificSectionFieldFetcher(
                widget.email, widget.courseName, 'query')
            .then((queryExists) {
          if (queryExists == null) {
            print("checker 4");
            desc = "Something went wrong";
          } else if (queryExists == "") {
            print("checker 5");
            desc = "Something went wrong";
          } else {
            print(queryExists);
            // call AI create
            courseProvider
                .createDescAI(widget.email, queryExists.toString(),
                    widget.sectionName, widget.courseName)
                .then((resp) {
              if (resp == "") {
                print("checker 6");
                desc = "Something went wrong";
              } else {
                print("checker 7");
                desc = resp.toString();
                setState(() {
                  isLoading = false;
                });
              }
            });
          }
        });
      } else {
        desc = descExists;
        setState(() {
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
                    padding: const EdgeInsets.only(top: 45, left: 10),
                    height: 120,
                    child: const Text(
                      " Explanation",
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
                        color: const Color.fromARGB(255, 255, 255, 255),
                        size: 150,
                      ),
                    )
                  : desc == ""
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
                            const Text("Something went wrong !"),
                          ],
                        ) // for this add
                      : Container(
                          margin: const EdgeInsets.only(bottom: 60),
                          child: Card(
                            color: const Color.fromARGB(255, 36, 35, 35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(30),
                              child: Text(
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 238, 233, 233)),
                                  desc),
                            ),
                          ),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
