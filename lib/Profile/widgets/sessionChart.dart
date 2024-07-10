import 'package:alzpal_patient/Profile/model/chartModel.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Sessionchart extends StatefulWidget {
  const Sessionchart({super.key, required this.chartData});

  final List<SessionchartModel> chartData;

  @override
  State<Sessionchart> createState() => _SessionchartState();
}

class _SessionchartState extends State<Sessionchart> {
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
            '${data.y.toString().split('.').first}',
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
    final List<SessionchartModel> chartData = widget.chartData;
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
                  'Session Time (in seconds)',
                  style: TextStyle(
                      color: GreenColor, fontSize: screenWidth * 0.042),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.20,
            child: SfCartesianChart(
              tooltipBehavior: _tooltipBehavior,
              legend: Legend(
                isVisible: true,
                legendItemBuilder:
                    (String name, dynamic series, dynamic point, int index) {
                  return Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Session Time',
                        style: TextStyle(
                            color: Colors.white, fontSize: screenWidth * 0.042),
                      ),
                    ],
                  );
                },
              ),
              series: <CartesianSeries>[
                // Renders column chart

                ColumnSeries<SessionchartModel, String>(
                    enableTooltip: true,
                    name: 'x',
                    dataSource: chartData,
                    xValueMapper: (SessionchartModel data, _) =>
                        data.x.toString(),
                    yValueMapper: (SessionchartModel data, _) => data.y)
              ],
              plotAreaBorderWidth: 0,
              primaryXAxis: const CategoryAxis(
                labelStyle: TextStyle(color: Colors.transparent),
                majorGridLines: MajorGridLines(width: 0),
              ),
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
