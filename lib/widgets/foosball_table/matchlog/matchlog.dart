import 'dart:async';

import 'package:dano_foosball/models/foosball-table/game_score.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:flutter/material.dart';

class Matchlog extends StatelessWidget {
  final UserState userState;
  final bool matchStarted;
  final bool matchEnded;
  final List<GameScore> matchLogScore;
  final int teamOneScore;
  final int teamTwoScore;
  final Duration gameDuration; // Duration of the game

  const Matchlog({
    super.key,
    required this.userState,
    this.matchStarted = false,
    this.matchEnded = false,
    required this.matchLogScore,
    required this.teamOneScore,
    required this.teamTwoScore,
    required this.gameDuration
  });

  BoxDecoration _boxDecoration({
    Color? borderColor,
    Color? boxColor,
    double borderWidth = 1.0,
    double shadowOpacity = 0.1,
    double shadowSpread = 2,
    double shadowBlur = 5,
  }) {
    return BoxDecoration(
      color: boxColor ??
          (userState.darkmode ? AppColors.darkModeBackground : AppColors.white),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: borderColor ?? Colors.transparent,
        width: borderWidth,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(shadowOpacity),
          blurRadius: shadowBlur,
          spreadRadius: shadowSpread,
        ),
      ],
    );
  }

Widget _buildMatchLog(Color textColor, Color boxColor, Color borderColor) {
  return Container(
    decoration: _boxDecoration(boxColor: boxColor, borderColor: borderColor),
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        if (matchLogScore.isNotEmpty)
          Text(
            "${matchEnded ? 'FT' : ''} ${teamOneScore.toString()} - ${teamTwoScore.toString()}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: matchLogScore.length,
            itemBuilder: (context, index) {
              final entry = matchLogScore[matchLogScore.length - 1 - index];
              final isTeamGrey = entry.teamName == "Team Grey";

              // Content widgets
              final children = <Widget>[
                Text(entry.teamName, style: TextStyle(color: textColor)),
                const SizedBox(width: 8),
                _scoreBox(entry),
                const SizedBox(width: 12),
                const Icon(Icons.sports_soccer,
                    color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(entry.timeOfGoal, style: TextStyle(color: textColor)),
              ];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment:
                      isTeamGrey ? MainAxisAlignment.start : MainAxisAlignment.end,
                  children: [
                    // Wrap in Flexible so it doesn't overflow
                    Flexible(
                      child: Row(
                        mainAxisAlignment: isTeamGrey
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: isTeamGrey ? children : children.reversed.toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget _scoreBox(entry) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      "(${entry.teamScore}-${entry.opponentTeamScore})",
      style: const TextStyle(color: Colors.white, fontSize: 14),
    ),
  );
}

  Widget _buildMatchInvitation(
      Color textColor, Color boxColor, Color borderColor) {
    return Container(
      decoration: _boxDecoration(boxColor: boxColor, borderColor: borderColor),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Larger, more greyed out Dano logo
          Opacity(
            opacity: 0.25,
            child: Image.asset(
              'assets/images/dano-scaled.png', // Adjust path as needed
              height: 120,
              width: 120,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Ready for a match?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          // Typewriter effect for instruction text
          TypewriterText(
            text: "Press Start Game to begin tracking",
            textStyle: TextStyle(
              fontSize: 16,
              color: textColor.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
          // Enhanced animated element
          EnhancedPulse(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sports_soccer,
                  color: textColor.withOpacity(0.7),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  "Last match: Grey Team won 10-8",
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: textColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = userState.darkmode ? Colors.white : Colors.black;
    Color boxColor = userState.darkmode
        ? AppColors.darkModeBackground.withOpacity(0.8)
        : AppColors.white;
    Color borderColor = userState.darkmode
        ? Colors.white.withOpacity(0.2)
        : Colors.grey.withOpacity(0.3);

    return matchStarted
        ? _buildMatchLog(textColor, boxColor, borderColor)
        : _buildMatchInvitation(textColor, boxColor, borderColor);
  }
}

// Enhanced animation with more noticeable effect
class EnhancedPulse extends StatefulWidget {
  final Widget child;

  const EnhancedPulse({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _EnhancedPulseState createState() => _EnhancedPulseState();
}

class _EnhancedPulseState extends State<EnhancedPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

/// Typewriter text effect with proper lifecycle management
class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Duration typingSpeed;
  final Duration startDelay;
  final bool repeat;

  const TypewriterText({
    Key? key,
    required this.text,
    required this.textStyle,
    this.typingSpeed = const Duration(milliseconds: 100),
    this.startDelay = const Duration(milliseconds: 500),
    this.repeat = true,
  }) : super(key: key);

  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  String _displayedText = "";
  Timer? _timer;
  Timer? _delayTimer;
  int _charIndex = 0;
  bool _backspacing = false;

  @override
  void initState() {
    super.initState();
    _scheduleStartTyping();
  }

  void _scheduleStartTyping() {
    _delayTimer = Timer(widget.startDelay, () {
      if (mounted) {
        _startTyping();
      }
    });
  }

  void _startTyping() {
    _cancelTimers();

    _timer = Timer.periodic(widget.typingSpeed, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        if (!_backspacing) {
          // Typing forward
          if (_charIndex < widget.text.length) {
            _displayedText = widget.text.substring(0, _charIndex + 1);
            _charIndex++;
          } else if (widget.repeat) {
            // Delay before backspacing
            _pauseBeforeBackspace();
          }
        }
      });
    });
  }

  void _pauseBeforeBackspace() {
    _cancelTimers();

    _delayTimer = Timer(const Duration(seconds: 5), () {
      if (!mounted) return;

      setState(() {
        _backspacing = true;
      });

      _timer = Timer.periodic(widget.typingSpeed, (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        _backspace();
      });
    });
  }

  void _backspace() {
    if (!mounted) return;

    setState(() {
      if (_charIndex > 0) {
        _charIndex--;
        _displayedText = widget.text.substring(0, _charIndex);
      } else {
        _backspacing = false;
        // Delay before typing again
        _pauseBeforeRestart();
      }
    });
  }

  void _pauseBeforeRestart() {
    _cancelTimers();

    _delayTimer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        _startTyping();
      }
    });
  }

  void _cancelTimers() {
    _timer?.cancel();
    _timer = null;
    _delayTimer?.cancel();
    _delayTimer = null;
  }

  @override
  void dispose() {
    _cancelTimers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _displayedText,
          style: widget.textStyle,
          textAlign: TextAlign.center,
        ),
        // Blinking cursor effect
        Visibility(
          visible:
              (_displayedText.length < widget.text.length && !_backspacing),
          child: _BlinkingCursor(textStyle: widget.textStyle),
        ),
      ],
    );
  }
}

// Separated blinking cursor for better management
class _BlinkingCursor extends StatefulWidget {
  final TextStyle textStyle;

  const _BlinkingCursor({required this.textStyle});

  @override
  _BlinkingCursorState createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Text(
        "|",
        style: widget.textStyle,
      ),
    );
  }
}
