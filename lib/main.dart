import 'package:flutter/material.dart';
import 'package:get_to_know_thiana/pages/landing.dart';
import 'package:get_to_know_thiana/style/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBC2qsC4UzFpAQ2tp0OfJnFgXy75w2HKTs",
      authDomain: "ai-chat-app-c4659.firebaseapp.com",
      databaseURL: "https://ai-chat-app-c4659-default-rtdb.asia-southeast1.firebasedatabase.app",
      projectId: "ai-chat-app-c4659",
      storageBucket: "ai-chat-app-c4659.appspot.com",
      messagingSenderId: "288664481689",
      appId: "1:288664481689:web:579d783f883014c701ed08",
      measurementId: "G-1YLRSM3596"
    ),

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MaterialTheme materialTheme = MaterialTheme(ThemeData.light().textTheme);
    return MaterialApp(
      title: 'Get to Know Thiana',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      themeMode: ThemeMode.system,
      highContrastTheme: materialTheme.lightHighContrast(),
      highContrastDarkTheme: materialTheme.darkHighContrast(),
      home: const LandingPage(),
    );
  }
}
