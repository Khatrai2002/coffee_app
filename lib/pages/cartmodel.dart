import 'dart:collection';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  List<Item> get getItems => _items;

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}

class Item {
  final String? id;
  final String? name;
  final String? price;
  final String? image;

  Item({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.image,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          image == other.image;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ price.hashCode ^ image.hashCode;
}
