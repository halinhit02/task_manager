import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyChart extends StatefulWidget {
  const MyChart({Key? key}) : super(key: key);

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  final List<ChartData> chartData = [
    ChartData('Mar', 20, 30, 40, 50),
    ChartData('May', 40, 20, 60, 50),
    ChartData('Jun', 18, 28, 50, 30),
    ChartData('Jul', 20, 10, 10, 50),
    ChartData('Aug', 30, 20, 40, 20)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
        title: ChartTitle(
            text: 'Monthly Progress',
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          StackedColumnSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData ch, _) => ch.x,
              yValueMapper: (ChartData ch, _) => ch.y1,),
          StackedColumnSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData ch, _) => ch.x,
              yValueMapper: (ChartData ch, _) => ch.y2),
          StackedColumnSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData ch, _) => ch.x,
              yValueMapper: (ChartData ch, _) => ch.y3)
        ],
      ),
    );
  }
}

class ChartData {
  final String x;
  final int y1;
  final int y2;
  final int y3;
  final int y4;

  ChartData(this.x, this.y1, this.y2, this.y3, this.y4);
}
