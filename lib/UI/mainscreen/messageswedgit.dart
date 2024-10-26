import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:serenity/constants/const.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.text,
    required this.isFromUser,
  });

  final String text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                NeoPopButton(
                  color: isFromUser ? accentColor : bgColor,
                  shadowColor: accentColor,
                  depth: 5,
                  onTapUp: () {
                    HapticFeedback.vibrate();
                  },
                  onTapDown: () => HapticFeedback.vibrate(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: MarkdownBody(
                      data: text,
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.poppins(
                          color: isFromUser
                              ? Colors.black
                              : Colors.white, // User text black, AI text white
                        ),
                        h1: GoogleFonts.poppins(
                          color: isFromUser ? Colors.black : Colors.white,
                        ),
                        h2: GoogleFonts.poppins(
                          color: isFromUser ? Colors.black : Colors.white,
                        ),
                        h3: GoogleFonts.poppins(
                          color: isFromUser ? Colors.black : Colors.white,
                        ),
                        h4: GoogleFonts.poppins(
                          color: isFromUser ? Colors.black : Colors.white,
                        ),
                        h5: GoogleFonts.poppins(
                          color: isFromUser ? Colors.black : Colors.white,
                        ),
                        h6: GoogleFonts.poppins(
                          color: isFromUser ? Colors.black : Colors.white,
                        ),
                        blockquote: GoogleFonts.poppins(
                          color: isFromUser ? Colors.black : Colors.white,
                        ),
                        strong: GoogleFonts.poppins(
                          color: isFromUser ? Colors.black : Colors.white,
                        ),
                        em: GoogleFonts.poppins(
                          color: isFromUser ? Colors.black : Colors.white,
                        ),
                        code: GoogleFonts.poppins(
                          color: isFromUser ? Colors.black : Colors.white,
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
