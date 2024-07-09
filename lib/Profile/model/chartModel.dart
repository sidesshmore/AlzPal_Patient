class AccuracyChartModel {
  AccuracyChartModel(this.index, this.accuracy);
  final int index;
  final double accuracy;
}

class AverageResponseChartModel {
  AverageResponseChartModel(this.x, this.y, this.y1);
  final int x;
  final double? y;
  final double? y1;
}

class SessionchartModel{
  SessionchartModel(this.x, this.y);
  final int x;
  final double? y;
}