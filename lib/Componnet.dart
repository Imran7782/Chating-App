import 'package:flutter/material.dart';

// Button Widget
class LoginAndRegisterButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;

   LoginAndRegisterButton({
    required this.color,
    required this.onPressed,
    required this.text,
 
  }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: MaterialButton(
        height: 40,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: color,
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ),
    );
  }
}

// Email and Password TextField Widget
class EmailAndPasswordTextField extends StatelessWidget {
  final String hintT;
  final String helperT;
  final Icon icon;
  final Function(String)? onChanged; // Accepts String

   EmailAndPasswordTextField({
    required this.helperT,
    required this.hintT,
    required this.icon,
    required this.onChanged
   
  }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(1),
        height: 60,
        child: TextField(
          onChanged: onChanged, // Now properly takes a String input
          style: const TextStyle(color: Colors.black),
          // obscureText: true,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            hintText: hintT,
            helperText: helperT,
            helperStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            prefixIcon: icon,
            fillColor: Colors.white70,
            filled: true,
            contentPadding: const EdgeInsets.all(1), // Reduce padding
          ),
        ),
      ),
    );
  }
}
