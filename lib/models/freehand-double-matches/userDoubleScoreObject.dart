import 'package:dano_foosball/models/user/user_response.dart';

class UserDoubleScoreObject {
  List<UserResponse> players;
  int score;

  UserDoubleScoreObject({required this.players, required this.score});
}
