import 'dart:async';

import 'package:bored_app/home.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void preCacheImageAsset() async {
    await precacheImage(
        const AssetImage('assets/images/splashscreen.png'),
        context);
  }

  @override
  void initState() {
    super.initState();
    preCacheImageAsset();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(75, 154, 150, 100),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splashscreen.png',
                height: 285, width: 325),
            const SizedBox(
              height: 20,
            ),
            JumpingDots(
              radius: 10,
              color: Colors.white,
              animationDuration: const Duration(milliseconds: 200),
            ),
            
          ],
        ),
      ),
    );
  }
}
