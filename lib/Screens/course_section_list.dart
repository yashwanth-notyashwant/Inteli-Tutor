import 'package:flutter/material.dart';
import 'package:intellitutor/Providers/courses_list.dart';
import 'package:intellitutor/Screens/analysis_screen.dart';
import 'package:intellitutor/Screens/profile_screen.dart';

import 'package:intellitutor/Widgets/card_desc_sectionslist.dart';
import 'package:intellitutor/Widgets/rounded_card_quiz.dart';

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
  bool _isMounted = false;
  List<String> items = [];
  int _selectedIndex = 0;
  List<int> list = [];
  PageController _pageController = PageController();

  void caller() async {
    final CourseProvider courseProvider = CourseProvider();
    var courseExists = await courseProvider.sectionNameFetcher(
        widget.email, widget.courseName);

    if (courseExists != null) {
      print(courseExists.toList().toString());
      items = courseExists;
      list = (await courseProvider.getSectionScores(
          widget.email, widget.courseName));
      if (list == []) {
        if (_isMounted) {
          setState(() {
            print("No sections found");
            items = [];
            isLoading = false;
          });
        }
      }
      if (_isMounted) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      if (_isMounted) {
        setState(() {
          print("No sections found");
          items = [];
          isLoading = false;
        });
      }
    }
  }

  void another() {
    caller();
  }

  @override
  void initState() {
    _isMounted = true;
    super.initState();
    another();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press to ensure correct behavior
        if (_selectedIndex != 0) {
          _pageController.jumpToPage(0);
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            buildCourseSections(context),
            // QuizScreen(),
            // QuizSectionNameScreen(
            //   courseName: widget.email,
            //   email: widget.courseName,
            // ),
            buildCourseSectionsQuiz(context),
            AnalysisScreen(
              score: list,
            ),
            ProfileScreen(emailId: widget.email.toString(), score: list),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.white, // color of the top border
                width: 0.3, // width of the top border
              ),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                ),
                label: '',
                activeIcon: Icon(
                  Icons.home_filled,
                  size: 30,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.quiz_outlined,
                  size: 30,
                ),
                label: '',
                activeIcon: Icon(
                  Icons.quiz,
                  size: 30,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.pie_chart_outline,
                  size: 30,
                ),
                label: '',
                activeIcon: Icon(
                  size: 30,
                  Icons.pie_chart,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_2_outlined,
                  size: 30,
                ),
                label: '',
                activeIcon: Icon(
                  size: 30,
                  Icons.person_2,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }

  Widget buildCourseSections(BuildContext context) {
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
                                fit: BoxFit.contain,
                              ),
                            ),
                            const Text(
                                "No course sections found, Something went wrong"),
                          ],
                        )
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

  Widget buildCourseSectionsQuiz(BuildContext context) {
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
                      "  Quizzes",
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
                                fit: BoxFit.contain,
                              ),
                            ),
                            const Text("Something went wrong"),
                          ],
                        )
                      : RoundedCardQuiz(
                          score: list,
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
