import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/Dato_CMS.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/cms/hardcoded_strings.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/widgets/dashboard/dahsboard_user_info.dart/dashboard_user_info.dart';
import 'package:foosball_mobile_app/widgets/dashboard/dashboard_charts/dashboard_charts.dart';
import 'package:foosball_mobile_app/widgets/dashboard/dashboard_last_five.dart';
import 'package:foosball_mobile_app/widgets/dashboard/dashboard_quick_actions.dart';
import 'package:foosball_mobile_app/widgets/drawer_sidebar.dart';
import 'package:foosball_mobile_app/widgets/headline.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';

class NewDashboard extends StatefulWidget {
  final UserState userState;
  const NewDashboard({Key? key, required this.userState}) : super(key: key);

  @override
  State<NewDashboard> createState() => _NewDashboardState();
}

class _NewDashboardState extends State<NewDashboard> {
  // state
  late Future<HardcodedStrings?> hardcodedStringsFuture;

  Future<HardcodedStrings?> getHardcodedStrings() async {
    DatoCMS datoCMS = DatoCMS();
    var hardcodedStrings =
        await datoCMS.getHardcodedStrings(widget.userState.language);

    if (hardcodedStrings != null) {
      widget.userState.setHardcodedStrings(hardcodedStrings);
    }

    return hardcodedStrings;
  }

  @override
  void initState() {
    super.initState();
    hardcodedStringsFuture = getHardcodedStrings();
  }

  void updateAllState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.userState.darkmode;
    return Scaffold(
      appBar: AppBar(
          iconTheme: darkMode
              ? const IconThemeData(color: AppColors.white)
              : IconThemeData(color: Colors.grey[700]),
          backgroundColor:
              darkMode ? AppColors.darkModeBackground : AppColors.white),
      drawer: DrawerSideBar(
        userState: widget.userState,
        notifyParent: updateAllState,
      ),
      onDrawerChanged: (isOpen) {
        // setState(() {
        //   userStateState = widget.param;
        // });
      },
      body: FutureBuilder(
        future: hardcodedStringsFuture,
        builder: (context, AsyncSnapshot<HardcodedStrings?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the future to complete
            return Loading(
              userState: widget.userState,
            );
          } else if (snapshot.hasError) {
            // Show an error message if the future completes with an error
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // Show the widget tree if the future completes successfully
            return Theme(
                data: darkMode ? ThemeData.dark() : ThemeData.light(),
                child: Container(
                    height: double.infinity,
                    color: darkMode
                        ? AppColors.darkModeBackground
                        : AppColors.white,
                    child: SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        DashBoardUserInfo(userState: widget.userState),
                        DashboardCharts(userState: widget.userState),
                        Headline(
                            headline:
                                widget.userState.hardcodedStrings.quickActions,
                            userState: userState),
                        QuicActions(
                          userState: userState,
                          notifyParent: updateAllState,
                        ),
                        Headline(
                            headline: widget
                                .userState.hardcodedStrings.lastTenMatches,
                            userState: userState),
                        SizedBox(
                            height: 200,
                            child: DashBoardLastFive(
                              userState: widget.userState,
                            )),
                      ],
                    ))));
          } else {
            // Show a fallback widget if the future is null
            return const SizedBox();
          }
        },
      ),
    );
  }
}
