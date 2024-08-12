import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intellitutor/Prompts.dart';
import 'package:intellitutor/Providers/courses_list.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:loading_btn/loading_btn.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  // late String id;
  final String courseName;
  final String email;
  final String secName;
  final List<int> scoreList;
  final int index;

  const QuizScreen(
      {required this.email,
      required this.secName,
      required this.courseName,
      required this.scoreList,
      required this.index});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int score = 0;
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  final TextEditingController _textController4 = TextEditingController();
  final TextEditingController _textController5 = TextEditingController();
  final TextEditingController _textController6 = TextEditingController();
  final TextEditingController _textController7 = TextEditingController();
  final TextEditingController _textController8 = TextEditingController();
  final TextEditingController _textController9 = TextEditingController();
  final TextEditingController _textController10 = TextEditingController();
  int _currentIndex = 0;
  bool isSubmitted = false;

  List<Map<String, String>> _questions = [];

  Widget toast(bool val) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 190, 190, 190),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          val == false ? Icon(Icons.warning) : Icon(Icons.fireplace),
          const SizedBox(
            width: 12.0,
          ),
          Text(
              val == false ? "  Wrong Answer !    " : "  Correct Answer !    "),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    _textController4.dispose();
    _textController5.dispose();
    _textController6.dispose();
    _textController7.dispose();
    _textController8.dispose();
    _textController9.dispose();
    _textController10.dispose();
    super.dispose();
  }

  late FToast fToast;
  bool isLoading = true;
  bool SWR = false;

  void awaiter() async {
    await Future.delayed(Duration(seconds: 3));
    final CourseProvider courseProvider = CourseProvider();
    String q2 = await courseProvider.getSectionQuery2(
        widget.email, widget.courseName, widget.secName);
    print("finally");
    print("The Q2");
    print(q2);
    if (q2 == "") {
      setState(() {
        SWR = true;
        isLoading = false;
      });
      return;
    }
    Prompts pr = Prompts();
    print("q2");
    print(q2);

    String? theJSON = await pr.promptJSon(q2);

    print(theJSON);
    _questions = (jsonDecode(theJSON!) as List<dynamic>)
        .map((item) => Map<String, String>.from(item))
        .toList();

    //

    setState(() {
      isLoading = false;
    });
  }

  void caller() {
    awaiter();
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    caller();

    _questions.shuffle();
  }

  void _showNextQuestion() {
    if (_currentIndex == _questions.length - 1) {
      return;
    }
    setState(() {
      _currentIndex = (_currentIndex + 1) % _questions.length;
    });
  }

  void _showPreviousQuestion() {
    if (_currentIndex == 0) {
      return;
    }
    setState(() {
      _currentIndex = (_currentIndex - 1) % _questions.length;
    });
  }

  int countItemsWithTStat(List<Map<String, String>> list) {
    int count = 0;

    for (var item in list) {
      if (item["stat"] == "T") {
        count++;
      }
    }

    return count;
  }

  @override
  Widget build(BuildContext context) {
    List CpntrollerList = [
      _textController1,
      _textController2,
      _textController3,
      _textController4,
      _textController5,
      _textController6,
      _textController7,
      _textController8,
      _textController9,
      _textController10,
    ];

    var wi = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 19, 24, 1),
      appBar: !isSubmitted
          ? AppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              toolbarHeight: 60,
              title: Text(
                'Section - ${widget.index + 1}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : AppBar(
              title: Text(''),
            ),
      body: !isSubmitted
          ? isLoading == true
              ? Column(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.3),
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: 150,
                        ),
                      ),
                    ),
                  ],
                )
              : SWR
                  ? Container(
                      child: Center(
                        child: Text('''Please read this section before
attending the quiz'''),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        width: wi,
                        color: Color.fromRGBO(18, 19, 24, 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20, top: 20),
                              child: Text(
                                'Question no:${_currentIndex + 1}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            _questions[_currentIndex]['stat'] == 'T'
                                ? Container(
                                    // height: 60,
                                    margin: EdgeInsets.only(top: 30),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 182, 222, 255),
                                      // borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),

                                    child: const Text(
                                      'Answer Correct Please Submit all',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black),
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 10),
                                    child: Text(
                                      _questions[_currentIndex]['question'] ??
                                          '',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                            SizedBox(height: 10),
                            if (_questions[_currentIndex]['stat'] == 'F')
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: TextField(
                                    controller: CpntrollerList[_currentIndex],
                                    decoration: InputDecoration(
                                      labelText: 'Enter your answer',
                                    ),
                                  ),
                                ),
                              ),
                            if (_questions[_currentIndex]['stat'] == 'F')
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 20.0,
                                    left: MediaQuery.of(context).size.width *
                                        0.04),
                                child: LoadingBtn(
                                  height: 60,
                                  borderRadius: 20,
                                  animate: true,
                                  color: Colors.white,
                                  // color: const Color.fromARGB(255, 182, 222, 255),
                                  width:
                                      MediaQuery.of(context).size.width * 0.92,
                                  loader: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 40,
                                    height: 40,
                                    child: const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.black),
                                    ),
                                  ),
                                  onTap: ((startLoading, stopLoading,
                                      btnState) async {
                                    startLoading();
                                    FocusScope.of(context).unfocus();

                                    Future.delayed(Duration(seconds: 1), () {
                                      if (CpntrollerList[_currentIndex]
                                              .text
                                              .toLowerCase()
                                              .replaceAll(' ', '') ==
                                          _questions[_currentIndex]['answer']
                                              ?.toLowerCase()
                                              .replaceAll(' ', '')) {
                                        var toastWidget = toast(true);
                                        score++;
                                        fToast.showToast(
                                          child: toastWidget,
                                          gravity: ToastGravity.BOTTOM,
                                          toastDuration: Duration(seconds: 1),
                                        );
                                        stopLoading();
                                        setState(() {
                                          _questions[_currentIndex]['stat'] =
                                              'T';
                                        });
                                        _showNextQuestion();
                                      } else {
                                        var toastWidget = toast(false);
                                        fToast.showToast(
                                          child: toastWidget,
                                          gravity: ToastGravity.BOTTOM,
                                          toastDuration: Duration(seconds: 1),
                                        );
                                        print('Wrong answer!');
                                        _showNextQuestion();
                                        stopLoading();
                                        return;
                                      }
                                    });

                                    return;
                                  }),
                                  child: const Text(
                                    'Check',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                  ), //add some styles
                                ),
                              ),
                            const SizedBox(height: 10),
                            if (_currentIndex == _questions.length - 1)
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 20.0,
                                    left: MediaQuery.of(context).size.width *
                                        0.04),
                                child: LoadingBtn(
                                  height: 60,
                                  borderRadius: 20,
                                  animate: true,
                                  color:
                                      const Color.fromARGB(255, 182, 222, 255),
                                  width:
                                      MediaQuery.of(context).size.width * 0.92,
                                  loader: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 40,
                                    height: 40,
                                    child: const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ),
                                  onTap: ((startLoading, stopLoading,
                                      btnState) async {
                                    if (_questions[_currentIndex]['stat'] ==
                                        'F') {
                                      var toastWidget = toast(false);
                                      fToast.showToast(
                                        child: toastWidget,
                                        gravity: ToastGravity.BOTTOM,
                                        toastDuration:
                                            const Duration(seconds: 1),
                                      );

                                      return;
                                    }
                                    if (btnState == ButtonState.idle) {
                                      startLoading();

                                      // add points in here
                                      print("The score is ");
                                      print(score);
                                      final CourseProvider courseProvider =
                                          CourseProvider();
                                      widget.scoreList[widget.index] = score;
                                      await courseProvider.updateSectionScores(
                                          widget.email,
                                          widget.courseName,
                                          widget.scoreList);

                                      stopLoading();
                                      await Future.delayed(
                                          const Duration(seconds: 1));
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    }
                                  }),
                                  child: const Text(
                                    'Submit All',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                  ), //add some styles
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width - 50,
                    width: MediaQuery.of(context).size.width - 50,
                    child: Text("DONE"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 30),
                    child: const Text(
                      '''You have submitted answers for this round Sucessfully and we have stored your results 🤞. Wait patiently, the next round will begin automatically''',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: !isSubmitted
          ? isLoading == false
              ? !SWR
                  ? FloatingActionButton.extended(
                      icon: const Icon(Icons.remove_red_eye),
                      label: const Text('See Answer'),
                      backgroundColor: Color.fromARGB(255, 182, 222, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 3.0,
                      onPressed: () {
                        openBottomSheetChoice(
                            context, _questions[_currentIndex]['answer']!);
                      },
                    )
                  : null
              : null
          : null,
    );
  }

  void openBottomSheetChoice(BuildContext context, String answer) {
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
            width: MediaQuery.of(context).size.width,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Text(
                  "Answer:",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  answer,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
