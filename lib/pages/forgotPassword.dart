import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nayiswflut/components/textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);
  @override
  State<ForgotPasswordPage> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
          showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Password reset link sent to your email!")
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString())
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 236, 220, 220),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
                "Please enter your email! We'll send you a password reset Link",
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 10),
          TextFieldBox(
            controller: emailController,
            hintText: "Email",
            obscureText: false,
          ),
          const SizedBox(height: 10),
          MaterialButton(
            onPressed: () {
              passwordReset(); // Remove the parentheses here
            },
            color: const Color.fromARGB(255, 236, 220, 220),
            child: const Text("Reset Password"),
          ),
        ],
      ),
    );
  }
}
