import 'package:charts_flutter/flutter.dart' as charts;

class GoalsChart {
  final String name;
  final int goals;
  final charts.Color barColor;

  GoalsChart(
    {
      required this.name,
      required this.goals,
      required this.barColor
    }
  );
}