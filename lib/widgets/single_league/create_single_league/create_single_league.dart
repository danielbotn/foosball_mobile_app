import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';

class CreateSingleLegue extends StatefulWidget {
  final UserState userState;
  const CreateSingleLegue({Key? key, required this.userState})
      : super(key: key);

  @override
  State<CreateSingleLegue> createState() => _CreateSingleLegueState();
}

class _CreateSingleLegueState extends State<CreateSingleLegue> {
  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: widget.userState.hardcodedStrings.about,
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
          child: Column(
            children: <Widget>[
              ExtendedText(
                text: 'Choose Players',
                userState: widget.userState,
                fontSize: 20,
              )
            ],
          ),
        ));
  }
}
