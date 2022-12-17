import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/item.dart';

class Cart with ChangeNotifier {
  List selectedprodct = [];
  var price = 0;
  add(Item product) {
    selectedprodct.add(product);
    price += product.price.round();
    notifyListeners();
  }

  remove(Item product) {
    selectedprodct.remove(product);
    price -= product.price.round();
    notifyListeners();
  }
}
