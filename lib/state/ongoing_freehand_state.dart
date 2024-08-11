import 'package:dano_foosball/models/freehand-matches/userScoreObject.dart';
import 'package:dano_foosball/models/user/user_response.dart';
import 'package:mobx/mobx.dart';
// Include generated file
part 'ongoing_freehand_state.g.dart';

// This is the class used by rest of your codebase
class OngoingFreehandState = _OngoingFreehandState with _$OngoingFreehandState;

// The store-class
abstract class _OngoingFreehandState with Store {
  // true equals 2 players, false equals 4 players
  @observable
  UserScoreObject playerOne = UserScoreObject(
      player: UserResponse(
          id: 0,
          email: '',
          firstName: '',
          lastName: '',
          createdAt: DateTime.now(),
          currentOrganisationId: 0,
          photoUrl: '',
          isAdmin: false,
          isDeleted: false),
      score: 0);

  @observable
  UserScoreObject playerTwo = UserScoreObject(
      player: UserResponse(
          id: 0,
          email: '',
          firstName: '',
          lastName: '',
          createdAt: DateTime.now(),
          currentOrganisationId: 0,
          photoUrl: '',
          isAdmin: false,
          isDeleted: false),
      score: 0);

  @observable
  bool isClockPaused = false;

  @observable
  int elapsedSeconds = 0;

  // update playerOne
  @action
  void updatePlayerOne(UserScoreObject playerOne) {
    this.playerOne = playerOne;
  }

  // update playerTwo
  @action
  void updatePlayerTwo(UserScoreObject playerTwo) {
    this.playerTwo = playerTwo;
  }

  @action
  void setPlayer(UserScoreObject player) {
    playerOne = player;
  }

  // update score of playerOne
  @action
  void updatePlayerOneScore(int score) {
    playerOne.score = score;
  }

  // update score of playerTwo
  @action
  void updatePlayerTwoScore(int score) {
    playerTwo.score = score;
  }

  @action
  void setPlayerTwo(UserScoreObject player) {
    playerTwo = player;
  }

  @action
  void clearPlayerOne() {
    playerOne = UserScoreObject(
        player: UserResponse(
            id: 0,
            email: '',
            firstName: '',
            lastName: '',
            createdAt: DateTime.now(),
            currentOrganisationId: 0,
            photoUrl: '',
            isDeleted: false,
            isAdmin: false),
        score: 0);
  }

  @action
  void clearPlayerTwo() {
    playerTwo = UserScoreObject(
        player: UserResponse(
            id: 0,
            email: '',
            firstName: '',
            lastName: '',
            createdAt: DateTime.now(),
            currentOrganisationId: 0,
            photoUrl: '',
            isDeleted: false,
            isAdmin: false),
        score: 0);
  }

  @action
  void setIsClockPaused(bool value) {
    isClockPaused = value;
  }

  @action
  void setElapsedSeconds(int value) {
    elapsedSeconds = value;
  }

  @action
  void clearElapsedSeconds() {
    elapsedSeconds = 0;
  }
}
