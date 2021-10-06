import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:foosball_mobile_app/models/charts/goals_chart.dart';
import 'package:foosball_mobile_app/models/charts/user_stats_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';

class DashboardGoalsChart extends StatefulWidget {
  final UserState userState;
  final UserStatsResponse? userStatsResponse;
  DashboardGoalsChart(
      {Key? key, required this.userState, required this.userStatsResponse})
      : super(key: key);

  @override
  _DashboardGoalsChartState createState() => _DashboardGoalsChartState();
}

class _DashboardGoalsChartState extends State<DashboardGoalsChart> {
  //state
  List<GoalsChart> data = [];

  _setChartData() {
    data = [
      GoalsChart(
        name: "Scored",
        goals: this.widget.userStatsResponse!.totalGoalsScored,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      GoalsChart(
        name: "Recieved",
        goals: this.widget.userStatsResponse!.totalGoalsReceived,
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      )
    ];
  }

  @override
  void initState() {
    super.initState();
    _setChartData();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<GoalsChart, String>> series = [
      charts.Series(
          id: "developers",
          data: data,
          domainFn: (GoalsChart series, _) => series.name,
          measureFn: (GoalsChart series, _) => series.goals,
          colorFn: (GoalsChart series, _) => series.barColor)
    ];

    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text(
                "Goals",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
