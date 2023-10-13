import 'package:flutter/material.dart';
import 'package:nayiswflut/pages/login_page.dart';
import 'package:nayiswflut/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // initially show login page
  bool showLoginpage = true;

  // toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginpage = !showLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginpage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
