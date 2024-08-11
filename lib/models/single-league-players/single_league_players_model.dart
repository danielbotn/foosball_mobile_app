import 'package:dano_foosball/models/user/user_response.dart';

class SingleLeaguePlayersModel {
  List<UserResponse> users;
  int leagueId;

  SingleLeaguePlayersModel({
    required this.users,
    required this.leagueId,
  });

  Map<String, dynamic> toJson() {
    return {
      'users': users.map((user) => user.toJson(user)).toList(),
      'leagueId': leagueId,
    };
  }
}
