import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/CartProvider.dart';
import '../../services/ScreenAdapter.dart';

class CartNum extends StatefulWidget {
  final Map item;

  @override
  _CartNumState createState() => _CartNumState();

  CartNum(this.item);
}

class _CartNumState extends State<CartNum> {

  Map _item;

  @override
  Widget build(BuildContext context) {
    _item = widget.item;
    return Container(
      width: ScreenAdapter.width(188),
      decoration:
          BoxDecoration(border: Border.all(width: ScreenAdapter.width(2), color: Colors.black12)),
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
        width: ScreenAdapter.width(55),
        height: ScreenAdapter.width(55),
        child: Text("-"),
      ),
      onTap: () {
        if (_item["count"] > 1) {
          _item["count"] = _item["count"] - 1;
          context.read<CartProvider>().itemCountChanged();
        }
      },
    );
  }

  //右侧按钮
  Widget _rightBtn() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(55),
        height: ScreenAdapter.width(55),
        child: Text("+"),
      ),
      onTap: () {
        _item["count"] = _item["count"] + 1;
        context.read<CartProvider>().itemCountChanged();
      },
    );
  }

  //中间区域
  Widget _centerArea() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(width: ScreenAdapter.width(2), color: Colors.black12),
              right: BorderSide(width: ScreenAdapter.width(2), color: Colors.black12))),
      alignment: Alignment.center,
      width: ScreenAdapter.width(70),
      height: ScreenAdapter.width(55),
      child: Text("${_item["count"]}"),
    );
  }
}
