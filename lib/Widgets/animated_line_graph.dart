import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineGraph extends StatelessWidget {
  final List<int> list;

  LineGraph({required this.list});
  final List<String> labels = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: list.asMap().entries.map((entry) {
              final index = entry.key;
              final value = entry.value;
              return FlSpot(index.toDouble(), value.toDouble());
            }).toList(),
            isCurved: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
            aboveBarData: BarAreaData(show: false),
          ),
        ],
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 1, // Ensure each title is shown for each value
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < labels.length) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      labels[index],
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  );
                } else {
                  return SizedBox
                      .shrink(); // Return an empty widget if out of range
                }
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 14),
                );
              },
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        lineTouchData: LineTouchData(enabled: true),
      ),
    );
  }
}
