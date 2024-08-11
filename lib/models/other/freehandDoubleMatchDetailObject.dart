import 'package:dano_foosball/models/freehand-double-matches/freehand_double_match_create_response.dart';
import 'package:dano_foosball/models/freehand-double-matches/userDoubleScoreObject.dart';
import 'package:dano_foosball/state/user_state.dart';

class FreehandDoubleMatchDetailObject {
  UserState userState;
  FreehandDoubleMatchCreateResponse? freehandMatchCreateResponse;
  UserDoubleScoreObject teamOne;
  UserDoubleScoreObject teamTwo;

  FreehandDoubleMatchDetailObject(
      {required this.userState,
      required this.freehandMatchCreateResponse,
      required this.teamOne,
      required this.teamTwo});
}
