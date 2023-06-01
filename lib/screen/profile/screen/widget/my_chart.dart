import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyChart extends StatelessWidget {
  const MyChart({Key? key, required this.chartDatas}) : super(key: key);

  final List<ChartData> chartDatas;

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
              color: Theme.of(context).primaryColor,
              dataSource: chartDatas,
              xValueMapper: (ChartData ch, _) => ch.x,
              yValueMapper: (ChartData ch, _) => ch.y1),
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
