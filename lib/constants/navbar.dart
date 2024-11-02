import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:serenity/UI/about%20us/aboutus.dart';
import 'package:serenity/UI/bookmark/bookmarkscreen.dart';
import 'package:serenity/UI/chat/chatscreen.dart';
import 'package:serenity/UI/exercise/excercise.dart';
import 'package:serenity/UI/profile/profile.dart';
import 'package:serenity/UI/qize/qize.dart';
import 'package:serenity/UI/sholak/readshloke.dart';
import 'package:serenity/UI/story/story.dart';
import 'package:serenity/UI/timer/timer.dart';
import 'package:serenity/constants/const.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

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

  // Function to navigate with delay
  void _navigateWithDelay(Widget screen) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
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
      endDrawer: CurvedDrawer(
        isEndDrawer: true,
        color: Colors.black,
        labelColor: Colors.white,
        animationCurve: Curves.easeInOut,
        buttonBackgroundColor: Colors.black,
        width: 75.0,
        items: const <DrawerItem>[
          DrawerItem(
            icon: Icon(
              Icons.explore,
              color: Colors.white,
            ),
            label: "Explore  ",
          ),
          DrawerItem(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: "Profile  ",
          ),
          DrawerItem(
            icon: Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            label: "Bookmarks  ",
          ),
          DrawerItem(
            icon: Icon(
              Icons.chat_bubble,
              color: Colors.white,
            ),
            label: "Community Chat  ",
          ),
          DrawerItem(
            icon: Icon(
              Icons.info,
              color: Colors.white,
            ),
            label: "About us  ",
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              _navigateWithDelay(const ProfileScreen());
              break;
            case 2:
              _navigateWithDelay(const ContentScreen());
              break;
            case 3:
              _navigateWithDelay(CommunityChatScreen());
              break;
            case 4:
              _navigateWithDelay(const AboutUsScreen());
              break;
            default:
              break;
          }
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
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

// Example screen classes
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Explore")),
      body: const Center(child: Text("Explore Screen")),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: const Center(child: Text("Settings Screen")),
    );
  }
}
