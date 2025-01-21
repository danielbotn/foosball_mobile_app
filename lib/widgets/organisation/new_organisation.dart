import 'package:dano_foosball/widgets/UI/Buttons/Button.dart';
import 'package:dano_foosball/widgets/inputs/InputWidget.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/api/Organisation.dart';

import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';

class NewOrganisation extends StatefulWidget {
  final UserState userState;
  final Function() notifyOrganisationButtons;
  const NewOrganisation(
      {super.key,
      required this.userState,
      required this.notifyOrganisationButtons});

  @override
  State<NewOrganisation> createState() => _NewOrganisationState();
}

class _NewOrganisationState extends State<NewOrganisation> {
  String _inputText = "";

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

  void _onChangeInput(String value) {
    setState(() {
      _inputText = value;
    });
  }

  Future<void> _onButtonClick() async {
    if (_inputText.isNotEmpty) {
      Organisation api = Organisation();
      var result = await api.createNewOrganisation(_inputText);

      if (result.statusCode == 201) {
        // success
        setState(() {
          _inputText = "";
        });
        await _showMyDialog(
            widget.userState.hardcodedStrings.newOrganisationSuccessMessage);
        widget.notifyOrganisationButtons();
      } else {
        // error handling
        await _showMyDialog(
            widget.userState.hardcodedStrings.newOrganisationErrorMessage);
      }
    }
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
              child: InputWidget(
                userState: widget.userState,
                onChangeInput: _onChangeInput,
                clearInputText: true,
                hintText:
                    widget.userState.hardcodedStrings.nameOfNewOrganisation,
              ),
            ),
            Expanded(child: Container()), // This takes up the remaining space
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Button(
                userState: widget.userState,
                onClick: _onButtonClick,
                text: widget.userState.hardcodedStrings.create,
                paddingBottom: 10,
                paddingLeft: 10,
                paddingRight: 10,
                paddingTop: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
