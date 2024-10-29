import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    const storyWidget(),
    const RelaxationGuideWidget(),
    const CalmingMediaWidget(),
  ];

  // Function to handle item taps in BottomNavigationBar
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedFontSize: 10,
        showSelectedLabels: false,
        selectedItemColor: accentColor,
        enableFeedback: true,
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: GoogleFonts.poppins(),
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/open-book1.png")),
            label: 'Shloka',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/yoga.png")),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/reading-book.png")),
            label: 'Story',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/yoga1.png")),
            label: 'Exercise',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/ideas.png")),
            label: 'Quiz',
          ),
        ],
      ),
    );
  }
}

// class DigitalKarmaBank extends StatefulWidget {
//   @override
//   _DigitalKarmaBankState createState() => _DigitalKarmaBankState();
// }

// class _DigitalKarmaBankState extends State<DigitalKarmaBank> {
//   int karmaPoints = 120; // Sample karma points
//   String currentLevel = "Seeker"; // Sample current level
//   final List<Map<String, dynamic>> actions = [
//     {"name": "Act of Kindness", "points": 10},
//     {"name": "Practiced Patience", "points": 15},
//     {"name": "Demonstrated Detachment", "points": 20},
//     {"name": "Self-Discipline", "points": 25},
//   ];

//   final List<Map<String, dynamic>> rewards = [
//     {"name": "Exclusive Meditation", "pointsRequired": 100},
//     {"name": "Advanced Gita Lessons", "pointsRequired": 150},
//     {"name": "Personal Growth Challenge", "pointsRequired": 200},
//   ];

//   final List<Map<String, String>> milestones = [
//     {"date": "10/01/2024", "description": "Reached 100 Karma Points"},
//     {"date": "10/15/2024", "description": "Completed Patience Challenge"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Digital Karma Bank'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Karma Points Section
//             Text("Karma Points: $karmaPoints",
//                 style: const TextStyle(fontSize: 24)),
//             const SizedBox(height: 10),
//             LinearProgressIndicator(
//                 value: karmaPoints / 300), // Example progress to next level
//             const SizedBox(height: 20),
//             Text("Current Level: $currentLevel",
//                 style: const TextStyle(fontSize: 20)),
//             const SizedBox(height: 20),

//             // Log Positive Action Button
//             ElevatedButton(
//               onPressed: () {
//                 _showKarmaLogDialog();
//               },
//               child: const Text("Log Positive Action"),
//             ),
//             const SizedBox(height: 20),

//             // Recent Actions Section
//             const Text("Recent Actions",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             ListView.builder(
//               physics:
//                   const NeverScrollableScrollPhysics(), // Prevent scrolling
//               shrinkWrap: true, // Take up only the space needed
//               itemCount: actions.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(actions[index]['name']),
//                   subtitle: Text("+${actions[index]['points']} Points"),
//                 );
//               },
//             ),
//             const SizedBox(height: 20),

//             // Karma Rewards Section
//             const Text("Available Rewards",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             ListView.builder(
//               physics:
//                   const NeverScrollableScrollPhysics(), // Prevent scrolling
//               shrinkWrap: true, // Take up only the space needed
//               itemCount: rewards.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: ListTile(
//                     title: Text(rewards[index]['name']),
//                     subtitle: Text(
//                         "Requires ${rewards[index]['pointsRequired']} points"),
//                     trailing: ElevatedButton(
//                       onPressed: () {
//                         // Unlock reward logic
//                       },
//                       child: const Text("Unlock"),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 20),

//             // Progress Milestones Section
//             const Text("Progress Milestones",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             ListView.builder(
//               physics:
//                   const NeverScrollableScrollPhysics(), // Prevent scrolling
//               shrinkWrap: true, // Take up only the space needed
//               itemCount: milestones.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: const Icon(Icons.star, color: Colors.amber),
//                   title: Text(milestones[index]['description']!),
//                   subtitle: Text(milestones[index]['date']!),
//                 );
//               },
//             ),
//             const SizedBox(height: 20),

//             // Share Karma Button
//             ElevatedButton(
//               onPressed: () {
//                 _showShareDialog();
//               },
//               child: const Text("Share Your Progress"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showKarmaLogDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Log Positive Action"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: actions.map((action) {
//               return ListTile(
//                 title: Text(action['name']),
//                 subtitle: Text("Earn ${action['points']} points"),
//                 onTap: () {
//                   setState(() {
//                     karmaPoints += action['points'] as int;
//                   });
//                   Navigator.pop(context);
//                 },
//               );
//             }).toList(),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Cancel"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showShareDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Share Your Milestone"),
//           content: Text("You've reached $karmaPoints Karma Points!"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Implement share functionality
//               },
//               child: const Text("Share"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Cancel"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
