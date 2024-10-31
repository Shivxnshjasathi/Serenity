import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:serenity/constants/const.dart';
import 'package:url_launcher/url_launcher.dart';

class CalmingMediaWidget extends StatefulWidget {
  const CalmingMediaWidget({super.key});

  @override
  State<CalmingMediaWidget> createState() => _CalmingMediaWidgetState();
}

class _CalmingMediaWidgetState extends State<CalmingMediaWidget> {
  static const String apiKey = 'AIzaSyAPHtUCHKOZ2YAOOlPETWaVFaBAoVKhs6U';

  late final GenerativeModel _model;
  late final ChatSession _chat;
  late final FlutterTts _flutterTts;
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;
  String? _shloka;
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
    _generatePlaylists();
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

  Future<void> _generatePlaylists() async {
    setState(() {
      _loading = true;
    });

    try {
      final response = await _chat.sendMessage(
        Content.text(
          "Generate a random fact about the Bhagavad Gita, Mahabharata, or Ramayana, including detailed information about characters, incidents, and philosophical teachings. The fact should illuminate a significant moment or character's journey within these epic texts.",
        ),
      );
      setState(() {
        _shloka = response.text;
      });
    } catch (e) {
      _shloka = "Error generating playlists: ${e.toString()}";
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
      if (_shloka != null && _shloka!.isNotEmpty) {
        await _flutterTts.setLanguage("en-IN");
        await _flutterTts.setPitch(1);
        await _flutterTts.speak(_shloka!);
      }
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
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
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePlayPause,
        backgroundColor: Colors.black,
        child: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
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
                          Text("Discover the Depths",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white38,
                              )),
                          const SizedBox(height: 10),
                          Text(
                              "Discover Lesser-Known Truths Behind Hindu Epic Characters and Events that You Never Knew.",
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
                      data: _shloka ?? '',
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
                      Text('Generating your Epic Insights...',
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
                          _generatePlaylists();
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
                              Text("Generate New Facts",
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
                        'assets/music.json',
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
