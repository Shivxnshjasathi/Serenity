import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serenity/UI/landingscreens/landingscreen.dart';
import 'package:serenity/constants/const.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoggingIn = false;
  bool _isSigningUp = false;

  @override
  void initState() {
    super.initState();
    _checkUserLoggedIn();
  }

  Future<void> _checkUserLoggedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User already logged in, navigate to landing screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingPage()),
      );
    }
  }

  Future<void> _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    setState(() {
      _isLoggingIn = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Successful login, navigate to the landing screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          'Login successful!',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        )),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingPage()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle login errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          'Error: ${e.message}',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        )),
      );
    } finally {
      setState(() {
        _isLoggingIn = false;
      });
    }
  }

  Future<void> _signUp() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    setState(() {
      _isSigningUp = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Successful sign up, show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          'Sign-up successful! Please log in.',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        )),
      );
    } on FirebaseAuthException catch (e) {
      // Handle sign-up errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          'Error: ${e.message}',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        )),
      );
    } finally {
      setState(() {
        _isSigningUp = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: 500,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Lottie.network(
                                  //'https://lottie.host/af564d77-ec53-4c7a-bc07-a6d46f718c0e/sXX4N5GafR.json',
                                  'https://lottie.host/0f570bf4-a30a-4e32-a817-4d147a1cd568/zFNnKHvnwB.json',
                                  width: 250,
                                  height: 250,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Welcome to SerenityAI",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white38,
                                  )),
                              const SizedBox(height: 10),
                              Text(
                                  "Log in to your account \nor create a new one",
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
                        Center(
                          child: TextField(
                            controller: _emailController,
                            cursorColor: Colors.black,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                borderSide:
                                    BorderSide(width: 2, color: accentColor),
                              ),
                              fillColor: Colors.white,
                              suffixIcon:
                                  const Icon(Icons.email, color: Colors.black),
                              labelText: 'Email',
                              labelStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                              ),
                              hintText: 'Type your Email here...',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: TextField(
                            controller: _passwordController,
                            cursorColor: Colors.black,
                            obscureText: true,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                borderSide:
                                    BorderSide(width: 2, color: accentColor),
                              ),
                              suffixIcon:
                                  const Icon(Icons.lock, color: Colors.black),
                              labelText: 'Password',
                              labelStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                              ),
                              hintText: 'Type your Password here...',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Made with ❤️ by Shivansh",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    NeoPopButton(
                      color: accentColor,
                      onTapUp: () {
                        _login(); // Call the login function
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
                            if (_isLoggingIn)
                              const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            else
                              Text("Log In",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                  )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    NeoPopButton(
                      color: Colors.black,
                      onTapUp: () {
                        _signUp(); // Call the sign-up function
                        HapticFeedback.vibrate();
                      },
                      onTapDown: () => HapticFeedback.vibrate(),
                      parentColor: Colors.blue,
                      buttonPosition: Position.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_isSigningUp)
                              const CircularProgressIndicator()
                            else
                              Text("Sign Up",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
