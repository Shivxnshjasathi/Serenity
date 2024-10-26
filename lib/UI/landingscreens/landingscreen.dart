import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';
import 'package:serenity/UI/landingscreens/notifyme.dart';
import 'package:serenity/UI/mainscreen/mainchatscreen.dart';
import 'package:serenity/constants/const.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 390,
                  color: const Color.fromARGB(255, 85, 85, 85).withOpacity(0.2),
                  child: Stack(
                    children: [
                      CustomPaint(
                        painter: GridPainter(),
                        child: Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    NeoPopButton(
                                      color: bgColor,
                                      buttonPosition: Position.center,
                                      onTapUp: () {
                                        () async {
                                          Uri uri = Uri.parse(
                                              'https://serenityai.vercel.app/');
                                          if (await canLaunchUrl(uri)) {
                                            await launchUrl(uri);
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Could not launch url')),
                                            );
                                          }
                                        };
                                        HapticFeedback.vibrate();
                                      },
                                      onTapDown: () => HapticFeedback.vibrate(),
                                      border: const Border.fromBorderSide(
                                        BorderSide(
                                            color: accentColor, width: 1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Try Web",
                                                style: GoogleFonts.poppins(
                                                  fontSize:
                                                      14, // You can adjust the size as needed
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors
                                                      .white, // Change to your desired color
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Text("Your AI Companion for Mental Wellness",
                                style: GoogleFonts.libreBaskerville(
                                  fontSize:
                                      18, // You can adjust the size as needed
                                  fontWeight: FontWeight.w400,
                                  color: Colors
                                      .white, // Change to your desired color
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Serenity uses advanced AI to provide empathetic support grounded in the wisdom of the Bhagavad Gita, helping students navigate their emotional challenges and improve mental well-being.",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white38,
                                )),
                            const SizedBox(
                              height: 45,
                            ),
                            SizedBox(
                              width: 120,
                              child: NeoPopButton(
                                color: bgColor,
                                depth: 5,
                                shadowColor: accentColor,
                                onTapUp: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Notifty(),
                                      ));
                                  HapticFeedback.vibrate();
                                },
                                onTapDown: () => HapticFeedback.vibrate(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Text(
                                    "Notifty Me ",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                                "Get notified when Serenity is available for you.",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white38,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ready to Prioritize Your Mental Health?",
                          style: GoogleFonts.libreBaskerville(
                            fontSize: 16, // You can adjust the size as needed
                            fontWeight: FontWeight.w400,
                            color: Colors.white, // Change to your desired color
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Engage in meaningful Conversations with an AI that understands and responds to your emotions.",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white38,
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                  8.0), // Optional padding for better layout
                              child: Lottie.network(
                                'https://lottie.host/5701d836-3809-491f-ac3e-caf440d0025a/6vvCMnbls8.json',
                                width: 200,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                          " Hello! I'm your companion. How can I support you today ?",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white38,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            NeoPopTiltedButton(
              isFloating: true,
              onTapUp: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChatScreen(title: 'Serenity AI'),
                    ));
              },
              decoration: const NeoPopTiltedButtonDecoration(
                color: accentColor,
                plunkColor: accentColor,
                shadowColor: Color.fromRGBO(36, 36, 36, 1),
                showShimmer: true,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 70.0,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Try Demo  ',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight
                            .w500, // You can adjust the size as needed
                        color: bgColor, // Change to your desired color
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: bgColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
