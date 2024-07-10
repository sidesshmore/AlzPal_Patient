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
            '${seriesIndex == 0 ? data.y.toString().split('.').first : data.y1.toString().split('.').first}',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final List<AverageResponseChartModel> chartData = widget.chartData;

    return Container(
      height: screenHeight * 0.31,
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
              height: screenHeight * 0.20,
              child: SfCartesianChart(
                  legend: Legend(
                    isVisible: true,
                    legendItemBuilder: (String name, dynamic series,
                        dynamic point, int index) {
                      Color color;
                      String text;
                      if (name == 'y') {
                        color = Colors.blue;
                        text = 'Correct Response';
                      } else {
                        color = Colors.purple;
                        text = 'Wrong Response';
                      }
                      return Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            color: series.color,
                          ),
                          SizedBox(width: 5),
                          Text(
                            text,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      );
                    },
                  ),
                  tooltipBehavior: _tooltipBehavior,
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(
                    labelStyle: TextStyle(color: Colors.transparent),
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  series: <CartesianSeries>[
                    ColumnSeries<AverageResponseChartModel, String>(
                      color: Colors.blue,
                        name: 'y',
                        enableTooltip: true,
                        dataSource: chartData,
                        xValueMapper: (AverageResponseChartModel data, _) =>
                            data.x.toString(),
                        yValueMapper: (AverageResponseChartModel data, _) =>
                            data.y),
                    ColumnSeries<AverageResponseChartModel, String>(
                      color:Colors.purple,
                        name: 'y1',
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
