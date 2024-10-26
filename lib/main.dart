import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:serenity/UI/LandingPage.dart';
import 'package:serenity/UI/splash.dart';
import 'package:serenity/constants/const.dart';
import 'package:url_launcher/link.dart';

void main() {
  runApp(const GenerativeAISample());
}

class GenerativeAISample extends StatelessWidget {
  const GenerativeAISample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Serenity AI',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: const Color.fromARGB(255, 171, 222, 244),
          ),
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}

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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(
                                8.0), // Optional padding for better layout
                            child: Lottie.network(
                              'https://lottie.host/0cc6c8e8-3f15-4ec7-8925-b5cbed3a43a7/xFUsBluOqj.json',
                              width: 200,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
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
                            "Always available to listen and provide support, you need it.",
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

class ApiKeyWidget extends StatelessWidget {
  ApiKeyWidget({required this.onSubmitted, super.key});

  final ValueChanged<String> onSubmitted;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'To use the Gemini API, you\'ll need an API key. '
              'If you don\'t already have one, '
              'create a key in Google AI Studio.',
              style: primaryTextStyle,
            ),
            const SizedBox(height: 8),
            Link(
              uri: Uri.https('makersuite.google.com', '/app/apikey'),
              target: LinkTarget.blank,
              builder: (context, followLink) => TextButton(
                onPressed: followLink,
                child: Text(
                  'Get an API Key',
                  style: primaryTextStyle,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration:
                        textFieldDecoration(context, 'Enter your API key'),
                    controller: _textController,
                    onSubmitted: (value) {
                      onSubmitted(value);
                    },
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    onSubmitted(_textController.value.text);
                  },
                  child: Text(
                    'Submit',
                    style: primaryTextStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
            'You are a supportive and empathetic AI assistant that provides guidance grounded in the wisdom of the Bhagavad Gita. For each user concern, share relevant verses (shlokas) and impart life lessons inspired by the Gita, addressing the user’s challenges with spiritual insight and practical advice. Your responses are compassionate, non-judgmental, and tailored to nurture inner strength, clarity, and emotional resilience. Alongside each shloka, provide interpretations that apply the Gita’s teachings to modern life, helping users cultivate peace, balance, and self-awareness. Encourage users to embody values like patience, humility, and self-compassion, as emphasized in the Gita, and suggest meditation or mindfulness practices when beneficial. Always remind users that your insights are spiritual perspectives and suggest professional mental health support if needed.')
        // 'You are a supportive and empathetic AI assistant designed to provide mental health support and help users build emotional resilience. Your responses should be caring, non-judgmental, and aimed at promoting emotional well-being. In addition to providing emotional support, you actively track and analyze the user\'s mood patterns, offering personalized emotional resilience plans and adaptive coping strategies. You provide preemptive recommendations based on emotional triggers and suggest progressive emotional growth challenges to help users strengthen their mental health over time. You offer real-time coping strategies in moments of distress and provide positive reflection through automated journaling. You collaborate with the user to create mental health action plans and adapt your guidance based on what works best for them. Always remind the user that you are an AI, encourage self-care, and suggest professional help when needed.'),
        );
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

InputDecoration textFieldDecoration(BuildContext context, String hintText) =>
    InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(0),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(0),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );

class GridPainter extends CustomPainter {
  final double gridSize = 30.0; // Size of each grid cell

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.2) // Light color for aesthetics
      ..strokeWidth = 0.5;

    for (double x = 0; x < size.width; x += gridSize) {
      // Draw vertical lines
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += gridSize) {
      // Draw horizontal lines
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
