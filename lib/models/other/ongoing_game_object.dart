import 'package:dano_foosball/models/freehand-matches/freehand_match_create_response.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:dano_foosball/state/user_state.dart';

class OngoingGameObject {
  UserState userState;
  FreehandMatchCreateResponse? freehandMatchCreateResponse;
  UserResponse playerOne;
  UserResponse playerTwo;

  OngoingGameObject(
      {required this.userState,
      required this.freehandMatchCreateResponse,
      required this.playerOne,
      required this.playerTwo});
}
