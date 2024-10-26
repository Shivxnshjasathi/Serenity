import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:http/http.dart' as http;
import 'package:serenity/constants/const.dart';

class Notifty extends StatefulWidget {
  const Notifty({super.key});

  @override
  State<Notifty> createState() => _NotiftyState();
}

class _NotiftyState extends State<Notifty> {
  final TextEditingController _emailController = TextEditingController();
  bool _isSending = false;

  Future<void> _sendEmail() async {
    final String apiUrl =
        'https://your-api-endpoint.com/send-email'; // Replace with your email sending API endpoint
    final Map<String, dynamic> emailData = {
      'to': _emailController.text,
      'subject': 'Early Access Notification',
      'body':
          'Thank you for your interest! We will notify you when the app is ready.',
    };

    setState(() {
      _isSending = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(emailData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email sent successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send email.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isSending = false; // Reset sending state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Lottie.network(
                              'https://lottie.host/0f570bf4-a30a-4e32-a817-4d147a1cd568/zFNnKHvnwB.json',
                              width: 150,
                              height: 150,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Early Access Application",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white38,
                              )),
                          SizedBox(height: 10),
                          Text(
                              "Tell us your email and we \nwill notify you when the app is ready",
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: 1.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Center(
                          child: TextField(
                            controller: _emailController,
                            cursorColor: Colors.black,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: "Email",
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    NeoPopButton(
                      color: Colors.black,
                      onTapUp: () {
                        _sendEmail;
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
                            if (_isSending)
                              CircularProgressIndicator() // Show loading indicator while sending
                            else
                              Text("Agree and Notify Me",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                          ],
                        ),
                      ),
                      // Send email on button tap
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
