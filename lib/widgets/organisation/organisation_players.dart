import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/emptyData/emptyData.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

import '../../api/UserApi.dart';
import '../../models/user/user_response.dart';
import '../../state/user_state.dart';
import '../../utils/app_color.dart';
import '../loading.dart';

class OrganisationPlayers extends StatefulWidget {
  final UserState userState;
  final String randomString;
  const OrganisationPlayers(
      {Key? key, required this.userState, required this.randomString})
      : super(key: key);

  @override
  State<OrganisationPlayers> createState() => _OrganisationPlayersState();
}

class _OrganisationPlayersState extends State<OrganisationPlayers> {
  // state
  late Future<List<UserResponse>?> playersFuture;
  late List<UserResponse>? playersData;

  @override
  void initState() {
    super.initState();
    playersFuture = getPlayersData();
  }

  @override
  void didUpdateWidget(OrganisationPlayers old) {
    playersFuture = getPlayersData();
    super.didUpdateWidget(old);
  }

  Future<List<UserResponse>?> getPlayersData() async {
    UserApi user = UserApi();
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
      result = widget.userState.hardcodedStrings.admin;
    }
    if (user.isDeleted == true) {
      result += " ${widget.userState.hardcodedStrings.inactive}";
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Helpers helpers = Helpers();
    return FutureBuilder(
      future: playersFuture,
      builder: (context, AsyncSnapshot<List<UserResponse>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading(
            userState: widget.userState,
          );
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return EmptyData(
              userState: widget.userState,
              message: widget.userState.hardcodedStrings.noData,
              iconData: Icons.error);
        } else {
          return SafeArea(
            child: ListView.builder(
              itemCount: playersData!.length,
              itemBuilder: (context, index) {
                String headline = getHeadline(playersData![index]);

                return Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
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
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
