import 'package:flutter/material.dart';
import 'package:dano_foosball/api/Organisation.dart';
import 'package:dano_foosball/main.dart';

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
          title: Text(widget.userState.hardcodedStrings.newOrganisation),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(widget.userState.hardcodedStrings.close),
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
          userState: widget.userState,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: helpers.getIconTheme(widget.userState.darkmode),
        backgroundColor: helpers.getBackgroundColor(widget.userState.darkmode),
      ),
      body: Container(
        color: widget.userState.darkmode
            ? AppColors.darkModeLighterBackground
            : AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.userState.darkmode
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.userState.darkmode
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.userState.darkmode
                          ? Colors.white
                          : Colors.blue,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          widget.userState.darkmode ? Colors.white : Colors.red,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _textController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  hintText:
                      widget.userState.hardcodedStrings.nameOfNewOrganisation,
                ),
              ),
            ),
            Expanded(child: Container()), // This takes up the remaining space
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                height: 50, // Adjust the height as needed
                child: MaterialButton(
                  onPressed: () async {
                    String inputText = _textController.text;
                    if (inputText.isNotEmpty) {
                      Organisation api = Organisation();
                      var result = await api.createNewOrganisation(inputText);

                      if (result.statusCode == 201) {
                        // success
                        _textController.clear();
                        await _showMyDialog(widget.userState.hardcodedStrings
                            .newOrganisationSuccessMessage);
                        widget.notifyOrganisationButtons();
                      } else {
                        // error handling
                        await _showMyDialog(widget.userState.hardcodedStrings
                            .newOrganisationErrorMessage);
                      }
                    }
                  },
                  color: widget.userState.darkmode
                      ? AppColors.darkModeButtonColor
                      : AppColors.buttonsLightTheme,
                  child: ExtendedText(
                    text: widget.userState.hardcodedStrings.create,
                    userState: widget.userState,
                    colorOverride: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
