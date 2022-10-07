import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hari/globale/globle.dart';

import 'package:hari/widget/dilog.dart';
import 'package:hari/widget/loding_dilog.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_storage/firebase_storage.dart' as fStorage;

import 'homepage.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  var _isVisible = false;

  Position? position;
  List<Placemark>? placeMarks;

  String sellerImageUrl = " ";
  String completeAddress = " ";

  getCurrentLocation() async {
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position = newPosition;
    placeMarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    Placemark pMark = placeMarks![0];

    completeAddress =
        '${pMark.subThoroughfare} ${pMark.subThoroughfare},${pMark.subLocality} ${pMark.locality},${pMark.subAdministrativeArea},${pMark.administrativeArea} ${pMark.postalCode},${pMark.country}';

    locationController.text = completeAddress;
  }

  Future<void> formValidation() async {
    if (passwordController.text == confirmpasswordController.text) {
      if (confirmpasswordController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          nameController.text.isNotEmpty) {
        showDialog(
            context: context,
            builder: (c) {
              return LoadingDialog(
                message: "Regestering Account",
              );
            });
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        fStorage.Reference reference = fStorage.FirebaseStorage.instance
            .ref()
            .child("Sellers")
            .child(fileName);

        authenticateSellerAndSignUp();
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message:
                    "password write the  complete required info for Regestration.",
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "password do not match",
            );
          });
    }
  }
  // }

  void authenticateSellerAndSignUp() async {
    User? currentUser;

    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
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
      saveDataToFireStore(currentUser!).then((value) {
        Navigator.pop(context);
        Route newRoute = MaterialPageRoute(builder: (c) => const Home());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFireStore(User currentUser) async {
    FirebaseFirestore.instance.collection("sellers").doc(currentUser.uid).set({
      "sellerUID": currentUser.uid,
      "sellerEmail": currentUser.email,
      "sellerName": nameController.text.trim(),
      "sellerAvtarUrl": sellerImageUrl,
      "stauus": "approved",
      "earnings": 0.0,
      "lat": position?.latitude,
      "lng": position?.longitude,
    });

    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", sellerImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/2.png"), fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Create Account",
                        style: TextStyle(
                          color: Color.fromARGB(255, 218, 255, 219),
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 173, 152, 152)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_rounded),
                          border: InputBorder.none,
                          hintText: 'Name',
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
                      color: const Color.fromARGB(255, 173, 152, 152)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none,
                          hintText: 'E-mail',
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
                      color: const Color.fromARGB(255, 173, 152, 152)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: _isVisible ? false : true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
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
                              color: Colors.grey,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: ' Password',
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
                      color: const Color.fromARGB(255, 173, 152, 152)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: confirmpasswordController,
                        obscureText: _isVisible ? false : true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
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
                              color: Colors.grey,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () {
                      formValidation();
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
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Already have an Account?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          children: [
                        TextSpan(
                            text: ' Sign in',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 183, 103, 225),
                                fontSize: 18),
                            recognizer: TapGestureRecognizer()
                              ..onTap = (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              }))
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
