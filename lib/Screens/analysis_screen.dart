import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intellitutor/Widgets/arrow_to_rectangle.dart';
import 'package:intellitutor/Widgets/bar_graph_widget.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Widgets/animated_line_graph.dart';

class AnalysisScreen extends StatefulWidget {
  AnalysisScreen();

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Section 1": 12.5,
      "Section 2": 12.5,
      "Section 3": 12.5,
      "Section 4": 12.5,
      "Section 5": 12.5,
      "Section 6": 12.5,
      "Section 7": 12.5,
      "Section 8": 12.5,
    };

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
                // isLoading
                //     ? Container(
                //         margin: EdgeInsets.only(
                //             top: MediaQuery.of(context).size.height * 0.3),
                //         child: LoadingAnimationWidget.staggeredDotsWave(
                //           color: const Color.fromARGB(255, 255, 255, 255),
                //           size: 150,
                //         ),
                //       )
                //  Column(
                //             children: [
                //               Container(
                //                 margin: EdgeInsets.only(
                //                     top: MediaQuery.of(context).size.height *
                //                         0.3),
                //                 height: 110,
                //                 width: 110,
                //                 child: Image.asset(
                //                   'lib/assets/not_found_image_asset.png',
                //                   fit: BoxFit
                //                       .contain, // Ensure the image fits within the container
                //                 ),
                //               ),
                //               const Text("Something went wrong !"),
                //             ],
                //           ) // for this add
                Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  child: Card(
                    color: Color.fromARGB(255, 27, 26, 26),
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
                            dataMap: dataMap,
                            animationDuration: Duration(milliseconds: 800),
                            chartLegendSpacing: 50,
                            chartRadius: MediaQuery.of(context).size.width / 2,
                            colorList: const [
                              Colors.red,
                              Colors.green,
                              Colors.blue,
                              Colors.yellow,
                              Colors.orange,
                              Colors.pink,
                              Colors.purple,
                              Colors.amber,
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
                              selectedIndex: 0,
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
                          Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: BarGraph()),
                          SBOX(),
                          DividerWidget(),
                          SBOX(),
                          const Text(
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 241, 239, 239),
                            ),
                            "Complexity Analysis:",
                          ).animate().fade(duration: 450.ms).slide(),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: LineGraph()),
                        ],
                      ),
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
