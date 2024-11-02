import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:serenity/constants/const.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  bool _addUserDetailsLoading = false;

  @override
  void initState() {
    super.initState();
    // Get the current user
    _currentUser = _auth.currentUser;
    if (_currentUser != null) {
      _emailController.text = _currentUser!.email ?? '';
      // Load existing user details when the screen initializes
      _loadUserDetails();
    }
  }

  void _loadUserDetails() {
    if (_currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .collection('user_details')
          .snapshots()
          .listen((snapshot) {
        for (var doc in snapshot.docs) {
          _nameController.text = doc['name'] ?? '';
          _phoneController.text = doc['phone'] ?? '';
          _ageController.text = doc['age'] ?? '';
          _genderController.text = doc['gender'] ?? '';
        }
      });
    }
  }

  void _addUserDetails() {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String phone = _phoneController.text;
    final String age = _ageController.text;
    final String gender = _genderController.text;

    if (_currentUser != null &&
        name.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid) // Use the current user's ID
          .collection('user_details')
          .doc('details') // Use a specific document for user details
          .set({
        'name': name,
        'email': email,
        'phone': phone,
        'age': age,
        'gender': gender,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((value) {
        // Clear the text fields after saving
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: bgColor,
            content: Text(
              'User details updated successfully!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: bgColor,
          content: Text('Failed to update user details: $error',
              style: const TextStyle(color: Colors.white)),
        ));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: bgColor,
        content: Text('Please fill in all fields.',
            style: TextStyle(color: Colors.white)),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
        'Profile',
        style: primaryTextStyle,
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 5,
              color: accentColor,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    cursorColor: Colors.black,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: accentColor),
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      prefixIcon: const Icon(Icons.person, color: Colors.black),
                      labelText: 'Name',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      hintText: 'Type your Name here...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    cursorColor: Colors.black,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: accentColor),
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      prefixIcon: const Icon(Icons.email, color: Colors.black),
                      labelText: 'Email',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      hintText: 'Type your Email here...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _phoneController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.phone,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: accentColor),
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      prefixIcon: const Icon(Icons.phone, color: Colors.black),
                      labelText: 'Phone',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      hintText: 'Type your Phone number here...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _ageController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.phone,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: accentColor),
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      prefixIcon: const Icon(Icons.face, color: Colors.black),
                      labelText: 'Age',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      hintText: 'Type your Age number here...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _genderController,
                    cursorColor: Colors.black,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: accentColor),
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      prefixIcon: const Icon(Icons.male, color: Colors.black),
                      labelText: 'Gender',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      hintText: 'Type your Gender here...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Note: Please Click on the fields to update your details.',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  NeoPopButton(
                    color: Colors.black,
                    onTapUp: () {
                      _addUserDetails(); // Call the sign-up function
                      HapticFeedback.vibrate();
                    },
                    onTapDown: () => HapticFeedback.vibrate(),
                    shadowColor: accentColor,
                    buttonPosition: Position.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_addUserDetailsLoading)
                            const CircularProgressIndicator(
                              color: accentColor,
                            )
                          else
                            Text("Update Details",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 12,
                                )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Lottie.asset(
                      'assets/profile.json',
                      width: 350,
                      height: 350,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
