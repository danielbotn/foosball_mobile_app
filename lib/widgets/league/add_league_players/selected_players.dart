import 'package:flutter/material.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/user_state.dart';

class SelectedPlayers extends StatefulWidget {
  final UserState userState;
  final List<UserResponse> players;
  const SelectedPlayers(
      {Key? key, required this.userState, required this.players})
      : super(key: key);

  @override
  State<SelectedPlayers> createState() => _SelectedPlayersState();
}

class _SelectedPlayersState extends State<SelectedPlayers> {
  List<ListTile> _buildPlayersList(List<UserResponse>? users) {
    List<ListTile> list = <ListTile>[];
    for (var i = 0; i < users!.length; i++) {
      if (users[i].isDeleted == false) {
        list.add(ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("${users[i].firstName} ${users[i].lastName}"),
            ],
          ),
          subtitle: Text(users[i].email),
          leading: SizedBox(
              height: 100, width: 50, child: Image.network(users[i].photoUrl)),
        ));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      // add listview with variable two
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: _buildPlayersList(widget.players),
      ),
    );
  }
}
