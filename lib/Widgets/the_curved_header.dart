import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TheHeaderWidget extends StatelessWidget {
  final String title;

  const TheHeaderWidget({required this.title});

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
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      padding: const EdgeInsets.only(top: 45, left: 10),
                      height: 120,
                      child: Animate(
                        effects: [
                          FadeEffect(duration: 400.ms),
                          const SlideEffect()
                        ],
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 231, 231, 231),
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          // maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
