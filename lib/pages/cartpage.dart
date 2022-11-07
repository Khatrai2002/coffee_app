import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hari/pages/cartmodel.dart';
import 'package:provider/provider.dart';

class CartList extends StatefulWidget {
  const CartList({
    Key? key,
  }) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  CollectionReference _productss =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          actions:const [
            Center(
              child: Padding(
                padding:  EdgeInsets.all(8.0),
              ),
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: cart.getItems.length,
            itemBuilder: (
              context,
              index,
            ) {
              return Dismissible(
                key:const Key('hello'),
                background:
                    Container(color: Colors.red, child:const Icon(Icons.delete)),
                secondaryBackground: Container(
                    color: Colors.green, child: const Icon(Icons.arrow_back_ios)),
                resizeDuration:const Duration(seconds: 5),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                                image: NetworkImage(
                                  "${cart.getItems[index].image}",
                                ),
                                fit: BoxFit.cover)),
                      ),
                      Column(
                        children: [
                          Text(
                            "${cart.getItems[index].name}",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${cart.getItems[index].price}",
                            style: const TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
