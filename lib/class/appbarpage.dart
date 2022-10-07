import 'package:flutter/material.dart';
import 'package:hari/globale/globle.dart';

import '../pages/cartpage.dart';

class AppBarPage extends StatefulWidget {
  const AppBarPage({super.key});

  @override
  State<AppBarPage> createState() => _AppbarPageState();
}

class _AppbarPageState extends State<AppBarPage> {
  @override
  Widget build(BuildContext context) {
    return

        

        PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: AppBar(
          title: Text(sharedPreferences!.getString("name")!),
          backgroundColor: const Color(0xff65350f),
          actions: [
            IconButton(
                onPressed: () async {
                  var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartList(),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart))
          ]),
    );
    ;
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
