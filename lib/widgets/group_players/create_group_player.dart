import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/user/create_group_user_model.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/group_players/info_card.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:async';

import 'package:foosball_mobile_app/widgets/inputs/InputWidget.dart';

class CreateGroupPlayer extends StatefulWidget {
  final UserState userState;
  const CreateGroupPlayer({Key? key, required this.userState})
      : super(key: key);

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
      if (visible == false) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  Future<UserResponse?> createNewGroupUser() async {
    late UserResponse? result;
    UserApi userApi = UserApi();
    CreateGroupUserModel groupUser =
        CreateGroupUserModel(firstName: firstNameText, lastName: lastNameText);
    var response = await userApi.createGroupUser(groupUser);

    if (response != null) {
      result = response;
    } else {
      result = null;
    }

    return result;
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
            children: [
              Visibility(
                visible: isKeyPadOpen == false,
                child: InfoCard(userState: widget.userState),
              ),
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InputWidget(
                      userState: widget.userState,
                      onChangeInput: (value) {
                        setState(() {
                          firstNameText = value;
                          clearInputs = false;
                        });
                      },
                      hintText: userState.hardcodedStrings.firstName,
                      clearInputText: clearInputs)),
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InputWidget(
                      userState: widget.userState,
                      hintText: userState.hardcodedStrings.lastName,
                      onChangeInput: (value) {
                        setState(() {
                          lastNameText = value;
                          clearInputs = false;
                        });
                      },
                      clearInputText: clearInputs)),
              const Spacer(),
              Visibility(
                  visible: firstNameText != "" &&
                      lastNameText != "" &&
                      isKeyPadOpen == false,
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        color: Colors.blue[800],
                        child: ElevatedButton(
                          onPressed: () async {
                            UserApi userApi = UserApi();
                            CreateGroupUserModel groupUser =
                                CreateGroupUserModel(
                                    firstName: firstNameText,
                                    lastName: lastNameText);

                            var response =
                                await userApi.createGroupUser(groupUser);
                            if (response != null) {
                              await showMyDialog(
                                  widget.userState.hardcodedStrings
                                      .groupPlayerCreateSuccess,
                                  true);
                            } else {
                              await showMyDialog(
                                  widget.userState.hardcodedStrings
                                      .groupPlayerCreateFailure,
                                  false);
                            }
                            clearAllInputs();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: widget.userState.darkmode
                                  ? AppColors.darkModeButtonColor
                                  : AppColors.buttonsLightTheme,
                              minimumSize: const Size(200, 50)),
                          child: Text(widget.userState.hardcodedStrings.create),
                        ),
                      )))
            ],
          ),
        ));
  }
}
