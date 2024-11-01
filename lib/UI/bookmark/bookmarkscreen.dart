import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:serenity/constants/const.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Total number of tabs
      child: Scaffold(
        backgroundColor: Colors.white, // Set the background color to white
        appBar: AppBar(
          backgroundColor: Colors.black, // AppBar background color
          title: Text(
            'Bookmarks',
            style: primaryTextStyle, // Text color
          ),
          bottom: const TabBar(
            indicatorColor: accentColor, // Set the indicator color to white
            labelColor:
                accentColor, // Set the selected tab label color to white
            unselectedLabelColor:
                Colors.white, // Set the unselected tab label color
            tabs: [
              Tab(text: 'Facts'),
              Tab(text: 'Stories'),
              Tab(text: 'Exercises'),
              Tab(text: 'Shlokas'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildFactsTab(),
            _buildStoriesTab(),
            _buildExercisesTab(),
            _buildShlokasTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildFactsTab() {
    return _buildContentTab('factsBookmarks');
  }

  // Stories Tab
  Widget _buildStoriesTab() {
    return _buildContentTab('storyBookmarks');
  }

  // Exercises Tab
  Widget _buildExercisesTab() {
    return _buildContentTab(
        'relaxationBookmarks'); // Call to exercise bookmarks
  }

  // Shlokas Tab
  Widget _buildShlokasTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('shlokaBookmarks') // Collection for shlokas
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final shlokas = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: shlokas.length,
          itemBuilder: (context, index) {
            final shloka = shlokas[index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MarkdownBody(
                  data:
                      shloka['content'] ?? '', // Use the content from Firestore
                  styleSheet: MarkdownStyleSheet(
                    p: GoogleFonts.poppins(
                      color: Colors.black, // Text color for paragraphs
                      fontWeight: FontWeight.w400,
                    ),
                    h1: GoogleFonts.poppins(color: Colors.black),
                    h2: GoogleFonts.poppins(color: Colors.black),
                    h3: GoogleFonts.poppins(color: Colors.black),
                    h4: GoogleFonts.poppins(color: Colors.black),
                    h5: GoogleFonts.poppins(color: Colors.black),
                    h6: GoogleFonts.poppins(color: Colors.black),
                    blockquote: GoogleFonts.poppins(color: Colors.black),
                    strong: GoogleFonts.poppins(color: Colors.black),
                    em: GoogleFonts.poppins(color: Colors.black),
                    code: GoogleFonts.poppins(color: Colors.black),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Generic method to build content for each tab
  Widget _buildContentTab(String collectionName) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection(collectionName)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final items = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Using MarkdownBody to render content with Markdown
                    MarkdownBody(
                      data:
                          item['content'] ?? '', // Display the Markdown content
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.poppins(
                          color: Colors.black, // Text color for paragraphs
                          fontWeight: FontWeight.w400,
                        ),
                        h1: GoogleFonts.poppins(color: Colors.black),
                        h2: GoogleFonts.poppins(color: Colors.black),
                        h3: GoogleFonts.poppins(color: Colors.black),
                        h4: GoogleFonts.poppins(color: Colors.black),
                        h5: GoogleFonts.poppins(color: Colors.black),
                        h6: GoogleFonts.poppins(color: Colors.black),
                        blockquote: GoogleFonts.poppins(color: Colors.black),
                        strong: GoogleFonts.poppins(color: Colors.black),
                        em: GoogleFonts.poppins(color: Colors.black),
                        code: GoogleFonts.poppins(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                        height: 8.0), // Space between content and tag
                    Text(
                      'Tag: ${item['tag']}',
                      style: GoogleFonts.poppins(
                          color: Colors.grey[600]), // Tag color
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
