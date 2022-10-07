import 'package:flutter/material.dart';

import '../globale/globle.dart';
import '../pages/login.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffefe6dd),
      child: Column(
        children: [
          Container(
            height: 250,
            color: Color.fromARGB(255, 192, 145, 127),
            child: Padding(
              padding: const EdgeInsets.only(top: 55, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                          "asset/0.png",
                        ),
                      ),
                    ],
                  ),
                  Text(
                    sharedPreferences!.getString(
                      "name",
                    )!,
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text(
                    sharedPreferences!.getString("email")!,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
              onTap: () {
                firebaseAuth.signOut().then((value) => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const LoginScreen()))
                    });
              },
              child: const ListTile(
                leading: Icon(
                  Icons.logout,
                ),
                title: Text(
                  "Sign Out",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }
}
