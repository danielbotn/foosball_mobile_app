// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ongoing_freehand_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OngoingFreehandState on _OngoingFreehandState, Store {
  late final _$playerOneAtom =
      Atom(name: '_OngoingFreehandState.playerOne', context: context);

  @override
  UserScoreObject get playerOne {
    _$playerOneAtom.reportRead();
    return super.playerOne;
  }

  @override
  set playerOne(UserScoreObject value) {
    _$playerOneAtom.reportWrite(value, super.playerOne, () {
      super.playerOne = value;
    });
  }

  late final _$playerTwoAtom =
      Atom(name: '_OngoingFreehandState.playerTwo', context: context);

  @override
  UserScoreObject get playerTwo {
    _$playerTwoAtom.reportRead();
    return super.playerTwo;
  }

  @override
  set playerTwo(UserScoreObject value) {
    _$playerTwoAtom.reportWrite(value, super.playerTwo, () {
      super.playerTwo = value;
    });
  }

  late final _$isClockPausedAtom =
      Atom(name: '_OngoingFreehandState.isClockPaused', context: context);

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

  late final _$elapsedSecondsAtom =
      Atom(name: '_OngoingFreehandState.elapsedSeconds', context: context);

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

  late final _$_OngoingFreehandStateActionController =
      ActionController(name: '_OngoingFreehandState', context: context);

  @override
  void updatePlayerOne(UserScoreObject playerOne) {
    final _$actionInfo = _$_OngoingFreehandStateActionController.startAction(
        name: '_OngoingFreehandState.updatePlayerOne');
    try {
      return super.updatePlayerOne(playerOne);
    } finally {
      _$_OngoingFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePlayerTwo(UserScoreObject playerTwo) {
    final _$actionInfo = _$_OngoingFreehandStateActionController.startAction(
        name: '_OngoingFreehandState.updatePlayerTwo');
    try {
      return super.updatePlayerTwo(playerTwo);
    } finally {
      _$_OngoingFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlayer(UserScoreObject player) {
    final _$actionInfo = _$_OngoingFreehandStateActionController.startAction(
        name: '_OngoingFreehandState.setPlayer');
    try {
      return super.setPlayer(player);
    } finally {
      _$_OngoingFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePlayerOneScore(int score) {
    final _$actionInfo = _$_OngoingFreehandStateActionController.startAction(
        name: '_OngoingFreehandState.updatePlayerOneScore');
    try {
      return super.updatePlayerOneScore(score);
    } finally {
      _$_OngoingFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePlayerTwoScore(int score) {
    final _$actionInfo = _$_OngoingFreehandStateActionController.startAction(
        name: '_OngoingFreehandState.updatePlayerTwoScore');
    try {
      return super.updatePlayerTwoScore(score);
    } finally {
      _$_OngoingFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlayerTwo(UserScoreObject player) {
    final _$actionInfo = _$_OngoingFreehandStateActionController.startAction(
        name: '_OngoingFreehandState.setPlayerTwo');
    try {
      return super.setPlayerTwo(player);
    } finally {
      _$_OngoingFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearPlayerOne() {
    final _$actionInfo = _$_OngoingFreehandStateActionController.startAction(
        name: '_OngoingFreehandState.clearPlayerOne');
    try {
      return super.clearPlayerOne();
    } finally {
      _$_OngoingFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearPlayerTwo() {
    final _$actionInfo = _$_OngoingFreehandStateActionController.startAction(
        name: '_OngoingFreehandState.clearPlayerTwo');
    try {
      return super.clearPlayerTwo();
    } finally {
      _$_OngoingFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsClockPaused(bool value) {
    final _$actionInfo = _$_OngoingFreehandStateActionController.startAction(
        name: '_OngoingFreehandState.setIsClockPaused');
    try {
      return super.setIsClockPaused(value);
    } finally {
      _$_OngoingFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setElapsedSeconds(int value) {
    final _$actionInfo = _$_OngoingFreehandStateActionController.startAction(
        name: '_OngoingFreehandState.setElapsedSeconds');
    try {
      return super.setElapsedSeconds(value);
    } finally {
      _$_OngoingFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearElapsedSeconds() {
    final _$actionInfo = _$_OngoingFreehandStateActionController.startAction(
        name: '_OngoingFreehandState.clearElapsedSeconds');
    try {
      return super.clearElapsedSeconds();
    } finally {
      _$_OngoingFreehandStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
playerOne: ${playerOne},
playerTwo: ${playerTwo},
isClockPaused: ${isClockPaused},
elapsedSeconds: ${elapsedSeconds}
    ''';
  }
}
