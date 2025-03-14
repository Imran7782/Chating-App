import 'package:flasapp/Chat_screen.dart';
import 'package:flasapp/Loign_screen.dart';
import 'package:flasapp/Registration_screen.dart';
import 'package:flasapp/welcom_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA-Gp68iFCnRGEfkpMeeJK5QU-S7RA7Mbk",
      authDomain: "flash-26.firebaseapp.com",
      projectId: "flash-26",
      storageBucket: "flash-26.appspot.com",
      messagingSenderId: "281440773877",
      appId: "1:281440773877:web:db3cf2864e09886ca307bc",
    ),
  );

  runApp(const First());
}

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: WelcomScreen.id,
      routes: {
        WelcomScreen.id: (context) => const WelcomScreen(),
        LoignScreen.id: (context) => const LoignScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
      },
    );
  }
}
