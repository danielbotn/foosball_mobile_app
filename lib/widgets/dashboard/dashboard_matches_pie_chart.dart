import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:foosball_mobile_app/models/charts/user_stats_response.dart';
import 'package:foosball_mobile_app/models/charts/matches_chart.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

class DashboardMatchesPieChart extends StatefulWidget {
  final UserState userState;
  final UserStatsResponse? userStatsResponse;
  DashboardMatchesPieChart(
      {Key? key, required this.userState, required this.userStatsResponse})
      : super(key: key);

  @override
  _DashboardMatchesPieChartState createState() => _DashboardMatchesPieChartState();
}

class _DashboardMatchesPieChartState extends State<DashboardMatchesPieChart> {
  //state
  List<MatchesChart> data = [];
  Color dude = Colors.pink[50] as Color;
  _setChartData() {
    data = [
      MatchesChart(
        name: "Won",
        matches: this.widget.userStatsResponse!.totalMatchesWon,
        barColor: charts.ColorUtil.fromDartColor(Colors.green[400] as Color),
         
      ),
      MatchesChart(
        name: "Lost",
        matches: this.widget.userStatsResponse!.totalMatchesLost,
        barColor: charts.ColorUtil.fromDartColor(Colors.pink),
       
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
    List<charts.Series<MatchesChart, String>> series = [
      charts.Series(
          id: "developers",
          data: data,
          domainFn: (MatchesChart series, _) => series.name,
          measureFn: (MatchesChart series, _) => series.matches,
          colorFn: (MatchesChart series, _) => series.barColor,
      ),
          
    ];

    return Container(
      padding: EdgeInsets.all(0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: <Widget>[
              Text(
                "Matches",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Expanded(
                child: charts.PieChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
