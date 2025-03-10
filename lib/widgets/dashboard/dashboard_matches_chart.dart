import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:dano_foosball/models/charts/user_stats_response.dart';
import 'package:dano_foosball/models/charts/matches_chart.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';

class DashboardMatchesChart extends StatefulWidget {
  final UserState userState;
  final UserStatsResponse? userStatsResponse;
  const DashboardMatchesChart(
      {super.key, required this.userState, required this.userStatsResponse});

  @override
  State<DashboardMatchesChart> createState() => _DashboardMatchesChartState();
}

class _DashboardMatchesChartState extends State<DashboardMatchesChart> {
  // state variables
  late List<MatchesChart> data = [];

  // sets the data for the chart
  _setChartData() {
    var d = [
      MatchesChart(
        name: widget.userState.hardcodedStrings.won,
        matches: widget.userStatsResponse!.totalMatchesWon,
        barColor: charts.ColorUtil.fromDartColor(
            userState.darkmode ? AppColors.wonDarkMode : AppColors.primary),
      ),
      MatchesChart(
        name: widget.userState.hardcodedStrings.lost,
        matches: widget.userStatsResponse!.totalMatchesLost,
        barColor: charts.ColorUtil.fromDartColor(
            userState.darkmode ? AppColors.lostDarkMode : AppColors.losingRed),
      )
    ];

    setState(() {
      data = d;
    });
  }

  @override
  void initState() {
    super.initState();
    _setChartData();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure chart data is set
    _setChartData();

    List<charts.Series<MatchesChart, String>> series = [
      charts.Series(
        id: "matches",
        data: data,
        domainFn: (MatchesChart series, _) => series.name,
        measureFn: (MatchesChart series, _) => series.matches,
        colorFn: (MatchesChart series, _) => series.barColor,
      ),
    ];

    return Visibility(
        visible: data.isNotEmpty && widget.userStatsResponse!.userId != 0,
        child: Container(
          padding: const EdgeInsets.all(0),
          child: Card(
            elevation: 0,
            color: widget.userState.darkmode
                ? AppColors.darkModeBackground
                : AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: <Widget>[
                  ExtendedText(
                    text: widget.userState.hardcodedStrings.matches,
                    userState: userState,
                    isBold: true,
                    fontSize: 14,
                  ),
                  // change label style of BarChart to fit the theme
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
                                    : AppColors.surfaceDark,
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
                                    : AppColors.surfaceDark,
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
