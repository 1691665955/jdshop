import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

class OrderInfoPage extends StatefulWidget {

  final Map arguments;

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();

  OrderInfoPage(this.arguments);
}

class _OrderInfoPageState extends State<OrderInfoPage> {

  String _orderID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orderID = widget.arguments["id"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("订单详情"),
      ),
      body:Container(
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "张三 18565203444"),
                        SizedBox(
                          height: 10,
                        ),
                        Text("北京市海淀区西二旗 触点大厦保安室")
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "四季沐歌（MICOE）洗衣机水龙头 洗衣机水嘴",
                                maxLines: 2,
                                style: TextStyle(fontSize: ScreenAdapter.fontSize(32)),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "洗衣机 水龙头",
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
                                        "¥100",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: ScreenAdapter.fontSize(32)),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("x1"),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
