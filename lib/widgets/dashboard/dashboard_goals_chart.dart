import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:dano_foosball/models/charts/goals_chart.dart';
import 'package:dano_foosball/models/charts/user_stats_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';

class DashboardGoalsChart extends StatefulWidget {
  final UserState userState;
  final UserStatsResponse? userStatsResponse;
  const DashboardGoalsChart(
      {Key? key, required this.userState, required this.userStatsResponse})
      : super(key: key);

  @override
  State<DashboardGoalsChart> createState() => _DashboardGoalsChartState();
}

class _DashboardGoalsChartState extends State<DashboardGoalsChart> {
  //state
  late List<GoalsChart> data = [];

  _setChartData() {
    setState(() {
      data = [
        GoalsChart(
          name: widget.userState.hardcodedStrings.scored,
          goals: widget.userStatsResponse!.totalGoalsScored,
          barColor: charts.ColorUtil.fromDartColor(
              const Color.fromRGBO(127, 211, 29, .9)),
        ),
        GoalsChart(
          name: widget.userState.hardcodedStrings.recieved,
          goals: widget.userStatsResponse!.totalGoalsReceived,
          barColor: charts.ColorUtil.fromDartColor(
              const Color.fromRGBO(112, 193, 255, .9)),
        )
      ];
    });
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

    return Visibility(
        visible: data.isNotEmpty && widget.userStatsResponse!.userId != 0,
        child: Container(
          padding: const EdgeInsets.all(0),
          child: Card(
            color: widget.userState.darkmode
                ? AppColors.darkModeBackground
                : AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.userState.hardcodedStrings.goals,
                    style:
                        Theme.of(context).textTheme.bodyLarge, // Updated line
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
        ));
  }
}
