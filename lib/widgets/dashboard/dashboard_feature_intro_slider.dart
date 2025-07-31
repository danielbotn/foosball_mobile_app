import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeatureIntroSlider extends StatefulWidget {
  final bool darkMode;
  const FeatureIntroSlider({super.key, required this.darkMode});

  @override
  State<FeatureIntroSlider> createState() => _FeatureIntroSliderState();
}

class _FeatureIntroSliderState extends State<FeatureIntroSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_SlideData> slides = [
    _SlideData(
      title: "Track Matches",
      description:
          "Log your foosball games and keep score with precision. See history and results.",
      icon: FontAwesomeIcons.futbol,
    ),
    _SlideData(
      title: "Create Leagues",
      description:
          "Build leagues with friends, rank up on the leaderboard, and compete for glory.",
      icon: FontAwesomeIcons.trophy,
    ),
    _SlideData(
      title: "Team & Solo Play",
      description:
          "Supports both team and individual matches. Perfect for quick games or serious tournaments.",
      icon: FontAwesomeIcons.users,
    ),
    _SlideData(
      title: "Smart Stats",
      description:
          "See detailed stats like win rates, ELO ratings, and match streaks.",
      icon: FontAwesomeIcons.chartLine,
    ),
  ];

  void _nextSlide() {
    if (_currentPage < slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.darkMode ? Colors.black : Colors.white;
    final textColor = widget.darkMode ? Colors.white : Colors.black87;

    return Container(
      height: 400,
      color: bgColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: slides.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final slide = slides[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      slide.icon,
                      size: 60,
                      color: widget.darkMode ? Colors.amber : Colors.blueGrey,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      slide.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      slide.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              slides.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Colors.amber
                      : Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SlideData {
  final String title;
  final String description;
  final IconData icon;

  _SlideData({
    required this.title,
    required this.description,
    required this.icon,
  });
}
