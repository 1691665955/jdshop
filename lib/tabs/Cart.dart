import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/ScreenAdapter.dart';
import '../provider/CartProvider.dart';
import '../pages/cart/CartItem.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
        actions: [
          IconButton(
            icon: Icon(Icons.launch),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              CartItem(),
              CartItem(),
            ],
          ),
          Positioned(
            bottom: 0,
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.width(78),
            child: Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.width(78),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(top: BorderSide(width: 1, color: Colors.black12))),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: ScreenAdapter.width(80),
                            child: Checkbox(value: true, activeColor: Colors.red, onChanged: (val) {}),
                          ),
                          Text("全选")
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      child: Text(
                        "结算",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.red,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
