import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的订单"),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: ScreenAdapter.width(88)),
            padding: EdgeInsets.all(ScreenAdapter.width(16)),
            child: ListView(
              children: [
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("订单编号"),
                      ),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(100),
                          height: ScreenAdapter.width(100),
                          child: Image.network(
                              "https://www.itying.com/images/flutter/list2.jpg"),
                        ),
                        title: Text("6小时学会TpyeScript入门实战教程"),
                        trailing: Text("x1"),
                        onTap: () {
                          Navigator.pushNamed(context, "/orderInfo",arguments: {"id":"zzzz"});
                        },
                      ),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(100),
                          height: ScreenAdapter.width(100),
                          child: Image.network(
                              "https://www.itying.com/images/flutter/list2.jpg"),
                        ),
                        title: Text("6小时学会TpyeScript入门实战教程"),
                        trailing: Text("x1"),
                      ),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(100),
                          height: ScreenAdapter.width(100),
                          child: Image.network(
                              "https://www.itying.com/images/flutter/list2.jpg"),
                        ),
                        title: Text("6小时学会TpyeScript入门实战教程"),
                        trailing: Text("x1"),
                      ),
                      ListTile(
                        leading: Text("合计：¥345"),
                        trailing: FlatButton(
                          child: Text("申请售后"),
                          onPressed: () {},
                          color: Colors.grey[100],
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("订单编号"),
                      ),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(100),
                          height: ScreenAdapter.width(100),
                          child: Image.network(
                              "https://www.itying.com/images/flutter/list2.jpg"),
                        ),
                        title: Text("6小时学会TpyeScript入门实战教程"),
                        trailing: Text("x1"),
                      ),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(100),
                          height: ScreenAdapter.width(100),
                          child: Image.network(
                              "https://www.itying.com/images/flutter/list2.jpg"),
                        ),
                        title: Text("6小时学会TpyeScript入门实战教程"),
                        trailing: Text("x1"),
                      ),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(100),
                          height: ScreenAdapter.width(100),
                          child: Image.network(
                              "https://www.itying.com/images/flutter/list2.jpg"),
                        ),
                        title: Text("6小时学会TpyeScript入门实战教程"),
                        trailing: Text("x1"),
                      ),
                      ListTile(
                        leading: Text("合计：¥345"),
                        trailing: FlatButton(
                          child: Text("申请售后"),
                          onPressed: () {},
                          color: Colors.grey[100],
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("订单编号"),
                      ),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(100),
                          height: ScreenAdapter.width(100),
                          child: Image.network(
                              "https://www.itying.com/images/flutter/list2.jpg"),
                        ),
                        title: Text("6小时学会TpyeScript入门实战教程"),
                        trailing: Text("x1"),
                      ),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(100),
                          height: ScreenAdapter.width(100),
                          child: Image.network(
                              "https://www.itying.com/images/flutter/list2.jpg"),
                        ),
                        title: Text("6小时学会TpyeScript入门实战教程"),
                        trailing: Text("x1"),
                      ),
                      ListTile(
                        leading: Container(
                          width: ScreenAdapter.width(100),
                          height: ScreenAdapter.width(100),
                          child: Image.network(
                              "https://www.itying.com/images/flutter/list2.jpg"),
                        ),
                        title: Text("6小时学会TpyeScript入门实战教程"),
                        trailing: Text("x1"),
                      ),
                      ListTile(
                        leading: Text("合计：¥345"),
                        trailing: FlatButton(
                          child: Text("申请售后"),
                          onPressed: () {},
                          color: Colors.grey[100],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.width(88),
            top: 0,
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Text("全部",textAlign: TextAlign.center,),
                  ),
                  Expanded(
                    child: Text("待付款",textAlign: TextAlign.center,),
                  ),
                  Expanded(
                    child: Text("待收货",textAlign: TextAlign.center,),
                  ),
                  Expanded(
                    child: Text("已完成",textAlign: TextAlign.center,),
                  ),
                  Expanded(
                    child: Text("已取消",textAlign: TextAlign.center,),
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
