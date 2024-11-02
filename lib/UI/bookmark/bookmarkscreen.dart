import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';
import 'package:serenity/constants/const.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Bookmarks',
            style: primaryTextStyle,
          ),
          bottom: const TabBar(
            indicatorColor: accentColor,
            labelColor: accentColor,
            unselectedLabelColor: Colors.white,
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

  Widget _buildStoriesTab() {
    return _buildContentTab('storyBookmarks');
  }

  Widget _buildExercisesTab() {
    return _buildContentTab('relaxationBookmarks');
  }

  Widget _buildShlokasTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('shlokaBookmarks')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final shlokas = snapshot.data!.docs;
        if (shlokas.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Lottie.asset(
                    'assets/bookmark.json',
                    width: 350,
                    height: 350,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'No bookmarks in Shlokas section',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: shlokas.length,
          itemBuilder: (context, index) {
            final shloka = shlokas[index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4,
              child: ListTile(
                title: MarkdownBody(
                  data: shloka['content'] ?? '',
                  styleSheet: MarkdownStyleSheet(
                    p: GoogleFonts.poppins(
                      color: Colors.black,
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
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.black),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection('shlokaBookmarks')
                        .doc(shloka.id)
                        .delete();
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

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
        if (items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Lottie.asset(
                    'assets/bookmark.json',
                    width: 350,
                    height: 350,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'No bookmarks in this section',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4,
              child: ListTile(
                title: MarkdownBody(
                  data: item['content'] ?? '',
                  styleSheet: MarkdownStyleSheet(
                    p: GoogleFonts.poppins(
                      color: Colors.black,
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
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.black),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection(collectionName)
                        .doc(item.id)
                        .delete();
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
