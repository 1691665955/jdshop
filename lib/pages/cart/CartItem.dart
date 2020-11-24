import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/CartProvider.dart';
import '../../services/ScreenAdapter.dart';
import 'CartNum.dart';

class CartItem extends StatefulWidget {
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenAdapter.width(200),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          children: [
            Container(
              width: ScreenAdapter.width(80),
              child: Checkbox(
                value: true,
                onChanged: (val) {},
                activeColor: Colors.pink,
              ),
            ),
            Container(
              width: ScreenAdapter.width(160),
              child: Image.network(
                "https://www.itying.com/images/flutter/list2.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "撒谎那个拼命吃撒谎那个拼命吃撒谎那个拼命吃",
                      maxLines: 2,
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "¥40",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CartNum(),
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
