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
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final List<SessionchartModel> chartData = widget.chartData;
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
                  'Session Time',
                  style: TextStyle(color: GreenColor, fontSize: 19),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.15,
            child: SfCartesianChart(
              series: <CartesianSeries>[
                // Renders column chart

                ColumnSeries<SessionchartModel, String>(
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
