import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hari/globale/globle.dart';

import 'package:hari/widget/dilog.dart';
import 'package:hari/widget/loding_dilog.dart';

import 'Ragester.dart';
import 'forgot.dart';
import 'homepage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _isVisible = false;

  formvalidation() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      loginNow();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please write email/password",
            );
          });
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingDialog(
            message: "Checking Credentials",
          );
        });

    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((auth) {
      currentUser = auth.user!;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });
    if (currentUser != null) {
      readDataAndSetDataLocaly(currentUser!).then((value) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const Home()));
      });
    }
  }

  Future readDataAndSetDataLocaly(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      await sharedPreferences!.setString("uid", currentUser.uid);
      await sharedPreferences!
          .setString("email", snapshot.data()!["sellerEmail"]);
      await sharedPreferences!
          .setString("name", snapshot.data()!["sellerName"]);
      await sharedPreferences!
          .setString("photoUrl", snapshot.data()!["sellerAvtarUrl"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/3.png"), fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 170),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Welcome...",
                        style: TextStyle(
                          color: Color.fromARGB(255, 218, 255, 219),
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color:
                          Color.fromARGB(255, 173, 152, 152).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color:
                          Color.fromARGB(255, 173, 152, 152).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: _isVisible ? false : true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: Icon(
                              _isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.brown,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Forgot()));
                          },
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      formvalidation();
                    },
                    child: Container(
                      height: 50,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 101, 179, 157)),
                      child: const Center(
                          child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: width * 0.8,
                  //   child: MaterialButton(
                  //     // padding:
                  //     //     EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  //     // color: Color.fromARGB(255, 101, 179, 157),
                  //     onPressed: () {
                  //       formvalidation();
                  //     },
                  //     child: Text(
                  //       "LOGIN",
                  //       style: TextStyle(fontSize: 20, color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Dont`t have an Account?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          children: [
                        TextSpan(
                            text: ' Sign up',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 183, 103, 225),
                                fontSize: 18),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()));
                              })
                      ]))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
