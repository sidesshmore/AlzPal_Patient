import 'dart:developer';

import 'package:alzpal_patient/Profile/model/chartModel.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AccuracyChart extends StatefulWidget {
  const AccuracyChart({super.key, required this.chartData});

  final List<AccuracyChartModel> chartData;

  @override
  State<AccuracyChart> createState() => _AccuracyChartState();
}

class _AccuracyChartState extends State<AccuracyChart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      header: '',
      enable: true,
      borderWidth: 5,
      color: Colors.white,
      textStyle: TextStyle(color: GreenColor, fontWeight: FontWeight.bold),
       builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.75),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '${seriesIndex == 0 ? data.accuracy.toString().split('.').first : data.accuracy.toString().split('.').first }',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log(widget.chartData[0].index.toString());
    final List<AccuracyChartModel> chartDatas = widget.chartData;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.29,
      width: screenWidth * 0.91,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(33), color: DarkBlack),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Accuracy',
                  style: TextStyle(color: GreenColor, fontSize: 19),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.15,
            child: SfCartesianChart(
              tooltipBehavior: _tooltipBehavior,
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                //Hide the axis line of x-axis

                labelStyle: TextStyle(color: Colors.transparent),
              ),
              primaryYAxis: CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                //Hide the axis line of x-axis
              ),
              enableAxisAnimation: true,
              series: <CartesianSeries>[
                // Renders line chart
                LineSeries<AccuracyChartModel, int>(
                    dataSource: chartDatas,
                    xValueMapper: (AccuracyChartModel data, _) => data.index,
                    yValueMapper: (AccuracyChartModel data, _) => data.accuracy)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
