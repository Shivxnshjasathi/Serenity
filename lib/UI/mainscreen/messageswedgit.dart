import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:serenity/constants/const.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({
    super.key,
    required this.text,
    required this.isFromUser,
  });

  final String text;
  final bool isFromUser;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  late FlutterTts _flutterTts;
  bool _isSpeaking = false; // Variable to track if speech is ongoing

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
  }

  Future<void> _speak(String text) async {
    if (_isSpeaking) {
      // If already speaking, pause
      await _flutterTts.pause();
      _isSpeaking = false; // Update state
    } else {
      // If not speaking, start speaking
      await _flutterTts.setLanguage("en-US"); // Set the language
      await _flutterTts.setPitch(1.0); // Set the pitch
      await _flutterTts.speak(text); // Speak the text
      _isSpeaking = true; // Update state
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                NeoPopButton(
                  color: widget.isFromUser ? accentColor : bgColor,
                  shadowColor: accentColor,
                  depth: 5,
                  onTapUp: () {
                    HapticFeedback.vibrate();
                    _speak(
                        widget.text); // Speak the message text or pause/resume
                  },
                  onTapDown: () => HapticFeedback.vibrate(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: MarkdownBody(
                      data: widget.text,
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.poppins(
                          color: widget.isFromUser
                              ? Colors.black
                              : Colors.white, // User text black, AI text white
                        ),
                        h1: GoogleFonts.poppins(
                          color:
                              widget.isFromUser ? Colors.black : Colors.white,
                        ),
                        h2: GoogleFonts.poppins(
                          color:
                              widget.isFromUser ? Colors.black : Colors.white,
                        ),
                        h3: GoogleFonts.poppins(
                          color:
                              widget.isFromUser ? Colors.black : Colors.white,
                        ),
                        h4: GoogleFonts.poppins(
                          color:
                              widget.isFromUser ? Colors.black : Colors.white,
                        ),
                        h5: GoogleFonts.poppins(
                          color:
                              widget.isFromUser ? Colors.black : Colors.white,
                        ),
                        h6: GoogleFonts.poppins(
                          color:
                              widget.isFromUser ? Colors.black : Colors.white,
                        ),
                        blockquote: GoogleFonts.poppins(
                          color:
                              widget.isFromUser ? Colors.black : Colors.white,
                        ),
                        strong: GoogleFonts.poppins(
                          color:
                              widget.isFromUser ? Colors.black : Colors.white,
                        ),
                        em: GoogleFonts.poppins(
                          color:
                              widget.isFromUser ? Colors.black : Colors.white,
                        ),
                        code: GoogleFonts.poppins(
                          color:
                              widget.isFromUser ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
