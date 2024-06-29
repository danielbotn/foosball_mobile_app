import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';
import 'package:tuple/tuple.dart';

class TeamsSelecter extends StatefulWidget {
  final UserState userState;
  final Function(List<UserResponse> teamPlayers) addTeam;
  const TeamsSelecter(
      {super.key, required this.userState, required this.addTeam});

  @override
  State<TeamsSelecter> createState() => _TeamsSelecterState();
}

class _TeamsSelecterState extends State<TeamsSelecter> {
  // state
  late Future<List<UserResponse>?> usersFuture;
  List<UserResponse>? users;
  List<Tuple2<UserResponse, bool>> allPlayers = [];
  List<UserResponse> selectedPlayers = [];

  bool checkIfLessThenTwo() {
    bool result = true;

    if (allPlayers.isNotEmpty) {
      int counter = 0;
      for (var element in allPlayers) {
        if (element.item2 == true) {
          counter++;
        }
        if (counter >= 2) {
          result = false;
          break;
        }
      }
    }
    return result;
  }

  void checkBoxChecked(bool? value, int index, UserResponse user) {
    bool isChecked = value ?? false;

    Tuple2<UserResponse, bool> player = Tuple2(users![index], isChecked);

    if (isChecked) {
      setState(() {
        if (!selectedPlayers.contains(user)) {
          if (selectedPlayers.length < 2) {
            selectedPlayers.add(user);
            allPlayers[index] = player;
          }
        }
      });
    } else {
      setState(() {
        selectedPlayers.remove(user);
        allPlayers[index] = player;
      });
    }

    widget.addTeam(selectedPlayers);
  }

  @override
  void initState() {
    super.initState();
    usersFuture = getAllUsers();

    usersFuture.then((users) {
      users?.forEach((user) {
        Tuple2<UserResponse, bool> player = Tuple2(user, false);
        allPlayers.add(player);
      });
      // Perform any further operations with the selected players here
    });
  }

  Future<List<UserResponse>?> getAllUsers() async {
    UserApi userApi = UserApi();
    var allUsers = await userApi.getUsers();
    setState(() {
      users = allUsers;
    });
    return allUsers;
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();

    List<ListTile> _buildPlayersList(List<UserResponse>? users) {
      List<ListTile> list = <ListTile>[];
      for (var i = 0; i < users!.length; i++) {
        if (users[i].isDeleted == false) {
          list.add(ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ExtendedText(
                    text: "${users[i].firstName} ${users[i].lastName}",
                    userState: widget.userState),
              ],
            ),
            subtitle: ExtendedText(
              text: users[i].email,
              userState: widget.userState,
            ),
            leading: SizedBox(
                height: 100,
                width: 50,
                child: Image.network(users[i].photoUrl)),
            trailing: SizedBox(
              width: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Visibility(
                        visible: true,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          side: MaterialStateBorderSide.resolveWith((states) {
                            if (widget.userState.darkmode) {
                              return const BorderSide(
                                  width: 1.0, color: AppColors.white);
                            }
                            return const BorderSide(
                                width: 1.0, color: AppColors.textGrey);
                          }),
                          checkColor: Colors.white,
                          activeColor: helpers
                              .getCheckMarkColor(widget.userState.darkmode),
                          value: allPlayers[i].item2,
                          onChanged: (bool? value) {
                            checkBoxChecked(value, i, users[i]);
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          ));
        }
      }
      return list;
    }

    return FutureBuilder(
        future: usersFuture,
        builder: (context, AsyncSnapshot<List<UserResponse>?> snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 230,
              // add listview with variable two
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                children: _buildPlayersList(snapshot.data),
              ),
            );
          } else {
            return Center(child: Loading(userState: widget.userState));
          }
        });
  }
}
