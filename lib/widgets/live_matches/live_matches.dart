import 'package:dano_foosball/utils/preferences_service.dart';
import 'package:dano_foosball/widgets/live_matches/live_double_freehand_match.dart';
import 'package:dano_foosball/widgets/live_matches/live_freehand_match.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/api/LiveMatchesApi.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/loading.dart';
import 'package:dano_foosball/models/live-matches/match.dart';
import 'package:intl/intl.dart';
import 'package:signalr_netcore/signalr_client.dart' as signalr;

class LiveMatches extends StatefulWidget {
  final UserState userState;

  const LiveMatches({super.key, required this.userState});

  @override
  State<LiveMatches> createState() => _LiveMatchesState();
}

class _LiveMatchesState extends State<LiveMatches> {
  late Future<List<Match>?> matchesFuture;
  late signalr.HubConnection _hubConnection;
  List<Match>? _matches; // Store matches in local state

  @override
  void initState() {
    super.initState();
    matchesFuture = getLiveMatches().then((matches) {
      setState(() {
        _matches = matches;
      });
      return matches;
    });
    _initializeSignalR();
  }

  @override
  void dispose() {
    _hubConnection.stop();
    super.dispose();
  }

  Future<List<Match>?> getLiveMatches() async {
    LiveMatchesApi api = LiveMatchesApi();
    return await api.getLiveMatches();
  }

  Future<String?> _getJwtToken() async {
    PreferencesService preferencesService = PreferencesService();
    return await preferencesService.getJwtToken();
  }

  Future<dynamic> getAccessToken() async {
    String result = '';
    PreferencesService preferencesService = PreferencesService();
    String? jwtToken = await preferencesService.getJwtToken();
    if (jwtToken != null) {
      result = jwtToken;
    }
    return result;
  }

  void _initializeSignalR() async {
    _hubConnection = signalr.HubConnectionBuilder()
        .withUrl('https://localhost:7145/messageHub',
            options: signalr.HttpConnectionOptions(
                accessTokenFactory: () async => await getAccessToken()))
        .build();

    _hubConnection.on("SendLiveMatches", (List<Object?>? message) {
      if (message != null && message.isNotEmpty) {
        _handleScoreUpdate(message.cast<Object>());
      }
    });

    // not critical skip
    //_hubConnection.onclose((Exception? error) {
    //print("Connection closed: ${error?.toString()}");
    // } as signalr.ClosedCallback);

    try {
      await _hubConnection.start();
      print("SignalR Connection started");

      String organisationId = widget.userState.currentOrganisationId.toString();
      await _hubConnection.invoke("JoinGroup", args: [organisationId]);
    } catch (e) {
      print("Error starting SignalR connection: $e");
    }
  }

  void _handleScoreUpdate(List<Object>? message) {
    if (message != null && message.isNotEmpty) {
      final matchData = message[0] as Map<String, dynamic>;
      final updatedMatch = Match.fromJson(matchData);

      setState(() {
        if (_matches != null) {
          _matches = _matches!.map((match) {
            if (match.matchId == updatedMatch.matchId) {
              return updatedMatch;
            }
            return match;
          }).toList();
        }
      });
    }
  }

  goToLiveFreehandMatch(BuildContext context, int matchId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiveFreehandMatch(
          userState: widget.userState,
          hubConnection: _hubConnection,
          matchId: matchId,
        ),
      ),
    );
  }

  goToLiveDoubleFreehandMatch(BuildContext context, int matchId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiveDoubleFreehandMatch(
          userState: widget.userState,
          hubConnection: _hubConnection,
          matchId: matchId,
        ),
      ),
    );
  }

  Widget _buildMatchTile(Match match) {
    final isDarkMode = widget.userState.darkmode;

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

    String participants;
    if (match.typeOfMatch == ETypeOfMatch.doubleFreehandMatch ||
        match.typeOfMatch == ETypeOfMatch.doubleLeagueMatch) {
      participants =
          "${match.userFirstName} ${match.userLastName} & ${match.teamMateFirstName ?? 'TBA'} ${match.teamMateLastName ?? 'TBA'} vs ${match.opponentOneFirstName} ${match.opponentOneLastName} & ${match.opponentTwoFirstName ?? 'TBA'} ${match.opponentTwoLastName ?? 'TBA'}";
    } else {
      participants =
          "${match.userFirstName} ${match.userLastName} vs ${match.opponentOneFirstName} ${match.opponentOneLastName}";
    }

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
              color: isDarkMode ? AppColors.white : AppColors.textBlack,
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
        if (match.typeOfMatch == ETypeOfMatch.freehandMatch) {
          goToLiveFreehandMatch(context, match.matchId);
        }
        if (match.typeOfMatch == ETypeOfMatch.doubleFreehandMatch) {
          goToLiveDoubleFreehandMatch(context, match.matchId);
        }
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
      body: Container(
        color: isDarkMode
            ? AppColors.darkModeBackground
            : AppColors.white, // Set background color here
        child: _matches == null
            ? Center(
                child: Loading(userState: widget.userState),
              )
            : (_matches!.isEmpty
                ? Center(
                    child: Text('No live matches available',
                        style: TextStyle(
                            color: isDarkMode
                                ? AppColors.white
                                : AppColors.textBlack)))
                : ListView.builder(
                    itemCount: _matches!.length,
                    itemBuilder: (context, index) {
                      final match = _matches![index];
                      return _buildMatchTile(match);
                    },
                  )),
      ),
    );
  }
}
