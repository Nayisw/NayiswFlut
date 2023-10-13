import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nayiswflut/components/buttons.dart';
import 'package:nayiswflut/components/squaretile.dart';
import 'package:nayiswflut/components/textfield.dart';
import 'package:nayiswflut/services/auth.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user method
  void signUserUp() async {
    //show loading screen
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign up
    try {
      // check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        // pop the loading cirle
        Navigator.pop(context);
      } else {

        // pop the loading cirle
        Navigator.pop(context);
        // show error pop up, password don't match
        showErrorMessage("Password don't match");
      }
    } on FirebaseAuthException catch (e) {

      // pop the loading cirle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code);
    }
  }

  // wrong error pop up to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurpleAccent,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 217, 217),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),

                // Custom logo using Image.asset
                Image.asset(
                  'lib/assets/icon.png',
                  width: 100,
                  height: 100,
                ),

                // let's get started
                const SizedBox(height: 25),

                Text(
                  "Let's get started!",
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),

                const SizedBox(height: 25),
                // username textfield
                TextFieldBox(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                // password textfield
                TextFieldBox(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 25),

                TextFieldBox(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                const SizedBox(height: 25),

                // sign up button
                ButtonBox(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),
                const SizedBox(height: 30),

                // or continue with google sign in buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 52.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTileBox(
                      imagePath: "lib/images/google.png", 
                      onTap: () =>AuthService().signInWithGoogle(),
                      )
                    ],
                ),
                const SizedBox(height: 30),

                // register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account??",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login now!",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
