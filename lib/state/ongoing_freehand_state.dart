import 'package:foosball_mobile_app/models/freehand-matches/userScoreObject.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:mobx/mobx.dart';
// Include generated file
part 'ongoing_freehand_state.g.dart';

// This is the class used by rest of your codebase
class OngoingFreehandState = _OngoingFreehandState with _$OngoingFreehandState;

// The store-class
abstract class _OngoingFreehandState with Store {
  // true equals 2 players, false equals 4 players
  @observable
  UserScoreObject playerOne = new UserScoreObject(
      player: new UserResponse(
          id: 0,
          email: '',
          firstName: '',
          lastName: '',
          createdAt: DateTime.now(),
          currentOrganisationId: 0,
          photoUrl: ''),
      score: 0);

  @observable
  UserScoreObject playerTwo = new UserScoreObject(
      player: new UserResponse(
          id: 0,
          email: '',
          firstName: '',
          lastName: '',
          createdAt: DateTime.now(),
          currentOrganisationId: 0,
          photoUrl: ''),
      score: 0);

  @observable
  bool isClockPaused = false;

  @observable
  int elapsedSeconds = 0;

  @action
  void setPlayer(UserScoreObject player) {
    this.playerOne = player;
  }

  // update score of playerOne
  @action
  void updatePlayerOneScore(int score) {
    this.playerOne.score = score;
  }

  // update score of playerTwo
  @action
  void updatePlayerTwoScore(int score) {
    this.playerTwo.score = score;
  }

  @action
  void setPlayerTwo(UserScoreObject player) {
    this.playerTwo = player;
  }

  @action
  void clearPlayerOne() {
    this.playerOne = new UserScoreObject(
        player: new UserResponse(
            id: 0,
            email: '',
            firstName: '',
            lastName: '',
            createdAt: DateTime.now(),
            currentOrganisationId: 0,
            photoUrl: ''),
        score: 0);
  }

  @action
  void clearPlayerTwo() {
    this.playerTwo = new UserScoreObject(
        player: new UserResponse(
            id: 0,
            email: '',
            firstName: '',
            lastName: '',
            createdAt: DateTime.now(),
            currentOrganisationId: 0,
            photoUrl: ''),
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
