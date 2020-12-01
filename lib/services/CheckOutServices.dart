import 'dart:convert';
import 'package:flutter/material.dart';
import '../provider/CartProvider.dart';
import 'package:provider/provider.dart';

class CheckOutServices {
  //计算总价
  static String getAllPrice(List<Map> checkOutList) {
    var tempAllPrice = 0.0;
    for (var i = 0; i < checkOutList.length; i++) {
      tempAllPrice += checkOutList[i]["price"] * checkOutList[i]["count"];
    }
    return tempAllPrice.toStringAsFixed(1);
  }

  static void removePaidCartItem(BuildContext context) async {
    context.read<CartProvider>().removeCartItem();
  }
}