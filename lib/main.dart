import 'package:billing_sytem/firebase_option.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chapa_unofficial/chapa_unofficial.dart';

import 'pages/auth/log_in.dart';
 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Chapa.configure(privateKey: "YOUR_PRIVATE_KEY");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.ptSansTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        '/': (context) => const LoginScreen(),
        '/payment': (context) => const LoginScreen(),  // Add payment screen route
      },
    );
  }
}
