import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'CartNum.dart';
import 'package:provider/provider.dart';
import '../../provider/CartProvider.dart';

class CartItem extends StatefulWidget {
  final Map item;

  @override
  _CartItemState createState() => _CartItemState();

  CartItem(this.item);
}

class _CartItemState extends State<CartItem> {
  Map _item;

  @override
  Widget build(BuildContext context) {
    _item = widget.item;
    return Container(
        height: ScreenAdapter.width(240),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          children: [
            Container(
              width: ScreenAdapter.width(80),
              child: Checkbox(
                value: _item["checked"],
                onChanged: (val) {
                  _item["checked"] = !_item["checked"];
                  context.read<CartProvider>().itemCheckedChanged();
                },
                activeColor: Colors.pink,
              ),
            ),
            Container(
              width: ScreenAdapter.width(160),
              child: Image.network(
                _item["pic"],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _item["title"],
                      maxLines: 2,
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(32)),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      _item["selectedAttr"],
                      maxLines: 1,
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(28)),
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: ScreenAdapter.width(59),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "¥${_item["price"]}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: ScreenAdapter.fontSize(32)),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CartNum(_item),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
