import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


DateTime now =DateTime.now();
String formattedDate=DateFormat("hh:mm a").format(now);
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static String id = 'Chat_screen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller=TextEditingController();
  final auth = FirebaseAuth.instance;
  late User loginedUser;
  late String data = '';
  final firestoreAuth = FirebaseFirestore.instance;
 



  Future<void> getCurrentUser() async {
    final user = auth.currentUser;
    if (user != null) {
      loginedUser = user;
      print(loginedUser.uid);
    }
  }

  // Future<void> getDataFromFirebase()async{
  //   final  messages= await firestoreAuth.collection("messages").get();

  //   for (var element in messages.docs ) {
  //     debugPrint(element.data().toString());
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentUser();
  }

  void getDataUsingStream() async {
    firestoreAuth.collection("messages").snapshots().listen(
      (snapshot) {
        for (var element in snapshot.docs) {
          debugPrint(element.data().toString());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Flash chat "),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // auth.signOut();
              // Navigator.pop(context);
              // getDataFromFirebase();
              getDataUsingStream();
            },
            icon: const Icon(
              Icons.close,
              size: 30,
              color: Colors.red,
            ),
          ),
        ],
        backgroundColor: Colors.blue.shade400,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("$now",style: TextStyle(color: const Color.fromARGB(255, 150, 148, 148),fontSize: 28),),
            StreamBuilder(
              stream: firestoreAuth.collection("messages").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator(
                    color: Colors.red,
                    backgroundColor: Colors.red,
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.red,
                    backgroundColor: Colors.red,
                  );
                }
                final messages = snapshot.data!.docs;
                List<buble> messageWigets = [];
                
                for (var message in messages) {
                  final messageT = message.get("email") ?? "unkown";
                  final currentUser=loginedUser.email;
                  final String T=message.get("Time")??"UnKown";
                 
                  final messageSender =
                      message.get("sender") ?? "unknownn sender";
            
                  final messageWiget = buble(messageSender, messageT,messageT==currentUser,T);
                  messageWigets.add(messageWiget);
                }
                return Expanded(
                  child: ListView(
                    children: messageWigets,
                  ),
                );
              },
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      enableInteractiveSelection: true,
                      selectionControls: MaterialTextSelectionControls(),
                      controller: controller,
                      onChanged: (value) {
                        data = value;
                      },
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                          hintText: "Write some thing here ...",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 20),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                  ),
                  ElevatedButton(

                      style: const ButtonStyle(
                        shape: WidgetStatePropertyAll(StarBorder.polygon(sides: 3,squash: 1)),
                        backgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
                      ),
                      onPressed: () {
                        print(formattedDate);
                        controller.clear();
                        try {
                          firestoreAuth.collection("messages").add(
                              {"email": loginedUser.email, "sender": data,"Time":formattedDate});
                        } catch (e) {
                          debugPrint("$e");
                        }
                      },
                      child: const Center(
                        child: Text(
                          "send",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class buble extends StatelessWidget {
  final IsMe;
  final messageT;
  final messageSender;
  final t;
  buble(this.messageSender,this.messageT,this.IsMe,this.t);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: IsMe ?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
       Center(child: Text("$t",style: TextStyle(color: const Color.fromARGB(255, 104, 95, 95),fontSize: 18),)),
        Text(
          messageT,
          style: TextStyle(color: const Color.fromARGB(255, 70, 64, 64)),
        ),
        Material(
            color: IsMe ? Colors.lightBlue:Colors.white,
            elevation: 10,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topLeft:Radius.circular(20)),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "$messageSender ",
                  style: TextStyle(
                      color: IsMe ?Colors.white:Colors.black ,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ))),
      ]),
    );
  }
}
