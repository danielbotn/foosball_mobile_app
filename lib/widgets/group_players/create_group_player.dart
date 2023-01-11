import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/models/user/create_group_user_model.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/group_players/info_card.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:async';

class CreateGroupPlayer extends StatefulWidget {
  final UserState userState;
  const CreateGroupPlayer({Key? key, required this.userState})
      : super(key: key);

  @override
  State<CreateGroupPlayer> createState() => _CreateGroupPlayerState();
}

class _CreateGroupPlayerState extends State<CreateGroupPlayer> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool isKeyPadOpen = false;
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  late StreamSubscription<bool> keyboardSubscription;

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
    focusNode1.addListener(() {
      setState(() {
        isKeyPadOpen = focusNode1.hasFocus;
      });
      if (!focusNode1.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
    focusNode2.addListener(() {
      setState(() {
        isKeyPadOpen = focusNode2.hasFocus;
      });
      if (!focusNode2.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  Future<UserResponse?> createNewGroupUser() async {
    late UserResponse? result;
    UserApi userApi = UserApi(token: widget.userState.token);
    CreateGroupUserModel groupUser = CreateGroupUserModel(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text);
    var response = await userApi.createGroupUser(groupUser);

    if (response.statusCode == 200) {
      result = UserResponse.fromJson(jsonDecode(response.body));
    } else {
      result = null;
    }

    return result;
  }

  // Alert Dialog if user wants to create new group user
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

  void clearAllInputs() {
    _firstNameController.clear();
    _lastNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: 'Create Group User', userState: widget.userState),
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
                child: TextField(
                  style: TextStyle(
                      color: widget.userState.darkmode
                          ? AppColors.white
                          : AppColors.textGrey),
                  onSubmitted: (term) {
                    focusNode1.unfocus();
                  },
                  focusNode: focusNode1,
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: widget.userState.darkmode
                            ? AppColors.white
                            : AppColors.textGrey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.userState.darkmode
                              ? AppColors.white
                              : AppColors.textGrey,
                          width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.userState.darkmode
                              ? AppColors.white
                              : AppColors.textGrey,
                          width: 1.0),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          _firstNameController.clear();
                        },
                        icon: Icon(Icons.clear,
                            color: widget.userState.darkmode
                                ? AppColors.white
                                : AppColors.textGrey)),
                    hintText: 'First Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  style: TextStyle(
                      color: widget.userState.darkmode
                          ? AppColors.white
                          : AppColors.textGrey),
                  focusNode: focusNode2,
                  controller: _lastNameController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: widget.userState.darkmode
                              ? AppColors.white
                              : AppColors.textGrey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: widget.userState.darkmode
                                ? AppColors.white
                                : AppColors.textGrey,
                            width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: widget.userState.darkmode
                                ? AppColors.white
                                : AppColors.textGrey,
                            width: 1.0),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _lastNameController.clear();
                          },
                          icon: Icon(
                            Icons.clear,
                            color: widget.userState.darkmode
                                ? AppColors.white
                                : AppColors.textGrey,
                          )),
                      hintText: 'Last Name'),
                ),
              ),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    color: Colors.blue[800],
                    child: ElevatedButton(
                      onPressed: () async {
                        UserApi userApi =
                            UserApi(token: widget.userState.token);
                        CreateGroupUserModel groupUser = CreateGroupUserModel(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text);
                        var response = await userApi.createGroupUser(groupUser);
                        if (response.statusCode == 200) {
                          await _showMyDialog('success');
                        } else {
                          await _showMyDialog('failure');
                        }
                        clearAllInputs();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: widget.userState.darkmode
                              ? AppColors.lightThemeShadowColor
                              : AppColors.buttonsLightTheme,
                          minimumSize: const Size(200, 50)),
                      child: Text(widget.userState.hardcodedStrings.create),
                    ),
                  ))
            ],
          ),
        ));
  }
}
