import 'package:flutter/material.dart';
import 'package:intellitutor/Consts/constants.dart';
import 'package:intellitutor/Screens/desc_page.dart';

class CardRoundedSections extends StatefulWidget {
  final String? email;
  final String? courseName;
  final List<String> items;
  CardRoundedSections({required this.items, this.email, this.courseName});
  @override
  State<CardRoundedSections> createState() => _CardRoundedSectionsState();
}

class _CardRoundedSectionsState extends State<CardRoundedSections> {
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
                            child: Hero(
                              tag: 'circle1-$index',
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
                              builder: (context) => DescWidget(
                                email: widget.email!,
                                courseName: widget.courseName!,
                                sectionName: widget.items[index],
                                itemColor: itemColor,
                                itemColor2: itemColor2,
                                numb: index,
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
