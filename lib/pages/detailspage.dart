import 'package:flutter/material.dart';
import 'package:hari/class/appbarpage.dart';
import 'package:hari/class/drawer.dart';
import 'package:hari/items.dart';
import 'package:hari/pages/cartmodel.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String? name;
  final String? id;
  final String? image;
  final String? price;

  const DetailsPage({
    Key? key,
    this.name,
    this.id,
    this.image,
    this.price,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _LastState();
}

class _LastState extends State<DetailsPage> {
  int minimum = 0;
  int maximum = 10;
  int currentindex = 0;

  bool _isliked = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        // drawer: const DrawerPage(),
        // // ignore: prefer_const_constructors
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(70),
        //   child: AppBarPage(),
        // ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _isliked = !_isliked;
                        });
                      },
                      icon: Icon(Icons.favorite,
                          color: _isliked ? Colors.red : Colors.grey))
                ],
              ),
              Container(
                  height: height / 3,
                  width: width * 1,
                  child: Image.network("${widget.image}")),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    ("${widget.name}"),
                    style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color(0Xff3d251e)),
                  ),
                  const Spacer(),
                  ElevatedButton(
                      style: ButtonStyle(backgroundColor:
                          MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.black;
                          return Color(0xff65350f);
                        },
                      )),
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text("ADD ITEM")),
                ],
              ),
              const Text(
                "About This Product:       ",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff65350f)),
              ),
              const Text(
                "This is delicious coffee with lots of yummy ingridents.Its very \npopular order drink...",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0Xff888888)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 30),
                child: Row(
                  children: [
                    const Icon(
                      Icons.timer,
                      color: Color(0xffC4C4C4),
                      size: 50,
                    ),
                    Column(
                      children: const [
                        Text(
                          "Delivery Time",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0Xff3F3D56),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "25 Minutes",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0Xff888888),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      right: 120,
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: const Color(0xff65350f),
                    heroTag: null,
                    onPressed: decrement,
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "$currentindex",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    backgroundColor: const Color(0xff65350f),
                    child: Icon(Icons.add),
                    onPressed: increment,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onDoubleTap: (){
                  
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xff65350f),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Buy Now",
                      style: TextStyle(fontSize: 20, color: Color(0xffffffff)),
                    ),
                  ),
                ),
              ),
             
              
            ],
          ),
        ),
      ),
    );
  }

  void increment() {
    if (currentindex < maximum) {
      setState(
        () {
          currentindex++;
        },
      );
    }
  }

  void decrement() {
    if (currentindex > minimum) {
      setState(
        () {
          currentindex--;
        },
      );
    }
  }
}
