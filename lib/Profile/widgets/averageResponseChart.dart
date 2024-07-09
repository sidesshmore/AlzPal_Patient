import 'package:alzpal_patient/Profile/model/chartModel.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AverageResponseChart extends StatefulWidget {
  const AverageResponseChart({super.key, required this.chartData});
  final List<AverageResponseChartModel> chartData;

  @override
  State<AverageResponseChart> createState() => _AverageResponseChartState();
}

class _AverageResponseChartState extends State<AverageResponseChart> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final List<AverageResponseChartModel> chartData = widget.chartData;

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
                  'Response Time',
                  style: TextStyle(color: GreenColor, fontSize: 19),
                ),
              ],
            ),
          ),
          Container(
              height: screenHeight * 0.15,
              child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(
                    labelStyle: TextStyle(color: Colors.transparent),
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  series: <CartesianSeries>[
                    ColumnSeries<AverageResponseChartModel, String>(
                        dataSource: chartData,
                        xValueMapper: (AverageResponseChartModel data, _) =>
                            data.x.toString(),
                        yValueMapper: (AverageResponseChartModel data, _) =>
                            data.y),
                    ColumnSeries<AverageResponseChartModel, String>(
                        dataSource: chartData,
                        xValueMapper: (AverageResponseChartModel data, _) =>
                            data.x.toString(),
                        yValueMapper: (AverageResponseChartModel data, _) =>
                            data.y1)
                  ]))
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1, this.y2);
  final String x;
  final double? y;
  final double? y1;
  final double? y2;
}
