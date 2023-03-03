import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

import '../../loading.dart';

class ChoosePlayers extends StatefulWidget {
  final UserState userState;
  const ChoosePlayers({Key? key, required this.userState}) : super(key: key);

  @override
  State<ChoosePlayers> createState() => _ChoosePlayersState();
}

class _ChoosePlayersState extends State<ChoosePlayers> {
  late Future<List<UserResponse>?> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = getPlayers();
  }

  Future<List<UserResponse>?> getPlayers() async {
    UserApi userApi = UserApi(token: widget.userState.token);
    var users = await userApi.getUsers();
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: usersFuture,
        builder: (context, AsyncSnapshot<List<UserResponse>?> snapshot) {
          if (snapshot.hasData) {
            return Container();
          } else {
            return const Loading();
          }
        });
  }
}
