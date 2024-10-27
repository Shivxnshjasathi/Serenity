import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:serenity/constants/const.dart';

class SWidget extends StatefulWidget {
  const SWidget({super.key});

  @override
  State<SWidget> createState() => _SWidgetState();
}

class _SWidgetState extends State<SWidget> {
  static const String apiKey = 'AIzaSyAPHtUCHKOZ2YAOOlPETWaVFaBAoVKhs6U';

  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;
  String? _shloka;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );
    _chat = _model.startChat();
    _generateShloka();
  }

  Future<void> _generateShloka() async {
    setState(() {
      _loading = true;
    });

    try {
      final response = await _chat.sendMessage(
        Content.text(
          "Provide a random shloka from the Bhagavad Gita along with a detailed explanation of its meaning and how it applies to modern life. Include any relevant spiritual insights.",
        ),
      );
      setState(() {
        _shloka = response.text;
      });
    } catch (e) {
      _shloka = "Error generating shloka: ${e.toString()}";
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 200,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Read a Shlok",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white38,
                              )),
                          const SizedBox(height: 10),
                          Text(
                              "Meaningful and motivational quotations can help spark inspiration and create a sense of purpose.",
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
                      data: _shloka ?? 'Generating your first shloka...',
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.w400
                            // User text black, AI text white
                            ),
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
                    NeoPopButton(
                      color: Colors.black,
                      bottomShadowColor: accentColor,
                      depth: 5,
                      onTapUp: () {
                        _generateShloka();
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
                            Text("Change Shloka",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 12,
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Lottie.network(
                        'https://lottie.host/29c39914-44d2-42be-860d-8db2b692c716/g8vFEyMsPW.json',
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
