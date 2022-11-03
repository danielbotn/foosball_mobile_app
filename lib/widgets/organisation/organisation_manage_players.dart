import 'package:flutter/material.dart';

import '../../api/UserApi.dart';
import '../../models/user/user_response.dart';
import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../../utils/helpers.dart';
import '../extended_Text.dart';
import '../loading.dart';
import 'OrganisationManagePlayer.dart';

class OrganisationManagePlayers extends StatefulWidget {
  final UserState userState;
  const OrganisationManagePlayers({Key? key, required this.userState})
      : super(key: key);

  @override
  State<OrganisationManagePlayers> createState() =>
      _OrganisationManagePlayersState();
}

class _OrganisationManagePlayersState extends State<OrganisationManagePlayers> {
  // state
  late Future<List<UserResponse>?> playersFuture;
  late List<UserResponse>? playersData;

  @override
  void initState() {
    super.initState();
    playersFuture = getPlayersData();
  }

  Future<List<UserResponse>?> getPlayersData() async {
    String token = widget.userState.token;
    UserApi user = UserApi(token: token);
    var data = await user.getUsers();
    playersData = data;
    return data;
  }

  String getHeadline(UserResponse user) {
    return "${user.firstName} ${user.lastName}";
  }

  String getIsAdmin(UserResponse user) {
    String result = "";
    if (user.isAdmin == true) {
      result = "Admin";
    }
    return result;
  }

  goToManagePlayer(BuildContext context, UserResponse user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OrganisationManagePlayer(
                  userState: widget.userState,
                  userData: user,
                )));
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return Scaffold(
        appBar: AppBar(
            title: ExtendedText(
                text: widget.userState.hardcodedStrings.managePlayers,
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
        body: FutureBuilder(
          future: playersFuture,
          builder: (context, AsyncSnapshot<List<UserResponse>?> snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                  child: ListView.builder(
                itemCount: playersData!.length,
                itemBuilder: (context, index) {
                  String headline = getHeadline(playersData![index]);

                  return Card(
                    margin: EdgeInsets.zero,
                    color: widget.userState.darkmode
                        ? AppColors.darkModeBackground
                        : AppColors.white,
                    child: ListTile(
                      leading: Image.network(playersData![index].photoUrl),
                      title: ExtendedText(
                        text: headline,
                        userState: widget.userState,
                      ),
                      subtitle: ExtendedText(
                        text: getIsAdmin(playersData![index]),
                        userState: widget.userState,
                        colorOverride: AppColors.textGrey,
                      ),
                      trailing: Icon(Icons.chevron_right,
                          color: widget.userState.darkmode
                              ? AppColors.white
                              : AppColors.textGrey),
                      onTap: () {
                        goToManagePlayer(context, playersData![index]);
                      },
                    ),
                  );
                },
              ));
            } else {
              return const Loading();
            }
          },
        ));
  }
}
