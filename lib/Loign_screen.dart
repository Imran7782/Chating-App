import 'package:firebase_auth/firebase_auth.dart';
import 'package:flasapp/Chat_screen.dart';
import 'package:flasapp/Componnet.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoignScreen extends StatefulWidget {
  const LoignScreen({super.key});
  static String id = 'Login_screen';
  @override
  State<LoignScreen> createState() => _LoignScreenState();
}

class _LoignScreenState extends State<LoignScreen> {
  final auth = FirebaseAuth.instance;
  late String email;
  late String Password;
  late bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade300,
          title: const Text(
            "Let's Login",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Hero(
                tag: 'logo',
                child: Container(
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
              helperT: "Enter YOur Email",
              hintT: "Email",
              icon: const Icon(
                Icons.email,
                color: Colors.black,
              ),
              onChanged: (value) {
                email = value;
              },
            ),
            EmailAndPasswordTextField(
              helperT: "Enter your Password",
              hintT: "Pssword",
              icon: const Icon(
                Icons.password,
                color: Colors.black,
              ),
              onChanged: (value) {
                Password = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            LoginAndRegisterButton(
                color: Colors.blue.shade300,
                onPressed: () async {
                  debugPrint("user wnat login in with email : $email");
                   debugPrint("user wnat login in with password : $Password");
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    if (email.isNotEmpty && Password.isNotEmpty) {
                      final user = await auth.signInWithEmailAndPassword(
                          email: email, password: Password);
                      if (user.user !=null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    }else{
                      setState(() {
                        showSpinner=false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter correcet credtional")),
                      );
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    setState(() {
                      showSpinner = false;
                       
                    });
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("$e")));
                   
                  }
                },
                text: "Login")
          ]),
        ));
  }
}
