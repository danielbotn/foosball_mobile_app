import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/widgets/UI/Buttons/Button.dart';
import 'package:dano_foosball/widgets/UI/Inputs/custom_input_two.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/api/UserApi.dart';
import 'package:dano_foosball/models/user/create_group_user_model.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:dano_foosball/widgets/group_players/info_card.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:async';

class CreateGroupPlayer extends StatefulWidget {
  final UserState userState;
  const CreateGroupPlayer({super.key, required this.userState});

  @override
  State<CreateGroupPlayer> createState() => _CreateGroupPlayerState();
}

class _CreateGroupPlayerState extends State<CreateGroupPlayer> {
  bool isKeyPadOpen = false;
  late StreamSubscription<bool> keyboardSubscription;
  String firstNameText = "";
  String lastNameText = "";
  bool clearInputs = false;

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();

    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        isKeyPadOpen = visible;
      });
      if (!visible) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  Future<UserResponse?> createNewGroupUser() async {
    UserApi userApi = UserApi();
    CreateGroupUserModel groupUser =
        CreateGroupUserModel(firstName: firstNameText, lastName: lastNameText);
    var response = await userApi.createGroupUser(groupUser);

    return response;
  }

  // Alert Dialog if user wants to create new group user
  Future<void> showMyDialog(String message, bool success) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(success
              ? widget.userState.hardcodedStrings.success
              : widget.userState.hardcodedStrings.failure),
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

  void clearAllInputs() {
    setState(() {
      firstNameText = "";
      lastNameText = "";
      clearInputs = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
      appBar: AppBar(
        title: ExtendedText(
          text: widget.userState.hardcodedStrings.createGroupPlayer,
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
            ? AppColors.darkModeBackground
            : AppColors.white,
        child: Column(
          children: [
            Visibility(
              visible: !isKeyPadOpen,
              child: InfoCard(userState: widget.userState),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: CustomInputTwo(
                userState: widget.userState,
                onChangeInput: (value) {
                  setState(() {
                    firstNameText = value;
                    clearInputs = false;
                  });
                },
                labelText: widget.userState.hardcodedStrings.firstName,
                clearInputText: clearInputs,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: CustomInputTwo(
                userState: widget.userState,
                labelText: widget.userState.hardcodedStrings.lastName,
                onChangeInput: (value) {
                  setState(() {
                    lastNameText = value;
                    clearInputs = false;
                  });
                },
                clearInputText: clearInputs,
              ),
            ),
            const Spacer(),
            Visibility(
              visible: firstNameText.isNotEmpty &&
                  lastNameText.isNotEmpty &&
                  !isKeyPadOpen,
              child: Button(
                text: widget.userState.hardcodedStrings.create,
                onClick: () async {
                  UserApi userApi = UserApi();
                  CreateGroupUserModel groupUser = CreateGroupUserModel(
                    firstName: firstNameText,
                    lastName: lastNameText,
                  );

                  var response = await userApi.createGroupUser(groupUser);
                  if (response != null) {
                    await showMyDialog(
                      widget
                          .userState.hardcodedStrings.groupPlayerCreateSuccess,
                      true,
                    );
                  } else {
                    await showMyDialog(
                      widget
                          .userState.hardcodedStrings.groupPlayerCreateFailure,
                      false,
                    );
                  }
                  clearAllInputs();
                },
                userState: userState,
                paddingBottom: 16,
                paddingLeft: 16,
                paddingRight: 16,
                paddingTop: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
