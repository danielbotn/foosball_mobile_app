import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:foosball_mobile_app/models/charts/goals_chart.dart';
import 'package:foosball_mobile_app/models/charts/user_stats_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

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
        name: this.widget.userState.hardcodedStrings.scored,
        goals: this.widget.userStatsResponse!.totalGoalsScored,
        barColor:
            charts.ColorUtil.fromDartColor(Color.fromRGBO(127, 211, 29, .9)),
      ),
      GoalsChart(
        name: this.widget.userState.hardcodedStrings.recieved,
        goals: this.widget.userStatsResponse!.totalGoalsReceived,
        barColor:
            charts.ColorUtil.fromDartColor(Color.fromRGBO(112, 193, 255, .9)),
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
    
    _setChartData();

    List<charts.Series<GoalsChart, String>> series = [
      charts.Series(
          id: "developers",
          data: data,
          domainFn: (GoalsChart series, _) => series.name,
          measureFn: (GoalsChart series, _) => series.goals,
          colorFn: (GoalsChart series, _) => series.barColor)
    ];

    return Container(
      padding: EdgeInsets.all(0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: <Widget>[
              Text(
                this.widget.userState.hardcodedStrings.goals,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Expanded(
                child: charts.BarChart(series,
                    animate: true,
                    domainAxis: charts.OrdinalAxisSpec(
                      renderSpec: charts.SmallTickRendererSpec(
                        labelStyle: charts.TextStyleSpec(
                          fontSize: 12,
                          color: charts.ColorUtil.fromDartColor(
                            widget.userState.darkmode
                                ? AppColors.white
                                : AppColors.textBlack,
                          ),
                        ),
                      ),
                    ),
                    primaryMeasureAxis: charts.NumericAxisSpec(
                      renderSpec: charts.GridlineRendererSpec(
                        labelStyle: charts.TextStyleSpec(
                          fontSize: 12,
                          color: charts.ColorUtil.fromDartColor(
                              widget.userState.darkmode
                                  ? AppColors.white
                                  : AppColors.textBlack),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
