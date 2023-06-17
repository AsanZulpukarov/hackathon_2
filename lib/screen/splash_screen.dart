import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kodeks/screen/auth/login_screen.dart';
import 'package:kodeks/screen/menu_page.dart';

class SplashScreen extends StatefulWidget {
  final prefs;
  const SplashScreen({Key? key, required this.prefs}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 3),
            () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => widget.prefs.getString('roleKey') == null
                    ? const LoginScreen()
                    : MenuPage(widget.prefs.getString('roleKey')))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}