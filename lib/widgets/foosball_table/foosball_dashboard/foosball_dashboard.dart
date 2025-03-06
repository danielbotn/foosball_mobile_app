import 'dart:async';
import 'dart:convert';
import 'package:dano_foosball/widgets/foosball_table/Other/Other.dart';
import 'package:dano_foosball/widgets/foosball_table/matchlog/matchlog.dart';
import 'package:dano_foosball/widgets/foosball_table/scoreboard/scoreboard.dart';
import 'package:dano_foosball/widgets/foosball_table/sidebar/sidebar.dart';
import 'package:dano_foosball/widgets/foosball_table/timer_controls/timer_controls.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class FoosballDashboard extends StatefulWidget {
  final UserState userState;
  const FoosballDashboard({super.key, required this.userState});

  @override
  State<FoosballDashboard> createState() => _FoosballDashboardState();
}

class _FoosballDashboardState extends State<FoosballDashboard> {
  // State
  bool gameStarted = false;
  bool gamePaused = false;
  bool gameFinished = false;
  Duration duration = const Duration();
  Timer? timer;
  int teamOneScore = 0;
  int teamTwoScore = 0;
  int upTo = 10;

  // Connections state
  bool goalOneConnected = false;
  bool goalTwoConnected = true;
  bool serverConnected = false;

  // WebSocket state
  WebSocketChannel? _channel;
  Timer? _reconnectTimer;
  String _lastEvent = "No sensor events yet";

  @override
  void initState() {
    super.initState();
    // Connect to the WebSocket server when the widget initializes
    // We are using two servers for the 2 goals
    connectToWebSocket();
    connectToWebSocketTwo();
  }

  void connectToWebSocketTwo() {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://localhost:8764'),
      );

      setState(() {
        serverConnected = true;
      });

      // Listen for messages from the server
      _channel!.stream.listen(
        (message) {
          handleWebSocketMessage(message);
        },
        onDone: () {
          setState(() {
            serverConnected = false;
          });
          // Try to reconnect after a delay
          scheduleReconnect();
        },
        onError: (error) {
          print("WebSocket error: $error");
          setState(() {
            serverConnected = false;
          });
          // Try to reconnect after a delay
          scheduleReconnect();
        },
      );
    } catch (e) {
      print("WebSocket connection error: $e");
      setState(() {
        serverConnected = false;
      });
      // Try to reconnect after a delay
      scheduleReconnect();
    }
  }

  void connectToWebSocket() {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://localhost:8765'),
      );

      setState(() {
        serverConnected = true;
      });

      // Listen for messages from the server
      _channel!.stream.listen(
        (message) {
          handleWebSocketMessage(message);
        },
        onDone: () {
          setState(() {
            serverConnected = false;
          });
          // Try to reconnect after a delay
          scheduleReconnect();
        },
        onError: (error) {
          print("WebSocket error: $error");
          setState(() {
            serverConnected = false;
          });
          // Try to reconnect after a delay
          scheduleReconnect();
        },
      );
    } catch (e) {
      print("WebSocket connection error: $e");
      setState(() {
        serverConnected = false;
      });
      // Try to reconnect after a delay
      scheduleReconnect();
    }
  }

  void scheduleReconnect() {
    // Cancel any existing reconnect timer
    _reconnectTimer?.cancel();

    // Schedule reconnection attempt after 5 seconds
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      connectToWebSocket();
    });
  }

  void handleWebSocketMessage(dynamic message) {
    try {
      final data = jsonDecode(message);

      setState(() {
        _lastEvent =
            "Received: ${data['sensor']} ${data['state'] ?? data['distance']}";
      });

      if (gameFinished == false) {
        // For testing purposes, update score on any sensor event
        // In a real implementation, you'd have more specific logic
        if (data['sensor'] == 'BEAM1') {
          _updateScore('teamOne');
        } else if (data['sensor'] == 'BEAM2') {
          _updateScore('teamTwo');
        }
      }
    } catch (e) {
      print("Error parsing WebSocket message: $e");
    }
  }

  bool _checkIfGameIsOver() {
    bool result = false;
    if (gameStarted) {
      if (teamOneScore >= upTo || teamTwoScore >= upTo) {
        result = true;
      }
    }

    return result;
  }

  void _updateScore(String team) {
    if (gameStarted && !gamePaused) {
      setState(() {
        if (team == 'teamOne') {
          teamOneScore++;
        } else if (team == 'teamTwo') {
          teamTwoScore++;
        }
      });
      gameFinished = _checkIfGameIsOver();
    }
  }

  // Called from child widget
  // Fires when game is finished
  void onGameOver() {
    setState(() {
      gameStarted = false;
      gamePaused = false;
      gameFinished = true;
      duration = const Duration();
    });

    timer?.cancel();
  }

  // Start Game
  void startGame() {
    resetGame();
    setState(() {
      gameStarted = true;
      gamePaused = false;
      gameFinished = false;
      duration = const Duration(); // Reset duration when starting
    });

    timer?.cancel(); // Cancel any existing timer
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        duration += const Duration(milliseconds: 100);
      });
    });
  }

  // Pause or Resume Game
  void togglePause() {
    if (gamePaused) {
      setState(() {
        gamePaused = false;
      });

      timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          duration += const Duration(milliseconds: 100);
        });
      });
    } else {
      setState(() {
        gamePaused = true;
      });

      timer?.cancel();
    }
  }

  // Reset Game
  void resetGame() {
    setState(() {
      gameStarted = false;
      gamePaused = false;
      duration = const Duration();
      teamOneScore = 0;
      teamTwoScore = 0;
    });

    timer?.cancel();
  }

  @override
  void dispose() {
    // Close WebSocket connection and cancel timers when widget is disposed
    _channel?.sink.close();
    _reconnectTimer?.cancel();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = widget.userState.darkmode;
    Color backgroundColor =
        isDarkMode ? AppColors.darkModeBackground : AppColors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Row(
        children: [
          Sidebar(userState: widget.userState),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Scoreboard(
                      userState: widget.userState,
                      gameDuration: duration,
                      onPlayerImageClick: _updateScore,
                      teamOneScore: teamOneScore, // Pass team scores
                      teamTwoScore: teamTwoScore,
                      gamePaused: gamePaused,
                      gameStarted: gameStarted,
                      upTo: upTo,
                      onGameOver: onGameOver),
                  const SizedBox(height: 16),
                  Expanded(
                      child: Matchlog(
                    userState: widget.userState,
                    matchStarted: gameStarted,
                  )),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TimerControls(
                    userState: widget.userState,
                    gameStarted: gameStarted,
                    gamePaused: gamePaused,
                    duration: duration,
                    onStartGame: startGame,
                    onPause: togglePause,
                    onReset: resetGame,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                      child: Other(
                    goalOneConnected: goalOneConnected,
                    goalTwoConnected: goalTwoConnected,
                    serverConnected: serverConnected,
                    userState: widget.userState,
                    upTo: upTo,
                    onScoreChanged: (newScore) {
                      setState(() {
                        upTo = newScore;
                      });
                    },
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
