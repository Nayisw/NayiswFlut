import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nayiswflut/components/buttons.dart';
import 'package:nayiswflut/components/squaretile.dart';
import 'package:nayiswflut/components/textfield.dart';
import 'package:nayiswflut/pages/forgotPassword.dart';
import 'package:nayiswflut/services/auth.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user method
  void signUserIn() async {
    //show loading screen
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign in
    try {
      
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      // pop the loading cirle
      Navigator.pop(context);
      
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
                const SizedBox(height: 50),

                // Custom logo using Image.asset
                Image.asset(
                  'lib/assets/icon.png',
                  width: 100,
                  height: 100,
                ),


                // Welcome back
                const SizedBox(height: 50),

                Text(
                  "Welcome Back!",
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
                // forgot password?

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ForgotPasswordPage();
                        }));
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // sign in button
                ButtonBox(
                  text: "Sign In",
                  onTap: signUserIn,
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
                      onTap: () => AuthService().signInWithGoogle(),
                    )
                  ],
                ),
                const SizedBox(height: 30),

                // register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register now!",
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
