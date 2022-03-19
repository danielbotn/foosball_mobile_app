import 'package:foosball_mobile_app/models/freehand-matches/freehand_match_create_response.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';

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
