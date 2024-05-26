import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/charts/user_stats_response.dart';
import 'package:foosball_mobile_app/models/charts/matches_chart.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

class DashboardMatchesChart extends StatefulWidget {
  final UserState userState;
  final UserStatsResponse? userStatsResponse;
  const DashboardMatchesChart(
      {Key? key, required this.userState, required this.userStatsResponse})
      : super(key: key);

  @override
  State<DashboardMatchesChart> createState() => _DashboardMatchesChartState();
}

class _DashboardMatchesChartState extends State<DashboardMatchesChart> {
  // state variables
  late List<MatchesChart> data = [];
  Color dude = Colors.pink[50] as Color;

  // sets the data for the chart
  _setChartData() {
    var d = [
      MatchesChart(
        name: widget.userState.hardcodedStrings.matches,
        matches: widget.userStatsResponse!.totalMatches,
        barColor: charts.ColorUtil.fromDartColor(
            const Color.fromRGBO(255, 136, 0, .9)),
      ),
      MatchesChart(
        name: widget.userState.hardcodedStrings.won,
        matches: widget.userStatsResponse!.totalMatchesWon,
        barColor: charts.ColorUtil.fromDartColor(
            const Color.fromRGBO(127, 211, 29, .9)),
      ),
      MatchesChart(
        name: widget.userState.hardcodedStrings.lost,
        matches: widget.userStatsResponse!.totalMatchesLost,
        barColor: charts.ColorUtil.fromDartColor(
            const Color.fromRGBO(112, 193, 255, .9)),
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
    _setChartData();

    List<charts.Series<MatchesChart, String>> series = [
      charts.Series(
        id: "developers",
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
            color: widget.userState.darkmode
                ? AppColors.darkModeBackground
                : AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.userState.hardcodedStrings.matches,
                    style: Theme.of(context).textTheme.bodyText1,
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
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
