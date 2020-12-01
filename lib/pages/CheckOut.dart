import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import '../provider/CheckOutProvider.dart';
import '../services/UserServices.dart';
import '../services/SignServices.dart';
import '../config/Config.dart';
import 'package:dio/dio.dart';
import '../services/EventBus.dart';
import '../services/CheckOutServices.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  var _defaultAddress;
  var _activeEventBus;
  var _allPrice;

  initState() {
    super.initState();
    _getDefaultAddress();
    _allPrice = CheckOutServices.getAllPrice(
        context.read<CheckOutProvider>().checkOutList);
    _activeEventBus = eventBus.on<CheckOutEvent>().listen((event) {
      _getDefaultAddress();
    });
  }

  dispose() {
    super.dispose();
    _activeEventBus.cancel();
  }

  _getDefaultAddress() async {
    String uid = await UserServices.getUserID();
    String salt = await UserServices.getUserSalt();
    var params = {"uid": uid, "salt": salt};
    var sign = SignServices.getSign(params);
    var api = "${Config.domain}/api/oneAddressList?uid=$uid&sign=$sign";
    var result = await Dio().get(api);
    setState(() {
      _defaultAddress =
          result.data["result"].length > 0 ? result.data["result"][0] : null;
    });
  }

  Widget _checkOutItem(item) {
    return Row(
      children: [
        Container(
          width: ScreenAdapter.width(160),
          child: Image.network(
            item["pic"],
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
                  item["title"],
                  maxLines: 2,
                  style: TextStyle(fontSize: ScreenAdapter.fontSize(32)),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item["selectedAttr"],
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
                          "¥${item["price"]}",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenAdapter.fontSize(32)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("x${item["count"]}"),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("结算"),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: ScreenAdapter.height(100)),
            children: [
              Container(
                child: Column(
                  children: [
                    _defaultAddress == null
                        ? ListTile(
                            leading: Icon(Icons.add_location),
                            title: Center(
                              child: Text("请添加收货地址"),
                            ),
                            trailing: Icon(Icons.navigate_next),
                            onTap: () {
                              Navigator.pushNamed(context, "/addressAdd");
                            },
                          )
                        : ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${_defaultAddress["name"]} ${_defaultAddress["phone"]}"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("${_defaultAddress["address"]}")
                              ],
                            ),
                            trailing: Icon(Icons.navigate_next),
                            onTap: () {
                              Navigator.pushNamed(context, "/addressList");
                            },
                          ),
                    Divider()
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Column(
                  children: context
                      .watch<CheckOutProvider>()
                      .checkOutList
                      .map((item) {
                    return Column(
                      children: [_checkOutItem(item), Divider()],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("商品总金额：¥100"),
                    Divider(),
                    Text("立减：¥5"),
                    Divider(),
                    Text("运费：¥0"),
                    Divider(),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(100),
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  ScreenAdapter.width(20), 0, ScreenAdapter.width(20), 0),
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(100),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(top: BorderSide(width: 1, color: Colors.black12))),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "总价：¥$_allPrice",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      child:
                          Text("立即下单", style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                      onPressed: () async {

                        if (_defaultAddress == null) {
                          Fluttertoast.showToast(msg: "请填写收货地址",gravity: ToastGravity.CENTER);
                          return;
                        }

                        String uid = await UserServices.getUserID();
                        String salt = await UserServices.getUserSalt();
                        var params = {
                          "uid": uid,
                          "address": _defaultAddress["address"],
                          "phone": _defaultAddress["phone"],
                          "name": _defaultAddress["name"],
                          "all_price": _allPrice,
                          "products": json.encode(
                              context.read<CheckOutProvider>().checkOutList),
                          "salt": salt
                        };
                        params["sign"] = SignServices.getSign(params);
                        params.remove("salt");
                        var api = "${Config.domain}/api/doOrder";
                        var result = await Dio().post(api, data: params);
                        if (result.data["success"]) {
                          //删除购物车支付过的商品
                          CheckOutServices.removePaidCartItem(context);
                          Navigator.pushNamed(context, "/pay");
                        }
                      },
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
