import 'package:charts_flutter/flutter.dart' as charts;

class MatchesChart {
  final String name;
  final int matches;
  final charts.Color barColor;

  MatchesChart(
    {
      required this.name,
      required this.matches,
      required this.barColor
    }
  );
}