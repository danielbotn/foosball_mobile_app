import 'package:dano_foosball/models/freehand-double-matches/freehand_double_match_create_response.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/user_state.dart';

class OngoingDoubleGameObject {
  UserState userState;
  FreehandDoubleMatchCreateResponse? freehandDoubleMatchCreateResponse;
  UserResponse playerOneTeamA;
  UserResponse playerTwoTeamA;
  UserResponse playerOneTeamB;
  UserResponse? playerTwoTeamB;

  OngoingDoubleGameObject({
    required this.userState,
    required this.freehandDoubleMatchCreateResponse,
    required this.playerOneTeamA,
    required this.playerTwoTeamA,
    required this.playerOneTeamB,
    required this.playerTwoTeamB,
  });
}
