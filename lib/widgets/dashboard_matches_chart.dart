import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:foosball_mobile_app/models/charts/user_stats_response.dart';
import 'package:foosball_mobile_app/models/charts/matches_chart.dart';
import 'package:foosball_mobile_app/state/user_state.dart';

class DashboardMatchesChart extends StatefulWidget {
  final UserState userState;
  final UserStatsResponse? userStatsResponse;
  DashboardMatchesChart(
      {Key? key, required this.userState, required this.userStatsResponse})
      : super(key: key);

  @override
  _DashboardMatchesChartState createState() => _DashboardMatchesChartState();
}

class _DashboardMatchesChartState extends State<DashboardMatchesChart> {
  //state
  List<MatchesChart> data = [];
  Color dude = Colors.pink[50] as Color;
  _setChartData() {
    data = [
      MatchesChart(
        name: "Matches",
        matches: this.widget.userStatsResponse!.totalMatches,
        barColor: charts.ColorUtil.fromDartColor(Color.fromRGBO(255,136,0, .9)),
      ),
      MatchesChart(
        name: "Won",
        matches: this.widget.userStatsResponse!.totalMatchesWon,
        barColor: charts.ColorUtil.fromDartColor(Color.fromRGBO(127,211,29, .9)),
      ),
      MatchesChart(
        name: "Lost",
        matches: this.widget.userStatsResponse!.totalMatchesLost,
        barColor: charts.ColorUtil.fromDartColor(Color.fromRGBO(112,193,255, .9)),
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
          colorFn: (MatchesChart series, _) => series.barColor)
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
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
