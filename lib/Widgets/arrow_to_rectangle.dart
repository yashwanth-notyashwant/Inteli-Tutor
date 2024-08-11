import 'package:flutter/material.dart';

class SectionedRectangleWithPointer extends StatelessWidget {
  final int selectedIndex;

  const SectionedRectangleWithPointer({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double rectangleWidth = screenWidth * 0.9; // Adjust width as needed
        double sectionWidth = rectangleWidth / 11;

        return Center(
          child: ClipRect(
            child: Container(
              height: 60,
              width: rectangleWidth,
              child: Stack(
                children: [
                  Container(
                    width: rectangleWidth,
                    height: 50, // Adjust height as needed
                    decoration: BoxDecoration(
                      // color: Colors.yellow,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      children: List.generate(
                        11,
                        (index) => Container(
                          width: sectionWidth
                              .floorToDouble(), // Ensure integer pixel width
                          color: index == selectedIndex
                              ? Colors.orange
                              : Colors.pink,
                          child: Center(child: Text('${index}')),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
