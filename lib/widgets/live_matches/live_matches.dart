import 'package:flutter/material.dart';
import 'package:dano_foosball/api/LiveMatchesApi.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/loading.dart';
import 'package:dano_foosball/models/live-matches/match.dart';
import 'package:intl/intl.dart'; // For date formatting

class LiveMatches extends StatefulWidget {
  final UserState userState;

  const LiveMatches({Key? key, required this.userState}) : super(key: key);

  @override
  State<LiveMatches> createState() => _LiveMatchesState();
}

class _LiveMatchesState extends State<LiveMatches> {
  late Future<List<Match>?> matchesFuture;

  @override
  void initState() {
    super.initState();
    matchesFuture = getLiveMatches();
  }

  Future<List<Match>?> getLiveMatches() async {
    LiveMatchesApi api = LiveMatchesApi();
    return await api.getLiveMatches();
  }

  Widget _buildMatchTile(Match match) {
    final isDarkMode = widget.userState.darkmode;

    // Determine the correct icon based on match type
    Icon matchIcon;
    if (match.typeOfMatch == ETypeOfMatch.freehandMatch) {
      matchIcon = Icon(Icons.person,
          color: isDarkMode ? AppColors.white : AppColors.textBlack);
    } else if (match.typeOfMatch == ETypeOfMatch.doubleFreehandMatch) {
      matchIcon = Icon(Icons.people,
          color: isDarkMode ? AppColors.white : AppColors.textBlack);
    } else if (match.typeOfMatch == ETypeOfMatch.singleLeagueMatch) {
      matchIcon = Icon(Icons.group,
          color: isDarkMode ? AppColors.white : AppColors.textBlack);
    } else {
      matchIcon = Icon(Icons.group_add,
          color: isDarkMode ? AppColors.white : AppColors.textBlack);
    }

    String formattedDate =
        DateFormat('dd-MM-yyyy | kk:mm').format(match.dateOfGame);

    // Building the participant names based on the match type
    String participants;
    if (match.typeOfMatch == ETypeOfMatch.doubleFreehandMatch ||
        match.typeOfMatch == ETypeOfMatch.doubleLeagueMatch) {
      participants =
          "${match.userFirstName} ${match.userLastName} & ${match.teamMateFirstName ?? 'TBA'} ${match.teamMateLastName ?? 'TBA'} vs ${match.opponentOneFirstName} ${match.opponentOneLastName} & ${match.opponentTwoFirstName ?? 'TBA'} ${match.opponentTwoLastName ?? 'TBA'}";
    } else {
      participants =
          "${match.userFirstName} ${match.userLastName} vs ${match.opponentOneFirstName} ${match.opponentOneLastName}";
    }

    // Determine player tiles based on match type and number of players
    List<Widget> leadingWidgets = [];
    List<Widget> trailingWidgets = [];

    if (match.typeOfMatch != ETypeOfMatch.doubleFreehandMatch &&
        match.typeOfMatch != ETypeOfMatch.doubleLeagueMatch) {
      leadingWidgets.add(
        CircleAvatar(
          backgroundImage: NetworkImage(match.userPhotoUrl),
          backgroundColor:
              isDarkMode ? AppColors.darkModeBackground : AppColors.white,
        ),
      );

      trailingWidgets.add(
        CircleAvatar(
          backgroundImage: NetworkImage(match.opponentOnePhotoUrl),
          backgroundColor:
              isDarkMode ? AppColors.darkModeBackground : AppColors.white,
        ),
      );

      if (match.typeOfMatch == ETypeOfMatch.doubleFreehandMatch ||
          match.typeOfMatch == ETypeOfMatch.doubleLeagueMatch) {
        leadingWidgets.add(
          CircleAvatar(
            backgroundImage:
                NetworkImage(match.teamMatePhotoUrl ?? 'default_image_url'),
            backgroundColor:
                isDarkMode ? AppColors.darkModeBackground : AppColors.white,
          ),
        );

        trailingWidgets.add(
          CircleAvatar(
            backgroundImage:
                NetworkImage(match.opponentTwoPhotoUrl ?? 'default_image_url'),
            backgroundColor:
                isDarkMode ? AppColors.darkModeBackground : AppColors.white,
          ),
        );
      }
    }

    // When there are 4 players, no images are displayed
    if (match.typeOfMatch == ETypeOfMatch.doubleFreehandMatch ||
        match.typeOfMatch == ETypeOfMatch.doubleLeagueMatch) {
      leadingWidgets.clear();
      trailingWidgets.clear();
    }

    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: leadingWidgets,
      ),
      title: Text(
        participants,
        style: TextStyle(
          color: isDarkMode ? AppColors.white : AppColors.textBlack,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${match.userScore} - ${match.opponentUserOrTeamScore}",
            style: TextStyle(
              color: isDarkMode ? AppColors.white : AppColors.textBlack,
            ),
          ),
          Text(
            formattedDate,
            style: TextStyle(
              color: isDarkMode ? AppColors.white : AppColors.grey2,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: trailingWidgets,
      ),
      tileColor: isDarkMode ? AppColors.darkModeBackground : AppColors.white,
      onTap: () {
        // Implement navigation or actions for the match tile tap
        print('Match tapped: ${match.matchId}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = widget.userState.darkmode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Live Matches',
          style: TextStyle(
            color: isDarkMode ? AppColors.white : AppColors.textBlack,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.chevron_left,
              color: isDarkMode ? AppColors.white : Colors.grey[700]),
          onPressed: () {
            Navigator.pop(context, widget.userState);
          },
        ),
        backgroundColor:
            isDarkMode ? AppColors.darkModeBackground : AppColors.white,
        iconTheme: IconThemeData(
            color: isDarkMode ? AppColors.white : Colors.grey[700]),
      ),
      body: FutureBuilder<List<Match>?>(
        future: matchesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Loading(userState: widget.userState),
            );
          } else if (snapshot.hasData) {
            var matches = snapshot.data;

            if (matches == null || matches.isEmpty) {
              return Center(
                  child: Text('No live matches available',
                      style: TextStyle(
                          color: isDarkMode
                              ? AppColors.white
                              : AppColors.textBlack)));
            }

            return ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                return _buildMatchTile(match);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: TextStyle(
                        color: isDarkMode
                            ? AppColors.white
                            : AppColors.textBlack)));
          } else {
            return Center(
                child: Text('No live matches available',
                    style: TextStyle(
                        color: isDarkMode
                            ? AppColors.white
                            : AppColors.textBlack)));
          }
        },
      ),
    );
  }
}
