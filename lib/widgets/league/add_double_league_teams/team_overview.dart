import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/main.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/widgets/extended_Text.dart';

class TeamOverview extends StatefulWidget {
  final UserState userState;
  final List<UserResponse>? team;
  const TeamOverview({super.key, required this.userState, required this.team});

  @override
  State<TeamOverview> createState() => _TeamOverviewState();
}

class _TeamOverviewState extends State<TeamOverview> {
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
                  userState: userState,
                ),
              ],
            ),
            subtitle: ExtendedText(
              text: users[i].email,
              userState: userState,
            ),
            leading: SizedBox(
                height: 100,
                width: 50,
                child: Image.network(users[i].photoUrl))));
      }
    }
    return list;
  }

  @override
  void didUpdateWidget(TeamOverview old) {
    super.didUpdateWidget(old);

    var gaur = widget.team;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: _buildPlayersList(widget.team),
      ),
    );
  }
}
