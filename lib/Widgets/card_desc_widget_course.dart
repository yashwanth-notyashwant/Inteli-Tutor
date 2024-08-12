import 'package:flutter/material.dart';
import 'package:intellitutor/Consts/constants.dart';
import 'package:intellitutor/Screens/course_section_list.dart';

class CardRounded extends StatefulWidget {
  final String? email;
  final String? courseName;
  final List<String> items;
  CardRounded({required this.items, this.email, this.courseName});
  @override
  State<CardRounded> createState() => _CardRoundedState();
}

class _CardRoundedState extends State<CardRounded> {
  

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
                          Color itemColor = colors[index % colors.length];
              Color itemColor2 = colors[(index + 1) % colors.length];

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
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: 36,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: itemColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 12,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: itemColor2,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        title: Text(
                          widget.items[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                       
                        trailing: const Icon(Icons.chevron_right),

                        onTap: () {
                          Navigator.push(
                            context,
                         
                            MaterialPageRoute(
                              builder: (context) => CourseSecionsScreen(
                                email: widget.email!,
                                courseName: widget.items[index],
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
