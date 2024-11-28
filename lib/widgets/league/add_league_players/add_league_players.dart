import 'package:flutter/material.dart';
import 'package:dano_foosball/api/UserApi.dart';
import 'package:dano_foosball/models/leagues/get-league-response.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/new_game_state.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/headline.dart';
import 'package:dano_foosball/widgets/league/add_league_players/players_list.dart';
import 'package:dano_foosball/widgets/league/add_league_players/selected_players.dart';
import 'package:dano_foosball/widgets/league/button/create_sl_button.dart';
import 'package:dano_foosball/widgets/loading.dart';

class AddLeaguePlayers extends StatefulWidget {
  final UserState userState;
  final GetLeagueResponse leagueData;
  const AddLeaguePlayers(
      {Key? key, required this.userState, required this.leagueData})
      : super(key: key);

  @override
  State<AddLeaguePlayers> createState() => _AddLeaguePlayersState();
}

class _AddLeaguePlayersState extends State<AddLeaguePlayers> {
  // state
  late Future<List<UserResponse>?> usersFuture;
  List<UserResponse>? users;
  late List<UserResponse> selectedPlayersList = [];
  final newGameState = NewGameState();

  @override
  void initState() {
    super.initState();
    usersFuture = getAllUsers();
  }

  Future<List<UserResponse>?> getAllUsers() async {
    UserApi userApi = UserApi();
    var allUsers = await userApi.getUsers();
    setState(() {
      users = allUsers;
    });
    initializePerson();
    return allUsers;
  }

  void playerChecked(UserResponse player, bool checkedOrNot) {
    if (checkedOrNot == true) {
      setState(() {
        selectedPlayersList.add(player);
      });
    } else {
      setState(() {
        selectedPlayersList.remove(player);
      });
    }
  }

  void initializePerson() {
    if (users != null) {
      for (var element in users!) {
        if (element.id == widget.userState.userId) {
          selectedPlayersList.add(element);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.userState.darkmode;
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: helpers.getIconTheme(widget.userState.darkmode),
          backgroundColor:
              helpers.getBackgroundColor(widget.userState.darkmode),
          title: ExtendedText(
            text: widget.userState.hardcodedStrings.addPlayers,
            userState: widget.userState,
            colorOverride: widget.userState.darkmode
                ? AppColors.white
                : AppColors.textBlack,
          ),
        ),
        body: Theme(
            data: darkMode ? ThemeData.dark() : ThemeData.light(),
            child: FutureBuilder(
                future: usersFuture,
                builder:
                    (context, AsyncSnapshot<List<UserResponse>?> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        color: helpers
                            .getBackgroundColor(widget.userState.darkmode),
                        child: Theme(
                            data: widget.userState.darkmode
                                ? ThemeData.dark()
                                : ThemeData.light(),
                            child: Column(children: <Widget>[
                              PlayersList(
                                userState: widget.userState,
                                players: snapshot.data as List<UserResponse>,
                                playerChecked: playerChecked,
                              ),
                              Visibility(
                                  visible: selectedPlayersList.isNotEmpty,
                                  child: Headline(
                                      headline: 'Selected players',
                                      userState: widget.userState)),
                              Visibility(
                                  visible: selectedPlayersList.isNotEmpty,
                                  child: SelectedPlayers(
                                      userState: widget.userState,
                                      players: selectedPlayersList)),
                              Visibility(
                                  visible: selectedPlayersList.isNotEmpty,
                                  child: CreateSingleLeagueButton(
                                    userState: widget.userState,
                                    selectedPlayersList: selectedPlayersList,
                                    leagueData: widget.leagueData,
                                  ))
                            ])));
                  } else {
                    return Center(child: Loading(userState: widget.userState));
                  }
                })));
  }
}
