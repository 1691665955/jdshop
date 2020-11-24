import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {

  List _cartList = [];

  List get cartList => _cartList;

}