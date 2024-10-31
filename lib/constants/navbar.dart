import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:serenity/UI/exercise/excercise.dart';
import 'package:serenity/UI/qize/qize.dart';
import 'package:serenity/UI/sholak/readshloke.dart';
import 'package:serenity/UI/story/story.dart';
import 'package:serenity/UI/timer/timer.dart';
import 'package:serenity/constants/const.dart';

class NavBarScreen extends StatefulWidget {
  @override
  _NavBarScreenState createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const SWidget(),
    PomodoroScreen(),
    const StoryWidget(),
    const RelaxationGuideWidget(),
    const CalmingMediaWidget(),
  ];

  // Function to handle item taps in GNav
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Row(
          children: [
            Text(
              'Serenity AI',
              style: primaryTextStyle,
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: GNav(
            textStyle: GoogleFonts.poppins(
              color: accentColor,
              fontSize: 12, // Increase font size if desired
              fontWeight: FontWeight.w500,
            ),
            haptic: true,
            curve: Curves.decelerate,
            gap: 8,
            color: Colors.white,
            activeColor: accentColor,
            iconSize: 28, // Increase icon size for a larger appearance
            //tabBackgroundColor: accentColor,
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 8), // Increase vertical padding
            selectedIndex: _currentIndex,
            onTabChange: _onItemTapped,
            tabs: const [
              GButton(
                icon: LineIcons.book,
                text: 'Shloka',
              ),
              GButton(
                icon: LineIcons.stopwatch,
                text: 'Timer',
              ),
              GButton(
                icon: LineIcons.bookOpen,
                text: 'Story',
              ),
              GButton(
                icon: LineIcons.running,
                text: 'Exercise',
              ),
              GButton(
                icon: LineIcons.questionCircle,
                text: 'Quiz',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
