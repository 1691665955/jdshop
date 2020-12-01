import 'package:flutter/material.dart';

class CheckOutProvider with ChangeNotifier {
  List _checkOutList = [];//购物车结算数据
  List get checkOutList => _checkOutList;

  changeCheckOutList(list) {
    _checkOutList = list;
    notifyListeners();
  }
}