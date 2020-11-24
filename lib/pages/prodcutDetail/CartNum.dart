import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../../model/product_detail_model_entity.dart';

class CartNum extends StatefulWidget {
  final ProductDetailModelResult detail;

  @override
  _CartNumState createState() => _CartNumState();

  CartNum(this.detail);
}

class _CartNumState extends State<CartNum> {

  ProductDetailModelResult _detail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _detail = widget.detail;
  }

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
      onTap: () {
        if (_detail.count > 1) {
          setState(() {
            _detail.count = _detail.count - 1;
          });
        }
      },
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
      onTap: () {
        setState(() {
          _detail.count = _detail.count + 1;
        });
      },
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
      child: Text("${_detail.count}"),
    );
  }
}
