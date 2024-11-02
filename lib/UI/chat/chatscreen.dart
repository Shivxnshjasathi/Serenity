import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:serenity/constants/wedgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:serenity/constants/const.dart';

class CommunityChatScreen extends StatefulWidget {
  @override
  _CommunityChatScreenState createState() => _CommunityChatScreenState();
}

class _CommunityChatScreenState extends State<CommunityChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _username = 'Anonymous';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // Load the username specific to the user's account from SharedPreferences, or prompt for it if it doesn't exist
  Future<void> _loadUsername() async {
    final user = _auth.currentUser;
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      final storedUsername = prefs.getString('username_${user.uid}');

      if (storedUsername == null) {
        _promptUsername();
      } else {
        setState(() {
          _username = storedUsername;
        });
      }
    }
  }

  // Prompt the user to enter a username, and save it specific to the user's account
  Future<void> _promptUsername() async {
    final usernameController = TextEditingController();
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Enter your username',
            style: primaryTextStyle,
          ),
          content: TextField(
            controller: usernameController,
            cursorColor: Colors.black,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(width: 2, color: Colors.white),
              ),
              labelText: 'Enter your Username...',
              labelStyle: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
              hintText: 'Type here...',
              hintStyle: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white30,
              ),
            ),
            autocorrect: true,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final username = usernameController.text.trim();
                final user = _auth.currentUser;
                if (username.isNotEmpty && user != null) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('username_${user.uid}', username);
                  setState(() {
                    _username = username;
                  });
                  Navigator.of(context).pop();
                }
              },
              child:
                  Text('Save', style: GoogleFonts.poppins(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // Function to send a message
  Future<void> _sendMessage() async {
    final user = _auth.currentUser;
    if (user != null && _messageController.text.trim().isNotEmpty) {
      await FirebaseFirestore.instance.collection('communityMessages').add({
        'userId': user.uid,
        'username': _username,
        'message': _messageController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    }
  }

  // Widget to build each message bubble
  Widget _buildMessageItem(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final isCurrentUser = data['userId'] == _auth.currentUser?.uid;
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3),
            child: NeoPopButton(
              color: isCurrentUser ? accentColor : bgColor,
              shadowColor: accentColor,
              depth: 5,
              onTapUp: () {
                HapticFeedback.vibrate();
              },
              onTapDown: () => HapticFeedback.vibrate(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['username'] ?? 'Anonymous',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: isCurrentUser ? Colors.black : Colors.white,
                      ),
                    ),
                    MarkdownBody(
                      data: data['message'],
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.poppins(
                          color: isCurrentUser ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Community Chat',
          style: primaryTextStyle,
        ),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          CustomPaint(
              painter: GridPainter(),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Start Conversation with Community Members",
                            style: GoogleFonts.libreBaskerville(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            "Always available to listen and provide support, Anytime you need it.",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white38,
                            )),
                      ],
                    ),
                  ),
                  Container(),
                ],
              )),
          Column(
            children: [
              // Display messages
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('communityMessages')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final messages = snapshot.data!.docs;
                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return _buildMessageItem(messages[index]);
                      },
                    );
                  },
                ),
              ),
              // Input field and send button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        cursorColor: Colors.black,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.white),
                          ),
                          labelText: 'Start Chatting...',
                          labelStyle: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          hintText: 'Type here...',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white30,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    NeoPopButton(
                      color: accentColor,
                      onTapUp: () {
                        HapticFeedback.vibrate();
                        _sendMessage();
                      },
                      onTapDown: () => HapticFeedback.vibrate(),
                      shadowColor: accentColor,
                      depth: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Chat",
                              style: GoogleFonts.poppins(color: bgColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
