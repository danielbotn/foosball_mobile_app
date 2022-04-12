import 'package:foosball_mobile_app/models/freehand-double-matches/userDoubleScoreObject.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:mobx/mobx.dart';
// Include generated file
part 'ongoing_double_freehand_state.g.dart';

// This is the class used by rest of your codebase
class OngoingDoubleFreehandState = _OngoingDoubleFreehandState with _$OngoingDoubleFreehandState;

// The store-class
abstract class _OngoingDoubleFreehandState with Store {
  // true equals 2 players, false equals 4 players
  @observable
  UserDoubleScoreObject teamOne = new UserDoubleScoreObject(
      players: [],
      score: 0);

    @observable
  UserDoubleScoreObject teamTwo = new UserDoubleScoreObject(
      players: [],
      score: 0);

  @observable
  bool isClockPaused = false;

  @observable
  int elapsedSeconds = 0;

  // set teamOne
  @action
  void setTeamOne(UserResponse userOne, UserResponse userTwo, int score) {
    teamOne.players.add(userOne);
    teamOne.players.add(userTwo);
    teamOne.score = score;
  }

  // set teamTwo
  @action
  void setTeamTwo(UserResponse userOne, UserResponse userTwo, int score) {
    teamTwo.players.add(userOne);
    teamTwo.players.add(userTwo);
    teamTwo.score = score;
  }

  // increase score teamOne
  @action
  void increaseScoreTeamOne() {
    teamOne.score++;
  }

  // increase score teamTwo
  @action
  void increaseScoreTeamTwo() {
    teamTwo.score++;
  }

  // set score teamOne
  @action
  void setScoreTeamOne(int score) {
    teamOne.score = score;
  }

  // set score teamTwo
  @action
  void setScoreTeamTwo(int score) {
    teamTwo.score = score;
  }

  // clear all teams
  @action
  void clearTeams() {
    teamOne.players.clear();
    teamTwo.players.clear();
    teamOne.score = 0;
    teamTwo.score = 0;
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
