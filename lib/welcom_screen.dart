import 'package:animated_text_kit/animated_text_kit.dart';
import 'Componnet.dart';
import 'package:flasapp/Loign_screen.dart';
import 'package:flasapp/Registration_screen.dart';
import 'package:flutter/material.dart';

const styleK =
    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 35);

class WelcomScreen extends StatefulWidget {
  const WelcomScreen({super.key});
  static String id = 'welcom_screen';
  @override
  State<WelcomScreen> createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Animation animation1;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation1 = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    animation =
        ColorTween(begin: Colors.grey, end: Colors.white).animate(controller);

    controller.forward();
    controller.addListener(
      () {
        setState(() {});
        print(animation.value);
      },
    );
    // animation.addStatusListener((status) {

    //     if (status==AnimationStatus.completed) {
    //       controller.reverse();
    //   }else if(status==AnimationStatus.dismissed){
    //       controller.forward();
    //   }

    //   print(status);
    // },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text(
          "Welcom To Chating App",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.grey.shade800),
        ),
      ),
      backgroundColor: animation.value,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    width: animation1.value * 100,
                    child: const Image(
                      image: AssetImage("assets/logo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Row(children: [
                    // Text("Flash ",style: styleK,),
                    AnimatedTextKit(
                        isRepeatingAnimation: true,
                        displayFullTextOnTap: true,
                        onFinished: () {
                          print("Finished");
                        },
                        pause: const Duration(milliseconds: 5),
                        totalRepeatCount: 4,
                        animatedTexts: [
                          ColorizeAnimatedText("Flash Chating App",
                              textStyle: styleK,
                              colors: [
                                Colors.grey.shade600,
                                Colors.red,
                                Colors.blue,
                                Colors.deepPurple
                              ])
                        ]),
                  ]),
                )
              ],
            ),
          ),
        
          LoginAndRegisterButton(
            color: Colors.blue.shade400, onPressed: () {
            Navigator.pushNamed(context, LoignScreen.id);} ,text: "Login")
     ,
           
          const SizedBox(
            height: 20,
          ),
       

       LoginAndRegisterButton(color: Colors.deepPurple.shade400, onPressed: () {
          Navigator.pushNamed(context, RegistrationScreen.id);
        }, text: "Register")
         
         
        ],
      ),
    );
  }
}
