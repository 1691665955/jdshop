import 'package:flutter/material.dart';
import '../services/CartServices.dart';

class CartProvider with ChangeNotifier {

  List<Map> _cartList = []; //购物车列表数据
  bool _isCheckedAll = false; //全选
  double _allPrice = 0; //总价

  List<Map> get cartList => _cartList;
  bool get isCheckedAll => _isCheckedAll;
  double get allPrice => _allPrice;

  CartProvider() {
    this.init();
  }

  Future<void> init() async {
    _cartList = await CartServices.getCartList();
    _isCheckedAll = judgeCheckedAll();
    calculateAllPrice();
  }

  //更新购物车
  void updateCartList() {
    init();
  }

  //改变购物车商品数量
  Future<void> itemCountChanged() async {
    await CartServices.saveCartList(_cartList);
    calculateAllPrice();
  }

  //全选或反选
  Future<void> checkAll(value) async {
    for (var i = 0; i < _cartList.length; i++) {
      _cartList[i]["checked"] = value;
    }
    _isCheckedAll = value;
    await CartServices.saveCartList(_cartList);
    calculateAllPrice();
  }

  //获取全选的状态
  bool judgeCheckedAll() {
    for(var i = 0; i < _cartList.length; i++) {
      if (!_cartList[i]["checked"]) {
        return false;
      }
    }
    return true;
  }

  //选中状态
  Future<void> itemCheckedChanged() async {
    _isCheckedAll = judgeCheckedAll();
    await CartServices.saveCartList(_cartList);
    calculateAllPrice();
  }

  //计算结算总价
  void calculateAllPrice() {
    double tempAllPrice = 0;
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]["checked"]) {
        tempAllPrice += _cartList[i]["price"] * _cartList[i]["count"];
      }
    }
    _allPrice = tempAllPrice;
    notifyListeners();
  }

  //删除数据
  Future<void> removeCartItem() async {
    List<Map> tempCartList = List<Map>();
    for (var i = 0; i < _cartList.length; i++) {
      if (!_cartList[i]["checked"]) {
        tempCartList.add(_cartList[i]);
      }
    }
    _cartList = tempCartList;
    await CartServices.saveCartList(tempCartList);
    calculateAllPrice();
  }

}