import 'package:flutter/material.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, "/");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome to our store")),
      backgroundColor: const Color.fromARGB(255, 92, 139, 224),
      body: const Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage("lib/assets/images/image.png"),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
