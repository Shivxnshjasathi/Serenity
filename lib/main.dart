import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:serenity/UI/splash.dart';
import 'package:serenity/constants/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        colorScheme: const ColorScheme.dark(
          primary: Colors.black,
          onPrimary: Colors.white,
          background: Colors.black,
          surface: Colors.black,
          onSurface: Colors.white,
          secondary: Colors.black,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor:
            Colors.black, // Sets the main background color to black
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white, // Text color in the AppBar
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
