import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:hari/class/appbarpage.dart';
import 'package:hari/class/drawer.dart';

import 'package:hari/items.dart';
import 'package:hari/pages/cartmodel.dart';
import 'package:provider/provider.dart';

import '../globale/globle.dart';
import 'cartpage.dart';
import 'detailspage.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Stream<QuerySnapshot> user =
      FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference _productss =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      // ignore: prefer_const_constructors
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBarPage(),
      ),

      body: Column(
        children: [
          const ListTile(
            title: Text(
              "House Signature",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Color(0xff2e1503),
              ),
            ),
          ),
          ImageSlideshow(
            width: double.infinity,

            height: 200,

            initialPage: 0,

            indicatorColor: Colors.blue,

            indicatorBackgroundColor: Colors.grey,

            // ignore: sort_child_properties_last
            children: [
              Image.asset(
                'asset/1.1.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'asset/1.2.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'asset/1.3.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'asset/1.4.jpg',
                fit: BoxFit.cover,
              ),
            ],
            onPageChanged: (value) {
              print('Page changed: $value');
            },

            autoPlayInterval: 3000,

            isLoop: true,
          ),
          const SizedBox(height: 10),
          const ListTile(
            title: Text("Menu...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Color(0xff2e1503),
                )),
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1,
              child: StreamBuilder<QuerySnapshot>(
                stream: user,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (streamSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        final item = Item(
                            id: documentSnapshot.id.toString(),
                            name: documentSnapshot['name'],
                            price: documentSnapshot['price']);
                        return Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            documentSnapshot['image']))),
                              ),
                              Column(
                                children: [
                                  Text(
                                    documentSnapshot['name'].toString(),
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    documentSnapshot['price'],
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Consumer<CartModel>(
                                    builder: (context, cart, child) {
                                      final checked = cart.getItems
                                              .where((element) =>
                                                  element.id ==
                                                  documentSnapshot.id)
                                              .toString() !=
                                          "()";
                                      return Checkbox(
                                        value: checked,
                                        onChanged: (val) {
                                          setState(() {
                                            if (val == true)
                                              // ignore: curly_braces_in_flow_control_structures
                                              cart.add(item);
                                            else
                                              cart.remove(item);
                                          });
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 80),
                                child: ElevatedButton(
                                    style: ButtonStyle(backgroundColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed))
                                          return const Color(0xff65350f);
                                        return Colors.black;
                                      },
                                    )),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsPage(
                                              id: documentSnapshot['id'],
                                              name: documentSnapshot['name'],
                                              price: documentSnapshot['price'],
                                              image: documentSnapshot['image']),
                                        ),
                                      );
                                    },
                                    child: const Text("Details")),
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
