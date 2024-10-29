import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:serenity/constants/const.dart';

class RelaxationGuideWidget extends StatefulWidget {
  const RelaxationGuideWidget({super.key});

  @override
  State<RelaxationGuideWidget> createState() => _RelaxationGuideWidgetState();
}

class _RelaxationGuideWidgetState extends State<RelaxationGuideWidget> {
  static const String apiKey = 'AIzaSyAPHtUCHKOZ2YAOOlPETWaVFaBAoVKhs6U';

  late final GenerativeModel _model;
  late final ChatSession _chat;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                              "Discover relaxation exercises inspired by the teachings of the *Bhagavad Gita* to calm your mind and reduce stress.",
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
                      child: Lottie.network(
                        'https://lottie.host/927d861e-19e0-481a-8ff8-8c958efc2bf4/yLXPKLWOGd.json',
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
