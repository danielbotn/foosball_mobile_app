import 'package:dano_foosball/api/LeagueApi.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/league/add_double_league_teams/add_double_league_teams.dart';
import 'package:dano_foosball/widgets/league/add_league_players/add_league_players.dart';
import 'package:dano_foosball/widgets/league/double_league_overview/double_league_overview.dart';
import 'package:dano_foosball/widgets/league/single_league_overview/single_league_overview.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/models/leagues/get-league-response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/inputs/InputWidget.dart';

class LeagueList extends StatelessWidget {
  final UserState userState;
  final String randomNumber;
  final List<GetLeagueResponse?>? data;
  final Function(GetLeagueResponse) onLeagueDeleted; // Add the callback

  const LeagueList(
      {super.key,
      required this.userState,
      this.data,
      required this.randomNumber,
      required this.onLeagueDeleted});

  void handleLeagueTap(BuildContext context, GetLeagueResponse leagueData) {
    // Implement the logic for what should happen when a league is tapped
    if (leagueData.hasLeagueStarted == false && leagueData.typeOfLeague == 0) {
      // go to add players screen
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddLeaguePlayers(
                    userState: userState,
                    leagueData: leagueData,
                  )));
    } else if (leagueData.hasLeagueStarted == true &&
        leagueData.typeOfLeague == 0) {
      //
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SingleLeagueOverview(
                    userState: userState,
                    leagueData: leagueData,
                  )));
    } else if (leagueData.hasLeagueStarted == false &&
        leagueData.typeOfLeague == 1) {
      // danni
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddDoubleLeagueTeams(
                    userState: userState,
                    leagueData: leagueData,
                  )));
    } else if (leagueData.hasLeagueStarted == true &&
        leagueData.typeOfLeague == 1) {
      // go to double league overview page
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DoubleLeagueOverview(
                    userState: userState,
                    leagueData: leagueData,
                  )));
    }
  }

  void _showEditLeagueDrawer(
      BuildContext context, GetLeagueResponse leagueData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        String updatedName = leagueData.name;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputWidget(
                userState: userState,
                onChangeInput: (name) => updatedName = name,
                clearInputText: false,
                hintText: userState.hardcodedStrings.leagueName,
                key: const Key('leagueNameInput'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await updateLeagueName(context, leagueData, updatedName);
                  // Navigator.of(context).pop(); // Close the drawer
                },
                child: Text(userState.hardcodedStrings.save),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> deleteLeague(
      BuildContext context, GetLeagueResponse leagueData) async {
    Helpers helper = Helpers();
    LeagueApi api = LeagueApi();

    try {
      var response = await api.deleteLeagueById(leagueData.id);
      if (response == true) {
        onLeagueDeleted(leagueData);
      } else {
        if (context.mounted) {
          helper.showSnackbar(
              context, userState.hardcodedStrings.unknownError, true);
        }
      }
    } catch (e) {
      // Handle any exceptions that might occur during the deletion process
      if (context.mounted) {
        helper.showSnackbar(
            context, userState.hardcodedStrings.unknownError, true);
      }
    }
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> updateLeagueName(BuildContext context,
      GetLeagueResponse leagueData, String newName) async {
    Helpers helper = Helpers();
    LeagueApi api = LeagueApi();

    try {
      // Call the API to update the league name
      var response = await api.updateLeagueName(leagueData.id, newName);
      if (response == true) {
        // Update successful
        onLeagueDeleted(leagueData);
      } else {
        // Update failed
        if (context.mounted) {
          helper.showSnackbar(
              context, userState.hardcodedStrings.unknownError, true);
        }
      }
    } catch (e) {
      // Handle any exceptions during the update process
      if (context.mounted) {
        helper.showSnackbar(
            context, userState.hardcodedStrings.unknownError, true);
      }
    }

    if (context.mounted) {
      Navigator.of(context).pop(); // Close the modal or drawer
    }
  }

  void _showDeleteConfirmDrawer(
      BuildContext context, GetLeagueResponse leagueData) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                userState.hardcodedStrings.delete,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(userState.hardcodedStrings.deleteLeagueAreYouSure),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(), // Close drawer
                    child: Text(userState.hardcodedStrings.cancel),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await deleteLeague(context, leagueData);
                    },
                    child: Text(userState.hardcodedStrings.delete),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      return const SizedBox();
    }

    // Filter the data list
    final filteredData = data!.where((league) {
      if (league == null) return false;
      return !(league.hasLeagueStarted == true && league.hasAccess == false);
    }).toList();

    if (filteredData.isEmpty) {
      return const SizedBox();
    }

    return SafeArea(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          final league = filteredData[index];
          if (league == null) {
            return const SizedBox();
          }

          return Dismissible(
            key: ValueKey('league_${league.id}'),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.blue,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(Icons.edit, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                _showDeleteConfirmDrawer(context, league);
                return false; // Do not dismiss on delete
              } else if (direction == DismissDirection.endToStart) {
                _showEditLeagueDrawer(context, league);
                return false; // Do not dismiss on edit
              }
              return false;
            },
            child: ListTile(
              onTap: () => handleLeagueTap(context, league),
              leading: Icon(
                league.typeOfLeague == 0 ? Icons.person : Icons.people,
                color: userState.darkmode ? AppColors.white : null,
              ),
              title: ExtendedText(
                text: league.name,
                userState: userState,
              ),
              subtitle: Text(league.hasLeagueStarted
                  ? (league.hasLeagueEnded!
                      ? userState.hardcodedStrings.finished
                      : userState.hardcodedStrings.ongoing)
                  : userState.hardcodedStrings.notStarted),
            ),
          );
        },
      ),
    );
  }
}
