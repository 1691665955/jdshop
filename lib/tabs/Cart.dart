import 'package:flutter/material.dart';
import '../services/CartServices.dart';
import 'package:provider/provider.dart';
import '../services/ScreenAdapter.dart';
import '../provider/CartProvider.dart';
import '../pages/cart/CartItem.dart';
import '../provider/CheckOutProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/UserServices.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isEdit = false;
  ///结算
  doCheckOut() async {
    //判断用户有没有登录
    bool login = await UserServices.getUserLoginState();
    if (!login) {
      Fluttertoast.showToast(msg: "您还没有登录，请登录以后再去结算", gravity: ToastGravity.CENTER);
      Navigator.pushNamed(context, "/login");
      return;
    }
    //获取购物车选中的数据
    List<Map> checkOutList = await CartServices.getCheckOutList();
    //保存购物车选中的数据
    context.read<CheckOutProvider>().changeCheckOutList(checkOutList);
    //购物车有没有选中的数据
    if (checkOutList.length == 0) {
      Fluttertoast.showToast(msg: "购物车没有选中数据", gravity: ToastGravity.CENTER);
      return;
    }
    Navigator.pushNamed(context, "/checkOut");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("购物车"),
        actions: [
          IconButton(
            icon: Icon(Icons.launch),
            onPressed: () {
              setState(() {
                _isEdit = !_isEdit;
              });
            },
          )
        ],
      ),
      body: context.watch<CartProvider>().cartList.length == 0
          ? Center(
              child: Text("购物车为空"),
            )
          : Stack(
              children: [
                ListView(
                  children: [
                    Column(
                      children: context
                          .watch<CartProvider>()
                          .cartList
                          .map((cartItem) {
                        return CartItem(cartItem);
                      }).toList(),
                    ),
                    SizedBox(
                      height: 44,
                    )
                  ],
                ),
                Positioned(
                  bottom: Navigator.canPop(context)?ScreenAdapter.getBottomBarHeight():0,
                  width: ScreenAdapter.width(750),
                  height: 44,
                  child: Container(
                    width: ScreenAdapter.width(750),
                    height: 44,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(width: 1, color: Colors.black12))),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  width: ScreenAdapter.width(80),
                                  child: Checkbox(
                                      value: context
                                          .watch<CartProvider>()
                                          .isCheckedAll,
                                      activeColor: Colors.red,
                                      onChanged: (val) {
                                        //实现全选或反选
                                        context
                                            .read<CartProvider>()
                                            .checkAll(val);
                                      }),
                                ),
                                Text("全选"),
                                SizedBox(
                                  width: ScreenAdapter.width(40),
                                ),
                                _isEdit?Text(""):Text("合计："),
                                _isEdit?Text(""):Text(
                                  "¥${context.watch<CartProvider>().allPrice}",
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(right: ScreenAdapter.width(10)),
                            child: RaisedButton(
                              child: Text(
                                _isEdit ? "删除" : "结算",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.red,
                              onPressed: () {
                                if (_isEdit) {
                                  //删除
                                  context.read<CartProvider>().removeCartItem();
                                } else {
                                  doCheckOut();
                                }
                              },
                            ),
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
