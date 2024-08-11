import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:loading_btn/loading_btn.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  // late String id;
  const QuizScreen();
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
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

  final List<Map<String, String>> _questions = [
    {
      "question":
          "An old man shoots his wife . Then he held her under the water for 5 minutes. Finally, he hangs her . But 10 minutes later they both go on a dinner date together. What is the old man's profession ?",
      "answer": "photographer",
      "stat": "F",
    },
    {
      "question": '''Pink houses are made up of pink bricks. 
Blue houses are made up of blue bricks.
Yellow houses are made up of yellow bricks.
Brown houses are made up of brown bricks.
Green houses are made up of ______
''',
      "answer": "glass",
      "stat": "F",
    },
    {
      "question":
          "Which three letters can frighten both  patient and a criminal?",
      "answer": "icu",
      "stat": "F",
    },
    {
      "question":
          "Hey can you guess the next four letters ? If not you’ll lose  H C Y G T F L _ _ _ _ ",
      "answer": "inyl",
      "stat": "F",
    },
    {
      "question": "What letter comes next? S R G M P D N _",
      "answer": "s",
      "stat": "F",
    },
  ];

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

  void awaiter() async {
    await Future.delayed(Duration(seconds: 3));
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

    _questions.shuffle(); // Shuffle the list of questions at the beginning
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

    Future<bool> pointAdder(String id, int points) async {
      try {
        // mark the list [0,0,0,0,0,0,0,0] to -- > [1,0,0,0,0,0,0,0]
        // Get a reference to the user's document in Firestore
        DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(id);

        // Update the milestone field by incrementing the provided points
        await userRef.update({
          'milestone': [
            1,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
          ]
        });

        print('Milestone updated successfully.');

        return true;
      } catch (error) {
        print('Error updating milestone: $error');

        return false;
      }
    }

    void _openBottomSheet(
      BuildContext context,
      int index,
    ) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text("Sampling"),
                ),
              ],
            ),
          );
        },
      );
    }

    // var hi = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 19, 24, 1),
      appBar: !isSubmitted
          ? AppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              title: Text(
                'Section -1',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
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
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.3),
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
                                  color:
                                      const Color.fromARGB(255, 182, 222, 255),
                                  // borderRadius: BorderRadius.circular(20),
                                ),
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(left: 10, right: 10),

                                child: const Text(
                                  'Answer Correct Please Submit all',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ), //add some styles
                              )
                            : Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10),
                                child: Text(
                                  _questions[_currentIndex]['question'] ?? '',
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
                                left: MediaQuery.of(context).size.width * 0.04),
                            child: LoadingBtn(
                              height: 60,
                              borderRadius: 20,
                              animate: true,
                              color: Colors.white,
                              // color: const Color.fromARGB(255, 182, 222, 255),
                              width: MediaQuery.of(context).size.width * 0.92,
                              loader: Container(
                                padding: const EdgeInsets.all(10),
                                width: 40,
                                height: 40,
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.black),
                                ),
                              ),
                              onTap:
                                  ((startLoading, stopLoading, btnState) async {
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
                                    fToast.showToast(
                                      child: toastWidget,
                                      gravity: ToastGravity.BOTTOM,
                                      toastDuration: Duration(seconds: 1),
                                    );
                                    stopLoading();
                                    setState(() {
                                      _questions[_currentIndex]['stat'] = 'T';
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
                        if (_currentIndex == _questions.length - 1)
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 20.0,
                                left: MediaQuery.of(context).size.width * 0.04),
                            child: LoadingBtn(
                              height: 60,
                              borderRadius: 20,
                              animate: true,
                              color: const Color.fromARGB(255, 182, 222, 255),
                              width: MediaQuery.of(context).size.width * 0.92,
                              loader: Container(
                                padding: const EdgeInsets.all(10),
                                width: 40,
                                height: 40,
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                              onTap:
                                  ((startLoading, stopLoading, btnState) async {
                                if (_questions[_currentIndex]['stat'] == 'F') {
                                  var toastWidget = toast(false);
                                  fToast.showToast(
                                    child: toastWidget,
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: Duration(seconds: 1),
                                  );

                                  return;
                                }
                                if (btnState == ButtonState.idle) {
                                  startLoading();

                                  // var ifSubmitted =
                                  //     await pointAdder(widget.id, 2);

                                  // if (ifSubmitted == true) {
                                  //   setState(() {
                                  //     isSubmitted = true;
                                  //   });
                                  //   Future.delayed(Duration(seconds: 3), () {
                                  //     Navigator.pushReplacement(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               Round2(widget.id)),
                                  //     );
                                  //   });
                                  // }
                                  // if (isSubmitted == false) {
                                  //   stopLoading();
                                  // }

                                  stopLoading();
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
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.remove_red_eye),
              label: const Text('See Answer'),
              backgroundColor: Color.fromARGB(255, 182, 222, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 3.0,
              onPressed: () {
                // int et = calculateElapsedTime();
                _openBottomSheet(
                  context,
                  0,
                );
              },
            )
          : null,
    );
  }
}
