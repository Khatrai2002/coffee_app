import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hari/globale/globle.dart';
import 'homepage.dart';
import 'login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _splashState();
}

class _splashState extends State<SplashPage> {
  startTimer() {
    Timer(const Duration(seconds: 1), () {
      if (firebaseAuth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 214, 179),
      body: Column(
        children: [
          const Image(
            image: AssetImage("asset/28.png"),
          ),
          const Text(
            "👋 Hello We're\nBasic Coffee Co. ",
            style: TextStyle(
              fontSize: 32,
              color: Color(0xff6f4436),
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Center(
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Get Started > ",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6f4436),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
