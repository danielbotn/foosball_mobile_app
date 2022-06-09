// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ongoing_double_freehand_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OngoingDoubleFreehandState on _OngoingDoubleFreehandState, Store {
  late final _$teamOneAtom =
      Atom(name: '_OngoingDoubleFreehandState.teamOne', context: context);

  @override
  UserDoubleScoreObject get teamOne {
    _$teamOneAtom.reportRead();
    return super.teamOne;
  }

  @override
  set teamOne(UserDoubleScoreObject value) {
    _$teamOneAtom.reportWrite(value, super.teamOne, () {
      super.teamOne = value;
    });
  }

  late final _$teamTwoAtom =
      Atom(name: '_OngoingDoubleFreehandState.teamTwo', context: context);

  @override
  UserDoubleScoreObject get teamTwo {
    _$teamTwoAtom.reportRead();
    return super.teamTwo;
  }

  @override
  set teamTwo(UserDoubleScoreObject value) {
    _$teamTwoAtom.reportWrite(value, super.teamTwo, () {
      super.teamTwo = value;
    });
  }

  late final _$isClockPausedAtom =
      Atom(name: '_OngoingDoubleFreehandState.isClockPaused', context: context);

  @override
  bool get isClockPaused {
    _$isClockPausedAtom.reportRead();
    return super.isClockPaused;
  }

  @override
  set isClockPaused(bool value) {
    _$isClockPausedAtom.reportWrite(value, super.isClockPaused, () {
      super.isClockPaused = value;
    });
  }

  late final _$elapsedSecondsAtom = Atom(
      name: '_OngoingDoubleFreehandState.elapsedSeconds', context: context);

  @override
  int get elapsedSeconds {
    _$elapsedSecondsAtom.reportRead();
    return super.elapsedSeconds;
  }

  @override
  set elapsedSeconds(int value) {
    _$elapsedSecondsAtom.reportWrite(value, super.elapsedSeconds, () {
      super.elapsedSeconds = value;
    });
  }

  late final _$_OngoingDoubleFreehandStateActionController =
      ActionController(name: '_OngoingDoubleFreehandState', context: context);

  @override
  void setTeamOne(UserResponse userOne, UserResponse userTwo, int score) {
    final _$actionInfo = _$_OngoingDoubleFreehandStateActionController
        .startAction(name: '_OngoingDoubleFreehandState.setTeamOne');
    try {
      return super.setTeamOne(userOne, userTwo, score);
    } finally {
      _$_OngoingDoubleFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTeamTwo(UserResponse userOne, UserResponse userTwo, int score) {
    final _$actionInfo = _$_OngoingDoubleFreehandStateActionController
        .startAction(name: '_OngoingDoubleFreehandState.setTeamTwo');
    try {
      return super.setTeamTwo(userOne, userTwo, score);
    } finally {
      _$_OngoingDoubleFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increaseScoreTeamOne() {
    final _$actionInfo = _$_OngoingDoubleFreehandStateActionController
        .startAction(name: '_OngoingDoubleFreehandState.increaseScoreTeamOne');
    try {
      return super.increaseScoreTeamOne();
    } finally {
      _$_OngoingDoubleFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increaseScoreTeamTwo() {
    final _$actionInfo = _$_OngoingDoubleFreehandStateActionController
        .startAction(name: '_OngoingDoubleFreehandState.increaseScoreTeamTwo');
    try {
      return super.increaseScoreTeamTwo();
    } finally {
      _$_OngoingDoubleFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setScoreTeamOne(int score) {
    final _$actionInfo = _$_OngoingDoubleFreehandStateActionController
        .startAction(name: '_OngoingDoubleFreehandState.setScoreTeamOne');
    try {
      return super.setScoreTeamOne(score);
    } finally {
      _$_OngoingDoubleFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setScoreTeamTwo(int score) {
    final _$actionInfo = _$_OngoingDoubleFreehandStateActionController
        .startAction(name: '_OngoingDoubleFreehandState.setScoreTeamTwo');
    try {
      return super.setScoreTeamTwo(score);
    } finally {
      _$_OngoingDoubleFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearTeams() {
    final _$actionInfo = _$_OngoingDoubleFreehandStateActionController
        .startAction(name: '_OngoingDoubleFreehandState.clearTeams');
    try {
      return super.clearTeams();
    } finally {
      _$_OngoingDoubleFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsClockPaused(bool value) {
    final _$actionInfo = _$_OngoingDoubleFreehandStateActionController
        .startAction(name: '_OngoingDoubleFreehandState.setIsClockPaused');
    try {
      return super.setIsClockPaused(value);
    } finally {
      _$_OngoingDoubleFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setElapsedSeconds(int value) {
    final _$actionInfo = _$_OngoingDoubleFreehandStateActionController
        .startAction(name: '_OngoingDoubleFreehandState.setElapsedSeconds');
    try {
      return super.setElapsedSeconds(value);
    } finally {
      _$_OngoingDoubleFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearElapsedSeconds() {
    final _$actionInfo = _$_OngoingDoubleFreehandStateActionController
        .startAction(name: '_OngoingDoubleFreehandState.clearElapsedSeconds');
    try {
      return super.clearElapsedSeconds();
    } finally {
      _$_OngoingDoubleFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
teamOne: ${teamOne},
teamTwo: ${teamTwo},
isClockPaused: ${isClockPaused},
elapsedSeconds: ${elapsedSeconds}
    ''';
  }
}
