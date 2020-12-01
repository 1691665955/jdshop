import 'package:flutter/material.dart';
import '../widget/MZButton.dart';

class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {

  int _payType = 0;
  List _payList = [
    {
      "title": "支付宝支付",
      "payType": 0,
      "image": "https://www.itying.com/themes/itying/images/alipay.png"
    },
    {
      "title": "微信支付",
      "payType": 1,
      "image": "https://www.itying.com/themes/itying/images/weixinpay.png"
    }
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("去支付"),
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            child: ListView.builder(
              itemCount: _payList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    SizedBox(height: index==0?8:0),
                    ListTile(
                      leading: Image.network(
                          "${_payList[index]["image"]}"),
                      title: Text("${_payList[index]["title"]}"),
                      trailing: _payList[index]["payType"]==_payType?Icon(Icons.check):null,
                      onTap: () {
                        setState(() {
                          _payType = _payList[index]["payType"];
                        });
                      },
                    ),
                    Divider()
                  ],
                );
              },
            ),
          ),
          MZButton(
            title: "支付",
            color: Colors.red,
            width: 260,
            style: TextStyle(color: Colors.white, fontSize: 18),
            onTap: () {
              //pop回指定页面
              // Navigator.popUntil(context, (route) => route.settings.name == "/cart");
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          )
        ],
      ),
    );
  }
}
