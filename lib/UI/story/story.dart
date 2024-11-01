import 'package:animated_floating_button_pro/floating_action_button.dart';
import 'package:animated_floating_button_pro/floating_button_props.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:serenity/constants/const.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryWidget extends StatefulWidget {
  const StoryWidget({super.key});

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  static const String apiKey = 'AIzaSyAPHtUCHKOZ2YAOOlPETWaVFaBAoVKhs6U';

  late final GenerativeModel _model;
  late final ChatSession _chat;
  late final FlutterTts _flutterTts;
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;
  String? _story;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );
    _chat = _model.startChat();
    _flutterTts = FlutterTts();
    _initializeTts();
    _generateStory();
  }

  void _initializeTts() {
    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isPlaying = false;
      });
    });

    _flutterTts.setPauseHandler(() {
      setState(() {
        _isPlaying = false;
      });
    });

    _flutterTts.setContinueHandler(() {
      setState(() {
        _isPlaying = true;
      });
    });
  }

  Future<void> _generateStory() async {
    setState(() {
      _loading = true;
    });

    try {
      final response = await _chat.sendMessage(
        Content.text(
          "Generate a random, wisdom-filled story from the *Bhagavad Gita* or an incident from the *Mahabharata* that teaches a valuable lesson. Include life lessons and spiritual insights that resonate with young people in metropolitan areas.",
        ),
      );
      setState(() {
        _story = response.text;
      });
    } catch (e) {
      _story = "Error generating story: ${e.toString()}";
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _flutterTts.pause();
    } else {
      if (_story != null && _story!.isNotEmpty) {
        await _flutterTts.setLanguage("en-IN");
        await _flutterTts.setPitch(1.0);
        await _flutterTts.speak(_story!);
      }
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  Future<void> _bookmarkStory() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }
      final userId = user.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('storyBookmarks')
          .add({
        'content': _story,
        'tag': 'story',
        'timestamp': FieldValue.serverTimestamp(),
      });

      // await FirebaseFirestore.instance
      //     .collection('bookmarks')
      //     .doc(userId)
      //     .collection('userBookmarks')
      //     .add({'tag': 'story', 'content': _story});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              'Story bookmarked successfully!',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            backgroundColor: bgColor),
      );
    } catch (e) {
      print('Failed to bookmark story: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              'Failed to bookmark story.',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            backgroundColor: bgColor),
      );
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedFloatingButton(
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.all(16),
        openIcon: const Icon(Icons.more_horiz),
        childrenProps: [
          FloatingButtonProps(
            icon: _isPlaying ? Icons.pause : Icons.play_arrow,
            action: _togglePlayPause,
          ),
          FloatingButtonProps(
            icon: Icons.bookmark,
            action: () {
              HapticFeedback.vibrate();
              _bookmarkStory();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Read a Story",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white38,
                              )),
                          const SizedBox(height: 10),
                          Text(
                              "Read Short stories to rejuvenate the mind, increase productivity and focus, in today's busy world.",
                              style: GoogleFonts.libreBaskerville(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 5,
                color: accentColor,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MarkdownBody(
                      data: _story ?? '',
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.w400),
                        h1: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        h2: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        h3: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        h4: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        h5: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        h6: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        blockquote: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        strong: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        em: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        code: GoogleFonts.poppins(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 40),
                    if (_loading)
                      Text('Generating your Personalized Story...',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ))
                    else
                      NeoPopButton(
                        color: Colors.black,
                        bottomShadowColor: accentColor,
                        depth: 5,
                        onTapUp: () {
                          _generateStory();
                          HapticFeedback.vibrate();
                        },
                        onTapDown: () => HapticFeedback.vibrate(),
                        parentColor: accentColor,
                        buttonPosition: Position.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Generate New Story",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Lottie.asset(
                        'assets/story.json',
                        width: 350,
                        height: 350,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
