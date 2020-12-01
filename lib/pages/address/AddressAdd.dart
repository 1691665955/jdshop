import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../../widget/MZButton.dart';
import 'package:city_pickers/city_pickers.dart';
import '../../services/UserServices.dart';
import '../../services/SignServices.dart';
import '../../config/Config.dart';
import 'package:dio/dio.dart';
import '../../services/EventBus.dart';

class AddressAddPage extends StatefulWidget {
  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String _area = "";
  String _name = "";
  String _phone = "";
  String _address = "";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    eventBus.fire(AddressEvent("增加成功"));
    eventBus.fire(CheckOutEvent("切换收货地址"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("增加收货地址"),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: ScreenAdapter.width(100),
              padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "收货人姓名",
                  border: InputBorder.none,
                ),
                onChanged: (string) {
                  _name = string;
                },
              ),
            ),
            Container(
              height: ScreenAdapter.width(100),
              padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 11,
                decoration: InputDecoration(
                  hintText: "收货人电话",
                  border: InputBorder.none,
                  counterText: "",
                ),
                onChanged: (string) {
                  _phone = string;
                },
              ),
            ),
            Container(
              height: ScreenAdapter.width(100),
              padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: InkWell(
                child: Row(
                  children: [
                    Icon(Icons.add_location),
                    Text(
                      _area.length == 0 ? "省/市/区" : _area,
                      style: TextStyle(color: Colors.black54),
                    )
                  ],
                ),
                onTap: () async {
                  Result result = await CityPickers.showCityPicker(
                      context: context,
                      height: ScreenAdapter.width(500),
                      confirmWidget: Text(
                        "确定",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ));
                  if (result != null) {
                    setState(() {
                      _area =
                          "${result.provinceName}/${result.cityName}/${result.areaName}";
                    });
                  }
                },
              ),
            ),
            Container(
              height: ScreenAdapter.width(300),
              padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "详细地址",
                  border: InputBorder.none,
                ),
                onChanged: (string) {
                  _address = string;
                },
              ),
            ),
            MZButton(
              title: "添加",
              margin: EdgeInsets.only(top: 20),
              width: ScreenAdapter.width(600),
              height: 44,
              color: Colors.red,
              style: TextStyle(color: Colors.white, fontSize: 16),
              onTap: () async {
                String uid = await UserServices.getUserID();
                String salt = await UserServices.getUserSalt();
                var params = {
                  "uid": uid,
                  "name": _name,
                  "phone": _phone,
                  "address": "$_area $_address",
                  "salt": salt
                };
                params["sign"] = SignServices.getSign(params);
                params.remove("salt");
                var api = "${Config.domain}/api/addAddress";
                var result = await Dio().post(api, data: params);
                if (result.data["success"]) {
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
