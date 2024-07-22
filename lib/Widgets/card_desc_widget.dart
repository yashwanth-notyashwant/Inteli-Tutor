import 'package:flutter/material.dart';

class CardRounded extends StatefulWidget {
  final List<String> items;
  CardRounded(this.items);
  @override
  State<CardRounded> createState() => _CardRoundedState();
}

class _CardRoundedState extends State<CardRounded> {
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
    return Container(
      margin: EdgeInsets.only(bottom: 60),
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
                    color: Color.fromARGB(255, 12, 12, 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      side: BorderSide(
                        color: Colors.white, // Adjust border color as needed
                        width: 1.0, // Adjust border width as needed
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListTile(
                        splashColor: Colors.transparent,
                        leading: Hero(
                          tag:
                              'circle1-$index', // Unique tag for the first circle hero animation
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: 36, // Width to accommodate the two circles
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color:
                                            itemColor, // Color of the first circle
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left:
                                        12, // Adjust this value to control the overlap
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
                        ), //
                        title: Text(
                          "${widget.items[index]}",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {},
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
