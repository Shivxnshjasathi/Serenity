import 'package:animated_floating_button_pro/floating_action_button.dart';
import 'package:animated_floating_button_pro/floating_button_props.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:serenity/constants/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RelaxationGuideWidget extends StatefulWidget {
  const RelaxationGuideWidget({super.key});

  @override
  State<RelaxationGuideWidget> createState() => _RelaxationGuideWidgetState();
}

class _RelaxationGuideWidgetState extends State<RelaxationGuideWidget> {
  static const String apiKey = 'AIzaSyAPHtUCHKOZ2YAOOlPETWaVFaBAoVKhs6U';
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;
  String? _story;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );
    _chat = _model.startChat();
    _generateStory();
  }

  Future<void> _generateStory() async {
    setState(() {
      _loading = true;
    });

    try {
      final response = await _chat.sendMessage(
        Content.text(
          "Generate a relaxation guide with exercises based on the *Bhagavad Gita* teachings that can help reduce stress and calm the mind. Include step-by-step instructions for each exercise, and explain how they promote tranquility and mindfulness.",
        ),
      );
      setState(() {
        _story = response.text;
      });
    } catch (e) {
      _story = "Error generating relaxation guide: ${e.toString()}";
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _togglePlayPause() async {
    if (_story != null) {
      if (_isPlaying) {
        await _flutterTts.stop();
      } else {
        await _flutterTts.speak(_story!);
      }
      setState(() {
        _isPlaying = !_isPlaying;
      });
    }
  }

  Future<void> _bookmarkRelaxationGuide() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null || _story == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('relaxationBookmarks')
        .add({
      'content': _story,
      'tag': 'relaxation',
      'timestamp': FieldValue.serverTimestamp(),
    });

    HapticFeedback.vibrate();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Relaxation guide bookmarked successfully!",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: bgColor));
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
            action: _bookmarkRelaxationGuide,
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
                          Text("Relaxation Guide",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white38,
                              )),
                          const SizedBox(height: 10),
                          Text(
                              "Discover relaxation exercises inspired by the teachings of the Bhagavad Gita to calm your mind and reduce stress.",
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
                    const SizedBox(height: 40),
                    if (_loading)
                      Text('Generating your relaxation guide...',
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
                              Text("Generate New Guide",
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
                        'assets/excercise.json',
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
