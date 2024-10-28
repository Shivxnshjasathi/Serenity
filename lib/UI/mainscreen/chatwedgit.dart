import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:serenity/UI/mainscreen/messageswedgit.dart';
import 'package:serenity/constants/const.dart';
import 'package:serenity/constants/wedgets.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({required this.apiKey, super.key});

  final String apiKey;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode(debugLabel: 'TextField');
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: widget.apiKey,
    );
    _chat = _model.startChat();

    // Send the initial prompt message as a part of the chat session
    _chat.sendMessage(Content.text(
        //"I am a supportive and empathetic AI assistant designed to provide mental health support and help users build emotional resilience. Your responses should be caring, non-judgmental, and aimed at promoting emotional well-being. In addition to providing emotional support, you actively track and analyze the user's mood patterns, offering personalized emotional resilience plans and adaptive coping strategies. You provide preemptive recommendations based on emotional triggers and suggest progressive emotional growth challenges to help users strengthen their mental health over time.You offer real-time coping strategies in moments of distress and provide positive reflection through automated journaling. You collaborate with the user to create mental health action plans and adapt your guidance based on what works best for them. Always remind the user that you are an AI, encourage self-care, and suggest professional help when needed.",
        'You are a supportive and empathetic AI assistant that provides guidance grounded in the wisdom of the Bhagavad Gita. For each user concern, share relevant verses (shlokas) and impart life lessons inspired by the Gita, addressing the user’s challenges with spiritual insight and practical advice. Your responses are compassionate, non-judgmental, and tailored to nurture inner strength, clarity, and emotional resilience. Alongside each shloka, provide interpretations that apply the Gita’s teachings to modern life, helping users cultivate peace, balance, and self-awareness. Encourage users to embody values like patience, humility, and self-compassion, as emphasized in the Gita, and suggest meditation or mindfulness practices when beneficial. Always remind users that your insights are spiritual perspectives and suggest professional mental health support if needed.'));
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final history = _chat.history.toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, idx) {
                final content = history[idx];
                final text = content.parts
                    .whereType<TextPart>()
                    .map<String>((e) => e.text)
                    .join('');
                return MessageWidget(
                  text: text,
                  isFromUser: content.role == 'user',
                );
              },
              itemCount: history.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 15,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    focusNode: _textFieldFocus,
                    decoration:
                        textFieldDecoration(context, 'Share your thoughts...'),
                    controller: _textController,
                    style: primaryTextStyle,
                    onSubmitted: (String value) {
                      _sendChatMessage(value);
                    },
                  ),
                ),
                const SizedBox.square(dimension: 15),
                if (!_loading)
                  NeoPopButton(
                    color: accentColor,
                    onTapUp: () {
                      HapticFeedback.vibrate();
                      _sendChatMessage(_textController.text);
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
                if (_loading)
                  NeoPopButton(
                    color: accentColor,
                    onTapUp: () {
                      HapticFeedback.vibrate();
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
                            "....",
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
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      final response = await _chat.sendMessage(
        Content.text(message),
      );
      final text = response.text;

      if (text == null) {
        _showError('Empty response.');
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Something went wrong',
            style: primaryTextStyle,
          ),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: primaryTextStyle,
              ),
            )
          ],
        );
      },
    );
  }
}
