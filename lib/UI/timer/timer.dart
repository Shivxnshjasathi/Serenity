import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:serenity/constants/const.dart';

class PomodoroScreen extends StatefulWidget {
  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  static const int pomodoroDuration = 25 * 60; // 25 minutes
  static const int shortBreakDuration = 5 * 60; // 5 minutes
  static const int longBreakDuration = 30 * 60; // 30 minutes

  int remainingTime = pomodoroDuration;
  Timer? _timer;
  bool isRunning = false;

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        setState(() {
          isRunning = false;
        });
        _showAlertDialog();
      }
    });
  }

  void _resetTimer() {
    setState(() {
      remainingTime = pomodoroDuration;
      isRunning = false;
    });
    _timer?.cancel();
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Time\'s Up!',
            style: GoogleFonts.poppins(),
          ),
          content: Text(
            'Take a 5-minute break and read a Bhagavad Gita shloka for inspiration!',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                          Text("What is Pomodoro ? Time management method.",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white38,
                              )),
                          const SizedBox(height: 10),
                          Text(
                              "Which breaks  work into \nmanageable intervals, allowing you to maintain focus and avoid burnout.",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Lottie.network(
                        'https://lottie.host/124dc20f-ada2-484d-9325-2898683bb538/SU9X0iPdqb.json',
                        width: 300,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Center(
                      child: Text(
                        _formatTime(remainingTime),
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 48,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NeoPopButton(
                            color: accentColor,
                            bottomShadowColor: Colors.black,
                            depth: 5,
                            onTapUp: () {
                              isRunning ? null : _startTimer();
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
                                  Text("Start",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 12,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          NeoPopButton(
                            color: Colors.black,
                            onTapUp: () {
                              _resetTimer();
                              HapticFeedback.vibrate();
                            },
                            onTapDown: () => HapticFeedback.vibrate(),
                            bottomShadowColor: accentColor,
                            depth: 5,
                            leftShadowColor: accentColor,
                            parentColor: accentColor,
                            buttonPosition: Position.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Reset",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 12,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Set a timer for 25 minutes and work on your task.\n'
                      'After 25 minutes, take a 5-minute break.\n'
                      'An alert will remind you to read a shloka.\n'
                      'After 4 breaks, take a 30-minute break.\n'
                      'Repeat the process until you complete all your tasks.',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
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
