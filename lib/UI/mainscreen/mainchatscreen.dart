import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serenity/UI/mainscreen/apistatus.dart';
import 'package:serenity/UI/mainscreen/chatwedgit.dart';
import 'package:serenity/constants/const.dart';
import 'package:serenity/constants/wedgets.dart';
import 'package:serenity/main.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title});

  final String title;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Directly assign the API key
  String apiKey = 'AIzaSyAPHtUCHKOZ2YAOOlPETWaVFaBAoVKhs6U';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Row(
          children: [
            Text(
              widget.title,
              style: primaryTextStyle,
            ),
          ],
        ),
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
                        Text("How can I support you today ?",
                            style: GoogleFonts.libreBaskerville(
                              fontSize: 16, // You can adjust the size as needed
                              fontWeight: FontWeight.w400,
                              color:
                                  Colors.white, // Change to your desired color
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
                        // Padding(
                        //   padding: const EdgeInsets.all(
                        //       8.0), // Optional padding for better layout
                        //   child: Lottie.network(
                        //     'https://lottie.host/0cc6c8e8-3f15-4ec7-8925-b5cbed3a43a7/xFUsBluOqj.json',
                        //     width: 200,
                        //     height: 200,
                        //     fit: BoxFit.contain,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Container(),
                ],
              )),
          apiKey.isNotEmpty
              ? ChatWidget(apiKey: apiKey)
              : ApiKeyWidget(onSubmitted: (key) {
                  setState(() => apiKey = key);
                }),
        ],
      ),
    );
  }
}
