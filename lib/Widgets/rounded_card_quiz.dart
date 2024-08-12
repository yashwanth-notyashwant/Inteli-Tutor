import 'package:flutter/material.dart';

import 'package:intellitutor/Providers/courses_list.dart';
import 'package:intellitutor/Screens/quiz_screen.dart';

class RoundedCardQuiz extends StatefulWidget {
  final String email;
  final String courseName;
  final List<String> items;
  final List<int> score;
  RoundedCardQuiz(
      {required this.items,
      required this.email,
      required this.courseName,
      required this.score});

  @override
  State<RoundedCardQuiz> createState() => _RoundedCardQuizState();
}

class _RoundedCardQuizState extends State<RoundedCardQuiz> {
  @override
  void initState() {
    // TODO: implement initState
    print("This iiiiiiiiiiiiiiiiiiiiiiiis it ");
    print(widget.score);
    super.initState();
  }
  // Define the list of items

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Container(
          height: widget.items.length * 80.0 + 66.0,
          child: Stack(
            children: List.generate(widget.items.length, (index) {
              // Get the color for the current index

              return Positioned(
                top: index * 80.0,
                left: 0,
                right: 0,
                child: Container(
                  height: 150,
                  child: Card(
                    // color: itemColor,
                    color: const Color.fromARGB(255, 12, 12, 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 190, 190, 190),
                        width: 0.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListTile(
                        splashColor: Colors.transparent,
                        leading: Container(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            width: 36,
                            child: widget.score[index] == -1
                                ? Icon(
                                    size: 25,
                                    Icons.hourglass_empty_rounded,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    size: 25,
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                          ),
                        ),

                        title: Text(
                          widget.items[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                        // subtitle: Icon(Icons.star), here i wanna add some section numbers
                        trailing: const Icon(Icons.chevron_right),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(
                                email: widget.email,
                                secName: widget.items[index],
                                courseName: widget.courseName,
                                scoreList: widget.score,
                                index: index,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
