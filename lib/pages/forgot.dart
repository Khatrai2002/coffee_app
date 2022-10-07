import 'package:flutter/material.dart';
import 'package:hari/pages/login.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 80),
                child: const Text('Reset',
                    style:
                        TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.only(top: 150),
                child: const Text('Password',
                    style:
                        TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(280.0, 150.0, 0.0, 0.0),
                child: const Text(
                  '  ?',
                  style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                const Text(
                  'Enter the email address associated with your account.',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
                const TextField(
                  decoration: InputDecoration(
                      labelText: 'Enter Your Email',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                ),
                const SizedBox(height: 40.0),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: Container(
                    height: 50,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 92, 175, 198)),
                    child: const Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[],
          ),
        ],
      ),
    );
  }
}
