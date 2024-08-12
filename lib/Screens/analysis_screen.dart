import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intellitutor/Widgets/arrow_to_rectangle.dart';
import 'package:intellitutor/Widgets/bar_graph_widget.dart';

// import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Widgets/animated_line_graph.dart';

class AnalysisScreen extends StatefulWidget {
  final List<int> score;
  AnalysisScreen({required this.score});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  bool isUntouched = false;
  bool _isMounted = false;
  Map<String, double> dataMapp = {
    "Completed": 50,
    "Incomplete": 50,
  };
  List<int> replacedNumbers = [];
  int average = 0;
  int n = 0;
  @override
  void initState() {
    _isMounted = true;
    int incomplete = 0;
    int complete = 0;
    for (int i in widget.score) {
      if (i == -1) {
        incomplete++;
      } else {
        n++;
        average += i;
        complete++;
      }
    }
    if (incomplete == widget.score.length) {
      if (_isMounted) {
        setState(() {
          isUntouched = true;
        });
      }

      return;
    }
    dataMapp["Completed"] = (complete / (complete + incomplete)) * 100;
    dataMapp["Incomplete"] = 100.0 - dataMapp["Completed"]!;
    print("before");
    print(average);
    average = average ~/ n;
    average = average > 0 ? average : 0;
    print(average);

    replacedNumbers = widget.score.map((number) {
      if (number == -1) {
        return 0;
      } else if (number == 0) {
        return 1;
      } else {
        return number + 1;
      }
    }).toList();
    super.initState();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                            SlideEffect()
                          ],
                          child: const Text(
                            "  Analysis",
                            style: TextStyle(
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
                !isUntouched
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 60),
                        child: Card(
                          // color: Color.fromARGB(255, 16, 16, 16), this is a bit darker if you wanna go with this see once
                          color: Color.fromRGBO(18, 19, 24, 1),
                          // color: Colors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                top: 60, left: 30, right: 30, bottom: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 241, 239, 239),
                                  ),
                                  "Completed sections:",
                                ).animate().fade(duration: 450.ms).slide(),
                                const SizedBox(height: 25),
                                PieChart(
                                  dataMap: dataMapp,
                                  animationDuration:
                                      Duration(milliseconds: 800),
                                  chartLegendSpacing: 50,
                                  chartRadius:
                                      MediaQuery.of(context).size.width / 2,
                                  colorList: const [
                                    // Colors.red,
                                    // Colors.green,
                                    // Colors.blue,
                                    // Colors.yellow,
                                    Colors.orange,
                                    Colors.pink,
                                    // Colors.purple,
                                    // Colors.amber,
                                  ],
                                  chartValuesOptions: const ChartValuesOptions(
                                    showChartValuesInPercentage: true,
                                    showChartValuesOutside: false,
                                    decimalPlaces: 1,
                                    showChartValues: true,
                                    chartValueStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    showChartValueBackground: false,
                                  ),
                                  legendOptions: const LegendOptions(
                                    showLegendsInRow: false,
                                    legendPosition: LegendPosition.right,
                                    legendTextStyle: TextStyle(
                                      color: Color.fromARGB(255, 241, 239, 239),
                                    ),
                                  ),
                                  // centerText: "Total",
                                ),
                                SBOX(),
                                DividerWidget(),
                                SBOX(),
                                const Text(
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 241, 239, 239),
                                  ),
                                  "Average of all sections:",
                                ).animate().fade(duration: 450.ms).slide(),
                                const SizedBox(height: 25),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: SectionedRectangleWithPointer(
                                    selectedIndex: average,
                                  ),
                                ),
                                SBOX(),
                                DividerWidget(),
                                SBOX(),
                                const Text(
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 241, 239, 239),
                                  ),
                                  "Score distribution:",
                                ).animate().fade(duration: 450.ms).slide(),
                                SBOX(),
                                SBOX(),
                                Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    child: BarGraph(
                                      list: replacedNumbers,
                                    )),
                                SBOX(),
                                DividerWidget(),
                                SBOX(),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    child: LineGraph(
                                      list: widget.score,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.3),
                        child: const Center(
                          child: Text(
                            "Please attend the quiz to view this screen",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget SBOX() {
    return const SizedBox(
      height: 10,
    );
  }

  Widget DividerWidget() {
    return const Divider(
      thickness: 0.3,
      indent: 20,
      endIndent: 20,
    );
  }
}
