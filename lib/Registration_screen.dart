import 'package:firebase_auth/firebase_auth.dart';
import 'package:flasapp/Chat_screen.dart';
import 'package:flasapp/Componnet.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static String id = 'Registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = "";
  String Password = "";

  final auth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text(
          "Let's Sign Up",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Hero(
                tag: 'logo',
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: const Image(
                    image: AssetImage("assets/logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            EmailAndPasswordTextField(
              helperT: "Enter Your Email",
              hintT: "Email",
              icon: const Icon(Icons.email, color: Colors.black),
              onChanged: (value) {
                email = value;
              },
            ),
            EmailAndPasswordTextField(
              helperT: "Enter your Password",
              hintT: "Password", // Fixed typo
              icon: const Icon(Icons.password, color: Colors.black),
              onChanged: (value) {
                Password = value;
              },
            ),
            const SizedBox(height: 20),
            LoginAndRegisterButton(
              color: Colors.deepPurple.shade400,
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });

                debugPrint("User Email: $email");
                debugPrint("User Password: $Password");

                try {
                  if (email.isNotEmpty && Password.isNotEmpty) {
                    final user = await auth.createUserWithEmailAndPassword(
                      email: email,
                      password: Password,
                    );

                    if (user.user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    } else {
                      setState(() {
                        showSpinner = false;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter correct credentials!"),
                        ),
                      );
                    }
                  }
                  setState(() {
                    showSpinner = false;
                  });
                } catch (e) {
                  debugPrint("Error: $e");
                  setState(() {
                    showSpinner = false;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error: $e"),
                    ),
                  );
                }
              },
              text: "Register",
            ),
          ],
        ),
      ),
    );
  }
}
