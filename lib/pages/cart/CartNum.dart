import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/CartProvider.dart';
import '../../services/ScreenAdapter.dart';

class CartNum extends StatefulWidget {
  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(160),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: [_leftBtn(), _centerArea(), _rightBtn()],
      ),
    );
  }

  //左侧按钮
  Widget _leftBtn() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.width(45),
        child: Text("-"),
      ),
      onTap: () {},
    );
  }

  //右侧按钮
  Widget _rightBtn() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.width(45),
        child: Text("+"),
      ),
      onTap: () {},
    );
  }

  //中间区域
  Widget _centerArea() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(width: 1, color: Colors.black12),
              right: BorderSide(width: 1, color: Colors.black12))),
      alignment: Alignment.center,
      width: ScreenAdapter.width(66),
      height: ScreenAdapter.width(45),
      child: Text("1"),
    );
  }
}
