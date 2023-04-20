import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/Organisation.dart';
import 'package:foosball_mobile_app/main.dart';

import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';

class NewOrganisation extends StatefulWidget {
  final UserState userState;
  final Function() notifyOrganisationButtons;
  const NewOrganisation(
      {Key? key,
      required this.userState,
      required this.notifyOrganisationButtons})
      : super(key: key);

  @override
  State<NewOrganisation> createState() => _NewOrganisationState();
}

class _NewOrganisationState extends State<NewOrganisation> {
  final _textController = TextEditingController();

  // Dialog for success or error message when
  // user creates a new organisation
  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(userState.hardcodedStrings.newOrganisation),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(userState.hardcodedStrings.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: widget.userState.hardcodedStrings.newOrganisation,
                userState: widget.userState),
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: helpers.getIconTheme(widget.userState.darkmode),
            backgroundColor:
                helpers.getBackgroundColor(widget.userState.darkmode)),
        body: Container(
            color: widget.userState.darkmode
                ? AppColors.darkModeBackground
                : AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {
                              _textController.clear();
                            },
                            icon: const Icon(Icons.clear)),
                        hintText:
                            userState.hardcodedStrings.nameOfNewOrganisation),
                  ),
                  MaterialButton(
                      onPressed: () async {
                        String inputText = _textController.text;
                        if (inputText.isNotEmpty) {
                          Organisation api = Organisation();
                          var result =
                              await api.createNewOrganisation(inputText);

                          if (result.statusCode == 201) {
                            // success
                            _textController.clear();
                            await _showMyDialog(userState.hardcodedStrings
                                .newOrganisationSuccessMessage);
                            widget.notifyOrganisationButtons();
                          } else {
                            // error handling
                            await _showMyDialog(userState
                                .hardcodedStrings.newOrganisationErrorMessage);
                          }
                        }
                      },
                      color: widget.userState.darkmode
                          ? AppColors.lightThemeShadowColor
                          : AppColors.buttonsLightTheme,
                      child: ExtendedText(
                        text: userState.hardcodedStrings.create,
                        userState: userState,
                        colorOverride: AppColors.white,
                      ))
                ],
              ),
            )));
  }
}
