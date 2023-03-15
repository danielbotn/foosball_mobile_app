// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/LeagueApi.dart';
import 'package:foosball_mobile_app/models/leagues/create-league-body.dart';
import 'package:foosball_mobile_app/models/leagues/create-league-response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/widgets/inputs/InputWidget.dart';

typedef MyFormCallback = void Function(bool result);

class CreateLeagueDialog extends StatefulWidget {
  final UserState userState;
  final MyFormCallback onSubmit;
  final MyFormCallback onCancel;
  const CreateLeagueDialog(
      {Key? key,
      required this.onSubmit,
      required this.userState,
      required this.onCancel})
      : super(key: key);

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

  Future<CreateLeagueResponse?> createNewLeague() async {
    LeagueApi api = LeagueApi(token: widget.userState.token);

    // Create payload
    CreateLeagueBody payload = CreateLeagueBody(
        name: leagueName,
        typeOfLeague: option.index,
        upTo: 10,
        organisationId: widget.userState.currentOrganisationId,
        howManyRounds: 2);

    CreateLeagueResponse? response = await api.createLeague(payload);

    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.userState.hardcodedStrings.createLeague),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            InputWidget(
              userState: widget.userState,
              onChangeInput: setLeagueName,
              clearInputText: false,
              hintText: widget.userState.hardcodedStrings.leagueName,
            ),
            Column(
              children: [
                ListTile(
                  title: const Text('Single league'),
                  leading: Radio<SingleOrDouble?>(
                    value: SingleOrDouble.single,
                    groupValue: option,
                    onChanged: (value) {
                      setState(() {
                        option = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Double league'),
                  leading: Radio<SingleOrDouble>(
                    value: SingleOrDouble.double,
                    groupValue: option,
                    onChanged: (value) {
                      setState(() {
                        option = value!;
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(widget.userState.hardcodedStrings.cancel),
          onPressed: () {
            widget.onCancel(true);
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(widget.userState.hardcodedStrings.create),
          onPressed: () async {
            var newLeague = await createNewLeague();

            if (newLeague != null) {
              widget.onSubmit(true);
            } else {
              widget.onSubmit(false);
            }

            if (mounted) {
              Navigator.of(context).pop();
            }
            // deleteMatch();
          },
        ),
      ],
    );
  }
}
