import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/models/leagues/get-league-response.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/api/LeagueApi.dart';
import 'package:dano_foosball/models/leagues/create-league-body.dart';
import 'package:dano_foosball/models/leagues/create-league-response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/widgets/inputs/InputWidget.dart';
import 'package:tuple/tuple.dart';

typedef MyFormCallback = void Function(Tuple2<bool, GetLeagueResponse?> result);
typedef MyFormCallback2 = void Function(bool result);

class CreateLeagueDialog extends StatefulWidget {
  final UserState userState;
  final MyFormCallback onSubmit;
  final MyFormCallback2 onCancel;

  const CreateLeagueDialog({
    super.key,
    required this.onSubmit,
    required this.userState,
    required this.onCancel,
  });

  @override
  State<CreateLeagueDialog> createState() => _CreateLeagueDialogState();
}

enum SingleOrDouble { single, double }

class _CreateLeagueDialogState extends State<CreateLeagueDialog> {
  String leagueName = "";
  SingleOrDouble option = SingleOrDouble.single;

  void setLeagueName(String name) {
    setState(() {
      leagueName = name;
    });
  }

  Future createLeague(BuildContext context) async {
    var newLeague = await createNewLeague();
    if (!mounted) {
      return;
    }

    // Prepare the result tuple
    Tuple2<bool, GetLeagueResponse?> result;
    if (newLeague != null) {
      GetLeagueResponse leagueData = GetLeagueResponse(
        id: newLeague.id,
        name: newLeague.name,
        typeOfLeague: newLeague.typeOfLeague,
        createdAt: newLeague.createdAt,
        organisationId: newLeague.organisationId,
        upTo: newLeague.upTo,
        hasLeagueStarted: newLeague.hasLeagueStarted,
        howManyRounds: newLeague.howManyRounds,
      );
      result = Tuple2(true, leagueData);
    } else {
      result = const Tuple2(false, null);
    }
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    // Call the callback with the tuple result
    widget.onSubmit(result);
  }

  Future<CreateLeagueResponse?> createNewLeague() async {
    LeagueApi api = LeagueApi();

    // Create payload
    CreateLeagueBody payload = CreateLeagueBody(
      name: leagueName,
      typeOfLeague: option.index,
      upTo: 10,
      organisationId: widget.userState.currentOrganisationId,
      howManyRounds: 2,
    );

    CreateLeagueResponse? response = await api.createLeague(payload);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.userState.hardcodedStrings.createLeague,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          InputWidget(
            userState: widget.userState,
            onChangeInput: setLeagueName,
            clearInputText: false,
            hintText: widget.userState.hardcodedStrings.leagueName,
            key: const Key('leagueNameInput'),
          ),
          const SizedBox(height: 20),
          Center(
            // Center the toggle buttons
            child: ToggleButtons(
              isSelected: [
                option == SingleOrDouble.single,
                option == SingleOrDouble.double,
              ],
              onPressed: (int index) {
                setState(() {
                  option = SingleOrDouble.values[index];
                });
              },
              selectedColor: Colors.white,
              fillColor: widget.userState.darkmode
                  ? AppColors.darkModeButtonColor // Button color in dark mode
                  : AppColors.buttonsLightTheme, // Button color in light mode
              color: widget.userState.darkmode
                  ? AppColors.white
                  : AppColors.surfaceDark,
              borderColor: widget.userState.darkmode
                  ? AppColors.grey2 // Border color in dark mode
                  : AppColors.lightGrey, // Border color in light mode
              borderWidth: 0.5, // Decreased border width
              borderRadius: BorderRadius.circular(8.0),
              constraints: const BoxConstraints(
                minWidth: 80, // Minimum width for each button
                minHeight: 36, // Minimum height for each button
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    userState.hardcodedStrings.singleLeague,
                    style: TextStyle(
                      color: option == SingleOrDouble.single
                          ? Colors.white
                          : widget.userState.darkmode
                              ? AppColors.white
                              : AppColors.surfaceDark,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    userState.hardcodedStrings.doubleLeague,
                    style: TextStyle(
                      color: option == SingleOrDouble.double
                          ? Colors.white
                          : widget.userState.darkmode
                              ? AppColors.white
                              : AppColors.surfaceDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(widget.userState.hardcodedStrings.cancel),
                onPressed: () {
                  widget.onCancel(true);
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text(widget.userState.hardcodedStrings.create),
                onPressed: () async {
                  await createLeague(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
