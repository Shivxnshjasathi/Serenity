import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:serenity/UI/LandingPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController with 2 seconds duration
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Scale animation: start from 0.2 (small) to 1 (normal size)
    _scaleAnimation = Tween<double>(begin: 0.2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Smooth in and out effect
      ),
    );

    // Opacity animation: start from 0 (invisible) to 1 (fully visible)
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn, // Slow fade-in effect
      ),
    );

    // Start the animations
    _controller.forward();

    // Navigate to Home screen after 3 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LandingPage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black, // Netflix-like black background
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("SerenityAI",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white38,
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(
                      8.0), // Optional padding for better layout
                  child: Lottie.network(
                    'https://lottie.host/ac1ba678-0208-4cea-8ee0-b1a2f14aa6c0/QrWskiOzHl.json',
                    width: 500,
                    height: 600,
                    fit: BoxFit.contain,
                  ),
                ),
                Text("Welcome To The Club",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white38,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text("Your Personal Mental,\nHealth Assistant",
                    style: GoogleFonts.libreBaskerville(
                      fontSize: 18, // You can adjust the size as needed
                      fontWeight: FontWeight.w400,
                      color: Colors.white, // Change to your desired color
                    )),
              ],
            ),
          ),
        ));
  }
}
